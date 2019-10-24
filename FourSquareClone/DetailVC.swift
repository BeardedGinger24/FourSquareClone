//
//  DetailVC.swift
//  FourSquareClone
//
//  Created by Mher Oganesyan on 10/23/19.
//  Copyright © 2019 Mher Oganesyan. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var atmosphereLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var chosenPlaceId = ""
    var chosenLat = Double()
    var chosenLong = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromParse()
        mapView.delegate = self
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(title: "error", message: error?.localizedDescription ?? "error")
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        
                        // Objects
                        
                        if let name = chosenPlaceObject.object(forKey: "name") as? String {
                            self.nameLabel.text = name
                        }
                        
                        if let type = chosenPlaceObject.object(forKey: "type") as? String {
                            self.typeLabel.text = type
                        }
                        
                        if let atmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.atmosphereLabel.text = atmosphere
                        }
                        
                        if let lat = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let latDouble = Double(lat) {
                                self.chosenLat = latDouble
                            }
                        }
                        
                        if let long = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let longDouble = Double(long) {
                                self.chosenLong = longDouble
                            }
                        }
                        
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { (data, error) in
                                if error == nil {
                                    if data != nil {
                                        self.imageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                        // Maps
                        let location = CLLocationCoordinate2D(latitude: self.chosenLat, longitude: self.chosenLong)
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.mapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.nameLabel.text
                        annotation.subtitle = self.typeLabel.text
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLong != 0.0 && self.chosenLat != 0.0 {
            let requestLocaiton = CLLocation(latitude: self.chosenLat, longitude: self.chosenLong)
            CLGeocoder().reverseGeocodeLocation(requestLocaiton) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlacemark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlacemark)
                        mapItem.name = self.nameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okbutton)
        self.present(alert, animated: true, completion: nil)
    }
}
