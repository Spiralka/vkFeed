//
//  NewsFeedInteractor.swift
//  vkFeed
//
//  Created by  Евгений on 27/05/2019.
//  Copyright (c) 2019 LosAnatoly Inc.. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
  private var fetcher: DataFetcher = NetwoorkDataFetcher(networking: NetworkService())
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    
    switch request {

    case .getNewsFeed:
        fetcher.getFeed { [weak self] (feedResponse) in
            self?.feedResponse = feedResponse
            self?.presentFeed()
        }
   
    case .revealPostIds(let postId):
        revealedPostIds.append(postId)
       presentFeed()
        
    case .getUser:
        fetcher.getUser { (userResponse) in
            self.presenter?.presentData(response: .presentUserInfo(user: userResponse))
        }
    }
 }
    
    private func presentFeed() {
        guard let feedRsponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse!, revealdedPostIds: revealedPostIds))
    }
}
