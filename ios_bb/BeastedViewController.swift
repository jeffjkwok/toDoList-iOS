//
//  BeastedViewController.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//

import UIKit
import CoreData

class BeastedViewController: UITableViewController {
    
    var beast = [Beast]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
//        fetchBeasted()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchBeasted()
        tableView.reloadData()
    }
    
// DELETE FUNCTION
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // remove the mission at indexPath in CORE DATA
        switch editingStyle{
        case .Delete:
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(beast[indexPath.row] as NSManagedObject)
            beast.removeAtIndex(indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
        fetchBeasted()
    }
    
//TABLE GENERATION
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastedCell2")
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell!.textLabel!.text = beast[indexPath.row].name
        cell!.detailTextLabel!.text = dateToString(beast[indexPath.row].date!)
        return cell!
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(beast.count)
        return beast.count
    }
    
//HELPER FUNCTION
    func fetchBeasted(){
        let idAttribute = "beasted"
        let idPredicate = NSPredicate(format: "%K != %i", idAttribute, -1)
        let userRequest = NSFetchRequest(entityName: "Beast")
        userRequest.predicate = idPredicate
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            beast = results as! [Beast]
        } catch {
            print("\(error)")
        }
    }
    
    func dateToString(date: NSDate)-> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM yy"
        let strdate = dateFormatter.stringFromDate(date)
        print(strdate)
        return strdate
    }

}
