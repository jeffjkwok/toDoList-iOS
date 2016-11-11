//
//  EditBeastController.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//

import UIKit

class EditBeastController: UITableViewController {

    var beastToEdit: Beast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if beastToEdit != nil {
            textField.text = beastToEdit!.name
        }
    }
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    var delegate: EditDelegate?
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if let beast = beastToEdit{
            beast.name = textField.text
            delegate?.editBeastController(self, didFinishEditingBeast: beast)
        } else {
            let beast = textField.text
            delegate?.editBeastController(self, didFinishAddingBeast: beast!)
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
}
