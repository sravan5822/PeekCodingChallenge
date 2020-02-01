//
//  GithubRepositoriesListViewController.swift
//  GithubGraphQL
//
//  Created by user on 1/31/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class GithubRepositoriesListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var viewModel: GithubViewModel!
    
    private var shouldShowLoadingCell = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Github Graphql"
        self.viewModel = GithubViewModel(delegate: self)
        self.viewModel.fetchRepositories()
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
}


extension GithubRepositoriesListViewController: UITableViewDataSource, UITableViewDelegate
{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
  
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! GithubRepositoryTableViewCell
    
        let repo = viewModel.repositories[indexPath.row]
        cell.configure(with: repo)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let lastItem = viewModel.repositories.count - 1
        if indexPath.row == lastItem
        {
            viewModel.fetchRepositories()
        }
        
    }
}

extension GithubRepositoriesListViewController: GithubViewModelDelegate {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  {
    guard let newIndexPathsToReload = newIndexPathsToReload else
    {
      tableView.reloadData()
      return
    }
    
    let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
    tableView.reloadRows(at: indexPathsToReload, with: .automatic)
  }
  
  func onFetchFailed(with reason: String)
  {
    let alert = UIAlertController(title: "Failed", message: reason, preferredStyle: UIAlertController.Style.alert)

    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

    self.present(alert, animated: true, completion: nil)
    
  }
}

