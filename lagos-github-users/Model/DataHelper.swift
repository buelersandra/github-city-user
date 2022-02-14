//
//  DataHelper.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 10/02/2022.
//

import RealmSwift
import Foundation

class DataHelper {
    
    static let shared = DataHelper()
    var notificationToken: NotificationToken?

    
    
    func groupUsersAlphabetically(users:[UserRecord]) -> [GroupedUsers]{
        let result = users
        print(result)

        
        let groups = Dictionary(grouping: result) { user in
            String(user.login!.uppercased().prefix(1).uppercased())
        }
    
        var groupUsers:[GroupedUsers] = groups.map { (key,value) in
            return GroupedUsers(alphabet: key, users: value)
        }
        
        groupUsers.sort()
        return groupUsers;
        
    }
    
    func convertModel(users:[User]) -> [UserRecord]{
        return users.map { user in
            UserRecord(value: ["login":user.login,
                               "avatar_url":user.avatar_url,
                               "url":user.url,
                               "html_url":user.html_url,
                               "name":user.name,
                               "bio":user.bio])
        }
        
        
        
        
    }
    

    
    func persistUserList(list:[User]){
        
        let userRecordList =  DataHelper.shared.convertModel(users: list)
        do {
            let realm = try Realm()
            userRecordList.forEach { record in
                try! realm.write(withoutNotifying: [notificationToken!], {
                    realm.add(record, update: .all)
                })
            }
            
            
           
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        

    }
    
    func retrieveSavedUsers(changeCallback:@escaping (RealmCollectionChange<Results<UserRecord>>)->Void) -> [UserRecord]{
        do {
            let realm = try Realm()
            let users = realm.objects(UserRecord.self).sorted(byKeyPath: "login")
            notificationToken = users.observe { [weak self] (changes: RealmCollectionChange) in
                changeCallback(changes)
                
            }

            return Array(users)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
       
        return [UserRecord]()
    }
    
    func favoriteUser(user:UserRecord){
        do {
            let realm = try Realm()
            let userFound = realm.object(ofType: UserRecord.self, forPrimaryKey: user.login!)
            try realm.write({
                userFound?.favorite = !(userFound?.favorite ?? false)
            })

            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func clearAllFavorites(){
        do {
            let realm = try Realm()
            let result = realm.objects(UserRecord.self).filter("favorite = true")
            try realm.write({
                result.forEach { record in
                    record.favorite = false
                }
            })
           
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAll(){
        do {
            let realm = try Realm()
            try! realm.write(withoutNotifying: [notificationToken!], {
                realm.deleteAll()
            })
        }
        catch let error as NSError {
            print(error)
        }
    }
}
