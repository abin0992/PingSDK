//
//  URLSession+DataTask.swift
//  PinkSDK
//
//  Created by Abin Baby on 07/03/21.
//

import Foundation

extension URLSession {
    func dataTask(with urlRequest: URLRequest,
                  result: @escaping (Result<(HTTPURLResponse, Data), APIError>) -> Void) -> URLSessionDataTask {
        dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                result(.failure(.unableToComplete))
                return
            }

            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                result(.failure(.invalidData))
                return
            }

            if response.statusCode != 200 {
                result(.failure(.undefined))
                return
            }

            result(.success((response, data)))
        }
    }
}
