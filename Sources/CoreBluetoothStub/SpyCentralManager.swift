import Combine
import CoreBluetooth
import CoreBluetoothTestable


public class SpyCentralManager: CentralManagerProtocol {
    // MARK: - Properties from CBManager
    public var state: CBManagerState { inherited.state }
    public var authorization: CBManagerAuthorization { inherited.authorization }
    
    // MARK: - Properties from CBCentralManager
    public var isScanning: Bool { inherited.isScanning }
    
    // MARK: - Publishers for CBCentralManagerDelegate
    public var didUpdateState: AnyPublisher<CBManagerState, Never> { inherited.didUpdateState }
    
    public var willRestoreState: AnyPublisher<[String: Any], Never> { inherited.willRestoreState }
    
    public var didDiscoverPeripheral: AnyPublisher<(peripheral: any PeripheralProtocol, advertisementData: [String : Any], rssi: NSNumber), Never> {
        inherited.didDiscoverPeripheral
    }
    
    public var didConnectPeripheral: AnyPublisher<any PeripheralProtocol, Never> {
        inherited.didConnectPeripheral
    }

    public var didFailToConnectPeripheral: AnyPublisher<(peripheral: any PeripheralProtocol, error: (any Error)?), Never> {
        inherited.didFailToConnectPeripheral
    }
    
    public var didDisconnectPeripheral: AnyPublisher<(peripheral: any PeripheralProtocol, error: (any Error)?), Never> {
        inherited.didDisconnectPeripheral
    }
    
    public var didDisconnectPeripheralReconnecting: AnyPublisher<(peripheral: any PeripheralProtocol, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?), Never> {
        inherited.didDisconnectPeripheralReconnecting
    }
    
    // MARK: - Properties for Internal Use
    public var _wrapped: CBCentralManager? { inherited._wrapped }
    
    
    // MARK: - Stubs
    public var inherited: any CentralManagerProtocol
    public private(set) var callArgs = [CallArg]()
    
    
    // MARK: - Initializers
    public init(inheriting inherited: CentralManagerProtocol) {
        self.inherited = inherited
    }
    
    
    // MARK: - Methods from CBCentralManager
    public func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [any PeripheralProtocol] {
        callArgs.append(.retrievePeripherals(identifiers: identifiers))
        return inherited.retrievePeripherals(withIdentifiers: identifiers)
    }
    
    
    public func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [any PeripheralProtocol] {
        callArgs.append(.retrieveConnectedPeripherals(serviceUUIDs: serviceUUIDs))
        return inherited.retrieveConnectedPeripherals(withServices: serviceUUIDs)
    }
    
    
    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?) {
        callArgs.append(.scanForPeripherals(serviceUUIDs: serviceUUIDs, options: nil))
    }
    
    
    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]?) {
        callArgs.append(.scanForPeripherals(serviceUUIDs: serviceUUIDs, options: options))
    }
    
    
    public func stopScan() {
        callArgs.append(.stopScan)
    }
    
    
    public func connect(_ peripheral: any PeripheralProtocol) {
        callArgs.append(.connect(peripheral: peripheral, options: nil))
    }
    
    
    public func connect(_ peripheral: any PeripheralProtocol, options: [String: Any]?) {
        callArgs.append(.connect(peripheral: peripheral, options: options))
    }
    
    
    public func cancelPeripheralConnection(_ peripheral: any PeripheralProtocol) {
        callArgs.append(.cancelPeripheralConnection(peripheral: peripheral))
    }
    
    
    public enum CallArg {
        case retrievePeripherals(identifiers: [UUID])
        case retrieveConnectedPeripherals(serviceUUIDs: [CBUUID])
        case scanForPeripherals(serviceUUIDs: [CBUUID]?, options: [String: Any]?)
        case stopScan
        case connect(peripheral: any PeripheralProtocol, options: [String: Any]?)
        case cancelPeripheralConnection(peripheral: any PeripheralProtocol)
    }
}
