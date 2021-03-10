//
//  NetworkOperation.swift
//  PinkSDK
//
//  Created by Abin Baby on 08/03/21.
//

import Foundation

class NetworkOperation: AsyncOperation {
    private let urlRequest: URLRequest
    private var logger: Logger = DefaultLogger(minLevel: .warning)
    private weak var request: URLSessionTask?
    private var networkOperationCompletionHandler: ((Result<(HTTPURLResponse, Data), APIError>) -> Void)?

    init(urlRequest: URLRequest,
         networkOperationCompletionHandler: ((Result<(HTTPURLResponse, Data), APIError>) -> Void)? = nil) {
        self.urlRequest = urlRequest
        self.networkOperationCompletionHandler = networkOperationCompletionHandler
        super.init()
    }

    override func main() {
        request = URLSession.shared.dataTask(with: urlRequest) { result in
            self.networkOperationCompletionHandler?(result)
        }
        request?.resume()
    }

    override func cancel() {
        request?.cancel()
        super.cancel()
    }
}
