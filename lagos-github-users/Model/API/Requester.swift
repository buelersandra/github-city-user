//
//  Requester.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 09/02/2022.
//

import Foundation
import UIKit

class Requester{
    
    static let shared = Requester()
    
    func fetchUsers(pageNumber:Int, callback:@escaping (UsersResponse?)->Void){
        let url = URL(string: "https://api.github.com/search/users?q=lagos&page=\(pageNumber)")!

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
            if let data = data {
                
                    if let userResponse = try? JSONDecoder().decode(UsersResponse.self, from: data) {
                        print("THREAD ME \(Thread.current)")
                        callback(userResponse)
                        print(userResponse)
                    } else {
                        print("Invalid Response")
                        callback(nil)
                    }
                
               
            } else if let error = error {
                callback(nil)
                print("HTTP Request Failed \(error)")
            }
                
           }
        }
        
        task.resume()
    }
    
    //check for null url
    func loadUserImage(url:String, callback:@escaping (UIImage?)->Void){
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    callback(UIImage(data: data))
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            
        }
        
        task.resume()
        

    }
}
