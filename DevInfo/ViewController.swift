//
//  ViewController.swift
//  DevInfo
//
//  Created by MAYANK NAILWAL on 02/03/24.
//

//Used Metal Framework to fetch GPU info

import UIKit // UIDevice class is contained in this
import CoreTelephony
import AVFoundation // using this for camera Mega Pixel info
import Metal


class ViewController: UIViewController {
    
    @IBOutlet weak var IMEI: UILabel!   //IMEI cannot be accessed however I have fetched the unique identifier
    @IBOutlet weak var gpuInfo: UILabel!                 //Done
    @IBOutlet weak var aperture: UILabel!                // executed below camera info
    @IBOutlet weak var megaPixel: UILabel!               // executed below camera info
    @IBOutlet weak var batteryLevel: UILabel!              //Done, will give always -1 in stimulators
    @IBOutlet weak var batteryHealth: UILabel!  //All that UIDevice provides is the level along with its                                                 current state.Hence cannot fetch the health
    @IBOutlet weak var totalStorage: UILabel!              //Done in Bytes
    @IBOutlet weak var freeStorage: UILabel!               //Done in Bytes
    @IBOutlet weak var serialNumber: UILabel!              //Restricted by apple, hence using same as IMEI
    @IBOutlet weak var iosVersion: UILabel!                //Done
    @IBOutlet weak var modelNumber: UILabel!               //Doubtful
    @IBOutlet weak var modelName: UILabel!                 //Done
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeviceInformation()
    }
    
    func getDeviceInformation(){
        modelName.text = UIDevice.current.name
        iosVersion.text = UIDevice.current.systemVersion
        
        //Storage Info
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last {
            let attributes = try? fileManager.attributesOfFileSystem(forPath: documentDirectory.path)
            if let freeSpace = attributes?[.systemFreeSize] as? NSNumber {
                freeStorage.text = "\((freeSpace.int64Value)/(1024 * 1024 * 1024)) GB"
            }
            if let totalSpace = attributes?[.systemSize] as? NSNumber {
                totalStorage.text = "\((totalSpace.int64Value)/(1024 * 1024 * 1024)) GB"
            }
        }
        
        // Current Battery Level
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        let level = UIDevice.current.batteryLevel * 100 //will return -1 always for stimulators -> -1*100 = -100 for stimulators
        batteryLevel.text = "\(level) %"
        
        //Camera Info
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
        })  //Request for accesing the camera made, i have added the NSCameraUsageDescription key to my app's Info.plist file
        
        //GPU Info
        fetchGPUInfo()
        
        //IMEI cannot be accessed however I have fetched the unique identifier
        let vendorIdentifier = UIDevice.current.identifierForVendor?.uuidString
        IMEI.text = "\(vendorIdentifier ?? "N/A")"
        serialNumber.text = "\(vendorIdentifier ?? "N/A")"
        
        //Camera Details
        let cameraInfoFetcher = CameraInfoFetcher()
        let megapixels = cameraInfoFetcher.fetchCameraResolutionInMegapixels()
        megaPixel.text = "\(megapixels)"    //will return 0.0 for stimulators as camera could not be accessed in this

        if let aperture = cameraInfoFetcher.fetchCurrentAperture() {
            self.aperture.text = "\(aperture)"
        } else {
            self.aperture.text = "0.0"
        }
    }
    
    
    // function to fetch GPU information
    func fetchGPUInfo() {
    
        let device = MTLCreateSystemDefaultDevice()
        let name = device?.name

        gpuInfo.text = " \(name ?? "N/A")"
        }
    
    
    //CPU Info

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cpuSegue"{
            
            let destinationVC = segue.destination as! CPUInfoViewController  //segue.destination is the viewcontoller that will appear when seque is performed
            let processInfo = ProcessInfo.processInfo  //ProcessInfo class has been used to fetch CPU details

            // Processor count
            let processorCount = processInfo.processorCount
            destinationVC.processorC = processorCount

            // Active processor count
            let activeProcessorCount = processInfo.activeProcessorCount
            destinationVC.activeProcessorCount = activeProcessorCount

            // Physical memory (in GB)
            let physicalMemory = processInfo.physicalMemory
            destinationVC.physicalMemory = physicalMemory/(1024 * 1024 * 1024)
        }
    }

     
    
    
}

