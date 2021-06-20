//
//  catTableViewCell.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/19/21.
//

import UIKit

class catTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bdayAndAgeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    weak var cat: Cat?
    func set(cat: Cat) {
        self.cat = cat
        
        catImage.image = cat.mainImage
        nameLabel.text = cat.name
        bdayAndAgeLabel.text = cat.birthdayAge
        descriptionLabel.text = cat.description
        interestLabel.text = "interest: \(cat.interest)"
    }
}
