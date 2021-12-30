//
//  UsersListScreenViewModel.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//

import UIKit
import Combine

final class UsersListScreenViewModel {
    
    private let apiManager: APIManagerService
    
    var usersSubject = PassthroughSubject<[UsersList], Error>()

    init(apiManager: APIManagerService) {
        self.apiManager = apiManager
    }
    
    func fetchUser() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        apiManager.fetchUsers(url: url) { [weak self] (result: Result<[UsersList], Error>) in
            switch result {
            case .success(let users):
                self?.usersSubject.send(users)
            case .failure(let error):
                self?.usersSubject.send(completion: .failure(error))
            }
        }
    }
}
