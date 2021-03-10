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

    /// This logger is used to perform logging of all sorts of PingSDK related information.
    /// Per default it is a `DefaultLogger` with a `minLevel` of `LogLevel.warning`. You can
    /// set your own Logger with a custom `minLevel` or a complete custom logging mechanism.
    public var logger: Logger = DefaultLogger(minLevel: .warning)

    public static let sharedInstance: PingTracker = PingTracker()
    public override init() {}

    // MARK: - Public function
    
    /// PingSDK function that sends the log to server. To send explicit timestamp and additional comments add it in a "ping event" object and pass it.
    /// - Parameter event: This is an optional parameter off PingEvent type
    public func log(event: PingEvent?) {
        let jsonBody: Data
        do {
            var pingEvent = PingEvent(timestamp: nil, comment: nil)
            if let log = event {
                pingEvent = log
            }
            jsonBody = try pingEvent.jsonData()
        } catch {
            return
        }

        let urlRequest: URLRequest = buildUrlRequest(with: jsonBody)

        let logOperation: NetworkOperation = NetworkOperation(urlRequest: urlRequest) { result in
            switch result {
            case .success(let result):
                if result.0.statusCode == 200 {
                    self.logger.info("Logged successfully")
                }
                // should we check the response?

            case .failure(let exception):
                self.logger.error(exception.localizedDescription)
                self.log(error: exception)
            }

        }
        queue.logQueue.addOperation(logOperation)
    }

    // MARK: - Private function to send back error to server
    private func log(error: APIError) {
        let payload: [String: Any] = [
            "error": "\(error.description)"
        ]
        let jsonBody: Data
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            return
        }

        let urlRequest: URLRequest = buildUrlRequest(with: jsonBody)

        let logOperation: NetworkOperation = NetworkOperation(urlRequest: urlRequest) { result in
            switch result {
            case .success(let result):
                if result.0.statusCode == 200 {
                    self.logger.info("Logged successfully")
                }
                // should we check the response?
                // let dataString = String(data: data!, encoding: String.Encoding.utf8)
            case .failure(let exception):
                self.logger.error(exception.localizedDescription)
            }
        }
        queue.logQueue.addOperation(logOperation)
    }

    private func buildUrlRequest(with body: Data) -> URLRequest {
        guard let url = APIEndpoint.log().url else {
            fatalError("URL with API endpoint could not be generated")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
