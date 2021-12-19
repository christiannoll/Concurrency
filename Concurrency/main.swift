import Foundation


func performTaskA() async -> Int {
    print("Start A")
    do {
        // Wait for 10 seconds
        try await Task.sleep(nanoseconds: 10 * 1_000_000_000)
        print("End A")
    }
    catch {
        print("Error")
    }
    return 3
}

func performTaskB() async -> Int {
    print("Start B")
    do {
        try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        print("End B")
    }
    catch {
        print("Error")
    }
    return 2
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

