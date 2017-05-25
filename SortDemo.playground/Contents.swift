//: Playground - noun: a place where people can play

import UIKit
import Foundation

var arr = [12,10,24,5,56,10,3]
//直接插入排序：在插入第i个记录时，R1,R2...已经排好序，这时将Ri的关键字依次与关键字Ki-1,Ki-2等进行比较，从而找到应该插入的位置并将Ri插入，插入位置及其后的记录依次向后移动。最好的情况下，每趟排序只需做1次比较且不需要移动元素，因此n个元素排序时的总比较次数为n-1,总移动次数为0.时间复杂度为：O(n²)，最坏情况下：总比较次数为：(n+2)(n-1)/2,总移动次数为：（n+3)(n-2)/2，
//从小到大排序
//1.遍历每个元素，让其与其前一个元素比较，如果前一个元素大于后一个元素，则该元素的下标为k,进行该元素前面的元素排序
//2.前面的元素逆序两两比较，下标往后移，并且标记第K个元素应该放置的位置，当此遍历完成后，存放第K个元素
func sort(var array:Array<Int>) -> Array<Int> {
    for index in 1..<array.count {
        if array[index] < array[index-1] {
            let temp = array[index]
            var lastIndex = index - 1
            for k in (0...index-1).reverse() {
                if temp < array[k] {
                    array[k+1] = array[k]
                    lastIndex -= 1
                }
            }
             array[lastIndex+1] = temp
        }
    }
    return array
}

sort(arr)


//冒泡排序：首先将第一个记录的关键字和第二个记录的关键字进行比较，若为逆序，则交换这两个记录的值，然后比较第二个记录和第三个记录的关键字，依此类推，直到第n-1个记录和第n个记录的关键字比较过为止，比较和移动最坏情况下时间复杂度为O(n²)，最坏情况下比较和交换次数为n(n-1)/2
//比较相邻的元素。如果第一个比第二个大，就交换他们两个。
//对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
//针对所有的元素重复以上的步骤，除了最后一个。
//持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
func BubbleSort(var array:Array<Int>) -> Array<Int> {
    var array = array
    for index in (0..<array.count).reverse() {
        for k in 0..<index {
            if array[k+1] < array[k] {
                let temp = array[k]
                array[k] = array[k+1]
                array[k+1] = temp
            }
        }
    }
    return array
}

//BubbleSort(arr)

//简单选择排序
//1.第一趟比较n-1次，第二趟比较n-2次，以此类推，需要比较的次数为n(n-1)/2,进行比较的时间复杂度为：o(n²)
//2.进行移动操作的时间复杂度为o(n)
func selectSort(var array:Array<Int>) -> Array<Int> {
    for index in 0..<array.count {
        for k in (index+1)..<array.count {
            if array[index] > array[k] {
                let temp = array[index]
                array[index] = array[k]
                array[k] = temp
            }
        }
    }
    return array
}

//selectSort(arr)

//希尔排序：缩小增量排序,把记录按下标的一定增量分组，对每组使用直接插入排序算法,以下按数组count/2取下界为增量
//时间复杂度为o(n1.3)，空间复杂度为o(1)

func shellSort(var array:Array<Int>) -> Array<Int>  {
    var d = array.count / 2
    while true {
        d = d/2
        for indexX in 0..<d {
            for(var indexY=indexX+d;indexY<array.count;indexY+=d){
                let temp = array[indexY]
                var k = 0
                for(k=indexY-d;k>=0&&array[k]>temp;k-=d) {
                    array[k+d] = array[k]
                }
                array[k+d] = temp
            }
        }
        if d==1 {
            break
        }
    }
    
    return array
}

//shellSort(arr)

//快速排序：是对冒泡排序的一种改进，通过一趟排序将要排序的数据分割成独立的两个部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序, 平均时间复杂度为o(nlogn),空间复杂度为o(logn).若初始记录序列按关键字有序或基本有序，算法的时间复杂度则退化为o(n²)

func quickSort(var array:Array<Int>,low:Int,high:Int) -> Array<Int>  {
        var i = low
        var j = high
        let pivotKey = array[i]
        while i<j {
            
            while i<j && array[j]>=pivotKey {
                j-=1
                print("first:\(j)")
            }
            if i < j {
                array[i] = array[j]
                print("first:\(array)")
            }

            while i<j&&array[i]<=pivotKey {
                i+=1
                print("\(i)")
            }
            if i < j {
                array[j] = array[i]
                print(array)
            }
        }
    array[i] = pivotKey

    if i > low {array = quickSort(array,low: low,high: i-1)}
    if j < high {array = quickSort(array, low: i+1, high: high)}
    return array
}

//quickSort(arr, low: 0, high: 6)


//堆排序：对一组待排序记录的关键字，首先按堆的定义排成一个序列，从而可以输出堆顶的最大关键字，然后将剩余的关键字再调整成新堆，便得到次大的关键字,如此反复，直到全部关键字排成有序序列为止,时间复杂度为o(nlogn),空间复杂度为o(1)
func heapAdjust(var array:Array<Int>,var s:Int,length:Int) -> Array<Int> {
    let t = array[s]
    for (var index = 2*s+1;index <= length;index = index*2+1) {
        if index < length && array[index] < array[index+1] {index+=1}
        if (t>=array[index]) { break;}
        array[s] = array[index]
        s = index
        print(array)
    }
    array[s] = t
    return array
}

func heapSort(var array:Array<Int>) -> Array<Int> {
    for index in (0...array.count/2-1).reverse() {
        print(index)
        array = heapAdjust(array, s: index,length: array.count-1)
    }
    print("second:\(array)")
    for index in (1..<array.count).reverse() {
        let temp = array[0]
        array[0] = array[index]
        array[index] = temp
        print("third:\(array)")
        array = heapAdjust(array, s: 0,length: index-1)
    }
    return array
}

//heapSort(arr)

//归并排序：该算法是采用分治法（Divide and Conquer）的一个非常典型的应用:
//比较a[i]和b[j]的大小，若a[i]<=b[j]，则将第一个有序表中的元素a[i]复制到r[k]中，并令i和k分别加上1；否则将第二个有序表中的元素b[j]复制到r[k]中，并令j和k分别加上1，如此循环下去，直到其中一个有序表取完，然后再将另一个有序表中剩余的元素复制到r中从下表k到下表t的单元。
//

//两路归并算法
func mergeSort(inout array1:Array<Int>,inout helper:Array<Int>,s:Int,m:Int,n:Int){
    for i in s...n {
        helper[i] = array1[i]
    }
    
    var helperLeft = s
    var helperRight = m+1
    var current = s
    
    while (helperLeft<=m && helperRight<=n) {
        if helper[helperLeft] <= helper[helperRight] {
            array1[current] = helper[helperLeft]
            helperLeft += 1
        } else {
            array1[current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    guard m - helperLeft >= 0 else {return }
    for index in 0...m-helperLeft {
        array1[current+index] = helper[helperLeft+index]
    }

}

func mergeSort(inout array:[Int],inout helper:[Int],s:Int,n:Int) {
    guard s < n else {return }
    let middle = (n-s)/2 + s
    mergeSort(&array, helper: &helper, s: s, n: middle)
    mergeSort(&array, helper: &helper, s: middle+1, n: n)
    mergeSort(&array, helper: &helper, s: s, m: middle, n: n)
}

//var helper = Array<Int>.init(count: arr.count, repeatedValue: 0)
//mergeSort(&arr, helper:&helper, s: 0, n: arr.count-1)
//print(arr)

//基数排序
//基数排序法是属于稳定性的排序，其时间复杂度为O (nlog(r)m)，其中r为所采取的基数，而m为堆数
//LSD的基数排序适用于位数小的数列，如果位数多的话，使用MSD的效率会比较好。MSD的方式与LSD相反，是由高位数为基底开始进行分配，但在分配之后并不马上合并回一个数组中，而是在每个“桶子”中建立“子桶”，将每个桶子中的数值按照下一数位的值分配到“子桶”中。在进行完最低位数的分配后再合并回单一的数组中。
func radixSort(var array:Array<Int>) -> Array<Int> {
    
        var m = 0
        var n = 1
        var k = 0
        let d =  findMaxNum(array)
    while m <= d {
        var temp = Array.init(count: 10, repeatedValue: Array<Int>())
        for index in 0..<array.count {
            let lsd = (array[index]/n)%10
            temp[lsd].append(array[index])
        }
        for index in 0..<10 {
            if temp[index].count != 0 {
                for indexJ in 0..<temp[index].count {
                    array[k] = temp[index][indexJ]
                    k += 1
                }
            }
        }
        n *= 10
        k = 0
        m += 1
    }

    
    return array
}
func getLoopTimes(num:Int) -> Int {
    var count = 0
    var temp = num / 10
    while  temp != 0  {
        count += 1
        temp /= 10
    }
    return count
}

func findMaxNum(array:Array<Int>) -> Int {
    var num = array[0]
    for item in array {
        if item > num {
            num = item
        }
    }
    return getLoopTimes(num)
}

var arr1 = [12,10,24,5,56,11,3]
findMaxNum(arr1)
radixSort(arr1)






