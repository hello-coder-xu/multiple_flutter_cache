package dev.flutter.multipleflutters

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import dev.flutter.multipleflutters.fragment.FirstFragment
import dev.flutter.multipleflutters.fragment.ImFragment
import dev.flutter.multipleflutters.fragment.SecondFragment
import io.flutter.embedding.android.FlutterFragment

class HomeActivity : AppCompatActivity() {
    private var selectIndex = -1

    private lateinit var first: TextView
    private lateinit var im: TextView
    private lateinit var second: TextView


    /// fragment数组
    private var fragmentList = arrayListOf<Fragment>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.home_activity)


        initView()
        initData()
        changeFragment(0)
    }


    private fun initView() {
        first = findViewById(R.id.first)
        im = findViewById(R.id.im)
        second = findViewById(R.id.second)

        first.setOnClickListener {
            changeBottom(0)
        }
        im.setOnClickListener {
            changeBottom(1)
        }
        second.setOnClickListener {
            changeBottom(2)
        }
    }

    private fun initData() {
        fragmentList.add(FirstFragment())
        fragmentList.add(ImFragment())
        fragmentList.add(SecondFragment())
    }


    /// 改变底部视图
    private fun changeBottom(index: Int) {
        first.setBackgroundColor(0xffffff)
        im.setBackgroundColor(0xffffff)
        second.setBackgroundColor(0xffffff)
        when (index) {
            0 -> {
                first.setBackgroundResource(R.color.purple_500)
            }
            1 -> {
                im.setBackgroundResource(R.color.purple_500)
            }
            2 -> {
                second.setBackgroundResource(R.color.purple_500)
            }
        }
        // 切换
        changeFragment(index)
    }

    /// 选择哪个fragment显示
    private fun changeFragment(index: Int) {
        println("test selectIndex=$selectIndex index=$index")
        if (selectIndex != index) {
            val transaction = supportFragmentManager.beginTransaction()
//            if (selectIndex != -1) {
//                transaction.hide(fragmentList[selectIndex])
//            }
            val currentFragment = fragmentList[index]
//            if (!fragmentList[index].isAdded) {
//                transaction.add(R.id.fragment, currentFragment)
//            } else {
//                transaction.show(currentFragment)
//            }
            transaction.replace(R.id.fragment, currentFragment)
            transaction.commitNow()
//            transaction.commitAllowingStateLoss()
            selectIndex = index
        }
    }


}