//
//  PingSDK.swift
//  PingSDK
//
//  Created by Abin Baby on 08/03/21.
//

import Foundation

final public class PingTracker: NSObject {
    //private let dispatcher: Dispatcher
    private var queue: Queue = Queue()
    private let serializer = LogAPISerializer()

    /// This logger is used to perform logging of all sorts of Matomo related information.
    /// Per default it is a `DefaultLogger` with a `minLevel` of `LogLevel.warning`. You can
    /// set your own Logger with a custom `minLevel` or a complete custom logging mechanism.
    public var logger: Logger = DefaultLogger(minLevel: .warning)

    public static let sharedInstance: PingTracker = PingTracker()
    public override init() {}

    public func log(log: PingEvent) {
        let jsonBody: Data
        do {
            jsonBody = try serializer.jsonData(for: log)
        } catch {
            return
        }

        guard let url = APIEndpoint.log().url else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let logOperation: NetworkOperation = NetworkOperation(urlRequest: urlRequest)
        queue.logQueue.addOperation(logOperation)
    }
}
