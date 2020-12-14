//
//  MapViewController.swift
//  FindMy
//
//  Created by Mohamed dennoun on 17/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var MapView: MKMapView!
    var autocompleteTableView = UITableView()
    var userCoordinate: MKCoordinateRegion?
    
    var data: Array<String> = []
    var storedData: Array<String> = []
    
    var resultSearchController = UISearchController()
    var stores = [Store]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.delegate = self
        self.navigationItem.title = "Magasins"
        setSearchView()
        self.MapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749), latitudinalMeters: 1000000, longitudinalMeters: 1000000), animated: true)
                   
     
        
        
       
        autocompleteTableView.delegate = self
        autocompleteTableView.dataSource = self
        autocompleteTableView.isScrollEnabled = true
        autocompleteTableView.isHidden = true

        self.view.addSubview(self.autocompleteTableView)

        //Auto-set the UITableViewCells height (requires iOS8)
        autocompleteTableView.rowHeight = 50
        autocompleteTableView.estimatedRowHeight = 50

        autocompleteTableView.separatorInset = UIEdgeInsets.zero
        autocompleteTableView.layer.cornerRadius = 5.0
        autocompleteTableView.separatorColor = UIColor.lightGray
        autocompleteTableView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        
        autocompleteTableView.frame = CGRect(x: 1, y: 0, width: self.view.frame.width-2, height:  (resultSearchController.searchBar.frame.height + 20))
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let storeServices = StoreServices()
        storeServices.getStores { (stores) in
            self.stores = stores
        
            for store in stores {
                self.data.append(store.name)
                let annotation = MKPointAnnotation()
                annotation.title = store.name
                annotation.coordinate = CLLocationCoordinate2D(latitude: store.location.lat, longitude: store.location.lon)
                self.MapView.addAnnotation(annotation)
            }

            
            self.data = Array(Set(self.data))
            self.storedData = self.data
            self.autocompleteTableView.reloadData()
        }
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let loc = userLocation.location else {
            return
        }
        //permet de zoomer sur la localisation user
        userCoordinate = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "store_annotation_view")
        if annotation == nil {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "store_annotation_view")
            pinAnnotationView.canShowCallout = true // pour afficher une pop-up
            pinAnnotationView.pinTintColor = .purple
            annotationView = pinAnnotationView
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        
        for store in stores {
            if store.name == annotation.title {
                let vc = StoreDetailViewController.newInstance(store: store)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension MapViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        
        guard let text = searchController.searchBar.text else { return }
        
        if text != "" {
            
            self.data = storedData
            self.autocompleteTableView.isHidden = false
            var resArray = Array<String>()
            for storeName in data {
                if(storeName.lowercased().contains(text.lowercased())){
                    resArray.append(storeName)
                }
            }
            for store in stores {
                
                if store.name == text {
                 self.MapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: store.location.lat, longitude: store.location.lon), latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
                }
            }
            
            
            let unique = Array(Set(resArray))
            self.data = unique
            self.autocompleteTableView.reloadData()
          
            

        } else {
             self.MapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749), latitudinalMeters: 1000000, longitudinalMeters: 1000000), animated: true)
            self.autocompleteTableView.isHidden = true
        }
    }
    
    
    
    func willDismissSearchController(_ searchController: UISearchController) {
        guard let cordinate = userCoordinate else {
            return
        }
        self.MapView.setRegion(cordinate, animated: true)
        self.autocompleteTableView.isHidden = true
    }
    func setSearchView() {
        self.resultSearchController = ({
            let controller  = UISearchController(searchResultsController: nil)
            
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.setValue("Retour", forKey: "cancelButtonText")
            controller.searchBar.placeholder = "Chercher"
            controller.definesPresentationContext = false
            controller.obscuresBackgroundDuringPresentation = false
            controller.delegate = self
            navigationItem.searchController = controller
            
            return controller
        })()
    }
    
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //resultSearchController.searchBar.text = data[0]
        let searchResult = data[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = searchResult
        cell.detailTextLabel?.text = searchResult
        let arrheight = (resultSearchController.searchBar.frame.height + 20) + CGFloat( self.data.count * 50 )
    
        self.autocompleteTableView.frame = CGRect(x: 1, y: 0, width: self.view.frame.width-2, height: arrheight)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        autocompleteTableView.isHidden = true
        resultSearchController.searchBar.text = data[indexPath.row]
        
    }
    

}
