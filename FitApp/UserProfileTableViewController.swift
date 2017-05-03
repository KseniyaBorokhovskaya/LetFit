//
//  UserProfileTableViewController.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/29/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift

class UserProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var hight: UITextField!

    
    @IBOutlet weak var basalMetabolism: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var fat: UILabel!
    
    @IBOutlet weak var EditButton: UIBarButtonItem!
    
    var firstLoad = true
    var editTextFieldToggle: Bool = false
    
    let dateFormatter = setDateFormatter()
    
    @IBAction func Edit(_ sender: UIButton) {
        editTextFieldToggle = !editTextFieldToggle
        if editTextFieldToggle == true {
            textFieldActive()
            EditButton.title = "Done"
            
        } else {
            textFieldDeactive()
            EditButton.title = "Edit"
            
        }
    }
    
    func textFieldActive()
    {
        name.isEnabled = true
        surname.isEnabled = true
        sex.isEnabled = true
        age.isEnabled = true
        weight.isEnabled = true
        hight.isEnabled = true
    }
    
    func textFieldDeactive()
    {
        name.isEnabled = false
        surname.isEnabled = false
        sex.isEnabled = false
        age.isEnabled = false
        weight.isEnabled = false
        hight.isEnabled = false
    }
    
    var detailUser: User? {
        didSet {
            configureResultsView()
            configureProfileView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstLoad == true
        {
            configureProfileView()
        }
        configureResultsView()
        if let realm = try? Realm() {
            let user = realm.objects(User.self)[0]
            basalMetabolism.text = String(user.basalMetabolism)
            name.text = String(user.name)
            surname.text = String(user.surname)
            sex.text = String(user.sex)
            age.text = String(user.age)
            hight.text = String(user.hight)
            weight.text = String(user.weight)
            carbs.text = String(user.carbs)
            fat.text = String(user.fat)
            protein.text = String(user.protein)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func configureResultsView() {
        if let detailUser = detailUser {
            if let basalMetabolism = basalMetabolism,
                let carbs = carbs,
                let protein = protein,
                let fat = fat
            {
                basalMetabolism.text = String(detailUser.basalMetabolism)
                carbs.text = String(detailUser.carbs)
                protein.text = String(detailUser.protein)
                fat.text = String(detailUser.fat)
            }
        }
    }
    
    
    func configureProfileView() {
        if let detailUser = detailUser {
            if let name = name,
                let surname = surname,
                let sex = sex,
                let age = age,
                let weight = weight,
                let hight = hight
            {
                name.text = detailUser.name
                surname.text = detailUser.surname
                sex.text = detailUser.sex
                age.text = String(detailUser.age)
                weight.text = String(detailUser.weight)
                hight.text = String(detailUser.hight)
            }
        }
        // firstLoad = false
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
