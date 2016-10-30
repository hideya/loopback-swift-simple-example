//
//  CoffeeShop.swift
//  CoffeeShops
//
//  Created by hideya kawahara on 1/2/16.
//

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
