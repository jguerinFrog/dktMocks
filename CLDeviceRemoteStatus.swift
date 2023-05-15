//
//  CLDeviceRemoteStatus.swift
//  CLDeviceRemoteMock
//
//  Created by Julien GUERIN on 17/04/2023.
//

import Combine
import Foundation


@available(iOS 13.0, *)
/// A protocol used for interacting with device remote status.
public protocol CLDeviceRemoteStatus {
    /// Create a subscription to the reported location of a given device.
    /// - Parameter id: The device identifier (ThingName).
    /// - Returns: A stream of CLDeviceLocation, as a Combine publisher.
    func observeDeviceLocation(withId deviceId: String) -> AnyPublisher<CLDeviceLocation, CLDeviceRemoteError>

    /// Create a subscription to the reported address of a given device.
    /// - Parameter id: The device identifier (ThingName).
    /// - Returns: A stream of CLDeviceAddress, as a Combine publisher.
    func observeDeviceAddress(withId deviceId: String) -> AnyPublisher<CLDeviceAddress, CLDeviceRemoteError>

    /// Create a subscription to the reported battery level of a given device.
    /// - Parameter id: The device identifier (ThingName).
    /// - Returns: A stream of CLDeviceBatteryLevel, as a Combine publisher.
    func observeDeviceBatteryLevel(withId deviceId: String) -> AnyPublisher<CLDeviceBatteryLevel, CLDeviceRemoteError>

    /// Create a subscription to the reported state of a given device.
    /// - Parameter id: The device identifier (ThingName).
    /// - Returns: A stream of CLDeviceState, as a Combine publisher.
    func observeDeviceState(withId deviceId: String) -> AnyPublisher<CLDeviceState, CLDeviceRemoteError>

    /// Create a subscription to the reported connection state of a given device.
    /// - Parameter id: The device identifier (ThingName).
    /// - Returns: A stream of CLDeviceConnectionState, as a Combine publisher.
    func observeDeviceConnectionState(withId deviceId: String) -> AnyPublisher<CLDeviceConnectionState, CLDeviceRemoteError>
}
