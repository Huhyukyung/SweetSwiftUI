//
//  Store.swift
//  FruitMart
//
//  Created by Yukyung Huh on 10/22/23.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import Foundation

final class Store {
    var products: [Product]
    
    init (filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}
