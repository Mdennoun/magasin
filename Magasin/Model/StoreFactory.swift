//
//  StoreFactory.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation
import MapKit

class StoreFactory {
     
        
    var name: String;
    var location: Location;
    var products: [Product];
    
    
    init(name: String, location: Location, products: [Product]) {
        self.name = name
        self.location = location
        self.products = products
    }
        
    
    static func storeFrom(store: [String: Any]) -> Store? {
        guard let name = store["name"] as? String,
            let location = LocationFactory.locationFrom(product: store["location"] as! [String : Any]),
            let products = ProductFactory.productsFrom(products: store["products"] as! [[String : Any]])
        else  {
                   return nil
           }
        let store = Store(name: name, location: location, products: products)
           return store
       }
    
    static func dictionaryFrom(store: Store) -> [String: Any] {
        return [
            "name": store.name ,
            "location": store.location ,
            "products": store.products
        ]
    }
}
