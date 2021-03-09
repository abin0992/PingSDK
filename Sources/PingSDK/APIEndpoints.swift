//
//  APIEndpoints.swift
//  PinkSDK
//
//  Created by Abin Baby on 07/03/21.
//

import Foundation

struct APIEndpoint {
    let path: String
    var queryItems: [URLQueryItem]?
    var url: URL? {
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = Constants.hostName
        components.path = path
        components.queryItems = queryItems

        return components.url
    }

    static func log() -> APIEndpoint {
        APIEndpoint(
            path: "/post", queryItems: nil
        )
    }
}
