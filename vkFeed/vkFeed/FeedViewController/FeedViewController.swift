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
    
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3005838394, blue: 0.2565174997, alpha: 1)
        networkService.getFeed()

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
