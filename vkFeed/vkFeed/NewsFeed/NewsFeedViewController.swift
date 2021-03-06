//
//  NewsFeedViewController.swift
//  vkFeed
//
//  Created by  Евгений on 27/05/2019.
//  Copyright (c) 2019 LosAnatoly Inc.. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {
  

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [])

    @IBOutlet weak var table: UITableView!
    
    private var titleView = TitleView()
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupTopBars()
   
    interactor?.makeRequest(request: .getNewsFeed)
    interactor?.makeRequest(request: .getUser)
    
    setupTable()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
    
    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
        
    }
    
    private func setupTable() {
        
//        let topInset: CGFloat = 2
//        table.contentInset.top = topInset
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        
        table.addSubview(refreshControl)
    }
    
    @objc private func refresh() {
        print("hello")
        interactor?.makeRequest(request: .getNewsFeed)
    }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    
   

    case .displayNewsFeed(let feedViewModel):
        self.feedViewModel = feedViewModel
        table.reloadData()
        refreshControl.endRefreshing()
    case .displayUser(let userViewModel):
        titleView.set(userViewModel: userViewModel)
    }
  }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
        }
    }
    
    //MARK:  delegate

    
    func revealPost(for cell: NewsFeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
        
    }
    
  
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
//        return 212
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    
    
    
}
