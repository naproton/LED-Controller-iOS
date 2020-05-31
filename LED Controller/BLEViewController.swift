//
//  BLEViewController.swift
//  LED Controller
//
//  Created by Nick Protonentis on 3/24/20.
//  Copyright © 2020 Nick Protonentis. All rights reserved.
//

import UIKit
import CoreBluetooth

let LEDServiceCBUUID = CBUUID(string: "0x18A0")
let RedServiceCBUUID = CBUUID(string: "0x18AA")
let BlueServiceCBUUID = CBUUID(string: "0x18AB")
let GreenServiceCBUUID = CBUUID(string: "0x18AC")
let TimeServiceCBUUID = CBUUID(string: "0x18AE")
//let LEDServiceCBUUID = CBUUID(string: "0x18AD")

let RedCBUUID = CBUUID(string: "18985fda-51aa-4f19-a777-71cf52abba1e")
let BlueCBUUID = CBUUID(string: "28985fda-51aa-4f19-a777-71cf52abba1e")
let GreenCBUUID = CBUUID(string: "38985fda-51aa-4f19-a777-71cf52abba1e")
let FlashCBUUID = CBUUID(string: "48985fda-51aa-4f19-a777-71cf52abba1e")
let TimeCBUUID = CBUUID(string: "58985fda-51aa-4f19-a777-71cf52abba1e")
let BrightnessCBUUID = CBUUID(string: "68985fda-51aa-4f19-a777-71cf52abba1e")


class BLEViewController: UIViewController {
    
    //setup BLE
    var centralM: CBCentralManager!
    var ControllerPeripheral: CBPeripheral!
    
    
    @IBOutlet weak var redSlide: UISlider!
    @IBOutlet weak var greenSlide: UISlider!
    @IBOutlet weak var blueSlide: UISlider!
  
    @IBOutlet weak var brightSlide: UISlider!
    @IBOutlet weak var timeSlide: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
   
    @IBOutlet weak var brightness: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var setBtn: UIButton!
    @IBOutlet weak var colorDisplay: UIImageView!
    @IBOutlet weak var fanBtn: UIButton!
    
    var redVal: Float = 0
    var greenVal: Float = 0
    var blueVal: Float = 0
    var timeVal: Float = 0
    var fanVal: Float = 0
    var brightVal: Float = 0
    
    var redCharacteristic: CBCharacteristic!
    var blueCharacteristic: CBCharacteristic!
    var greenCharacteristic: CBCharacteristic!
    var flashCharacteristic: CBCharacteristic!
    var timerCharacteristic: CBCharacteristic!
    var brightCharacteristic: CBCharacteristic!
   //var BrightnessCharacteristic: CBCharacteristic!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralM = CBCentralManager(delegate: self, queue: nil)
        // Do any additional setup after loading the view.
        redSlide.maximumValue = 255
        greenSlide.maximumValue = 255
        blueSlide.maximumValue = 255
        timeSlide.maximumValue = 60
        brightSlide.maximumValue = 255
        
        redSlide.value = redVal
        greenSlide.value = greenVal
        blueSlide.value = blueVal
        timeSlide.value = timeVal
        brightSlide.value = brightVal
        
        redLabel.text = String(Int(redVal))
        greenLabel.text = String(Int(greenVal))
        blueLabel.text = String(Int(blueVal))
        timeLabel.text = String(Int(timeVal))
        brightness.text = String(Int(brightVal))
        
        setBtn.layer.cornerRadius = 20
        fanBtn.layer.cornerRadius = 20
        colorDisplay.layer.cornerRadius = 45
        
        colorDisplay.layer.backgroundColor = CGColor(srgbRed: CGFloat(redVal), green: CGFloat(greenVal), blue: CGFloat(blueVal), alpha: 1)
        
    }
    
    
    
    @IBAction func reconnect(_ sender: Any) {
        
        centralM = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    @IBAction func sendValues(_ sender: Any) {
        
        //get red color value and send over BT
        var toSend = redLabel!.text
        var sendData: Data? = toSend!.data(using: .utf8)
        ControllerPeripheral?.writeValue(sendData!, for: redCharacteristic, type: .withResponse)
        
        //get blue value and send over BT
        toSend = blueLabel!.text
        sendData = toSend!.data(using: .utf8)
        ControllerPeripheral?.writeValue(sendData!, for: blueCharacteristic, type: .withResponse)
        
        //get green value and send over BT
        toSend = greenLabel!.text
        sendData = toSend!.data(using: .utf8)
        ControllerPeripheral?.writeValue(sendData!, for: greenCharacteristic, type: .withResponse)
        
        
    }
    
    
    @IBAction func SetRedSlide(_ sender: Any) {
        redVal = redSlide.value
        //print(redVal)
        redLabel.text = String(Int(redVal))
        colorDisplay.layer.backgroundColor = CGColor(srgbRed: CGFloat(redVal), green: CGFloat(greenVal), blue: CGFloat(blueVal), alpha: 1)
    }
    
    @IBAction func SetGreenSlide(_ sender: Any) {
        greenVal = greenSlide.value
        greenLabel.text = String(Int(greenVal))
        colorDisplay.layer.backgroundColor = CGColor(srgbRed: CGFloat(redVal), green: CGFloat(greenVal), blue: CGFloat(blueVal), alpha: 1)
    }
    
    
    @IBAction func SetBlueSlide(_ sender: Any) {
       blueVal = blueSlide.value
        blueLabel.text = String(Int(blueVal))
        colorDisplay.layer.backgroundColor = CGColor(srgbRed: CGFloat(redVal), green: CGFloat(greenVal), blue: CGFloat(blueVal), alpha: 1)
    }
    
    
    @IBAction func SetBrightnessSlide(_ sender: Any) {
        brightVal = brightSlide.value
         brightness.text = String(Int(brightVal))
    }
    
    @IBAction func SetTimeSlide(_ sender: Any) {
        timeVal = timeSlide.value
         timeLabel.text = String(Int(timeVal))
    }
    
    @IBAction func setFan(_ sender: Any){
        
        let toSend = "1"
        let sendData: Data? = toSend.data(using: .utf8)
        ControllerPeripheral?.writeValue(sendData!, for: flashCharacteristic, type: .withResponse)
    }
    
}



extension BLEViewController: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unknown:
      print("central.state is .unknown")
    case .resetting:
      print("central.state is .resetting")
    case .unsupported:
      print("central.state is .unsupported")
    case .unauthorized:
      print("central.state is .unauthorized")
    case .poweredOff:
      print("central.state is .poweredOff")
    case .poweredOn:
      print("central.state is .poweredOn")
      central.scanForPeripherals(withServices: [LEDServiceCBUUID, RedServiceCBUUID, BlueServiceCBUUID, GreenServiceCBUUID, TimeServiceCBUUID])
    }
  }

  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                      advertisementData: [String : Any], rssi RSSI: NSNumber) {
    print(peripheral)
    ControllerPeripheral = peripheral
    ControllerPeripheral.delegate = self
    centralM.stopScan()
    centralM.connect(ControllerPeripheral)
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("Connected!")
    ControllerPeripheral.discoverServices([LEDServiceCBUUID, RedServiceCBUUID, BlueServiceCBUUID, GreenServiceCBUUID, TimeServiceCBUUID])
  }
}

extension BLEViewController: CBPeripheralDelegate {
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    guard let services = peripheral.services else { return }
    for service in services {
      print(service)
      peripheral.discoverCharacteristics(nil, for: service)
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    guard let characteristics = service.characteristics else { return }

    for characteristic in characteristics {
      print(characteristic)
      
      if characteristic.properties.contains(.read) {
        print("\(characteristic.uuid): properties contains .read")
        peripheral.readValue(for: characteristic)
      }
      /*
      if characteristic.properties.contains(.notify) {
        print("\(characteristic.uuid): properties contains .notify")
        peripheral.setNotifyValue(false, for: characteristic)
      }
      */
        if characteristic.uuid == RedCBUUID {
            print("RED")
            redCharacteristic = characteristic
        }
        if characteristic.uuid == BlueCBUUID {
            print("Blue")
            blueCharacteristic = characteristic
        }
        
        if characteristic.uuid == TimeCBUUID {
                   timerCharacteristic = characteristic
        }
        
        
        if characteristic.uuid == GreenCBUUID {
            print("GReen")
            greenCharacteristic = characteristic
        }
        
       
        
        if characteristic.uuid == FlashCBUUID {
            flashCharacteristic = characteristic
        }
        if characteristic.uuid == BrightnessCBUUID {
            brightCharacteristic = characteristic
        }
        
        
      }
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    switch characteristic.uuid {
    
    default:
     //print("Unhandled Characteristic UUID: \(characteristic.uuid)")
      break
    }
  }

  
    
  


