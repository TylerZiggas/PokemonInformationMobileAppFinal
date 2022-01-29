//  PokemonAbilitiesViewController.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/26/21.

import UIKit
import PokemonFoundation

final class PokemonAbilitiesViewController: UIViewController {
    
    // MARK: - Variables and Outlets
    
    @IBOutlet weak var abilitiesTable: UITableView!
    
    private var pokemonAbilities: [Pokémon.Ability]!
    private var model: AbilitiesModel!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokemon Abilities"
        
        model = AbilitiesModel()
        abilitiesTable.delegate = self
        abilitiesTable.dataSource = self
    }
}

// MARK: - Displaying and Filling the Table

extension PokemonAbilitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ability = pokemonAbilities[indexPath.row]
        var unwrappedURL: URL!
        
        if ability.ability?.url != nil {
            unwrappedURL = ability.ability?.url!
        } else {
            return
        }
        
        let viewController = AbilityDetailsViewController.instance(unwrappedURL: unwrappedURL)
        show(viewController, sender: nil)
    }
}

extension PokemonAbilitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.unwrapArrayCount(pokemonInteger: pokemonAbilities.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ability = pokemonAbilities[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityTableViewCell") else {
            let cell = UITableViewCell()
            configure(cell, using: ability)
            
            return cell
        }
        
        configure(cell, using: ability)
        return cell
    }
}

// MARK: - Filling the Cell

extension PokemonAbilitiesViewController {
    
    private func configure(_ cell: UITableViewCell, using ability: Pokémon.Ability?) {
        cell.textLabel?.text = model.unwrapString(pokemonString: ability?.ability?.name)
        cell.detailTextLabel?.text = "Is a Hidden Ability?: " + model.unwrapBoolean(pokemonBoolean: ability?.isHidden)
    }
}

// MARK: - Creating Our Storyboard Instance

extension PokemonAbilitiesViewController {
    
    static func instance(pokémon: Pokémon) -> PokemonAbilitiesViewController {
        // swiftlint:disable:next force_cast
        let viewController = UIStoryboard(name: "PokemonAbilities", bundle: nil).instantiateInitialViewController() as! PokemonAbilitiesViewController
            
        viewController.pokemonAbilities = pokémon.abilities ?? []
        
        return viewController
    }
}
