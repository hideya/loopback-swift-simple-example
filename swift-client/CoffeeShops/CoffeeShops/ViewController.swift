//
//  ViewController.swift
//  CoffeeShops
//
//  Created by hideya kawahara on 1/1/16.
//

import UIKit
import LoopBack


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableData = [CoffeeShop]();

    override func viewWillAppear(animated: Bool) {
        getCoffeeShops()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getCoffeeShops() {
        AppDelegate.coffeeShopRepo.allWithSuccess(
            { (models: [AnyObject]!) -> Void in
                // success block
                self.tableData = models as! [CoffeeShop]
                self.tableView.reloadData()
            },
            failure: { (error: NSError!) -> Void in
                // failure block
                print(error)
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoffeeShopCell", forIndexPath: indexPath)
        let model = tableData[indexPath.row]
        cell.textLabel?.text = "\(model.name) in \(model.city)"

        return cell
    }

    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        getCoffeeShops()
    }
}
