//
//  Product.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class Product: CustomStringConvertible {
    

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
    
    var description: String {
    return "{ name: \(self.name ), imageURL: \(self.imageURL ), price: \(self.price ), stock: \(self.stock ) }"
    }
}
