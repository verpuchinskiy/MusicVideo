//
//  APIManager.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/10/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: @escaping ([Videos]) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //let session = URLSession.shared
        let url = URL(string: urlString)
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
                if error != nil {
                    
                    print((error?.localizedDescription)!)
                    
                } else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary,
                            let feed = json["feed"] as? JSONDictionary,
                            let entries = feed["entry"] as? JSONArray
                            {
                            var videos = [Videos]()
                                for entry in entries {
                                    let entry = Videos(data: entry as! JSONDictionary)
                                    videos.append(entry)
                                }
                                
                                let i = videos.count
                                print("iTunesApiManager - total count --> \(i)")
                                print (" ")
                                
                                DispatchQueue.main.async {
                                    completion(videos)
                                }
                        }
                    } catch {
                            print("Error in JSON Serialization")
                    }
                }
            }
        task.resume()
    }
}
