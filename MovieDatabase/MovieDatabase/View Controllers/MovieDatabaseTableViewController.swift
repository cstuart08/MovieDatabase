//
//  MovieDatabaseTableViewController.swift
//  MovieDatabase
//
//  Created by Apps on 8/16/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class MovieDatabaseTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text, !searchTerm.isEmpty else { return }
        
        MovieController.fetchMovies(searchTerm: searchTerm) { (searchedMovies) in
            self.movies = searchedMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.movieSearchBar.text = ""
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieResultsTableViewCell
        let movie = movies[indexPath.row]
        cell.item = movie
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
