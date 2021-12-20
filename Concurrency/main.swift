import Foundation


func performTaskA() async -> Int {
    print("Start Task A")
    let secondsToWait: UInt64 = 10
    do {
        try await Task.sleep(nanoseconds: secondsToWait * 1_000_000_000)
        print("End Task A")
    }
    catch {
        print("Error while trying to perform task A")
    }
    return Int(secondsToWait)
}

func performTaskB() async -> Int {
    print("Start Task B")
    let secondsToWait: UInt64 = 5
    do {
        try await Task.sleep(nanoseconds: secondsToWait * 1_000_000_000)
        print("End Task B")
    }
    catch {
        print("Error while trying to perform task B")
    }
    return Int(secondsToWait)
}

let runLoop = CFRunLoopGetCurrent()

func doSomething() {
    Task(priority: .high) {
        let start = Date()
        
        async let a = performTaskA()

        async let b = performTaskB()

        let sum = await (a + b)
        
        print("\nExpected time if sequentially executed: \(sum) seconds")
        print("Real time simultaneously executed: \(Int(start.timeIntervalSinceNow * -1)) seconds\n")
        
        CFRunLoopStop(runLoop)
    }
}

doSomething()
CFRunLoopRun()

