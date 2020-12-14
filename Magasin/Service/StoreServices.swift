//
//  UserServices.swift
//  Magasin
//
//  Created by Mohamed dennoun on 18/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation


typealias StoreCompletion = ([Store]) -> Void

class StoreServices {
    
    
    
    func getStores(completion: @escaping StoreCompletion) -> Void {
        guard let url = URL(string: "https://moc4a-poi.herokuapp.com/stores") else {
            return;
        }
        let task = URLSession.shared.dataTask(with: url) { (data,res,err) in

            
            guard let bytes = data,
            err == nil,
            let  json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                DispatchQueue.main.sync {
                    completion([])
                }
                    return
            }

            let request =  json.compactMap { (obj) -> Store? in
                guard let store = obj as? [String: Any] else {
                    return nil
                }
                return StoreFactory.storeFrom(store: store )
            }
            DispatchQueue.main.sync {
                completion(request)
            }

        }
        task.resume()
        
        
    }
    
 
    
    
    
}




