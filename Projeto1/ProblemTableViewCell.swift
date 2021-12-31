//
//  ProblemTableViewCell.swift
//  Projeto1
//
//  Created by Aristóteles Júnior on 31/12/21.
//

import UIKit

class ProblemTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ problem: Problem) {
        if let photo = problem.photo {
            imageViewPhoto.image = UIImage(data: photo)
        }
        labelName.text = problem.name
        labelLocation.text = problem.location
    }

}
