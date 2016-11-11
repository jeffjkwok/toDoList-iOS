//
//  BeastCell.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//

import UIKit

class BeastCell: UITableViewCell {
    
    @IBAction func beastButtonPressed(sender: UIButton) {
        delegate?.didPressBeastButton(BeastCell: taskLabel.tag)
    }
    var delegate: BeastCellDelegate?

    @IBOutlet weak var taskLabel: UILabel!
}
