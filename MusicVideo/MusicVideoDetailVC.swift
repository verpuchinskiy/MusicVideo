//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/14/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {
    
    @IBOutlet weak var vNameLbl: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenreLbl: UILabel!
    @IBOutlet weak var vPriceLbl: UILabel!
    @IBOutlet weak var vRightsLbl: UILabel!
    
    var videos: Videos!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.vArtist

        vNameLbl.text = videos.vName
        vPriceLbl.text = videos.vPrice
        vRightsLbl.text = videos.vRights
        vGenreLbl.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData as! Data)
        } else {
            videoImage.image = UIImage(named: "noimage")
        }
    }
    

    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = URL(string: videos.vVideoUrl)
        let player = AVPlayer(url: url!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) { 
            playerViewController.player?.play()
        }
    }

    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        shareMedia()
    }
    
    func shareMedia() {
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = "\(videos.vName) by \(videos.vArtist)"
        let activity3 = "Watch it and tell what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step It Up!)"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityType.mail {
                print("Email selected")
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }


}
