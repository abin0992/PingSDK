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
    weak var request: URLSessionTask?

    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        super.init()
    }

    override func main() {
        request = URLSession.shared.dataTask(with: urlRequest) { result in
            switch result {
            case .success:
                // should we check the response?
                // let dataString = String(data: data!, encoding: String.Encoding.utf8)
                self.logger.info("Logged successfully")
            case .failure(let exception):
                self.logger.error(exception.localizedDescription)
            }
        }
        request?.resume()
    }

    override func cancel() {
        request?.cancel()
        super.cancel()
    }
}
