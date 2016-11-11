//
//  EditDelegate.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//

import Foundation

protocol EditDelegate {
    func editBeastController(controller: EditBeastController, didFinishAddingBeast beast: String)
    func editBeastController(controller: EditBeastController, didFinishEditingBeast beast: Beast)
}