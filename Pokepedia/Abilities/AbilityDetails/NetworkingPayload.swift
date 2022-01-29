//  NetworkingPayload.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/28/21.

import Foundation

// MARK: - Payload Structs

struct NamedAPIResource: Codable {
    let name: String?
    let url: String?
}

struct AbilityPokemon: Codable {
    let pokemon: NamedAPIResource?
    
    enum CodingKeys: String, CodingKey {
        case pokemon
    }
}

struct NetworkingPayload: Codable {
    let id: Int?
    let name: String?
    let fromMainSeries: Bool?
    let generation: NamedAPIResource?
    let pokemon: [AbilityPokemon]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fromMainSeries = "is_main_series"
        case generation
        case pokemon
    }
}
