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
    
    private let networkService: Networking = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3005838394, blue: 0.2565174997, alpha: 1)
        let params = ["filters": "post, photo"]
        
        networkService.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("вечер добрый", error)
            }
            guard let data = data else { return }
           
            let json = try? JSONSerialization.jsonObject(with: data, options: [])

            print(json ?? "nil bratan")
        }

        
    }
    

}
