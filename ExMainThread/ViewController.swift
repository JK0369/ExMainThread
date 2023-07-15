//
//  ViewController.swift
//  ExMainThread
//
//  Created by 김종권 on 2023/07/15.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncOnlySample()
        asyncOnlySample()
        combinationSample1()
        combinationSample2()
        runOnBackgroundThread()
    }
    
    func syncOnlySample() {
        print("start only sync \n")
        
        DispatchQueue.mainSyncSafe {
            print(1)
            print(11)
        }
        
        print("\nbetween 1 and 2\n")
        
        DispatchQueue.mainSyncSafe {
            print(2)
            print(22)
        }
        
        print("\nbetween 2 and 3\n")
        
        DispatchQueue.mainSyncSafe {
            print(3)
            print(33)
        }
        
        print("\nbetween 3 and 4\n")
        
        DispatchQueue.mainSyncSafe {
            print(4)
            print(44)
        }
    }
    
    func asyncOnlySample() {
        print("start only async \n")
        
        DispatchQueue.main.async {
            print(1)
            print(11)
        }
        
        print("\nbetween 1 and 2\n")
        
        DispatchQueue.main.async {
            print(2)
            print(22)
        }
        
        print("\nbetween 2 and 3\n")
        
        DispatchQueue.main.async {
            print(3)
            print(33)
        }
        
        print("\nbetween 3 and 4\n")
        
        DispatchQueue.main.async {
            print(4)
            print(44)
        }
    }
    
    func combinationSample1() {
        print("start multi Thread \n")
        
        DispatchQueue.main.async {
            print(1)
            print(11)
        }
        
        print("\nbetween 1 and 2\n")
        
        DispatchQueue.mainSyncSafe {
            print(2)
            print(22)
        }
    }
    
    func combinationSample2() {
        print("start multi Thread \n")

        DispatchQueue.main.async {
            print(1)
            print(11)
        }

        print("\nbetween 1 and 2\n")

        print(2)
        print(22)
    }
    
    func runOnBackgroundThread() {
        DispatchQueue.global().async {
            self.someCode()
        }
        print("out of background thread?", Thread.isMainThread) // true
    }

    func someCode() {
        print("Thread.isMainThread?", Thread.isMainThread) // false
    }
}

extension DispatchQueue {
    static func mainSyncSafe(execute work: () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.sync(execute: work)
        }
    }
}
