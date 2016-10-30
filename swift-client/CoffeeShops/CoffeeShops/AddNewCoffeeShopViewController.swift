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

    @IBAction func actionDoneButton(_ sender: AnyObject) {
        if nameField.text == "" {
            let alert = UIAlertController(
                title: "Missing Coffee Shop Name!",
                message:"You have to enter a coffee shop name.",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true) {}
            return
        }

        if cityField.text == "" {
            let alert = UIAlertController(
                title: "Missing City Name!",
                message:"You have to enter a city name.",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true) {}
            return
        }

        let newCoffeeShop = AppDelegate.coffeeShopRepo.model(with: nil) as! CoffeeShop
        newCoffeeShop.name = nameField.text!
        newCoffeeShop.city = cityField.text!

        print("Adding \(newCoffeeShop)")
        newCoffeeShop.save(
            success: { () -> Void in
                // success block
                print("Added!")
                self.coffeeShop = newCoffeeShop;
                self.performSegue(withIdentifier: "unwindToList", sender: self)
            },
            failure: { (error: Error?) -> Void in
                // failure block
                print(error)
        })
    }
}
