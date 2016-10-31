# LoopBack Client in Swift 3 - A Simple Example

This is a simple LoopBack client written in Swift using an in-development version of LoopBack iOS SDK.

This basically is a Swift version of the iOS client found in this tutorial: ["How-to Build CRUD Enabled iOS Apps with the LoopBack API Server"](https://strongloop.com/strongblog/how-to-crud-ios-nodejs-loopback-api-server-part-1/) with the following differences:

 * Written in Swift, rather than Objective-C.
 * The LoopBack API server used in this demo is created by following [Getting started with LoopBack/Create a simple API](https://docs.strongloop.com/display/public/LB/Create+a+simple+API) instead of [the one](https://docs.strongloop.com/display/DOC/Creating+a+LoopBack+application) referenced in Step 2 of [the original tutorial](https://strongloop.com/strongblog/how-to-crud-ios-nodejs-loopback-api-server-part-1/), since it doesn't seem to exist anymore.  Because of this change, the app deals with `CoffeeShops` instead of `Books`.
 * The client workspace already includes a module-enabled version of the LoopBack iOS SDK framework.  **The bundled `LoopBack.framework` is an in-development version of [strongloop/loopback-sdk-ios](https://github.com/strongloop/loopback-sdk-ios) at revhash of `897293f` (12/25/2015)**.
 * Swipe-to-delete feature of the table view is added to demonstrate deletion of a model.

### How to Try Out

 1. Clone the repo: e.g. `git clone https://github.com/hideya/loopback-swift-simple-example`
 *  `cd test-server`
 *  `npm install` to install the node modules required by the server.
 *  `node .` to run the server.
 *  Open the client Xcode project from `swift-client/CoffeeShops/CoffeeShops.xcodeproj`
 *  Build and run the client by typing command⌘-R.

### Key Code Fragments

The following code fragments show key parts of LoopBack iOS SDK usage with Swift.

Model definition:

```
import LoopBack

class CoffeeShop: LBPersistedModel {
    var name: String!
    var city: String!
}

class CoffeeShopRepository: LBPersistedModelRepository {
    override init() {
        super.init(className: "CoffeeShops")
    }

    class func repository() -> CoffeeShopRepository {
        return CoffeeShopRepository()
    }
}
```

Instantiation of the adapter and the repository:

```
    static let adapter = LBRESTAdapter(url: URL(string: "http://localhost:3000/api"))
    static let coffeeShopRepo = adapter?.repository(with: CoffeeShopRepository.self) as! CoffeeShopRepository

```

Find all the models:

```
    coffeeShopRepo.all(
            success: { (models) -> Void in
            // success block
            let tableData = models as! [CoffeeShop]
            ...
        },
        failure: { (error: Error?) -> Void in
            // failure block
            ...
        })
```

Create a new model:

```
    let newCoffeeShop = coffeeShopRepo.modelWithDictionary(nil) as! CoffeeShop
    newCoffeeShop.name = nameField.text!
    newCoffeeShop.city = cityField.text!

    newCoffeeShop.save(
            success: { () -> Void in
            // success block
            ...
        },
        failure: { (error: Error?) -> Void in
            // failure block
            ...
        })
```

Delete an existing model:

```
        coffeeShop.destroy(
                success: { () -> Void in

            // success block
            ...
        },
        failure: { (error: Error?) -> Void in
            // failure block
            ...
        })
```
