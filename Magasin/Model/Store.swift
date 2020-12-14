//
//  Store.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import MapKit

class Store: CustomStringConvertible {
    
    var name: String;
    var location: Location;
    var products: [Product];
    
    init(name: String, location: Location, products: [Product]) {
        self.name = name
        self.location = location
        self.products = products
    }
    
    var description: String {
    return "{ name: \(self.name ), location: \(self.location ), products: \(self.products ) }"
    }

}
