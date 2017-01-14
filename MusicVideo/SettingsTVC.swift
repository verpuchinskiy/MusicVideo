//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/14/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICount: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChange), name: NSNotification.Name(rawValue: UIContentSizeCategoryNewValueKey), object: nil)

        tableView.alwaysBounceVertical = false
    }
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        APICount.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UIContentSizeCategoryNewValueKey), object: nil)
    }

}
