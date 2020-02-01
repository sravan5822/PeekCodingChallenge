//
//  GithubRepositoryTableViewCell.swift
//  GithubGraphQL
//
//  Created by user on 1/31/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class GithubRepositoryTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var ownerLabel:UILabel!
    @IBOutlet var starsLabel:UILabel!
    @IBOutlet var profileImageView:UIImageView!
    
    func configure(with repo: GithubRepository?)
    {
      if let repo = repo
      {
        self.nameLabel.text = repo.name
        self.ownerLabel.text = repo.owner
        self.starsLabel.text = "\(repo.stars)"
        
        if let url = URL(string: repo.avatar)
        {
            profileImageView?.setImage(from: url)
        }
      }
      else
      {
        
      }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
