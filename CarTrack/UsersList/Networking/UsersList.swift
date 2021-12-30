//
//  UsersList.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//

import Combine
import UIKit

protocol APIManagerService {
    func fetchUsers<T: Decodable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void)
}

class APIManager: APIManagerService {

    private var subscribers = Set<AnyCancellable>()
    
    func fetchUsers<T: Decodable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [T].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            }, receiveValue: { (resultArray) in
                completion(.success(resultArray))
            }).store(in: &subscribers)
    }
}
