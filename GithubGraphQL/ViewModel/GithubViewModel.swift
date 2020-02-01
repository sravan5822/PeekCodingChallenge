//
//  GithubViewModel.swift
//  GithubGraphQL
//
//  Created by user on 1/30/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Apollo

protocol GithubViewModelDelegate: class {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
}

final class GithubViewModel
{
    private weak var delegate: GithubViewModelDelegate?
    private var isFetchInProgress = false
    private var pageInfo:GithubPageInfo?
    
    private var currentPage = 0
    
    var repositories: [GithubRepository] = []
    
    init(delegate: GithubViewModelDelegate?)
    {
      self.delegate = delegate
    }
    
    func fetchRepositories()
    {
        guard !isFetchInProgress else {
          return
        }
        
        isFetchInProgress = true
        
        var gqlQuery:SearchRepositoriesQuery
        if self.currentPage > 0 && self.pageInfo?.hasNextPage ?? false
        {
            gqlQuery = SearchRepositoriesQuery.init(first: 5, after: self.pageInfo?.endCursor, query: "graphql", type: SearchType.repository)
        }
        else
        {
            gqlQuery = SearchRepositoriesQuery.init(first: 5, query: "graphql", type: SearchType.repository)
        }
        
        RepositoriesGraphQLClient.searchRepositories(query: gqlQuery) { (result) in
          switch result {
          case .success(let data):
            if let gqlResult = data {
              
              if let pageInfo = gqlResult.data?.search.pageInfo
              {
                self.pageInfo = GithubPageInfo(hasNextPage: pageInfo.hasNextPage, hasPreviousPage: pageInfo.hasPreviousPage, startCursor: pageInfo.startCursor, endCursor: pageInfo.endCursor)
              }
              
              gqlResult.data?.search.edges?.forEach { edge in
                guard let repository = edge?.node?.asRepository?.fragments.repositoryDetails else { return }
                let repo = GithubRepository(name: repository.name, path: repository.url, owner: repository.owner.login, avatar: repository.owner.avatarUrl, stars: repository.stargazers.totalCount)
                self.repositories.append(repo)
                
              }
                
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.delegate?.onFetchCompleted(with: .none)
                    self.delegate?.onFetchCompleted(with: .none)
                }
                
            }
          case .failure(let error):
            if let error = error {
              DispatchQueue.main.async {
                self.isFetchInProgress = false
                  self.delegate?.onFetchFailed(with: error.localizedDescription)
              }
            }
            
          }
        }
    }
    
}
