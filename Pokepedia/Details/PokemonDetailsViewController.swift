import UIKit
import PokemonFoundation

final class PokemonDetailsViewController: UIViewController {
    
    // MARK: - Variables & IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var moveLabel: UILabel!
    
    private var pokemon: Pokémon!
    private var model: DetailsModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = DetailsModel()
        
        fillView()
    }

}

// MARK: - Unwrapping Values and Displaying Them

extension PokemonDetailsViewController {
    private func fillView() {
        
        // MARK: - Obtaining Some Values
        
        let pokemonTypeName = pokemon.types?.first?.type?.name
        let pokemonBaseStat = pokemon.stats?.first?.baseStat
        let pokemonPossibleItem = pokemon.heldItems?.first?.item?.name
        let pokemonAbilityName = pokemon.abilities?.first?.ability?.name
        let pokemonMoveName = pokemon.moves?.first?.move?.name
        
        // MARK: - Filling Labels and Retrieving Model Information
        
        // Decided to separate the lines below so they are a bit easier to read

        nameLabel.text = model.combineStrings(labelTitle: "Name: ", labelInformation: pokemon.displayName)
        
        idLabel.text = model.combineStrings(labelTitle: "ID: ", labelInformation: model.unwrapInteger(pokemonInteger: pokemon.id))
        
        heightLabel.text = model.combineStrings(labelTitle: "Height: ", labelInformation: model.unwrapInteger(pokemonInteger: pokemon.height))
        
        weightLabel.text = model.combineStrings(labelTitle: "Weight: ", labelInformation: model.unwrapInteger(pokemonInteger: pokemon.weight))
        
        typeLabel.text = model.combineStrings(labelTitle: "Main Type: ", labelInformation: model.unwrapString(pokemonString: pokemonTypeName))
        
        experienceLabel.text = model.combineStrings(labelTitle: "Base Stat: ", labelInformation: model.unwrapInteger(pokemonInteger: pokemonBaseStat))
        
        statsLabel.text = model.combineStrings(labelTitle: "Base EXP: ", labelInformation: model.unwrapInteger(pokemonInteger: pokemon.baseExperience))
        
        itemLabel.text = model.combineStrings(labelTitle: "Possible Item: ", labelInformation: model.unwrapString(pokemonString: pokemonPossibleItem))
        
        abilityLabel.text = model.combineStrings(labelTitle: "An Ability: ", labelInformation: model.unwrapString(pokemonString: pokemonAbilityName))
        
        moveLabel.text = model.combineStrings(labelTitle: "A Move: ", labelInformation: model.unwrapString(pokemonString: pokemonMoveName))
    }
}

// MARK: - Creating Instance

extension PokemonDetailsViewController {
    
    static func instance(pokémon: Pokémon) -> PokemonDetailsViewController {
        // swiftlint:disable:next force_cast
        let viewController = UIStoryboard(name: "PokemonDetails", bundle: nil).instantiateInitialViewController() as! PokemonDetailsViewController
        viewController.pokemon = pokémon
        return viewController
    }
}
