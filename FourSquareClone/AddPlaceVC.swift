//
//  AddPlaceVC.swift
//  FourSquareClone
//
//  Created by Mher Oganesyan on 10/23/19.
//  Copyright © 2019 Mher Oganesyan. All rights reserved.
//

import UIKit

//var globalName = ""
//var globalType = ""
//var globalAtmosphere = ""

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        if nameText.text != "" && typeText.text != "" && atmosphereText.text != "" {
            if let chosenImage = imageView.image {
                    let placeModel = PlaceModel.sharedInstance
                    placeModel.placeName = nameText.text!
                    placeModel.placeType = typeText.text!
                    placeModel.placeAtmosphere = atmosphereText.text!
                    placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
            makeAlert(title: "Error", message: "Missing fields")
        }
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okbutton)
        self.present(alert, animated: true, completion: nil)
    }
}
