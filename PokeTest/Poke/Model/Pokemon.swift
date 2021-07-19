//
//  Pokemon.swift
//  PokeTest
//
//  Created by Barbara Barone on 19/07/21.
//

import Foundation

struct Pokemon: Decodable {
    let abilities: [Ability]
}

struct Ability: Decodable {
    let ability: AbilityInfo
    let isHidden: Bool
    let slot: Int
}

struct AbilityInfo: Decodable {
    let name: String
    let url: String
}


