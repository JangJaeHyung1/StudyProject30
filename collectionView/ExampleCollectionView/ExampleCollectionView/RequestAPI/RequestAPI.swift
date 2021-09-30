//
//  FetchPhotos.swift
//  ExampleCollectionView
//
//  Created by jh on 2021/10/01.
//

import Foundation


func requestFlickr(searchKey: String, completion: @escaping (_ data: [Photo]) -> Void){
    
    let apiKey = "be83bddb963d2ad00bcb99f8c9c43e1f"

    guard let url: URL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchKey)&per_page=20&format=json&nojsoncallback=1") else {
        return
    }
    
    let dataTask: URLSessionTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error{
            print(error.localizedDescription)
            return
        }
        guard let data = data else{
            return
        }
        do{
            let apiResponse = try JSONDecoder().decode(fetchData.self, from: data)
            completion(apiResponse.photos.photo)
            
        }catch(let err){
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}
