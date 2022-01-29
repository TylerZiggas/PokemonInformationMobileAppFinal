//  DetailsModel.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/7/21.

import Foundation

final class DetailsModel {
    
    // MARK: - Generic Unwrapping Functions
    
    func unwrapInteger(pokemonInteger: Int?) -> String {
        guard let pokemonIntegerLabel = pokemonInteger else {
            return "Unknown"
        }
        
        return "\(pokemonIntegerLabel)"
    }
    
    func unwrapString(pokemonString: String?) -> String {
        guard let pokemonStringLabel = pokemonString else {
            return "Unknown"
        }
        
        return "\(pokemonStringLabel)"
    }
    
    // MARK: - Generic Function for Concating Strings
    
    func combineStrings(labelTitle: String, labelInformation: String) -> String {
        return labelTitle + labelInformation
    }
}
