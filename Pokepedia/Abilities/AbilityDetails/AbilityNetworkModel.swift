//  AbilityNetworkModel.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/24/21.

import Foundation

// MARK: - Delegate Functions

protocol ModelDelegate: AnyObject {
    
    func willDownload()
    func didReceive(abilityInformation: NetworkingPayload)
    func didReceive(error: Error)
}

// MARK: - Setting Up Model

final class AbilityNetworkModel {
    
    private let serviceClient: ServiceClient
    private weak var delegate: ModelDelegate?
    
    init(serviceClient: ServiceClient, delegate: ModelDelegate) {
        self.serviceClient = serviceClient
        self.delegate = delegate
    }
    
}

// MARK: - Network Call Extension

extension AbilityNetworkModel {
    
    func grabInformation(abilityURL: URL) {
        delegate?.willDownload()
        
        serviceClient.get(from: abilityURL) { [weak self] result in
            do {
                
                let data = try result.get()
                let decoder = JSONDecoder()
                let payload = try decoder.decode(NetworkingPayload.self, from: data)
                self?.delegate?.didReceive(abilityInformation: payload)
            } catch {
                
                self?.delegate?.didReceive(error: error)
            }
        }
    }
}
