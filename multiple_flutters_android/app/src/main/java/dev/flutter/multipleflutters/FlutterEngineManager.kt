package dev.flutter.multipleflutters

import android.content.Context
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

object FlutterEngineManager {


    fun flutterEngine(context: Context, engineId: String, entryPoint: String): FlutterEngine {
        // 1. 从缓存中获取FlutterEngine
        var engine = FlutterEngineCache.getInstance().get(engineId)
        if (engine == null) {
            // 如果缓存中没有FlutterEngine
            // 1. 新建FlutterEngine，执行的入口函数是entryPoint
            val app = context.applicationContext as App
            val dartEntrypoint = DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(), entryPoint
            )
            engine = app.engines.createAndRunEngine(context, dartEntrypoint)
            // 2. 存入缓存
            FlutterEngineCache.getInstance().put(engineId, engine)
        }
        return engine!!
    }


}