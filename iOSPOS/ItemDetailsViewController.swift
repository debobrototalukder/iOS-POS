//
//  ItemDetailsViewController.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/18/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ItemDetailsViewController: UIViewController {
    var ref:DatabaseReference!
    
    var productName = ""
    var productPrice:Float = 0.0
    var quantity = 0
    var id = ""
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var quantityTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = productName
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        productNameLabel.text = productName
        productPriceLabel.text = "\(productPrice)"
        quantityTF.text = "\(quantity)"
    }
    
    @IBAction func UpdateBTN(_ sender: Any) {
        ref.child("cart/\(id)").setValue(["product_name":productName, "price": productPrice, "quantity": Int(quantityTF.text!), "id":id])
    }
    
    @IBAction func DeleteBTN(_ sender: Any) {
        ref.child("cart/\(id)").removeValue()
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
