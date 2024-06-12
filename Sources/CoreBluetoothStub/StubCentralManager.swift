import Combine
import CoreBluetooth
import CoreBluetoothTestable


public class StubCentralManager: CentralManagerProtocol {
    // MARK: - Properties from CBManager
    public var state: CBManagerState { didUpdateStateSubject.value }
    public var authorization: CBManagerAuthorization
    
    // MARK: - Properties from CBCentralManager
    public var isScanning: Bool
    
    // MARK: - Publishers for CBCentralManagerDelegate
    public let didUpdateStateSubject: CurrentValueSubject<CBManagerState, Never>
    public let didUpdateState: AnyPublisher<CBManagerState, Never>
    
    public let willRestoreStateSubject: PassthroughSubject<[String: Any], Never>
    public let willRestoreState: AnyPublisher<[String: Any], Never>
    
    public let didDiscoverPeripheralSubject: PassthroughSubject<(peripheral: any PeripheralProtocol, advertisementData: [String : Any], rssi: NSNumber), Never>
    public let didDiscoverPeripheral: AnyPublisher<(peripheral: any PeripheralProtocol, advertisementData: [String : Any], rssi: NSNumber), Never>
    
    public let didConnectPeripheralSubject: PassthroughSubject<any PeripheralProtocol, Never>
    public let didConnectPeripheral: AnyPublisher<any PeripheralProtocol, Never>

    public let didFailToConnectPeripheralSubject: PassthroughSubject<(peripheral: any PeripheralProtocol, error: (any Error)?), Never>
    public let didFailToConnectPeripheral: AnyPublisher<(peripheral: any PeripheralProtocol, error: (any Error)?), Never>
    
    public let didDisconnectPeripheralSubject: PassthroughSubject<(peripheral: any PeripheralProtocol, error: (any Error)?), Never>
    public let didDisconnectPeripheral: AnyPublisher<(peripheral: any PeripheralProtocol, error: (any Error)?), Never>
    
    public let didDisconnectPeripheralReconnectingSubject: PassthroughSubject<(peripheral: any PeripheralProtocol, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?), Never>
    public let didDisconnectPeripheralReconnecting: AnyPublisher<(peripheral: any PeripheralProtocol, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?), Never>
    
    // MARK: - Properties for Internal Use
    public var _wrapped: CBCentralManager? = nil
    
    
    // MARK: - Stubs
    public var peripherals: [any PeripheralProtocol]
    public var connectedPeripherals: [any PeripheralProtocol]
    
    
    // MARK: - Initializers
    public init(
        state: CBManagerState,
        authorization: CBManagerAuthorization,
        isScanning: Bool,
        peripherals: [any PeripheralProtocol],
        connectedPeipherals: [any PeripheralProtocol]
    ) {
        self.authorization = authorization
        self.isScanning = isScanning
        self.peripherals = peripherals
        self.connectedPeripherals = connectedPeipherals
        
        let didUpdateStateSubject = CurrentValueSubject<CBManagerState, Never>(state)
        self.didUpdateStateSubject = didUpdateStateSubject
        self.didUpdateState = didUpdateStateSubject.eraseToAnyPublisher()
        
        let willRestoreStateSubject = PassthroughSubject<[String: Any], Never>()
        self.willRestoreStateSubject = willRestoreStateSubject
        self.willRestoreState = willRestoreStateSubject.eraseToAnyPublisher()
        
        let didDiscoverPeripheralSubject = PassthroughSubject<(peripheral: any PeripheralProtocol, advertisementData: [String : Any], rssi: NSNumber), Never>()
        self.didDiscoverPeripheralSubject = didDiscoverPeripheralSubject
        self.didDiscoverPeripheral = didDiscoverPeripheralSubject.eraseToAnyPublisher()
        
        let didConnectPeripheralSubject = PassthroughSubject<any PeripheralProtocol, Never>()
        self.didConnectPeripheralSubject = didConnectPeripheralSubject
        self.didConnectPeripheral = didConnectPeripheralSubject.eraseToAnyPublisher()
        
        let didFailToConnectPeripheralSubject = PassthroughSubject<(peripheral: any PeripheralProtocol, error: (any Error)?), Never>()
        self.didFailToConnectPeripheralSubject = didFailToConnectPeripheralSubject
        self.didFailToConnectPeripheral = didFailToConnectPeripheralSubject.eraseToAnyPublisher()
        
        let didDisconnectPeripheralSubject = PassthroughSubject<(peripheral: any PeripheralProtocol, error: (any Error)?), Never>()
        self.didDisconnectPeripheralSubject = didDisconnectPeripheralSubject
        self.didDisconnectPeripheral = didDisconnectPeripheralSubject.eraseToAnyPublisher()
        
        let didDisconnectPeripheralReconnectingSubject = PassthroughSubject<(peripheral: any PeripheralProtocol, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?), Never>()
        self.didDisconnectPeripheralReconnectingSubject = didDisconnectPeripheralReconnectingSubject
        self.didDisconnectPeripheralReconnecting = didDisconnectPeripheralReconnectingSubject.eraseToAnyPublisher()
    }
    
    
    // MARK: - Methods from CBCentralManager
    public func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [any PeripheralProtocol] {
        peripherals
    }
    
    
    public func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [any PeripheralProtocol] {
        connectedPeripherals
    }
    
    
    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?) {
    }
    
    
    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]?) {
    }
    
    
    public func stopScan() {
    }
    
    
    public func connect(_ peripheral: any PeripheralProtocol) {
    }
    
    
    public func connect(_ peripheral: any PeripheralProtocol, options: [String: Any]?) {
    }
    
    
    public func cancelPeripheralConnection(_ peripheral: any PeripheralProtocol) {
    }
}
