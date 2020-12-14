//
//  Location.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class Location : CustomStringConvertible {
    
    var lat: Double
    var lon: Double
    
    init(lat:Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    var description: String {
       return "{ lat: \(self.lat ), lon: \(self.lon )}"
       }

}
