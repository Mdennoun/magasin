//
//  ProductCollectionViewCell.swift
//  Magasin
//
//  Created by Mohamed dennoun on 22/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var photoProduct: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productDispo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
