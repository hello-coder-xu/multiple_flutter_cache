package dev.flutter.multipleflutters

import android.content.Context
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

interface EngineBindingsDelegate {
    fun onNext()
}

class EngineBindings(
    context: Context,
    delegate: EngineBindingsDelegate,
    entrypoint: String,
    initialRoute: String = "/main"
) :
    DataModelObserver {
    private val channel: MethodChannel
    val engine: FlutterEngine
    private val delegate: EngineBindingsDelegate

    init {
        val app = context.applicationContext as App
        val dartEntrypoint = DartExecutor.DartEntrypoint(
            FlutterInjector.instance().flutterLoader().findAppBundlePath(), entrypoint
        )
        println("原生 entrypoint=$entrypoint initialRoute=$initialRoute")
        engine = app.engines.createAndRunEngine(context, dartEntrypoint, initialRoute)
        this.delegate = delegate
        channel = MethodChannel(engine.dartExecutor.binaryMessenger, "multiple-flutters")
    }


    fun attach() {
        DataModel.instance.addObserver(this)
        channel.invokeMethod("setCount", DataModel.instance.counter)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "incrementCount" -> {
                    DataModel.instance.counter = DataModel.instance.counter + 1
                    result.success(null)
                }
                "next" -> {
                    this.delegate.onNext()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    fun detach() {
        engine.destroy()
        DataModel.instance.removeObserver(this)
        channel.setMethodCallHandler(null)
    }

    override fun onCountUpdate(newCount: Int) {
        channel.invokeMethod("setCount", newCount)
    }
}
