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
    var url : NSURL = NSURL(string: "")!
    var resultText : MutableProperty<String> = MutableProperty("")
    var action : Action<String, NSURL, NSError>!
    var action2 : Action<AnyObject?, NSURL, NSError>!
//    var textToUrlProducer : SignalProducer<NSURL, NSError>
    
    
    override init() {
        super.init()
        
//        urlText.producer.startWithSignal { (observer, disposable) in
//            observer.map{ value -> NSURL in
//                return NSURL(string: value)!
//            }
//        }
     
        urlText.signal.observeNext { value in
            print(value)
           self.url = NSURL(string: value)!
        }
        
        action2 = Action { value in
            return SignalProducer<NSURL, NSError>{ observer, _ in
                observer.sendNext(NSURL(string: value as! String)!)
                observer.sendCompleted()
            }
//            print("aaaasaa")
//            return SignalProducer.empty
        }
        
//        action2 = Action(enabledIf:urlText) {_ in 
//            return SignalProducer<NSURL, NSError>{ observer, _ in
//                observer.sendNext(NSURL(string: urlText)
//            }
//        }
        
        action = Action { input in
            print("action")
            if let url : String = input {
                return SignalProducer<NSURL, NSError>{ observer, disposable in
                    observer.sendNext(NSURL(string: url)!)
                    observer.sendCompleted()
                }
            }
            fatalError("error")
        }
    }
    
    
    func getUrlbyText() -> SignalProducer<NSURL, NSError> {
        
        return SignalProducer<NSURL, NSError>({ (observer, disposable) in
            let url = NSURL(string: self.resultText.value as String)
            observer.sendNext(url!)
            observer.sendCompleted()
            
            disposable.addDisposable({ 
                //
            })
        }).observeOn(UIScheduler())
    }
    
}