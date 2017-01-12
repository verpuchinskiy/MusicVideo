//
//  ViewController.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/10/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLbl: UILabel!
    
    var videos = [Videos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
        let api = APIManager()
        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos:[Videos]) {
        
        for item in videos {
            print("\(item.vArtist) - \(item.vName)")
        }
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.red
            displayLbl.text = "No Internet Access"
        case WIFI:
            view.backgroundColor = UIColor.green
            displayLbl.text = "Reachable with WiFi"
        case WWAN:
            view.backgroundColor = UIColor.yellow
            displayLbl.text = "Reachable with Cellular"
        default:
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }

}

