//
//  StocksViewController.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/18/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StocksViewController: UIViewController {
    @IBOutlet weak var chipsLB: UILabel!
    @IBOutlet weak var drinksLB: UILabel!
    @IBOutlet weak var WaterLB: UILabel!
    @IBOutlet weak var CoffeeLB: UILabel!
    @IBOutlet weak var eggsLB: UILabel!
    @IBOutlet weak var BreadLB: UILabel!
    @IBOutlet weak var iceCreamLB: UILabel!
    @IBOutlet weak var milkLB: UILabel!
    @IBOutlet weak var SandwichLB: UILabel!
    @IBOutlet weak var teaLB: UILabel!
    
    
    
    let ref = Database.database().reference()
    var labelArray = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelArray.append(chipsLB)
        labelArray.append(drinksLB)
        labelArray.append(WaterLB)
        labelArray.append(CoffeeLB)
        labelArray.append(eggsLB)
        labelArray.append(BreadLB)
        labelArray.append(iceCreamLB)
        labelArray.append(milkLB)
        labelArray.append(SandwichLB)
        labelArray.append(teaLB)
        

        // Do any additional setup after loading the view.
        for i in stride(from: 1, to: 11, by: 1){
            ref.child("items/\(i)").observeSingleEvent(of: .value, with: {(snapshot) in
                var dict = snapshot.value as! [String: Any]
                
                let barcodedict = dict["barcode"] as! String
                let stockdict = dict["stock"] as! Int
                let iddict = dict["id"] as! Int
                let pricedict = dict["price"] as! Float
                let namedict = dict["product_name"] as! String
                
                self.labelArray[i-1].text = String(stockdict)
                
                
//                if barcodedict == barcode!{
//                    print("Value Exists")
//
//                    let nameDict = dict["product_name"] as! String
//                    let priceDict = dict["price"] as! Float
//
//                    //Adds items to cart if barcode exists
//                    let autoID = ref.childByAutoId().key
//                    print(autoID!)
//                    ref.child("cart/\(autoID!)").setValue(["product_name":nameDict, "price":priceDict, "quantity":1, "id":autoID!])
//
//                    return
//                } else {
//                    print(barcode!)
//                    print("Value does not exist")
//                }
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
