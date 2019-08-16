//
//  MovieResultsTableViewCell.swift
//  MovieDatabase
//
//  Created by Apps on 8/16/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class MovieResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieArtwork: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    var item: Movie? {
        didSet {
            guard let item = item else { return }
            
            movieTitleLabel.text = item.title
            movieRatingLabel.text = "Rating: \(item.rating)"
            movieSummaryLabel.text = item.summary
            movieArtwork.image = nil
            
            MovieController.fetchArtwork(item: item) { (fetchedArtwork) in
                if let artwork = fetchedArtwork {
                    DispatchQueue.main.async {
                        self.movieArtwork.image = artwork
                    }
                } else {
                    print("Artwork was not found or nil.")
                }
            }
        }
    }
}
