//
//  UserBackup.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 10/02/2022.
//

import Foundation
import RealmSwift

// MARK: Model
class UserRecord: Object {
    @Persisted(primaryKey: true) var login: String?
    @Persisted var avatar_url: String?
    @Persisted var url: String?
    @Persisted var html_url: String?
    @Persisted var name:String?
    @Persisted var bio:String?
    @Persisted var favorite:Bool = false
    
 
}
