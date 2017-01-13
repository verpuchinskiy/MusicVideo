//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/11/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    private var _vRights: String
    private var _vPrice: String
    private var _vArtist: String
    private var _vImid: String
    private var _vGenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDate: String
    
    var vImageData: NSData?
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    init(data: JSONDictionary) {
        if let name = data["im:name"] as? JSONDictionary, let vName = name["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        if let img = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            _vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String {
            _vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary,
            let vRights = rights["label"] as? String {
            _vRights = vRights
        } else {
            _vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String {
            _vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionary,
            let vArtist = artist["label"] as? String {
            _vArtist = vArtist
        } else {
            _vArtist = ""
        }
        
        if let imid = data["id"] as? JSONDictionary,
            let attributes = imid["attributes"] as? JSONDictionary,
            let vImid = attributes["im:id"] as? String {
            _vImid = vImid
        } else {
            _vImid = ""
        }
        
        if let genre = data["category"] as? JSONDictionary,
            let attributes = genre["attributes"] as? JSONDictionary,
            let vGenre = attributes["term"] as? String {
            _vGenre = vGenre
        } else {
            _vGenre = ""
        }
        
        if let link = data["id"] as? JSONDictionary,
            let linkToiTunes = link["label"] as? String
        {
            _vLinkToiTunes = linkToiTunes
        } else {
            _vLinkToiTunes = ""
        }
        
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            let attributes = releaseDate["attributes"] as? JSONDictionary,
            let vRelease = attributes["label"] as? String
        {
            _vReleaseDate = vRelease
        } else {
            _vReleaseDate = ""
        }
        
    }
}
