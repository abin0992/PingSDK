//
//  Encodable+JSONData.swift
//  PingSDK
//
//  Created by Abin Baby on 10/03/21.
//

import Foundation

extension Encodable {
    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
