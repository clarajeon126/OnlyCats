//
//  AboutViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/20/21.
//

import UIKit

class AboutViewController: UIViewController {

    @IBAction func githubPressed(_ sender: Any) {
        if let url = NSURL(string: "https://github.com/clarajeon126/OnlyCats"){
            UIApplication.shared.openURL(url as URL)
            }
    }
    @IBAction func youtubePressed(_ sender: Any) {
        if let url = NSURL(string: "https://github.com/clarajeon126/OnlyCats"){
            UIApplication.shared.openURL(url as URL)
            }
    }
    
    @IBAction func devpostPressed(_ sender: Any) {
        if let url = NSURL(string: "https://github.com/clarajeon126/OnlyCats"){
            UIApplication.shared.openURL(url as URL)
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
