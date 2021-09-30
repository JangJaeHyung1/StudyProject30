//
//  RequestAPI.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/23.
//

import Foundation
import Alamofire

struct fetchAPI {
    private init() { }
    static let shared = fetchAPI()
    func fetchData(searchKey: String, completion: @escaping (_ data: Welcome) -> Void) {
        
        let apiKey = "be83bddb963d2ad00bcb99f8c9c43e1f"
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json" ]

        let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchKey)&per_page=20&format=json&nojsoncallback=1"
        
        
        let body: Parameters = ["searchKey": searchKey]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            
            case .success:
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let photos = try decoder.decode(Welcome.self, from: data)
                    for ph in photos.photos.photo{
//                        print("ph = \(ph)")
                        fetchImage.shared.fetchData(server: ph.server, photoID: ph.id, secret: ph.secret) { FlickrPhoto in
//                            print(FlickrPhoto)
                        }
                    }
                    completion(photos)
                    
                } catch { print("error \(error)") }
            
            case .failure(let error):
                print("errorCode: \(error._code)")
                print("errorDescription: \(error.errorDescription!)")
            }
        }.resume()
    }
}
