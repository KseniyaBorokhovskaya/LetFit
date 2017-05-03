//
//  StartProfileTableViewController.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/28/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift

class StartProfileTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var hight: UITextField!
    
    var user: Results<User>!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            
            let realm = try! Realm()
            let user = User(name: name.text!,surname: surname.text!,sex: sex.text!, age: Int(age.text!)!, hight: Int(hight.text!)!, weight: Double(weight.text!)!)
            let todayData = realm.object(ofType: DailyData.self, forPrimaryKey: dateFormatter.string(from: (Date() as Date)) as AnyObject)
            
            try! realm.write {
                user.setBasalMetabolismAgain()
                todayData?.leftFat = user.setFat()
                todayData?.leftCarbs = user.setCarbs()
                todayData?.leftProtein = user.setProtein()
                realm.add(user)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil) //Write your storyboard name
            let viewController = storyboard.instantiateViewController(withIdentifier: "UserProfileTableViewController")
            let profileController = viewController as! UserProfileTableViewController

            
            let controller = segue.destination as! ResultsTableViewController
            
            
            controller.detailUser = user
            profileController.detailUser = user
            
            }
        }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        hight.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
