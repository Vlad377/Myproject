//
//  MainTableViewCell.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 11/28/18.
//  Copyright © 2018 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLeagueLabel: UILabel!
    @IBOutlet weak var backgroundImageLeague: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
