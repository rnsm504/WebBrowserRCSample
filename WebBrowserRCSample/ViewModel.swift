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
//    var url : NSURL = NSURL(string: "")!
//    var resultText : MutableProperty<String> = MutableProperty("")
//    var action : Action<String, NSURL, NSError>!
//    var action2 : Action<AnyObject?, NSURL, NSError>!
    var action3 : Action<String, NSURL, NSError>!
//    var action4 : Action<String, Void, NSError>?
    var validation: MutableProperty<Bool>!
//    var textToUrlProducer : SignalProducer<NSURL, NSError>

    internal lazy var enabled : AnyProperty<Bool> = {
        var property = MutableProperty(false)
        
        property <~ self.urlText.producer.map { $0.characters.count > 5}
        
        print("love")
        return AnyProperty(property)
    }()
    
    
    override init() {
        super.init()
        
        validation = MutableProperty(false)
        
        urlText.producer.startWithNext { value in
            if(value.characters.count > 5){
                print("yes")
                self.validation <~ MutableProperty(true)
            }
        }
    
        
        action3 = Action(enabledIf: validation) { value in
            return SignalProducer { (observer, disposable) in
                print("forever: " + self.urlText.value)
                observer.sendNext(NSURL(string: self.urlText.value)!)
                observer.sendCompleted()
            }
        }
        
//        action3.values.observeNext{$0}
        
//        urlText.producer.startWithSignal { (observer, disposable) in
//            observer.map{ value -> NSURL in
//                return NSURL(string: value)!
//            }
//        }
     
//        urlText.signal.observeNext { value in
//            print(value)
//           self.url = NSURL(string: value)!
//        }
//        

//        let validation = combineLatest(urlText.producer)
//            .map({(urlText) -> Bool in
//                urlText.characters.count > 5
//            })
//        
//        let validationS = urlText.producer
//            .map({ (urlText) -> Bool in
//                return urlText.characters.count > 2  })
//            .skipRepeats()

//        validation = AnyProperty(initialValue: false, signal: validationS)
        
//        action3 = Action<String, NSURL, NSError>(enabledIf: validation) { value in
//            return SignalProducer<NSURL, NSError>{ observer, _ in
//                print(value as! String)
//                observer.sendNext(NSURL(string: value as! String)!)
//                observer.sendCompleted()
//            }

//        action3 = Action<String, NSURL, NSError>(enabledIf: validationS) { value in
//            return SignalProducer<NSURL, NSError>{ observer, _ in
//                observer.sendNext(NSURL(string: value )!)
//                observer.sendCompleted()
//            }}
//
//        action3 = Action<String, NSURL, NSError>(enabledIf: validation, { value in
//            return SignalProducer<NSURL, NSError>{ observer, _ in
//                observer.sendNext(NSURL(string: value as! String)!)
//                observer.sendCompleted()
//            }
//        })

//        action3 = Action<String, NSURL, NoError>(enabledIf: validation, { (value)  ->
//             SignalProducer<NSURL, NoError>{ observer ,_ in
//                let url = NSURL(string: value)
//                observer.sendNext(url)
//                observer.sendCompleted()
//            }
//        })
        

//        action3 = Action(enabledIf: validationS) { value in
//            return SignalProducer<NSURL, NSError>{ observer, _ in
//                let url = NSURL(string: value as! String)
//                observer.sendNext(url!)
//                observer.sendCompleted()
//            }
//        }
        
        
//        action3 = Action<String, NSURL, NSError>(enabledIf: validationS, { value in SignalProducer<NSURL, NSError> {_,_ in 
//            
//            return SignalProducer<NSURL, NSError>({ (observer, disposable) in
//                let url = NSURL(string: value)
//                observer.sendNext(url!)
//                observer.sendCompleted()
//                
//                disposable.addDisposable({
//                    //
//                })
//            }).observeOn(UIScheduler())
//            }
//        }
//        )
        
//        
//        action3 = Action<String, NSURL, NoError>(enabledIf: validationS, { value in SignalProducer<NSURL, NoError> {_,_ in
//            return SignalProducer<NSURL, NoError>{ (observer, _) in
//                let url = NSURL(string: value)
//                observer.sendNext(url!)
//                observer.sendCompleted()
//                
////                disposable.addDisposable({
////                    //
////                })
//            }
//            }
//            }
//        )
        
   
        
//        action4 = Action<String, Void, NSError>(enabledIf: validation) {_ in
//            return SignalProducer.empty
//        }
        

        
//        action2 = Action { value in
//            return SignalProducer<NSURL, NSError>{ observer, _ in
//                print(value as! String)
//                observer.sendNext(NSURL(string: value as! String)!)
//                observer.sendCompleted()
//            }
////            print("aaaasaa")
////            return SignalProducer.empty
//        }
//        
////        action2 = Action(enabledIf:urlText) {_ in 
////            return SignalProducer<NSURL, NSError>{ observer, _ in
////                observer.sendNext(NSURL(string: urlText)
////            }
////        }
//        
//        action = Action { input in
//            print("action")
//            if let url : String = input {
//                return SignalProducer<NSURL, NSError>{ observer, disposable in
//                    observer.sendNext(NSURL(string: url)!)
//                    observer.sendCompleted()
//                }
//            }
//            fatalError("error")
//        }
    }
    
//    
//    func getUrlbyText() -> SignalProducer<NSURL, NSError> {
//        
//        return SignalProducer<NSURL, NSError>({ (observer, disposable) in
//            let url = NSURL(string: self.resultText.value as String)
//            observer.sendNext(url!)
//            observer.sendCompleted()
//            
//            disposable.addDisposable({ 
//                //
//            })
//        }).observeOn(UIScheduler())
//    }
    
}