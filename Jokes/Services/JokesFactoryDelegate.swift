//
//  JokesFactoryDelegate.swift
//  Jokes
//
//  Created by Roman Yaschenkov on 20.05.2025.
//

protocol JokesFactoryDelegate: AnyObject {
    func didReceiveNextJoke(joke: Joke?)
    func didFailToLoadData(with error: Error)
}
