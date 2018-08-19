//
//  SearchListTableViewCell.swift
//  WikiSearch
//
//  Created by Darshan K S on 19/08/18.
//  Copyright © 2018 Darshan K S. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    static let identifier = "SearchListTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImageView.configureRoundedCorner(withRadius: 4.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
