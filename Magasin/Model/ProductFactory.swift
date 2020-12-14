//
//  StoreFactory.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation
import MapKit

class ProductFactory {
     
        
    var name: String
    var imageURL: String
    var price: Double
    var stock: Int
    
    
    init(name: String, imageURL: String, price: Double, stock: Int) {
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.stock = stock
    }
        
    
    static func productsFrom(products: [[String: Any]]) -> [Product]? {
        var productsArray = [Product]()
        for product in products {
            
            guard let name = product["name"] as? String,
                     let imageURL = product["image"] as? String,
                     let price = product["price"] as? Double,
                     let stock = product["stock"] as? Int
               else {
                       return nil
               }
            let product = Product(name: name, imageURL: imageURL, price: price, stock: stock)
            productsArray.append(product)
            
        }
           
              return productsArray
          }
    
    static func dictionaryFrom(product: Product) -> [String: Any] {
        return [
            "name": product.name ,
            "imageURL": product.imageURL ,
            "price": product.price,
            "stock": product.stock
        ]
    }
}
