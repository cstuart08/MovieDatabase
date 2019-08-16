//
//  MovieController.swift
//  MovieDatabase
//
//  Created by Apps on 8/16/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MovieController {
    
    static func fetchMovies(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") else { completion([]); return }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let urlQueryItemKey = URLQueryItem(name: "api_key", value: "f773bd99f1300ca88446eb3e01aed5a6")
        let urlQueryItemSearch = URLQueryItem(name: "query", value: searchTerm)
        components?.queryItems = [urlQueryItemKey, urlQueryItemSearch]
        
        guard let finalURL = components?.url else { completion([]); return }
        
        let request = URLRequest(url: finalURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error creating a URL Session. Verify 'request' has a URL. \(#function) - \(error) - \(error.localizedDescription) ")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error receiving data.")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let topLevelDictionary = try decoder.decode(MovieTopLevelDictionary.self, from: data)
                print("Success getting movies.")
                completion(topLevelDictionary.results)
            } catch {
                print("Error")
                completion([])
            }
        }.resume()
        return
    }
    
    static func fetchArtwork(item: Movie, completion: @escaping ((UIImage?) -> Void)) {
        
        guard var baseURL = URL(string: "http://image.tmdb.org/t/p/w500") else { completion(nil); return }
        
        guard let imageURLAsString = item.imageURL else { return }
        
        let components = imageURLAsString
        
        baseURL.appendPathComponent(components)
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("Error creating URL Session for fetchArtwork. \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Could not get data from the image.")
                completion(nil)
                return
            }
            
            let artwork = UIImage(data: data)
            completion(artwork)
        }.resume()
    }
}
