//
//  ViewController.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/10/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var displayLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var videos = [Videos]()
    var limit = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
        //runAPI()
        
    }
    
//    func getAPICount() {
//        if UserDefaults.standard.value(forKey: "APICNT") != nil {
//            let theValue = UserDefaults.standard.value(forKey: "APICNT") as! Int
//            limit = theValue
//        }
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E, dd MMM yyy HH:mm:ss"
//        let refreshDate = formatter.string(from: NSDate() as Date)
//        
//        
//    }
    
//    func runAPI() {
//        
//        getAPICount()
//        
//        let api = APIManager()
//        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
//    }
    
    func didLoadData(videos:[Videos]) {
        
        self.videos = videos
        
        tableView.reloadData()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1)) \(video.vArtist)"
        cell.detailTextLabel?.text = "\(video.vName)"
        
        return cell
    }

}

