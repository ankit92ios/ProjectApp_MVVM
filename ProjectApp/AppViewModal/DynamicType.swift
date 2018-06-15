//
//  DynamicType.swift
//  ProjectApp
//
//  Created by Ankit Agarwal on 6/15/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

public class DynamicType<T>{
    typealias Listener = (T) -> Void
    private var listeners: [Listener] = []
    
    var value : T? { didSet  {
        for (_,observer) in listeners.enumerated() {
                if let value = value {
                    observer(value)
                }
            }
        }
    }
    
    func bind(listener: @escaping Listener) {
        /*BIND and FIRE*/
        self.listeners.append(listener)
        if let value = value {
            listener(value)
        }
    }


    init(_ value : T?){
        self.value = value
    }
    
}
