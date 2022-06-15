//
//  NetworkController.swift
//  iTunesSearch
//
//  Created by Karl Pfister on 6/4/22.
//

import UIKit

struct NetworkController {
    // MARK: - URL
    static let baseURLString = "https://itunes.apple.com"
    
    // MARK: - Albums
    static func fetchAlbumsWith(searchTerm: String, completion: @escaping (Result<TopLevelDictionaryAlbums, ResultError>) -> Void) {
        
        guard let baseUrl = URL(string: baseURLString) else { completion(.failure(.invalidURL(baseURLString))); return}
        
        let searchKey = URLQueryItem(name: "term", value: searchTerm)
        let entityKey = URLQueryItem(name: "entity", value: "album")
        
        var urlComponents = URLComponents(url:baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/search"
        urlComponents?.queryItems = [searchKey,entityKey]
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL("Hmm, Something went wrong with the url contruction - Albums"))); return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error))); return
            }
            guard let data = data else {
                completion(.failure(.noData)); return
            }
            do {
                let data = try JSONDecoder().decode(TopLevelDictionaryAlbums.self, from: data)
                completion(.success(data))
            } catch {
                    completion(.failure(.thrownError(error))); return
            }
        }.resume()
    }
    
    // MARK: - Tracks
    static func fetchTracks(with albumID: String, completion: @escaping (Result<[Track], ResultError>) -> Void) {
        guard let baseUrl = URL(string: baseURLString) else { completion(.failure(.invalidURL(baseURLString))); return}
        let idKey = URLQueryItem(name: "id", value: albumID)
        let entityKey = URLQueryItem(name: "entity", value: "song")
        
        var urlComponents = URLComponents(url:baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/lookup"
        urlComponents?.queryItems = [idKey,entityKey]
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL("Hmm, Something went wrong with the url contruction - Albums"))); return }
        print(finalURL)
        
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error))); return
            }
            guard let data = data else {
                completion(.failure(.noData)); return
            }
            do {
                let tracks = try JSONDecoder().decode(TopLevelDictionaryTracks.self, from: data).results
                completion(.success(tracks))
            } catch {
                    completion(.failure(.thrownError(error))); return
            }
        }.resume()
    }
    // TODO: - finish this
    
    // MARK: - Image
    static func fetchAlbumImage(with albumImageString: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        
        guard let imageURL = URL(string: albumImageString) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error))); return
            }
            guard let data = data else {
                completion(.failure(.noData)); return
            }
            guard let albumImage = UIImage(data: data) else {
                completion(.failure(.unableToDecode)); return
            }
            completion(.success(albumImage))
        }.resume()
    }
}
