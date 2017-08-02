//
//  NewMessageTableViewController.swift
//  ChatFirebaseDemo
//
//  Created by Abdoulaye Diallo on 7/22/17.
//  Copyright © 2017 Abdoulaye Diallo. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    var users = [User]()
    //Reference to the Mesages View Controllers...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat Log Controller"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        fetchUser()
    }
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                self.users.append(user)
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
    
      var aMessageController: MessagesController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            let user = self?.users[indexPath.row]
            self?.aMessageController?.showChatControllerForUser(user!)
        }
    }
    
}


