//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/13/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Video? {
        didSet {
            updateCell()
        }
    }

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var musicTitleLbl: UILabel!
    
    func updateCell() {
        
        musicTitleLbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        rankLbl.font = UIFont.preferredFont(forTextStyle: .body)
        
        musicTitleLbl.text = video?.vName
        rankLbl.text = "\(video!.vRank)"
        //musicImage.image = UIImage(named: "noimage")
        
        if video?.vImageData != nil {
            print("Get data from array...")
            musicImage.image = UIImage(data: video?.vImageData! as! Data)
        } else {
            getVideoImage(video: video!, imageView: musicImage)
            print("Get images in background thread")
        }
    }
    
    func getVideoImage(video: Video, imageView: UIImageView) {
        
        DispatchQueue.global(qos: .default).async {
            let data = NSData(contentsOf: URL(string: video.vImageUrl)!)
            
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data! as Data)
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }

        }
    }
    }


