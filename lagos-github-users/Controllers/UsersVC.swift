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
    
    var activityIndicatorView: UIActivityIndicatorView!

    
    var data:[GroupedUsers] = [GroupedUsers]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        self.tableView.backgroundView = activityIndicatorView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(deleteAllFavorites)), animated: true)
       loadDataLocal()
        fetchData()


    }
    
    @objc func deleteAllFavorites(){
        DataHelper.shared.clearAllFavorites()
    }
    
    override func fetchData() {
        activityIndicatorView.startAnimating()
        //check status of response
        Requester.shared.fetchUsers(pageNumber: page) { response in
            self.stopInfiniteLoading()

            if let items = response?.items{
                self.page+=1
                
                if self.page == 1{
                    DataHelper.shared.deleteAll()
                }
                
                DataHelper.shared.persistUserList(list:  items)
                self.loadDataLocal()
            }else{
                
                print("something went wrong")
            }
            
            self.activityIndicatorView.stopAnimating()

        }
    }
    
    func loadDataLocal(){
        self.data = DataHelper.shared.groupUsersAlphabetically(users: DataHelper.shared.retrieveSavedUsers(){ changes in
            self.updateTableVIew(changes: changes)
           
        })
    
    }
    
    func updateTableVIew(changes:RealmCollectionChange<Results<UserRecord>>){
        
        switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.performBatchUpdates({
                self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                                 with: .automatic)
                self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                 with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                                 with: .automatic)
                        }, completion: { finished in
                            self.tableView.reloadData()
                        })
            case .error(let error):
                fatalError("\(error)")
        }
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
