//
//  FetchImage.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/23.
//

import Foundation
import Alamofire



struct fetchImage {
    private init() { }
    static let shared = fetchImage()
    func fetchData(server: String, photoID: String, secret: String, completion: @escaping (_ data: FlickrPhoto2) -> Void) {

        let url = "https://live.staticflickr.com/\(server)/\(photoID)_\(secret)_m.jpg"
//        let url2 = "https://live.staticflickr.com/\(server)/\(photoID)_\(secret)_b.jpg"
        
        
        let body: Parameters = ["server": server, "photoID": photoID, "secret": secret]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    print(type(of: data) )
                    let returnedImage = UIImage.init(data: data)
                    print(returnedImage)
//                    completion(photos)

                } catch { print("error \(error)") }

            case .failure(let error):
                print("errorCode: \(error._code)")
                print("errorDescription: \(error.errorDescription!)")
            }
        }.resume()
    }
}
