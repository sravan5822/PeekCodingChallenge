//
//  GitHubPageInfo.swift
//  GithubGraphQL
//
//  Created by user on 1/31/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

struct GithubPageInfo
{
    let hasNextPage: Bool
    let hasPreviousPage: Bool
    let startCursor: String?
    let endCursor: String?
  
  init(hasNextPage: Bool, hasPreviousPage: Bool, startCursor: String?, endCursor: String?)
  {
    self.hasNextPage = hasNextPage
    self.hasPreviousPage = hasPreviousPage
    if let startCur = startCursor
    {
        self.startCursor = startCur
    }
    else
    {
        self.startCursor = ""
    }
    
    if let endCur = endCursor
    {
        self.endCursor = endCur
    }
    else
    {
        self.endCursor = ""
    }
  }
}
