//  AbilityDetailsViewController.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/24/21.

import UIKit
import PokemonFoundation

final class AbilityDetailsViewController: UIViewController {
    
    // MARK: - Variables and Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var mainSeriesLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var detailsTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var model: AbilityNetworkModel!
    private var unwrapModel: AbilitiesModel!
    private var abilityReturnedInfo: NetworkingPayload!
    private var pokemonList: [AbilityPokemon]!
    private var abilityURL: URL!
    
    // MARK: - Lifcycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ability Details"
        
        model = AbilityNetworkModel(serviceClient: ServiceClient(), delegate: self)
        unwrapModel = AbilitiesModel()
        
        model.grabInformation(abilityURL: abilityURL)
    }
}

// MARK: - Delegate Responses

extension AbilityDetailsViewController: ModelDelegate {
    func willDownload() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func didReceive(abilityInformation: NetworkingPayload) {
        DispatchQueue.main.async { [weak self] in
            self?.abilityReturnedInfo = abilityInformation
            self?.fillPage()
    
        }
    }
    
    func didReceive(error: Error) {
        DispatchQueue.main.async { [weak self] in
            let errorAlert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            errorAlert.addAction(confirmAction)
            
            self?.present(errorAlert, animated: true)
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Function to Update UI in Case of Success

extension AbilityDetailsViewController {
    private func fillPage() {
        nameLabel.text = "Ability Name: " + unwrapModel.unwrapString(pokemonString: abilityReturnedInfo.name)
        idLabel.text = "Ability ID: " + unwrapModel.unwrapInteger(pokemonInteger: abilityReturnedInfo.id)
        mainSeriesLabel.text = "Is Ability From Main Games: " + unwrapModel.unwrapBoolean(pokemonBoolean: abilityReturnedInfo.fromMainSeries)
        generationLabel.text = "Generation Origin: " + unwrapModel.unwrapGeneration(pokemonString: abilityReturnedInfo.generation?.name)
        listLabel.text = "List of Pokemon With This Ability: "
        
        pokemonList =  abilityReturnedInfo.pokemon ??  []
        
        detailsTable.delegate = self
        detailsTable.dataSource = self
        activityIndicator.stopAnimating()
        detailsTable.reloadData()
    }
}

// MARK: - Displaying and Filling the Table

 extension AbilityDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 }

 extension AbilityDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return unwrapModel.unwrapArrayCount(pokemonInteger: pokemonList.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = pokemonList[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityDetailViewCell") else {
            let cell = UITableViewCell()
            configure(cell, using: pokemon)

            return cell
        }

        configure(cell, using: pokemon)
        return cell
    }
 }

// MARK: - Filling the Cell

 extension AbilityDetailsViewController {

    private func configure(_ cell: UITableViewCell, using pokemon: AbilityPokemon) {
        cell.textLabel?.text = unwrapModel.unwrapString(pokemonString: pokemon.pokemon?.name)
    }
 }

// MARK: - Creating Our Storyboard Instance

extension AbilityDetailsViewController {

    static func instance(unwrappedURL: URL) -> AbilityDetailsViewController {
        // swiftlint:disable:next force_cast
        let viewController = UIStoryboard(name: "AbilityDetails", bundle: nil).instantiateInitialViewController() as! AbilityDetailsViewController
        viewController.abilityURL = unwrappedURL
        
        return viewController
    }
}
