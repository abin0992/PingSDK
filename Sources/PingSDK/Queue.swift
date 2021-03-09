//
//  Queue.swift
//  PinkSDK
//
//  Created by Abin Baby on 08/03/21.
//

import Foundation

class Queue {
    lazy var logQueue: OperationQueue = {
        var queue: OperationQueue = OperationQueue()
        queue.name = "Ping log queue"
        queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        queue.qualityOfService = .background
        return queue
    }()
}
