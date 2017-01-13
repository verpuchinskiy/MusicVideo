//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/13/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Videos? {
        didSet {
            updateCell()
        }
    }

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var musicTitleLbl: UILabel!
    
    func updateCell() {
        musicTitleLbl.text = video?.vName
        rankLbl.text = "\(video!.vRank)"
        //musicImage.image = UIImage(named: "noimage")
        
        if video?.vImageData != nil {
            print("Get data from array...")
            musicImage.image = UIImage(data: video?.vImageData! as! Data)
        } else {
            getVideoImage(video: video!, imageView: musicImage)
        }
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView) {
        DispatchQueue.main.async {
            let data = NSData(contentsOf: URL(string: video.vImageUrl)!)
            
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data! as Data)
            }
            
            imageView.image = image
        }
    }

}
