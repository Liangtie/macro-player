export p=`pwd`
export f=`pwd`/source/CMakeLists.txt
echo ${p##*/}
echo "target_sources(">$f
echo ${p##*/} >>$f
echo "PRIVATE" >>$f
cd source
find . -iname "*.cpp" >>$f

echo ")" >> $f

