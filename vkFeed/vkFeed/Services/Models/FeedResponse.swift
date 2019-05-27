//
//  FeedResponse.swift
//  vkFeed
//
//  Created by  Евгений on 27/05/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}
struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?

}

struct CountableItem: Decodable {
    let count: Int
}
