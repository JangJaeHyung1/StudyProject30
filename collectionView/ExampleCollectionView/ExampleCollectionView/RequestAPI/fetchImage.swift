//
//  RequestImage.swift
//  ExampleCollectionView
//
//  Created by jh on 2021/10/01.
//

import Foundation
import UIKit

func fetchImage(serverId: String, photoId: String, secretKey: String) -> UIImage? {
    
    guard let url: URL = URL(string: "https://live.staticflickr.com/\(serverId)/\(photoId)_\(secretKey)_m.jpg") else {
        return nil
    }
    let imageData = try! Data(contentsOf: url)
    return UIImage(data: imageData)
}
