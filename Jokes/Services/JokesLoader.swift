//
//  JokesLoader.swift
//  Jokes
//
//  Created by Roman Yaschenkov on 20.05.2025.
//

import Foundation

protocol JokesLoading {
    func loadRandomJoke(handler: @escaping (Result<Joke, Error>) -> Void)
}

struct JokesLoader: JokesLoading {
    // MARK: - JokesLoading
    func loadRandomJoke(handler: @escaping (Result<Joke, Error>) -> Void) {
        networkClient.fetch(url: randomJokeUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let joke = try JSONDecoder().decode(Joke.self, from: data)
                    handler(.success(joke))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    // MARK: - NetworkCliend
    private let networkClient = NetworkClient()
    
    // MARK: - URL
    private var randomJokeUrl: URL {
        guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
}

