//
//  ViewController.swift
//  CoffeeShops
//
//  Created by hideya kawahara on 1/1/16.
//

import UIKit
import LoopBack


class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tableData = [CoffeeShop]()

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCoffeeShops()
    }

    func reloadCoffeeShops() {
        print("Reloading Coffee Shops...")
        AppDelegate.coffeeShopRepo.allWithSuccess(
            { (models: [AnyObject]!) -> Void in
                // success block
                print(models)
                self.tableData = models as! [CoffeeShop]
                self.tableView.reloadData()
            },
            failure: { (error: NSError!) -> Void in
                // failure block
                print(error)
        })
    }

    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoffeeShopCell", forIndexPath: indexPath)
        let coffeeShop = tableData[indexPath.row]
        cell.textLabel?.text = "\(coffeeShop.name) in \(coffeeShop.city)"

        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let coffeeShop = tableData[indexPath.row]
            print("Deleting \(coffeeShop)")
            coffeeShop.destroyWithSuccess(
                { () -> Void in
                    // success block
                    print("Deleted!")
                    self.tableData.removeAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                },
                failure: { (error: NSError!) -> Void in
                    // failure block
                    print(error)
            })
        }
    }

    // MARK: - IBActions

    @IBAction func actionRefresh(sender: AnyObject) {
        reloadCoffeeShops()
    }

    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.sourceViewController as? AddNewCoffeeShopViewController, newCoffeeShop = sourceViewController.coffeeShop {
            tableData.append(newCoffeeShop)
            let indexPath = NSIndexPath(forRow: tableData.count - 1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
