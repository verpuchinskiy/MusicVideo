//
//  JsonDataExtractor.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/17/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import Foundation

class JsonDataExtractor {
    
    static func extractVideoDataFromJson(videoDataObject: AnyObject) -> [Video] {
        guard let videoData = videoDataObject as? JSONDictionary else {return [Video]()}
        
        var videos = [Video]()
        
        if let feeds = videoData["feed"] as? JSONDictionary,
            let entries = feeds["entry"] as? JSONArray
        {
            for (index,data) in entries.enumerated() {
                
                var vName = "", vRights = "", vPrice = "", vImageUrl = "", vArtist = "", vVideoUrl = "", vImid = "", vGenre = "", vLinkToiTunes = "", vReleaseDate = ""
                
                
                if let imName = data["im:name"] as? JSONDictionary,
                    let label = imName["label"] as? String {
                    vName = label
                }
                
                if let img = data["im:image"] as? JSONArray,
                    let image = img[2] as? JSONDictionary,
                    let immage = image["label"] as? String {
                    vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
                }
                
                if let video = data["link"] as? JSONArray,
                    let vUrl = video[1] as? JSONDictionary,
                    let vHref = vUrl["attributes"] as? JSONDictionary,
                    let href = vHref["href"] as? String {
                    vVideoUrl = href
                }
                
                if let rights = data["rights"] as? JSONDictionary,
                    let label = rights["label"] as? String {
                    vRights = label
                }
                
                if let imPrice = data["im:price"] as? JSONDictionary,
                    let label = imPrice["label"] as? String {
                    vPrice = label
                }
                
                if let artist = data["im:artist"] as? JSONDictionary,
                    let label = artist["label"] as? String {
                    vArtist = label
                }
                
                if let imid = data["id"] as? JSONDictionary,
                    let attributes = imid["attributes"] as? JSONDictionary,
                    let imId = attributes["im:id"] as? String {
                    vImid = imId
                }
                
                if let genre = data["category"] as? JSONDictionary,
                    let attributes = genre["attributes"] as? JSONDictionary,
                    let term = attributes["term"] as? String {
                    vGenre = term
                }
                
                if let link = data["id"] as? JSONDictionary,
                    let label = link["label"] as? String
                {
                    vLinkToiTunes = label
                }
                
                if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
                    let attributes = releaseDate["attributes"] as? JSONDictionary,
                    let label = attributes["label"] as? String
                {
                    vReleaseDate = label
                }
                
                
                
                
                let currentVideo = Video(vRank: index + 1, vName: vName, vRights: vRights, vPrice: vPrice, vImageUrl: vImageUrl, vArtist: vArtist, vVideoUrl: vVideoUrl, vImid: vImid, vGenre: vGenre, vLinkToiTunes: vLinkToiTunes, vReleaseDate: vReleaseDate)
                
                videos.append(currentVideo)
            }
        }
        return videos
    }
}
