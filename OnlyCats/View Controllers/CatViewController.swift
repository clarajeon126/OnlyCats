//
//  ViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import UIKit
import FirebaseAuth
import Kommunicate

public var cats = [Cat]()

class CatViewController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var pawNumButton: UIButton!
    @IBOutlet weak var pawsnumLabel: UILabel!
    
    var catTableCellId = "catTableCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        catTableView.register(UINib(nibName: "catTableViewCell", bundle: nil), forCellReuseIdentifier: catTableCellId)
        
        catTableView.dataSource = self
        catTableView.delegate = self
        catTableView.reloadData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        handleNotAuthenticated()
        
        
    }
    
    //handleing not authenticated
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let startingStoryBoard = UIStoryboard(name: "Starting", bundle: nil)
            let loginVC = startingStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
        else{
            print("user uid: \(Auth.auth().currentUser!.uid)")
            
            DatabaseManager.shared.observeUserProfile(Auth.auth().currentUser!.uid) { (userProfile) in
                UserProfile.currentUserProfile = userProfile
                
                //set paw num button text
                print(UserProfile.currentUserProfile?.paws)
                self.pawsnumLabel.text = "\(UserProfile.currentUserProfile?.paws ?? 1)"
                if cats.count == 0 {
                    DatabaseManager.shared.getCats { catsinside in
                        cats = catsinside
                        let userId = Kommunicate.randomId()
                        print(userId)
                        let kmUser = KMUser()
                        kmUser.userId = userId
                        kmUser.displayName = userProfile?.firstName
                        kmUser.applicationId = "168b157c6261ba66ce468994213834b28"

                        // Use this same API for login
                        Kommunicate.registerUser(kmUser, completion: {
                            response, error in
                            guard error == nil else {return}
                            print("Success")
                        })
                        
                        self.catTableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCatInDetail" {
            let indexPath = catTableView.indexPathForSelectedRow
            let catDetailVC = segue.destination as! CatDetailedViewController
            let catAtIndex:Cat = cats[indexPath!.row]
            
            catDetailVC.cat = catAtIndex
        }
    }
    
    
}

extension CatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.55
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: catTableCellId, for: indexPath) as! catTableViewCell
        cell.set(cat: cats[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCatInDetail", sender: self)
    }
    
}

