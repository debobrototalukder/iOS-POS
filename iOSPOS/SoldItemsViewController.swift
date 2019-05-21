//
//  SoldItemsViewController.swift
//  iOSPOS
//
//  Created by Ammar Joher on 12/18/18.
//  Copyright © 2018 Ammar Joher. All rights reserved.
//

import UIKit
import Firebase

class SoldItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!
    
    @IBOutlet weak var tblSold: UITableView!
    
    var itemsSold = [SoldItemsModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsSold.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! SoldItemsTableViewCell
        
        let soldItems: SoldItemsModel
        soldItems = itemsSold[indexPath.row]
        
        myCell.soldLabel.text = soldItems.itemName
        
        return myCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("sold_items")
        ref.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.itemsSold.removeAll()
                
                for i in snapshot.children.allObjects as![DataSnapshot] {
                    let itemObject = i.value as? [String: AnyObject]
                    let name = itemObject?["name"]
                    
                    let i = SoldItemsModel(itemName: name as! String?)
                    
                    self.itemsSold.append(i)
                }
                
                self.tblSold.reloadData()
            }
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
