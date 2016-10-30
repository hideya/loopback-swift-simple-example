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

        AppDelegate.coffeeShopRepo.all(
            success: { (models) -> Void in
                // success block
                print(models)
                self.tableData = models as! [CoffeeShop]
                self.tableView.reloadData()
            },
            failure: { (error: Error?) -> Void in
                // failure block
                print(error)
        })
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeShopCell", for: indexPath)
        let coffeeShop = tableData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = "\(coffeeShop.name!) in \(coffeeShop.city!)"

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let coffeeShop = tableData[(indexPath as NSIndexPath).row]
            print("Deleting \(coffeeShop)")
            coffeeShop.destroy(
                success: { () -> Void in
                    // success block
                    print("Deleted!")
                    self.tableData.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                },
                failure: { (error: Error?) -> Void in
                    // failure block
                    print(error)
            })
        }
    }

    // MARK: - IBActions

    @IBAction func actionRefresh(_ sender: AnyObject) {
        reloadCoffeeShops()
    }

    @IBAction func unwindToList(_ segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddNewCoffeeShopViewController, let newCoffeeShop = sourceViewController.coffeeShop {
            tableData.append(newCoffeeShop)
            let indexPath = IndexPath(row: tableData.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}
