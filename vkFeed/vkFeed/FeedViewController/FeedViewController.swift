//
//  FeedViewController.swift
//  vkFeed
//
//  Created by  Евгений on 26/05/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import UIKit
import VKSdkFramework

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetwoorkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3005838394, blue: 0.2565174997, alpha: 1)
        fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else {return}
            feedResponse.items.map({ (feedItem) in
                print(feedItem.date)
            })
        }
        

        }

        
    }
    


