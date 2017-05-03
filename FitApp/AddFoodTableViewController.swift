//
//  AddFoodTableViewController.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class AddFoodTableViewController: UITableViewController {
    
     var foodFromBase: Results<Food>!

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        foodFromBase = realm.objects(Food.self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodFromBase.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foodFromBase[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodTableViewCell
        //cell.textLabel!.text = activity.nameOfActivity
        cell.configureWithFood(food)
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! foodFromBase.realm!.write {
                let food = self.foodFromBase[indexPath.row]
                self.foodFromBase.realm!.delete(food)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //        else if editingStyle == .insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "AddMeal" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let food : Food
//                food = foodFromBase[indexPath.row]
//                let controller = segue.destination as! SelectedFoodTableViewController
//                controller.detailFood = food
//            }
//        }
//    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMeal" {
                        if let indexPath = tableView.indexPathForSelectedRow {
                            let food : Food
                            food = foodFromBase[indexPath.row]
                            let controller = segue.destination as! SelectedFoodTableViewController
                            controller.detailFood = food
                        }
                    }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
