//
//  APIError.swift
//  PinkSDK
//
//  Created by Abin Baby on 07/03/21.
//

import Foundation

public enum APIError: Error {

    case invalidParameters
    case unableToComplete
    case invalidResponse
    case invalidData
    case invalidUrl
    case undefined

    var description: String {
            switch self {
            case .invalidUrl:
                return "The url is not valid."
            case .invalidParameters:
                return "This parameters created an invalid request. Please try again."
            case .unableToComplete:
                return "Unable to complete your request. Please check your internet connection"
            case .invalidResponse:
                return "Invalid response from the server. Please try again."
            case .invalidData:
                return "The data received from the server was invalid. Please try again."
            case .undefined:
                return "Unknown error occured"
            }
        }
}
