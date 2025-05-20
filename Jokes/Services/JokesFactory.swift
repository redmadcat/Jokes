//
//  JokesFactory.swift
//  Jokes
//
//  Created by Roman Yaschenkov on 20.05.2025.
//

import Foundation

final class JokesFactory: JokesFactoryProtocol {
    // MARK: - Definition
    private let jokesLoader: JokesLoading
    private let delegate: JokesFactoryDelegate?
        
    init(jokesLoader: JokesLoading, delegate: JokesFactoryDelegate) {
        self.jokesLoader = jokesLoader
        self.delegate = delegate
    }
     
    // MARK: - JokesFactoryProtocol
    func requestNextJoke() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            jokesLoader.loadRandomJoke { result in
                switch result {
                case .success(let randomJoke):
                    self.delegate?.didReceiveNextJoke(joke: randomJoke)
                case.failure(let error):
                    DispatchQueue.main.async {
                        self.delegate?.didFailToLoadData(with: error)
                    }
                }
            }
        }
    }
}
