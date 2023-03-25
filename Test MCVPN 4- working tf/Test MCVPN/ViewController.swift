//
//  ViewController.swift
//  Test MCVPN
//
//  Created by Apple on 29/10/22.
//

import UIKit
import MessageUI
class ViewController: UIViewController {
    @IBOutlet var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(MFMessageComposeViewController.canSendText())
    }
    @IBAction func connect(_ sender: UIButton) {
        sendNewMessage()
    }
}
extension ViewController: MFMessageComposeViewControllerDelegate {
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {

        
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
    
        case .failed:
            print("Message failed")
            
        case .sent:
            print("Message was sent")
            
        default:
            return
        }
        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
    }
    
    public func startSending() {
        sendNewMessage()
    }
    func sendNewMessage() {
        if !MFMessageComposeViewController.canSendText() {
            DispatchQueue.main.async {
                let messageVC = MFMessageComposeViewController()
                
                messageVC.body = "body"
                messageVC.recipients = ["9574850843"]
                messageVC.messageComposeDelegate = self
                self.present(messageVC, animated: true, completion: nil)
            }
        }
    }
}

extension UIApplication {
    /// Get Current View Controller
    static func topViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
