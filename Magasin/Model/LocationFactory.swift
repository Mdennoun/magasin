//
//  LocationFactory.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation
import MapKit

class LocationFactory {
     
        
    var lat: Double
    var lon: Double
    
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
        
    
    static func locationFrom(product: [String: Any]) -> Location? {
        guard let lat = product["lat"] as? Double,
                 let lon = product["lon"] as? Double
           else {
                   return nil
           }
        let location = Location(lat: lat, lon: lon)
           return location
       }
    
    static func dictionaryFrom(location: Location) -> [String: Any] {
        return [
            "lat": location.lat,
            "lon": location.lon
        ]
    }
}
