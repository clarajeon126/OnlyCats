//
//  LoginViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(userDidSignInGoogle(_:)),
                                                   name: .signInGoogleCompleted,
                                                   object: nil)
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(returnUserDidSignInGoogle(_:)),
                                                   name: .returnUserSignInGoogleCompleted,
                                                   object: nil)
    }
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        print("notification read")
        DatabaseManager.shared.changeUid { success in
            self.updateScreen()
        }
    }
    @objc private func returnUserDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        print("notification read")
        self.updateScreen()
    }
    
    private func updateScreen() {
        print("update screen proced")
            performSegue(withIdentifier: "loginToMain", sender: self)
    }
}
