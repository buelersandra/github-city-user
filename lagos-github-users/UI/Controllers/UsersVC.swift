//
//  UsersVC.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 09/02/2022.
//

import UIKit
import RealmSwift
import SwiftUI

class UsersVC: InfiniteScrollTableViewController {
    
    var pageNumber = 0
    var activityIndicatorView: UIActivityIndicatorView!

    
    var data:[GroupedUsers] = [GroupedUsers]() {
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.tableView.backgroundView = activityIndicatorView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        
       loadDataLocal()

    }
    
    override func fetchData() {
        activityIndicatorView.startAnimating()
        //check status of response
        Requester.shared.fetchUsers(pageNumber: pageNumber) { response in
            
            if let items = response.items{
                let persistedUsers = items.map { user in
                    UserRecord(value: ["login":user.login,
                                       "avatar_url":user.avatar_url,
                                       "url":user.url,
                                       "html_url":user.html_url,
                                       "name":user.name,
                                       "bio":user.bio])
                }
                DataHelper.shared.persistUserList(list: persistedUsers)
                self.pageNumber+=1
                
                self.loadDataLocal()
            }else{
                
                print("something went wrong")
            }
            
            self.activityIndicatorView.stopAnimating()

        }
    }
    
    func loadDataLocal(){
        self.data = DataHelper.shared.groupUsersAlphabetically(users: DataHelper.shared.retrieveSavedUsers())
        fetchData()

    }
    
}

// MARK: - Table view data source
extension UsersVC{
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].users?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.render(user: data[indexPath.section].users![indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].alphabet
    }
    
}
