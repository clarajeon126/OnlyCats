//
//  ImageViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/19/21.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageInQuestion = #imageLiteral(resourceName: "defaultpp")
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func downloadButtonTapped(_ sender: Any) {
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageInQuestion
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "great", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "saved!", message: "the picture has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "great", style: .default))
            present(ac, animated: true)
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
