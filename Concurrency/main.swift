import Foundation


func performTaskA() async -> Int {
    print("Start A")
    // Wait for 10 seconds
    await Task.sleep(10 * 1_000_000_000)
    print("End A")
    return 3
}

func performTaskB() async -> Int {
    print("Start B")
    await Task.sleep(11 * 1_000_000_000)
    print("End B")
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

