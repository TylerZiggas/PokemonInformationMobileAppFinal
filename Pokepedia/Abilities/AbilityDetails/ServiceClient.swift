//  ServiceClient.swift
//  Pokepedia
//
//  Created by Tyler Ziggas on 7/28/21.

import Foundation

// MARK: - Get Function to Start Network Call

final class ServiceClient {
    
    func get(from url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        
        DispatchQueue.global(qos: .background).async {
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task: URLSessionDataTask = session.dataTask(with: request) { [weak self] data, response, error in
                self?.handle(data: data, response: response, error: error, completion: completion)
            }
            
            task.resume()
            session.finishTasksAndInvalidate()
        }
    }
}

// MARK: - Checking for Errors or Success Case

extension ServiceClient {
    private func handle(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, Error>) -> ()) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            let serviceError: ServiceError = .invalidResponse
            completion(.failure(serviceError))
            return
        }
        
        let statusCodeRange = 200...299 ~= httpResponse.statusCode
        guard statusCodeRange else {
            let localizedDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            let serviceError: ServiceError = .invalidStatusCode(localizedDescription)
            
            completion(.failure(serviceError))
            return
        }
        
        guard let data = data else {
            let serviceError: ServiceError = .noData
            completion(.failure(serviceError))
            return
        }
        
        completion(.success(data))
    }
}

// MARK: - Enum Cases for Errors

extension ServiceClient {
    enum ServiceError: CustomNSError {
        case invalidResponse
        case invalidStatusCode(String)
        case noData
        
        var errorUserInfo: [String: Any] {
            switch self {
            case .invalidResponse:
                return [NSLocalizedDescriptionKey: "Invalid Response."]
            case .invalidStatusCode(let localizedDescription):
                return [NSLocalizedDescriptionKey: localizedDescription]
            case .noData:
                return [NSLocalizedDescriptionKey: "No data found."]
            }
        }
    }
}
