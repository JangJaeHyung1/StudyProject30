//
//  PhotosModel.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/23.
//

import UIKit

// MARK: - fetchData

struct fetchData: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
