//
//  ViewController.swift
//  ios_bb
//
//  Created by Jeff Kwok on 9/23/16.
//  Copyright © 2016 Jeff Kwok. All rights reserved.
//

import UIKit
import CoreData

class ToBeastViewController: UITableViewController, EditDelegate, BeastCellDelegate, CancelButtonDelegate{
    var beast = [Beast]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        fetchToBeast()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        fetchToBeast()
    }
    
    func cancelButtonPressedFrom(controller: UITableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }

//BeastButtonPressed
    func didPressBeastButton(BeastCell index: Int){
        print("button works")
        beast[index].beasted = 1
        beast[index].date = NSDate()
        save()
        fetchToBeast()
        tableView.reloadData()
        }
    
    
// PREPARE FOR SEG
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAdd"{
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! EditBeastController
            dest.cancelButtonDelegate = self
            dest.delegate = self
        } else if segue.identifier == "toEdit"{
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! EditBeastController
            dest.cancelButtonDelegate = self
            dest.delegate = self
            if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell){
                dest.beastToEdit = beast[indexPath.row]
            }
        }
    }
// ADDING FUNCTION FROM DELEGATE
    func editBeastController(controller: EditBeastController, didFinishAddingBeast beast: String){
        dismissViewControllerAnimated(true, completion: nil)
        let add = NSEntityDescription.insertNewObjectForEntityForName("Beast", inManagedObjectContext: managedObjectContext) as! Beast
        add.name =  beast
//        add.date = NSDate()
//        print(add.date)
        add.beasted = -1
        print(add.beasted)
        save()
        fetchToBeast()
        tableView.reloadData()
    }
    
//UPDATING FUNCTION FROM DELEGATE
    func editBeastController(controller: EditBeastController, didFinishEditingBeast beast: Beast){
        dismissViewControllerAnimated(true, completion: nil)
        save()
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
    }
//SEGUE TO EDIT
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEdit", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
// TABLEVIEW GENERATION
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastCell") as! BeastCell
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.taskLabel.text = beast[indexPath.row].name
        
//      beasted button
        cell.taskLabel.tag = indexPath.row
        print(cell.taskLabel.tag)
        cell.delegate = self
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beast.count
    }

    
// HELPER FUNCTIONS
//    fetch,save
    func fetchToBeast(){
        let idAttribute = "beasted"
        let idPredicate = NSPredicate(format: "%K == %i", idAttribute, -1)
        let userRequest = NSFetchRequest(entityName: "Beast")
        userRequest.predicate = idPredicate
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            beast = results as! [Beast]
        } catch {
            print("\(error)")
        }
    }
    
    func save(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        
    }

}

