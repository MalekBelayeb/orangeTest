//
//  RecentTableViewCell.swift
//  LuckyTrip
//
//  Created by Saida Dagdoug on 13/1/2023.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var kinds: UILabel!
    @IBOutlet weak var dist: UILabel!
    @IBOutlet weak var favories: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
