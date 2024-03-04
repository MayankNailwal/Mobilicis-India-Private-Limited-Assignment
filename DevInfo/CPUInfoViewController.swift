//
//  CPUInfoViewController.swift
//  DevInfo
//
//  Created by MAYANK NAILWAL on 04/03/24.
//

import UIKit

class CPUInfoViewController: UIViewController {
    
    var processorC: Int?
    var activeProcessorCount: Int?
    var physicalMemory: UInt64?

    @IBOutlet weak var processorCount: UILabel!
    @IBOutlet weak var physicalMemo: UILabel!
    @IBOutlet weak var activeCount: UILabel!
    override func viewDidLoad() {
        processorCount.text = "\(processorC!)"
        activeCount.text = "\(activeProcessorCount!)"
        physicalMemo.text = "\(physicalMemory!) GB"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
