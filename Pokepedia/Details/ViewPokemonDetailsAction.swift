import UIKit

import PokemonFoundation
import PokemonUIKit

class ViewPokemonDetailsAction: PokédexMenuItemAction {
    
    let title: String = "View Pokemon"
    
    var image: UIImage? { UIImage(systemName: "list.bullet") }
    
    func viewController(for pokémon: Pokémon) -> UIViewController {
        let detailsController = PokemonDetailsViewController.instance(pokémon: pokémon)
        return detailsController
    }
    
}
