//
//  LogAPISerializer.swift
//  PinkSDK
//
//  Created by Abin Baby on 08/03/21.
//

import Foundation

final class LogAPISerializer {
    internal func jsonData(for event: PingEvent) throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: event,
                                                  options: .prettyPrinted)
        return jsonData
    }
}
