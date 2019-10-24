//
//  DetailVC.swift
//  FourSquareClone
//
//  Created by Mher Oganesyan on 10/23/19.
//  Copyright © 2019 Mher Oganesyan. All rights reserved.
//

import UIKit
import MapKit

class DetailVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var atmosphereLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
