//
//  Joke.swift
//  Jokes
//
//  Created by Roman Yaschenkov on 20.05.2025.
//

import Foundation

struct Joke: Codable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
