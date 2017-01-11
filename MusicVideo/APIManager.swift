//
//  APIManager.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/10/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: @escaping (_ result: String) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //let session = URLSession.shared
        let url = URL(string: urlString)
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
                if error != nil {
                    DispatchQueue.main.async {
                    completion((error?.localizedDescription)!)
                    }
                } else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary {
                            print(json)
                            
                            DispatchQueue.main.async {
                                completion("JSON Serialization Successful")
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion("Error in JSON Serialization")
                        }
                    }
                }
            }
        task.resume()
    }
}
