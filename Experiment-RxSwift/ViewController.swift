//
//  ViewController.swift
//  Experiment-RxSwift
//
//  Created by Jeffry Sandy Purnomo on 11/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

	let observableA = BehaviorRelay<String>(value: "")
	let observableB = BehaviorRelay<String>(value: "")
	let observableC = BehaviorRelay<String>(value: "")
	let observableD = BehaviorRelay<String>(value: "")
	let observableE = BehaviorRelay<String>(value: "")
	
	let disposeBag: DisposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		observeCombineLatest()
		
		updateObservable(observable: observableA, withValue: "Test", after: 3)
		updateObservable(observable: observableB, withValue: "HOHO", after: 6)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
			self.observeZip()
		}
		
		updateObservable(observable: observableA, withValue: "HEHE 1", after: 7)
		updateObservable(observable: observableB, withValue: "HEHE 2", after: 8)
		updateObservable(observable: observableC, withValue: "HEHE 3", after: 9)
		updateObservable(observable: observableD, withValue: "HEHE 4", after: 10)
		updateObservable(observable: observableE, withValue: "LALA 1", after: 13)
		
		updateObservable(observable: observableA, withValue: "HEHE 5", after: 14)
		updateObservable(observable: observableB, withValue: "HEHE 6", after: 15)
		updateObservable(observable: observableC, withValue: "HEHE 7", after: 16)
		updateObservable(observable: observableC, withValue: "HEHE 8", after: 16)
		updateObservable(observable: observableD, withValue: "HEHE 9", after: 17)
		updateObservable(observable: observableE, withValue: "LALA 2", after: 18)
	}
	
	private func updateObservable(observable: BehaviorRelay<String>, withValue: String, after time: Double) {
		DispatchQueue.main.asyncAfter(deadline: .now() + time) {
			observable.accept(withValue)
		}
	}
	
	private func observeCombineLatest() {
		Observable.combineLatest(observableA,
								 observableB,
								 observableC,
								 observableD,
								 observableE)
		.subscribe(onNext: { (observableA, observableB, observableC, observableD, observableE) in
			
			print("[Jeffry] Combine Latest: \(observableA) - \(observableB) - \(observableC) - \(observableD) - \(observableE)")
		})
		.disposed(by: disposeBag)
	}
	
	private func observeZip() {
		Observable.zip(observableA,
					   observableB,
					   observableC,
					   observableD,
					   observableE)
		.subscribe(onNext: { (observableA, observableB, observableC, observableD, observableE) in
			
			print("[Jeffry] Zip: \(observableA) - \(observableB) - \(observableC) - \(observableD) - \(observableE)")
		})
		.disposed(by: disposeBag)
	}
}

