import AVFoundation
import UIKit

class CameraInfoFetcher {
    
    func fetchCameraResolutionInMegapixels(position: AVCaptureDevice.Position = .back) -> Double {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {
            print("Unable to access camera")
            return 0.0
        }
        
        let dimensions = CMVideoFormatDescriptionGetDimensions(device.activeFormat.formatDescription)
        let megapixels = Double(dimensions.width * dimensions.height) / 1_000_000.0
        return megapixels
    }
    
    func fetchCurrentAperture(position: AVCaptureDevice.Position = .back) -> Float? {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {
            print("Unable to access camera")
            return nil
        }
        
        return device.lensAperture
    }
}
