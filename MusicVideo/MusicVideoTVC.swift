//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/13/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {

    var videos = [Videos]()
    var filteredSearch = [Videos]()
    let resultSearchController = UISearchController(searchResultsController: nil)
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func didLoadData(videos:[Videos]) {
        
        self.videos = videos
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        title = "The iTunes Top \(limit) Music Videos"
        
        resultSearchController.searchResultsUpdater = self
        definesPresentationContext = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for Artist, Name, Rank"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.red
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                    print("Cancel")})
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    print("Delete")})
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    print("Ok")})
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            
            
        default:
            //view.backgroundColor = UIColor.green
            
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()
            }
            
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        
        if resultSearchController.isActive {
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
        } else {
            runAPI()
        }
        
    }
    
    
    func getAPICount() {
        if UserDefaults.standard.value(forKey: "APICNT") != nil {
            let theValue = UserDefaults.standard.value(forKey: "APICNT") as! Int
            limit = theValue
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.string(from: NSDate() as Date)
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    func runAPI() {
        
        getAPICount()
        
        let api = APIManager()
        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultSearchController.isActive {
            return filteredSearch.count
        }
        
        return videos.count
    }

    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier, for: indexPath) as! MusicVideoTableViewCell

        if resultSearchController.isActive {
            cell.video = filteredSearch[indexPath.row]
        } else {
            cell.video = videos[indexPath.row]
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboard.segueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let video: Videos
                
                if resultSearchController.isActive {
                    video = filteredSearch[indexPath.row]
                } else {
                    video = videos[indexPath.row]
                }
                
                let destinationVC = segue.destination as! MusicVideoDetailVC
                destinationVC.videos = video
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.text!.lowercased()
        filterSearch(searchText: searchController.searchBar.text!)
    }
    
    func filterSearch(searchText: String) {
        filteredSearch = videos.filter({ (videos) in
            return videos.vArtist.lowercased().contains(searchText.lowercased()) || videos.vName.lowercased().contains(searchText.lowercased()) || "\(videos.vRank)".lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }

}


//extension MusicVideoTVC: UISearchResultsUpdating {
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        searchController.searchBar.text?.lowercased()
//        filterSearch(searchText: searchController.searchBar.text!)
//    }
//}
