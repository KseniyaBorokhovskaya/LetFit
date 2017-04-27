//
//  ActivityTableViewCell.swift
//  FitApp
//
//  Created by Kseniya Borokhovskaya on 4/23/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Calories: UILabel!
    var id: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithActivity(_ activity: Activity) {
        id = activity.id
        Name!.text = activity.nameOfActivity
        Calories!.text = "\(activity.calories)"
    }

}
