//
//  lagos_github_usersTests.swift
//  lagos-github-usersTests
//
//  Created by Beulah Ana on 09/02/2022.
//

import XCTest
@testable import lagos_github_users

class lagos_github_usersTests: XCTestCase {
    
    var dataHelper:DataHelper!

    override func setUpWithError() throws {
       try super.setUpWithError()
        
        dataHelper = DataHelper.shared
    }

    override func tearDownWithError() throws {
        dataHelper = nil
        try super.tearDownWithError()
        
        
    }

    func testSizeOfUsersAfterConvertingIsEqual() throws {
        let list = [User(login: "ama", avatar_url: "", url: "", html_url: "", name: "", bio: ""),
                    User(login: "adjoa", avatar_url: "", url: "", html_url: "", name: "", bio: ""),
                    User(login: "kofi", avatar_url: "", url: "", html_url: "", name: "", bio: "")]
        
        
        
        let recordList =  dataHelper.convertModel(users: list)
        XCTAssertEqual(list.count, recordList.count, "Size of list if the same")
    }
    
    func testGroupingOfUsersAlphabetically() throws {
        let list = [User(login: "ama", avatar_url: "", url: "", html_url: "", name: "", bio: ""),
                    User(login: "adjoa", avatar_url: "", url: "", html_url: "", name: "", bio: ""),
                    User(login: "kofi", avatar_url: "", url: "", html_url: "", name: "", bio: "")]
        
        
        
        let recordList =  dataHelper.convertModel(users: list)
        
        let result = dataHelper.groupUsersAlphabetically(users: recordList)
        
        XCTAssertEqual(result.first?.alphabet, "A")
        XCTAssertEqual(result.last?.alphabet, "K")
        
        XCTAssertEqual(result.first?.users?.count, 2)
        XCTAssertEqual(result.last?.users?.count, 1)
        

    }

    

}
