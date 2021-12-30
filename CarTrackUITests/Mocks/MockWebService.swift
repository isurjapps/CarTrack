//
//  MockWebService.swift
//  CarTrackUITests
//
//  Created by Prashant Singh on 30/12/21.
//

import Foundation

class MockWebService: APIManagerService {
    func fetchUsers<T>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        <#code#>
    }
}
