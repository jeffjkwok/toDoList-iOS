//
//  Beast+CoreDataProperties.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beast {

    @NSManaged var name: String?
    @NSManaged var date: NSDate?
    @NSManaged var beasted: NSNumber?

}
