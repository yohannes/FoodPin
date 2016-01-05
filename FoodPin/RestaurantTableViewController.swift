//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/2/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    // MARK: - Stored Properties
    
    /***
    var restaurants:[RestaurantModel] = [
        RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phoneNumber: "232-923423", image: "cafedeadend.jpg"),
        RestaurantModel(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phoneNumber: "348-233423", image: "homei.jpg"),
        RestaurantModel(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "354-243523", image: "teakha.jpg"),
        RestaurantModel(name: "Cafe loisl", type: "Austrian / Casual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "453-333423", image: "cafeloisl.jpg"),
        RestaurantModel(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "983-284334", image: "petiteoyster.jpg"),
        RestaurantModel(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phoneNumber: "232-434222", image: "forkeerestaurant.jpg"),
        RestaurantModel(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phoneNumber: "234-834322", image:"posatelier.jpg"),
        RestaurantModel(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phoneNumber: "982-434343", image: "bourkestreetbakery.jpg"),
        RestaurantModel(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phoneNumber: "734-232323", image:
        "haighschocolate.jpg"),
        RestaurantModel(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phoneNumber: "872-734343", image: "palominoespresso.jpg"),
        RestaurantModel(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phoneNumber: "343-233221", image: "upstate.jpg"),
        RestaurantModel(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phoneNumber: "985-723623", image: "traif.jpg"),
        RestaurantModel(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phoneNumber: "455-232345",
            image: "grahamavenuemeats.jpg"),
        RestaurantModel(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phoneNumber: "434-232322", image:
            "wafflewolf.jpg"),
        RestaurantModel(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phoneNumber: "343-234553", image: "fiveleaves.jpg"),
        RestaurantModel(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phoneNumber: "342-455433", image:
            "cafelore.jpg"),
        RestaurantModel(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phoneNumber: "643-332323", image: "confessional.jpg"),
        RestaurantModel(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phoneNumber: "542-343434", image:
            "barrafina.jpg"),
        RestaurantModel(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phoneNumber: "722-232323", image:
            "donostia.jpg"),
        RestaurantModel(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phoneNumber: "343-988834", image:
            "royaloak.jpg"),
        RestaurantModel(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phoneNumber: "432-344050", image: "thaicafe.jpg")
    ]
    ***/
    
    
    var restaurants = [RestaurantModel]()
    
    var fetchResultController: NSFetchedResultsController!
    
    var searchController: UISearchController!
    var searchResults: [RestaurantModel] = []
    
    // MARK: - IBAction Properties
    
    @IBAction func dismissNewEntry(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - Local Methods
    
    func filterContentForSearchText(parameter: String) {
        self.searchResults = self.restaurants.filter({ (restaurant) -> Bool in
            let matchingName = restaurant.name.rangeOfString(parameter, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let matchingLocation = restaurant.location.rangeOfString(parameter, options: .CaseInsensitiveSearch)
            return matchingName != nil || matchingLocation != nil
        })
    }
    
    // MARK: - NSFetchedResultsControllerDelegate Methods
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            if let freshIndexPath = newIndexPath {
                self.tableView.insertRowsAtIndexPaths([freshIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        case .Delete:
            if let depreciatedIndexPath = indexPath {
                self.tableView.deleteRowsAtIndexPaths([depreciatedIndexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let changedIndexPath = indexPath {
                self.tableView.reloadRowsAtIndexPaths([changedIndexPath], withRowAnimation: .Fade)
            }
        default:
            self.tableView.reloadData()
        }
        self.restaurants = controller.fetchedObjects as? [RestaurantModel] ?? []
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    // MARK: - UISearchResultsUpdating Protocol Method
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchText = self.searchController.searchBar.text else { return }
        self.filterContentForSearchText(searchText)
        self.tableView.reloadData()
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            
        self.tableView.estimatedRowHeight = 36
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        // Fetch data from persistent storage using Core Data [more efficient way; only load and display the change]
        let fetchRequest = NSFetchRequest(entityName: "RestaurantModel")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
        self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchResultController.delegate = self
        
        do {
            try self.fetchResultController.performFetch()
            guard let validFetchedObjects = self.fetchResultController.fetchedObjects as? [RestaurantModel] else { return }
            self.restaurants = validFetchedObjects
        }
        catch {
            print(error)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.hidesBarsOnSwipe = true
        
        // Fetch data from persistent storage using Core Data [less efficient way since all restaurants are reloaded & redisplayed every time]
//        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
//        let fetchRequest = NSFetchRequest(entityName: "RestaurantModel")
//        do {
//            self.restaurants = try managedObjectContext.executeFetchRequest(fetchRequest) as! [RestaurantModel]
//            self.tableView.reloadData()
//        }
//        catch {
//            print(error)
//            return
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let destinationViewController = segue.destinationViewController as! RestaurantDetailViewController
            destinationViewController.restaurant = self.searchController.active ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row]
        }
    }
    
    // MARK: - Table View Delegate Methods
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//        let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .Default) { [unowned self] (action: UIAlertAction) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            self.presentViewController(alertMessage, animated: true, completion: nil)
//        }
//        optionMenu.addAction(callAction)
//        
//        if self.restaurantsVisited[indexPath.row] {
//            let hasNotVisitedBeforeAction = UIAlertAction(title: "I've not been here", style: .Default, handler: { (action: UIAlertAction) -> Void in
//                guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
//                cell.accessoryType = UITableViewCellAccessoryType.None
//                self.restaurants[indexPath.row].isVisited = false
//                self.restaurantsVisited[indexPath.row] = false
//            })
//            optionMenu.addAction(hasNotVisitedBeforeAction)
//        }
//        else {
//            let hasVisitedBeforeAction = UIAlertAction(title: "I've been here", style: .Default) { [unowned self] (action: UIAlertAction) -> Void in
//                guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
//                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//                self.restaurants[indexPAth.row].isVisited = true
//            }
//            optionMenu.addAction(hasVisitedBeforeAction)
//        }
//        
//        self.presentViewController(optionMenu, animated: true, completion: nil)
//        
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
//    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: .Default, title: "Share") { (tableViewRowAction, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            guard let validImageData = self.restaurants[indexPath.row].image else { return }
            guard let imageToShare = UIImage(data: validImageData) else { return }
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }
        
        // Delete data in db and in table view using core data
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (tableViewRowAction, indexPath) -> Void in
            guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
            guard let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as? RestaurantModel else { return }
            managedObjectContext.deleteObject(restaurantToDelete)
            
            do {
                try managedObjectContext.save()
            }
            catch {
                print(error)
            }
        }
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    // MARK: - Table View Data Source Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchController.active ? self.searchResults.count : self.restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RestaurantInfoCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell

        let eachRestaurant = self.searchController.active ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row]
        
        // Configure the cell...
        guard let validImageData = eachRestaurant.image else { return cell }
        cell.thumbnailImageView.image = UIImage(data: validImageData)
        cell.nameLabel.text = eachRestaurant.name
        cell.locationLabel.text = eachRestaurant.location
        cell.typeLabel.text = eachRestaurant.type
        guard let isIndeedVisited = eachRestaurant.isVisited?.boolValue else { return cell }
        cell.accessoryType = isIndeedVisited ? .Checkmark : .None

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.searchController.active ? false : true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.restaurants.removeAtIndex(indexPath.row)
        }
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
