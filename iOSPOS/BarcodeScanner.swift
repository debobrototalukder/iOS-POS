//
//  BarcodeScanner.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/16/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BarcodeScanner: UIViewController {
    @IBOutlet weak var barcodeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addToCartBtn(_ sender: Any) {
        let ref = Database.database().reference()
        
        let barcode = barcodeTF.text
        
        // Checks all the data to see if barcode exists
        for i in stride(from: 1, to: 10, by: 1){
            ref.child("items/\(i)").observeSingleEvent(of: .value, with: {(snapshot) in
                var dict = snapshot.value as! [String: Any]
                
                let barcodedict = dict["barcode"] as! String
                
                if barcodedict == barcode!{
                    print("Value Exists")
    
                    let nameDict = dict["product_name"] as! String
                    let priceDict = dict["price"] as! Float
                    
                    //Adds items to cart if barcode exists
                    let autoID = ref.childByAutoId().key
                    print(autoID!)
                    ref.child("cart/\(autoID!)").setValue(["product_name":nameDict, "price":priceDict, "quantity":1, "id":autoID!])
                    
                    return
                } else {
                    print(barcode!)
                    print("Value does not exist")
                }
                print("\(i)")
                
            })
        }
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
