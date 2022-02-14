//
//  Responses.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 09/02/2022.
//

import Foundation

struct UsersResponse: Codable {
    let total_count: Int?
    let incomplete_results: Bool?
    let items: [User]?
}

// MARK: - Item
struct User: Codable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.login! < rhs.login!
    }
    
    let login: String?
    let avatar_url: String?
    let url, html_url: String?
    let name,bio:String?
    
}

struct GroupedUsers : Comparable{
    var alphabet:String?
    var users:[UserRecord]?
    
    static func < (lhs: GroupedUsers, rhs: GroupedUsers) -> Bool {
        lhs.alphabet! < rhs.alphabet!
    }
}
