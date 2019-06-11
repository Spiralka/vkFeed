//
//  UserResponse.swift
//  vkFeed
//
//  Created by  Евгений on 11/06/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
