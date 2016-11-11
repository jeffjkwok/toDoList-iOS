//
//  CancelButtonDelegate.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//

import Foundation; import UIKit

protocol CancelButtonDelegate: class {
    func cancelButtonPressedFrom(controller: UITableViewController)
}