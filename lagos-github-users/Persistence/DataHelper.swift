//
//  DataHelper.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 10/02/2022.
//

import RealmSwift
import Foundation

class DataHelper{
    
    static let shared = DataHelper()
    
    
    func groupUsersAlphabetically(users:[UserRecord]) -> [GroupedUsers]{
        let result = users
        print(result)

        
        let groups = Dictionary(grouping: result) { user in
            String(user.login!.prefix(0))
        }
    
        let groupUsers:[GroupedUsers] = groups.map { (key,value) in
            return GroupedUsers(alphabet: key, users: value)
        }
        
        
        return groupUsers;
        
    }
    
    func persistUserList(list:[UserRecord]){
        do {
            let realm = try Realm()
            list.forEach { record in
                try! realm.write {
                    realm.add(record)
                }
            }
            
            
           
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        

    }
    
    func retrieveSavedUsers() -> [UserRecord]{
        do {
            let realm = try Realm()
            let users = realm.objects(UserRecord.self).sorted(byKeyPath: "login")
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
            let objectId = try ObjectId(string: user.login!)
            let userFound = realm.object(ofType: UserRecord.self, forPrimaryKey: objectId)
            try realm.write({
                userFound?.favorite = !(userFound?.favorite ?? false)
            })

            //let predicate = NSPredicate(format: "login = %@ AND favorite = %@", user.login!, false)
            //let result = realm.objects(UserRecord.self).filter(predicate)
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func clearAllFavorites(){
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "favorite = %@", true)
            let result = realm.objects(UserRecord.self).filter(predicate)
            result.forEach { record in
                record.favorite = false
            }
           
        }
        catch let error as NSError {
            print(error)
        }
    }
}
