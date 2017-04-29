//
//  SelectedActivityTableViewController.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift

class SelectedActivityTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var ActivityName: UILabel!
    @IBOutlet weak var CaloriesPerHour: UILabel!
    
    @IBOutlet weak var minutes: UITextField!
    
    @IBOutlet weak var FinalCalories: UILabel!
    
    @IBAction func AddActivityToDailyBase(_ sender: UIButton)
    {
        let today: String? = String(describing: Date())
        if let realm = try? Realm(),
        let todayData = realm.object(ofType: DailyData.self, forPrimaryKey: today as AnyObject) {
            try! realm.write {
                todayData.activity.append(detailActivity!)
            }
        }
    }
    var detailActivity: Activity? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailActivity = detailActivity {
            if let ActivityName = ActivityName, let CaloriesPerHour = CaloriesPerHour {
                ActivityName.text = detailActivity.nameOfActivity
                CaloriesPerHour.text = String(detailActivity.calories)
                title = detailActivity.nameOfActivity
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        minutes.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    //textfield func for the touch on BG
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        minutes.resignFirstResponder()
//        self.view.endEditing(true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



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
