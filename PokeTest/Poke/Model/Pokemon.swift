//
//  Pokemon.swift
//  PokeTest
//
//  Created by Barbara Barone on 19/07/21.
//

import Foundation

struct Pokemon: Decodable, Equatable {
    let abilities: [Ability]
}

struct Ability: Decodable, Equatable {
    let ability: AbilityInfo
    let isHidden: Bool
    let slot: Int
}

struct AbilityInfo: Decodable, Equatable {
    let name: String
    let url: String
}


