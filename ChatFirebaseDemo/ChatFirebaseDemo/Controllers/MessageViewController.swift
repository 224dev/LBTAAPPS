//
//  HomeTableViewController.swift
//  ChatFirebaseDemo
//
//  Created by Abdoulaye Diallo on 7/18/17.
//  Copyright © 2017 Abdoulaye Diallo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MessageViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        checkIfUserIsLogged()
        
        let nmImage = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nmImage, style: .plain, target: self, action: #selector(handleNewMessage))
        
    }
    
    //MARK:- Custom Functions
    func checkIfUserIsLogged(){
            if Auth.auth().currentUser?.uid == nil {
                perform(#selector(handleLogOut), with: nil, afterDelay: 0)
            } else {
                let uid = Auth.auth().currentUser?.uid
                Database.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                    print(snapshot)
                }, withCancel: nil)   
        }
            
    }
    
    
    @objc func handleLogOut()  {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print( error.localizedDescription)
        }
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }
 //MARk- Handle New Message
    
    @objc func handleNewMessage()  {
        
         let messageController = NewMessageTableViewController()
         let navController = UINavigationController(rootViewController: messageController)
        present( navController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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