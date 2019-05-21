//
//  ViewController.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/16/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        //storeItems()
        print("App Started")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func storeItems(){
        let ref = Database.database().reference()
    
        //1
        ref.child("items/1").setValue(["barcode":"654763524123", "product_name":"Chips", "price":2.25, "stock":100, "id":1])
        
        //2
        ref.child("items/2").setValue(["barcode":"123756478643", "product_name":"Drinks", "price":2.5, "stock":100, "id":2])
        
        //3
        ref.child("items/3").setValue(["barcode":"654763524265", "product_name":"Water", "price":1, "stock":100, "id":3])
        
        //4
        ref.child("items/4").setValue(["barcode":"654763524835", "product_name":"Coffee", "price":5, "stock":100, "id":4])
        
        //5
        ref.child("items/5").setValue(["barcode":"321654763524", "product_name":"Eggs", "price":18, "stock":100, "id":5])
        
        //6
        ref.child("items/6").setValue(["barcode":"612354763524", "product_name":"Bread", "price":5, "stock":100, "id":6])
        
        //7
        ref.child("items/7").setValue(["barcode":"466654763524", "product_name":"Ice Cream", "price":1, "stock":100, "id":7])
        
        //8
        ref.child("items/8").setValue(["barcode":"654324763524", "product_name":"Milk", "price":6, "stock":100, "id":8])
        
        //9
        ref.child("items/9").setValue(["barcode":"654767413524", "product_name":"Sandwich", "price":4, "stock":100, "id":9])
        
        //10
        ref.child("items/10").setValue(["barcode":"654763524723", "product_name":"Tea", "price":1, "stock":100, "id":10])
    }
    
}

