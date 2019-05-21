//
//  cartModel.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/18/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import Foundation

class cartModel {
    var productName: String?
    var price : Float?
    var quantity: Int?
    var id: String?
    
    init(pName: String?, pric: Float?, quan: Int?, i: String?) {
        productName = pName
        price = pric
        quantity = quan
        id = i
    }
}
