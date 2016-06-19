//
//  ViewModel.swift
//  WebBrowserRCSample
//
//  Created by Masanori Kuze on 2016/05/22.
//  Copyright © 2016年 Masanori Kuze. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class ViewModel : NSObject {
 
    var urlText : MutableProperty<String> = MutableProperty("")
    var action : Action<String, NSURL, NSError>!
    var validation: MutableProperty<Bool>!
    
    override init() {
        super.init()
        
        validation = MutableProperty(false)
        
        urlText.producer.startWithNext { value in
            if(value.characters.count > 5){
                print("true")
                self.validation <~ MutableProperty(true)
            }
        }
        
        action = Action(enabledIf: validation) { value in
            return SignalProducer { (observer, disposable) in
                print("action: " + self.urlText.value)
                observer.sendNext(NSURL(string: self.urlText.value)!)
                observer.sendCompleted()
            }
        }
        
    }
    
}