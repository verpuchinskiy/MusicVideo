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
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {
    
    @IBOutlet weak var vNameLbl: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenreLbl: UILabel!
    @IBOutlet weak var vPriceLbl: UILabel!
    @IBOutlet weak var vRightsLbl: UILabel!
    
    var videos: Video!
    
    var securitySwitch = false

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
        securitySwitch = UserDefaults.standard.bool(forKey: "SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdChk()
        default:
            shareMedia()
        }
    }
    
    func touchIdChk() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social Media"
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        self.shareMedia()
                    }
                } else {
                    alert.title = "Unsuccessful!"
                    
                    switch policyError!{
                    case LAError.appCancel:
                        alert.message = "Authentication was cancelled by application"
                    case LAError.authenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                    case LAError.passcodeNotSet:
                        alert.message = "Passcode is not set on the device"
                    case LAError.systemCancel:
                        alert.message = "Authentication was cancelled by the system"
                    case LAError.touchIDLockout:
                        alert.message = "Too many failed attempts"
                    case LAError.userCancel:
                        alert.message = "You cancelled the request"
                    case LAError.userFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                    default:
                        alert.message = "Unable to authenticate!"
                    }
                    
                    DispatchQueue.main.async { [unowned self] in
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            alert.title = "Error"
            
            switch touchIDError! {
            case LAError.touchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
            case LAError.touchIDNotAvailable:
                alert.message = "Touch ID is not available on the device"
            case LAError.passcodeNotSet:
                alert.message = "Passcode has not been sent"
            case LAError.invalidContext:
                alert.message = "The context in invalid"
            default:
                alert.message = "Local Authentication not available"
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.present(alert, animated: true, completion: nil)
            }
        }
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
