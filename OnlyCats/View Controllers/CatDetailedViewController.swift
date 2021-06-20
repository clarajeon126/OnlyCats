//
//  CatDetailedViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import UIKit
import AVKit

class CatDetailedViewController: UIViewController {

    var cat = Cat()
    
    var imageToBeSent = #imageLiteral(resourceName: "defaultpp")
    
    @IBOutlet var offerViews: [UIView]!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayAgeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    
    @IBAction func cutePicButtonTapped(_ sender: Any) {
        print("pressed")
        let alert = UIAlertController(title: "purchase \(cat.name)'s cute pic?", message: "this action is not reversible and costs 50 paws!", preferredStyle: .alert)
        
        let nevermindAction = UIAlertAction(title: "nevermind", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "i'm sure!!", style: .destructive) { alertAction in
            self.imageToBeSent = self.cat.cuteCatPics.randomElement()!
            self.performSegue(withIdentifier: "toImage", sender: self)
        }
        
        alert.addAction(nevermindAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func feetPicButtonTapped(_ sender: Any) {
        print("pressed")
        let alert = UIAlertController(title: "purchase \(cat.name)'s feet pic?", message: "this action is not reversible and costs 70 paws!", preferredStyle: .alert)
        
        let nevermindAction = UIAlertAction(title: "nevermind", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "i'm sure!!", style: .destructive) { alertAction in
            self.imageToBeSent = self.cat.feetPics.randomElement()!
            self.performSegue(withIdentifier: "toImage", sender: self)
        }
        
        alert.addAction(nevermindAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    @IBAction func catVideoButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "purchase \(cat.name)'s cute video?", message: "this action is not reversible and costs 100 paws!", preferredStyle: .alert)
        
        let nevermindAction = UIAlertAction(title: "nevermind", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "i'm sure!!", style: .destructive) { alertAction in
            let player = AVPlayer(url: self.cat.cuteCatVid)
            let vc = AVPlayerViewController()
            vc.player = player
            
            self.present(vc, animated: true) {
                print("av player")
                vc.player?.play()
            }
        }
        
        alert.addAction(nevermindAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for x in 0..<offerViews.count {
            offerViews[x].layer.cornerRadius = 15
        }
        
        mainImageView.image = cat.mainImage
        nameLabel.text = cat.name
        birthdayAgeLabel.text = cat.birthdayAge
        descriptionLabel.text = cat.description
        interestLabel.text = "Interest: \(cat.interest)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImage" {
            let imageVC = segue.destination as! ImageViewController
            imageVC.imageInQuestion = imageToBeSent
        }
        
    }

}
