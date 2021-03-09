//
//  AsyncOperation.swift
//  PinkSDK
//
//  Created by Abin Baby on 08/03/21.
//

import Foundation

class AsyncOperation: Operation {
    //: NSOperation Overrides
    override var isReady: Bool {
        super.isReady && state == .ready
    }

    override var isExecuting: Bool {
        state == .executing
    }

    override var isFinished: Bool {
        state == .finished
    }

    override var isAsynchronous: Bool {
        true
    }

    override func start() {
        if isCancelled {
            state = .finished
            return
        }

        main()
        state = .executing
    }

    override func cancel() {
        state = .finished
    }

    enum State: String {
        case ready, executing, finished

        var keyPath: String {
            "is" + rawValue
        }
    }

    var state: State = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}
