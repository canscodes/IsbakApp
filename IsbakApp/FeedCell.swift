//
//  FeedCell.swift
//  IsbakApp
//
//  Created by Can Öncü on 22.09.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
