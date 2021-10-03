//
//  RequestAPI.swift
//  GitFollowers
//
//  Created by jh on 2021/10/01.
//

import Foundation

func requestGitFollowers(userName: String, completion: @escaping (_ data: Followers?) -> Void){
    
    guard let url: URL = URL(string: "https://api.github.com/users/\(userName)/followers") else {
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error{
            print(error.localizedDescription)
            return
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            completion(nil)
            return
        }
        guard let data = data else{
            return
        }
        do{
            let apiResponse = try JSONDecoder().decode(Followers.self, from: data)
            completion(apiResponse)
        }catch(let err){
            print(err.localizedDescription)
        }
    }.resume()
    
}
