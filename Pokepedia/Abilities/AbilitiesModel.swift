//  AbilitiesModel.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/23/21.

import Foundation

final class AbilitiesModel {
    
    // MARK: - Generic Unwrapping Functions
    
    func unwrapArrayCount(pokemonInteger: Int?) -> Int {
        guard let pokemonIntegerLabel = pokemonInteger else {
            return 0
        }
        
        return pokemonIntegerLabel
    }
    
    func unwrapBoolean(pokemonBoolean: Bool?) -> String {
        guard let pokemonBooleanLabel = pokemonBoolean else {
            return "Unknown"
        }
        
        if pokemonBooleanLabel {
            return "Yes"
        } else {
            return "No"
        }
    }
    
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
        
        return formattedString(stringToFix: pokemonStringLabel)
    }
    
    func unwrapGeneration(pokemonString: String?) -> String {
        guard let pokemonStringLabel = pokemonString else {
            return "Unknown"
        }
        
        return formattedGeneration(stringToFix: pokemonStringLabel)
    }
    
    // MARK: - Formatting Functions
    
    private func formattedString(stringToFix: String) -> String {
        var newString: String = ""
        var firstLetter: Bool = true
        
        for char in stringToFix {
            
            if char.isLetter {
                if firstLetter {
                    
                    newString.append(char.uppercased())
                } else {
                    
                    newString.append(char.lowercased())
                }
                firstLetter = false
            } else if char.isNumber {
                
                newString.append(char)
                firstLetter = false
            } else {
                
                newString.append(" ")
                firstLetter = true
            }
        }
        
        return newString
    }
    
    private func formattedGeneration(stringToFix: String) -> String {
        var newString: String = ""
        var firstLetter: Bool = true
        var firstWordDone: Bool = false
        
        for char in stringToFix {
            
            if char.isLetter {
                if firstLetter {
                    
                    newString.append(char.uppercased())
                } else if firstWordDone {
                
                    newString.append(char.uppercased())
                } else {
                    
                    newString.append(char.lowercased())
                }
                firstLetter = false
            } else {
                
                newString.append(" ")
                firstWordDone = true
            }
        }
        
        return newString
    }
    
}
