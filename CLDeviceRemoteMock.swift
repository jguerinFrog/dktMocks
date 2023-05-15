
//
//  Created by Julien GUERIN on 17/04/2023.
//

import Foundation
import UIKit
import Combine


@available(iOS 13.0, *)
open class CLDeviceRemoteMock: CLDeviceRemoteStatus {
    public static var shared = CLDeviceRemoteMock()


    private lazy var debugOverlay: UIControl = {
        let control = UIControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(extendOverlay), for: .touchUpInside)
        control.backgroundColor = .clear
        control.layer.cornerRadius = 25
        let imageView = UIImageView(image: UIImage(systemName: "network.badge.shield.half.filled"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        control.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: control.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: control.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: control.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: control.bottomAnchor)
        ])
        return control
    }()


    private var mockParser = CLDeviceRemoteMockParser()
    private var isFlowActive = true

    private var connectionState = PassthroughSubject<CLDeviceConnectionState, CLDeviceRemoteError>()
    private var deviceLocation = PassthroughSubject<CLDeviceLocation, CLDeviceRemoteError>()
    private var deviceAddress = PassthroughSubject<CLDeviceAddress, CLDeviceRemoteError>()
    private var deviceBatteryLevel = PassthroughSubject<CLDeviceBatteryLevel, CLDeviceRemoteError>()
    private var deviceState = PassthroughSubject<CLDeviceState, CLDeviceRemoteError>()

    init() {
        mockParser.loadJSON()
        startTimer()
    }

    @objc private func extendOverlay() {
        let alertController = UIAlertController(title: "Mock debug menu", message: nil, preferredStyle: .alert)
        let updateMock = UIAlertAction(title: "Update Mock file", style: .default) { _ in
            self.mockParser.updateFile()
        }
        let resetMock = UIAlertAction(title: "Reset mock flow", style: .default) { _ in
            self.mockParser.resetIndex()
        }
        let pauseTimer = UIAlertAction(title: "Pause mock flow", style: .default) { _ in
            self.isFlowActive = false
        }
        let resumeTimer = UIAlertAction(title: "Resume mock flow", style: .default) { _ in
            self.isFlowActive = true
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(updateMock)
        alertController.addAction(resetMock)
        alertController.addAction(pauseTimer)
        alertController.addAction(resumeTimer)
        alertController.addAction(cancel)

        UIApplication.shared.windows.last?.rootViewController?.present(alertController, animated: true)
    }

    public func showDebugOverlay() {
        if let view = UIApplication.shared.windows.last!.rootViewController?.view {
            view.addSubview(debugOverlay)

            NSLayoutConstraint.activate([
                debugOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                debugOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
                debugOverlay.widthAnchor.constraint(equalToConstant: 50),
                debugOverlay.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

    }

    public func stopFlow() {
        self.isFlowActive = false
    }

    public func resumeFlow() {
        self.isFlowActive = true
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true){ [weak self] _ in
            guard let self = self, self.isFlowActive else { return }
            self.updateMockData()
        }
    }

    private func updateMockData() {
        let mockData = mockParser.getNextData()
        self.connectionState.send(CLDeviceConnectionState.initFromMockData(data: mockData))
        self.deviceLocation.send(CLDeviceLocation.initFromMockData(data: mockData))
        self.deviceAddress.send(CLDeviceAddress.initFromMockData(data: mockData))
        self.deviceBatteryLevel.send(CLDeviceBatteryLevel.initFromMockData(data: mockData))
        self.deviceState.send(CLDeviceState.initFromMockData(data: mockData))
    }

    public func observeDeviceConnectionState(withId deviceId: String) -> AnyPublisher<CLDeviceConnectionState, CLDeviceRemoteError> {
        return connectionState.eraseToAnyPublisher()
    }

    public func observeDeviceLocation(withId deviceId: String) -> AnyPublisher<CLDeviceLocation, CLDeviceRemoteError> {
        return deviceLocation.eraseToAnyPublisher()
    }

    public func observeDeviceAddress(withId deviceId: String) -> AnyPublisher<CLDeviceAddress, CLDeviceRemoteError> {
        return deviceAddress.eraseToAnyPublisher()
    }

    public func observeDeviceBatteryLevel(withId deviceId: String) -> AnyPublisher<CLDeviceBatteryLevel, CLDeviceRemoteError> {
        return deviceBatteryLevel.eraseToAnyPublisher()
    }

    public func observeDeviceState(withId deviceId: String) -> AnyPublisher<CLDeviceState, CLDeviceRemoteError> {
        return deviceState.eraseToAnyPublisher()
    }
}
