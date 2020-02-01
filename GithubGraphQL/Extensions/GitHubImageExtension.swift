//
//  GitHubImageExtension.swift
//  GithubGraphQL
//
//  Created by user on 1/31/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL)
    {
        contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                
                self.image = image
            }
        }.resume()
    }
}
