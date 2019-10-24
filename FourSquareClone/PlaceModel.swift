//
//  PlaceModel.swift
//  FourSquareClone
//
//  Created by Mher Oganesyan on 10/24/19.
//  Copyright © 2019 Mher Oganesyan. All rights reserved.
//

import Foundation
import UIKit

class PlaceModel {
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLati = ""
    var placeLong = ""
    
    private init () {}
}
