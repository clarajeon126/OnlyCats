//
//  SettingViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    @IBAction func signoutTapped(_ sender: Any) {
        AuthManager.shared.logOut(completion: {success in
            DispatchQueue.main.async {
                if success {
                    UserProfile.currentUserProfile = nil
                    
                    let startingStoryBoard = UIStoryboard(name: "Starting", bundle: nil)
                    let loginVC = startingStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                }
            }
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.dataSource = self
        settingTableView.delegate = self
        
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath)
            return cell
        }
        else if indexPath.row == 1 {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: "pawsCell", for: indexPath)
            return cell
        }
        else {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: "signoutCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "settingToAbout", sender: self)
        }
        else if indexPath.row == 1 {
            performSegue(withIdentifier: "settingToPaws", sender: self)
        }
        else if indexPath.row == 2 {
            let alert = UIAlertController(title: "Sign out?", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { (AlertAction) in
                self.signoutTapped(self)
            }))
            alert.addAction(UIAlertAction(title: "Nevermind", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
