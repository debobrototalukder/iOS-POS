//
//  CartViewController.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/18/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import UIKit
import Firebase

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    
    var itemList = [cartModel]()
    var productArray = [String]()
    var quantityArray = [Int]()
    
    var check:Bool = true
    var count:Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ViewControllerTableViewCell
        
        let cartItems: cartModel
        cartItems = itemList[indexPath.row]
        
        myCell.name.text = cartItems.productName
        myCell.price.text = "\(cartItems.price!)"
        
        return myCell
    }
    
    var total: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check = true
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("cart")
        ref.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.itemList.removeAll()
                self.productArray.removeAll()
                self.quantityArray.removeAll()
                self.total = 0
                
                for i in snapshot.children.allObjects as![DataSnapshot] {
                    let itemObject = i.value as? [String: AnyObject]
                    let name = itemObject?["product_name"]
                    let price = itemObject?["price"]
                    let quantity = itemObject?["quantity"]
                    let id = itemObject?["id"]
                    
                    let price1:Float = price as! Float
                    let quantity1:Float = quantity as! Float
                    
                    let i = cartModel(pName: name as? String, pric: price as? Float, quan: quantity as? Int, i: id as? String)
                    
                    self.total = self.total + Double((price1 * quantity1))
                    self.itemList.append(i)
                    self.productArray.append(name as! String)
                    self.quantityArray.append(quantity as! Int)
                }
                
                self.tblView.reloadData()
                self.totalAmount.text = "Total: \(self.total)"
            }
        }
    }
    
    @IBAction func PurchaseBTN(_ sender: Any) {
        /*for j in 0...productArray.count-1 {
            
        for i in stride(from: 1, to: 10, by: 1){
            ref.child("items/\(i)").observeSingleEvent(of: .value, with: {(snapshot) in
                print("\(i)")
                var dict = snapshot.value as! [String: Any]
                
                let productdict = dict["product_name"] as! String
                //let index = self.productArray.firstIndex(of: productdict)
                var productName = self.productArray[j]
                print(productName)
                var quantity = self.quantityArray[j]
                
                if productName == productdict {
                    print("Value Exists")
                    
                    let barcodeDict = dict["barcode"] as! String
                    let priceDict = dict["price"] as! Float
                    let quantityDict = dict["quantity"] as! Int
                    
                    var newQuantity = quantityDict - quantity
                    //Update Quantity In Cart
                    self.ref.child("cart/\(i)").setValue(["barcode":barcodeDict, "price":priceDict, "product_name":productName, "quantity":newQuantity])
                    
                    return
                } else {
                    print("Value does not exist")
                }
                print("\(i)")
                
            })
        
        }
        }*/
        
        ref = Database.database().reference().child("items")
        ref.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                for i in snapshot.children.allObjects as![DataSnapshot] {
                    if self.count < 10 {
                        self.count += 1
                    let itemObject = i.value as? [String: AnyObject]
                    let name = itemObject?["product_name"]
                    let price = itemObject?["price"]
                    let barcode = itemObject?["barcode"]
                    let stock = itemObject?["stock"]
                    let id = itemObject?["id"]
                    
                    let price1:Float = price as! Float
                    let name1:String = name as! String
                    let barcode1:String = barcode as! String
                    let stock1:Int = stock as! Int
                    let id1:Int = id as! Int
                    
                    if self.check == true {
                        
                    for j in 0...self.productArray.count-1 {
                        if self.productArray[j] == name1 {
                            var newQuantity = 0
                            newQuantity = stock1 - self.quantityArray[j]
                            
                            //Update Quantity In Cart
                            let ref1 = Database.database().reference()
                            ref1.child("items/\(id1)").setValue(["barcode":barcode1, "price":price1, "product_name":name1, "stock":newQuantity, "id":id1])
                        }
                    }
                    }
                        
                    }
                }
            }
        }
        
        ref = Database.database().reference().child("cart")
        ref.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                for i in snapshot.children.allObjects as![DataSnapshot] {
                    let itemObject = i.value as? [String: AnyObject]
                    let name = itemObject?["product_name"]
                    let price = itemObject?["price"]
                    let quantity = itemObject?["quantity"]
                    let id = itemObject?["id"]
                    
                    let name1:String = name as! String
                    let price1:Float = price as! Float
                    let quantity1:Float = quantity as! Float
                    
                    let ref3 = Database.database().reference()
                    var randomID = self.ref.childByAutoId().key
                    ref3.child("sold_items/\(randomID!)").setValue(["name":name1, "id":randomID!])
                }
            }
        }
        
        let ref2 = Database.database().reference()
        ref2.child("cart").removeValue()
    }
    
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? ItemDetailsViewController
        
        let selectedRow:Int = (self.tblView.indexPathForSelectedRow?.row)!
        dest?.productName = itemList[selectedRow].productName!
        dest?.productPrice = itemList[selectedRow].price!
        dest?.quantity = itemList[selectedRow].quantity!
        dest?.id = itemList[selectedRow].id!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
