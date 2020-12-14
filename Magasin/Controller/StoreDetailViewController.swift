//
//  StoreDetailViewController.swift
//  Magasin
//
//  Created by Mohamed dennoun on 22/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import CoreLocation //Framework geoloc

class StoreDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet var adresse: UILabel?
    @IBOutlet var collectionView: UICollectionView!
    var nameTxt = "";
    var localisation = Location(lat: 0, lon: 0);
    var products = [Product]();
    
    
    class func newInstance(store: Store) -> StoreDetailViewController {
        let vc = StoreDetailViewController()
        
        vc.nameTxt = store.name.description
        vc.localisation = store.location
        vc.products = store.products
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddressLabelFromLatLon(location: localisation)
        
        navigationItem.title = nameTxt
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER", for: indexPath) as! ProductCollectionViewCell
        
        
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = "Prix: \(products[indexPath.row].price.description)"
        if products[indexPath.row].stock == 0 {
            cell.productDispo.text = "Produit Epuisé"
            cell.productDispo.textColor = .red
        } else {
            cell.productDispo.text = "\(products[indexPath.row].stock.description) en stock"
        }
        
        
        cell.photoProduct.image = UIImage(named: "product")
        
        if let imageURL = URL(string: products[indexPath.row].imageURL ) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.photoProduct?.image = image
                    }
                }
            }
        }
        return cell
    }
    
    func setAddressLabelFromLatLon(location: Location) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(location.lat)")!
        //21.228124
        let lon: Double = Double("\(location.lon)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        var addressString : String = ""


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    if pm.subLocality != nil {
                        let sub = pm.subLocality!
                        .components(separatedBy:CharacterSet.decimalDigits.inverted)
                        .joined()
                        addressString = sub + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }

                    self.adresse?.text = "Adresse: \(addressString)"
                    
              }
        })
        

    }
    


    

}
