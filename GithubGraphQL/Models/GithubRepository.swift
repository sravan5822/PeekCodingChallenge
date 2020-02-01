//
//  GithubRepository.swift
//  GithubGraphQL
//
//  Created by user on 1/30/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

/*
 Name: graphql
 Path: https://github.com/graphql-go/graphql
 Owner: graphql-go
 avatar: https://avatars3.githubusercontent.com/u/14210643?v=4
 Stars: 5936
 */

struct GithubRepository
{
    let name: String
    let path: String
    let owner: String
    let avatar: String
    let stars: Int
  
  init(name: String, path: String, owner: String, avatar: String, stars: Int)
  {
    self.name = name
    self.path = path
    self.owner = owner
    self.avatar = avatar
    self.stars = stars
  }
}
