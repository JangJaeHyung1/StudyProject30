//
//  Model.swift
//  GitFollowers
//
//  Created by jh on 2021/10/01.
//

import Foundation

// MARK: - WelcomeElement

typealias Followers = [Follower]

struct Follower: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}


