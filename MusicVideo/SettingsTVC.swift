//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Mike Verpuchinskiy on 1/14/17.
//  Copyright © 2017 MIKE VERPUCHINSKIY. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
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
        
        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        
        if UserDefaults.standard.value(forKey: "APICNT") != nil {
            let theValue = UserDefaults.standard.integer(forKey: "APICNT")
            APICount.text = "\(Int(theValue))"
            sliderCount.value = Float(theValue)
        } else {
            sliderCount.value = 10.0
            APICount.text = "\(Int(sliderCount.value))"
        }
    }
    
    
    @IBAction func touchIdSecurity(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        if touchID.isOn {
            defaults.set(touchID.isOn, forKey: "SecSetting")
        } else {
            defaults.set(false, forKey: "SecSetting")
        }
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCount.value), forKey: "APICNT")
        APICount.text = "\(Int(sliderCount.value))"
    }
    
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: .subheadline)
        APICount.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                mailAlert()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["mike.verpuchinskiy@gmail.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Mike, \n\nI Would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        let alertController = UIAlertController(title: "Alert", message: "No e-mail Account set up for Phone", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UIContentSizeCategoryNewValueKey), object: nil)
    }

}
