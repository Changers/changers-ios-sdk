//
//  ViewController.swift
//  SDKSample
//
//  Created by Clement Yerochewski on 19.05.21.
//

import UIKit
import ChangersSDK


class ViewController: UIViewController {

    @IBOutlet weak var uuidTextField: UITextField!
    
    private var isChangersReady: Bool = false {
        didSet {
            print(isChangersReady ? "Changers is ready" : "Changers is not ready")
        }
    }
    
    private var changersUUID: String? {
        didSet {
            self.uuidTextField.text = changersUUID
            print("changersUUID : \(changersUUID == nil ? "no changers UUID saved locally" : changersUUID!)")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uuidTextField.placeholder = "Changers UUID"
        self.changersUUID = ChangersHelper.changersUUID
    }
  
    fileprivate func logoutUser() {
        ChangersInstance.shared().logoutUser()
        ChangersHelper.changersUUID = nil
        changersUUID = nil
    }
    
    @IBAction func logout() {
        if ChangersInstance.shared().isLoggedIn {
            logoutUser()
        }
        ChangersHelper.changersUUID = nil
    }

    @IBAction func registerAsGuest(_ sender: Any) {
        if ChangersInstance.shared().isLoggedIn {
            logoutUser()
        }
        ChangersInstance.shared().registerUser(authenticationDelegate: self, setupDelegate: self)
        ChangersHelper.changersUUID = nil
    }
    
    @IBAction func login() {
        guard let uuid = self.uuidTextField.text else {
            print("uuid is missing in textfield")
            return
        }
        if ChangersInstance.shared().isLoggedIn {
            logoutUser()
        }
        ChangersInstance.shared().loginUser(uuid: uuid, authenticationDelegate: self, setupDelegate: self)
    }
    
    
    @IBAction func openWebApp() {
        let vc = ChangersInstance.shared().webApp()
        self.present(vc, animated: true)
    }
    
}

extension ViewController: ChangersAuthenticationDelegate {
    func didSetupUser(with uiid: String) {
        ChangersHelper.changersUUID = uiid // here you need to hold the user's changers uuid
        uuidTextField.text = uiid
    }
}


extension ViewController: ChangersDelegate {
    func setupDidFinish() {
        // webapp is ready to be open safely, listen to this callback
        self.isChangersReady = true
    }
    
    func setupDidFail(with error: ChangersAuthenticateError?) {
        // it has failed to autneticated properly
        self.isChangersReady = false
    }
    
    
}


