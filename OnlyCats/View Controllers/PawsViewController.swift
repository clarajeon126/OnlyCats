//
//  PawsViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import UIKit

class PawsViewController: UIViewController {

    @IBOutlet var blueViews: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()

        for x in 0..<blueViews.count {
            blueViews[x].layer.cornerRadius = 15
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
