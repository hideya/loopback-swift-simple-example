# LoopBack Client in Swift - A Simple Example

This is a simple LoopBack client written in Swift using an in-development version of LoopBack iOS SDK.

This basically is a Swift version of the iOS client found in this tutorial: ["How-to Build CRUD Enabled iOS Apps with the LoopBack API Server"](https://strongloop.com/strongblog/how-to-crud-ios-nodejs-loopback-api-server-part-1/) with the following differences:

 * Written in Swift, rather than Objective-C.
 * The LoopBack API server used in this demo is created by following [Getting started with LoopBack/Create a simple API](https://docs.strongloop.com/display/public/LB/Create+a+simple+API) instead of [the one](https://docs.strongloop.com/display/DOC/Creating+a+LoopBack+application) referenced in Step 2 of [the original tutorial](https://strongloop.com/strongblog/how-to-crud-ios-nodejs-loopback-api-server-part-1/), since it doesn't seem to exist anymore.  Because of this change, the app deals with `CoffeeShops` instead of `Books`.
 * The client workspace already includes an module-enabled version of LoopBack iOS SDK (`LoopBack.framework`).  So, no need to download one.  **The `LoopBack.framework` bundled is an in-development version of [strongloop/loopback-sdk-ios](https://github.com/strongloop/loopback-sdk-ios) at revhash of `897293f` (12/25/2015)**.
 * Includes minor changes like removal of the refresh button and bug fixes.

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
    let adapter = LBRESTAdapter(URL: NSURL(string: "http://localhost:3000/api"))
    let coffeeShopRepo = adapter.repositoryWithClass(CoffeeShopRepository) as! CoffeeShopRepository
```

Find all the models:

```
    coffeeShopRepo.allWithSuccess(
        { (models: [AnyObject]!) -> Void in
            // success block
            let tableData = models as! [CoffeeShop]
            ...
        },
        failure: { (error: NSError!) -> Void in
            // failure block
            ...
        })
```

Create a new model:

```
    let newModel = coffeeShopRepo.modelWithDictionary(nil) as! CoffeeShop
    newModel.name = nameField.text!
    newModel.city = cityField.text!

    newModel.saveWithSuccess(
        { () -> Void in
            // success block
            ...
        },
        failure: { (error: NSError!) -> Void in
            // failure block
            ...
        })
```

