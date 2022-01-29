//  ViewPokemonAbilitiesAction.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/23/21.

import UIKit

import PokemonFoundation
import PokemonUIKit

class ViewPokemonAbilitiesAction: PokédexMenuItemAction {
    
    let title: String = "View Abilities"
    
    var image: UIImage? { UIImage(systemName: "book.fill") }
    
    func viewController(for pokémon: Pokémon) -> UIViewController {
        let detailsController = PokemonAbilitiesViewController.instance(pokémon: pokémon)
        return detailsController
    }
    
}
