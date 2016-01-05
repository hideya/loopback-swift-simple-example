//
//  AddNewCoffeeShopViewController
//  CoffeeShops
//
//  Created by hideya kawahara on 1/1/16.
//

import UIKit
import LoopBack


class AddNewCoffeeShopViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cityField: UITextField!

    var coffeeShop: CoffeeShop?

    @IBAction func actionDoneButton(sender: AnyObject) {
        if nameField.text == "" {
            let alert = UIAlertController(
                title: "Missing Coffee Shop Name!",
                message:"You have to enter a coffee shop name.",
                preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            return
        }

        if cityField.text == "" {
            let alert = UIAlertController(
                title: "Missing City Name!",
                message:"You have to enter a city name.",
                preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            return
        }

        coffeeShop = nil
        let newCoffeeShop = AppDelegate.coffeeShopRepo.modelWithDictionary(nil) as! CoffeeShop
        newCoffeeShop.name = nameField.text!
        newCoffeeShop.city = cityField.text!

        print("Adding \(newCoffeeShop)")
        newCoffeeShop.saveWithSuccess(
            { () -> Void in
                // success block
                print("Added!")
                self.coffeeShop = newCoffeeShop;
                self.performSegueWithIdentifier("unwindToList", sender: self)
            },
            failure: { (error: NSError!) -> Void in
                // failure block
                print(error)
        })
    }
}
