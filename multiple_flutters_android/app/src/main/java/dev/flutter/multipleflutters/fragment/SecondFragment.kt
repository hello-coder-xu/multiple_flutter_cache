package dev.flutter.multipleflutters.fragment

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import dev.flutter.multipleflutters.*
import dev.flutter.multipleflutters.activity.SingleFlutterActivity

class SecondFragment : Fragment(), DataModelObserver {

    private lateinit var countView: TextView
    private lateinit var numberAdd: TextView
    private lateinit var nextPage: TextView

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        println("原生 第二个 onCreateView")
        val currentView = inflater.inflate(R.layout.second_fragment, container, false)
        DataModel.instance.addObserver(this)
        initView(currentView)
        return currentView
    }


    /// 初始化视图
    private fun initView(view: View) {
        countView = view.findViewById(R.id.count)
        numberAdd = view.findViewById(R.id.number_add)
        nextPage = view.findViewById(R.id.next_page)

        countView.text = DataModel.instance.counter.toString()

        numberAdd.setOnClickListener {
            DataModel.instance.counter = DataModel.instance.counter + 1
        }
        nextPage.setOnClickListener {
            val nextClass = SingleFlutterActivity::class.java
            val flutterIntent = Intent(activity, nextClass)
            flutterIntent.putExtra("initialRoute", "/second")
            startActivity(flutterIntent)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        println("原生 第二个 onDestroy")
        DataModel.instance.removeObserver(this)
    }

    override fun onCountUpdate(newCount: Int) {
        countView.text = newCount.toString()
    }


}