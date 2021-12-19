import Foundation


func performTaskA() async -> Int {
    print("Start A")
    let waitForSeconds: UInt64 = 10
    do {
        // Wait for 10 seconds
        try await Task.sleep(nanoseconds: waitForSeconds * 1_000_000_000)
        print("End A")
    }
    catch {
        print("Error")
    }
    return Int(waitForSeconds)
}

func performTaskB() async -> Int {
    print("Start B")
    let waitForSeconds: UInt64 = 5
    do {
        try await Task.sleep(nanoseconds: waitForSeconds * 1_000_000_000)
        print("End B")
    }
    catch {
        print("Error")
    }
    return Int(waitForSeconds)
}

let runLoop = CFRunLoopGetCurrent()

func doSomething() {
    Task(priority: .high) {
        // Create & start a child task
        async let a = performTaskA()

        // Create & start a child task
        async let b = performTaskB()

        let sum = await (a + b)
        print(sum)
        CFRunLoopStop(runLoop)
    }
}

doSomething()
CFRunLoopRun()

