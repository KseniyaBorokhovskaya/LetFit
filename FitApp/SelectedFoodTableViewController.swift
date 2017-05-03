//
//  SelectedFoodTableViewController.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift

class SelectedFoodTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var servingSize: UITextField!
    @IBOutlet weak var numberOfServings: UITextField!
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var caloriesPer100g: UILabel!
    @IBOutlet weak var finalCalories: UILabel!
    @IBOutlet weak var finalCarbs: UILabel!
    @IBOutlet weak var finalFat: UILabel!
    @IBOutlet weak var finalProtein: UILabel!
    
    var calories: RealmInt = RealmInt(value: 0)
    var carbs: RealmInt = RealmInt(value: 0)
    var fat: RealmInt = RealmInt(value: 0)
    var protein: RealmInt = RealmInt(value: 0)
    
    
    let dateFormatter = setDateFormatter()
    
    @IBAction func AddFoodTodailyBase(_ sender: UIButton) {
        if let realm = try? Realm(),
            let todayData = realm.object(ofType: DailyData.self, forPrimaryKey: dateFormatter.string(from: (Date() as Date)) as AnyObject) {
            try! realm.write {
                todayData.food.append(detailFood!)
                todayData.foodCalories.append(calories)
                todayData.carbs.append(carbs)
                todayData.fat.append(fat)
                todayData.protein.append(protein)
                todayData.eatenCalories = todayData.eatenCalories + calories.intValue
                todayData.leftFat = todayData.leftFat - Double(fat.intValue)
                todayData.leftCarbs = todayData.leftCarbs - Double(carbs.intValue)
                todayData.leftProtein = todayData.leftProtein - Double(protein.intValue)
            }
        }
    }
    
    var detailFood: Food? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailFood = detailFood {
            if let mealName = mealName, let caloriesPer100g = caloriesPer100g {
                mealName.text = detailFood.nameOfFood
                caloriesPer100g.text = String(detailFood.calories)
                title = detailFood.nameOfFood
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        numberOfServings.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        calories = RealmInt(value: Int(textField.text!)! * Int(servingSize.text!)! * Int(caloriesPer100g.text!)! / 100)
        finalCalories.text = String(describing: calories.intValue)
        carbs = RealmInt(value: Int(textField.text!)! * Int(servingSize.text!)! * Int((detailFood?.carbohydrates)!) / 100)
        finalCarbs.text = String(describing: carbs.intValue)
        fat = RealmInt(value: Int(textField.text!)! * Int(servingSize.text!)! * Int((detailFood?.fat)!) / 100)
        finalFat.text = String(describing: fat.intValue)
        protein = RealmInt(value: Int(textField.text!)! * Int(servingSize.text!)! * Int((detailFood?.protein)!) / 100)
        finalProtein.text = String(describing: protein.intValue)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
