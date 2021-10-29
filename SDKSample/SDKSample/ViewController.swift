//
//  ViewController.swift
//  SDKSample
//
//  Created by Clement Yerochewski on 19.05.21.
//

import UIKit
import ChangersSDK

protocol SDKWrapperDelegate {
    func ready()
    func updateUUID()
}

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    @IBAction func logout() {
        AppDelegate.shared().changers.cleanState()
        ChangersHelper.changersUUID = nil
        AppDelegate.shared().changers.initSDK(with: ChangersHelper.config, uuid: nil)
    }

    
    @IBAction func openWebApp() {   
        guard AppDelegate.shared().changers.isReady else {
            AppDelegate.shared().changers.cleanState()
            AppDelegate.shared().changers.initSDK(with: ChangersHelper.config, uuid: ChangersHelper.changersUUID)
            let alert = UIAlertController(title: "Changers SDK not ready", message: ChangersHelper.changersUUID != nil ? "We are authenticating your user with UUID : \(ChangersHelper.changersUUID!), just a moment." : "We are creating a guest user and you should be able to access to the web app, try in a moment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            return
        }
        let vc = Changers.webApp()
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}


//extension ViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        guard let text = textField.text else {
//            return true
//        }
//        ChangersHelper.changersUUID = text.isEmpty ? nil : text
//        AppDelegate.shared().changers.cleanState()
//        AppDelegate.shared().changers.initSDK(with: ChangersHelper.config, uuid: ChangersHelper.changersUUID)
//        return true
//    }
//}

extension ViewController: SDKWrapperDelegate {
    
    func ready() {
        print("SDK is ready")
    }
    
    func updateUUID() {
        print("logged in with new uuid : \(ChangersHelper.changersUUID)")
    }
    
}


