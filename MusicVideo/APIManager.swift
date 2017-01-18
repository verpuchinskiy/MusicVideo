//
//  APIManager.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/10/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: @escaping ([Video]) -> Void) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //let session = URLSession.shared
        let url = URL(string: urlString)
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                print((error?.localizedDescription)!)
                
            } else {
                let videos = self.parseJSON(data: data as NSData?)
                
                DispatchQueue.main.async {
                    completion(videos)
                }
            }
        }
        
        task.resume()
    }
    
    
    func parseJSON(data: NSData?) -> [Video] {
        do {
            if let json = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as AnyObject? {
                return JsonDataExtractor.extractVideoDataFromJson(videoDataObject: json)
            }
        } catch {
            print(error.localizedDescription)
        }
        return [Video]()
    }
}
