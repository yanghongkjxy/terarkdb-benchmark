nohup dstat -tcm --output /home/panfengfeng/trace_log/in-memory/wikiarticles/fillrandom_mulit_terark_index_256 2 > nohup.out &

file=/data/publicdata/wikiarticles/enwiki-latest.text
record_num=3977902
dirname=/mnt/datamemory

rm -rf $dirname/*
export TMPDIR=$dirname
echo $TMPDIR
cp ../../terarkschema/dbmeta_wikiarticles_index.json $dirname/dbmeta.json
echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export TerarkDb_WrSegCacheSizeMB=256
../../db_wikiarticles_terark_index --benchmarks=fillrandom --num=$record_num --sync_index=0 --db=$dirname --resource_data=$file
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

rm -rf $dirname/*
export TMPDIR=$dirname
echo $TMPDIR
cp ../../terarkschema/dbmeta_wikiarticles_index.json $dirname/dbmeta.json
echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export TerarkDb_WrSegCacheSizeMB=256
../../db_wikiarticles_terark_index --benchmarks=fillrandom --num=$record_num --sync_index=0 --db=$dirname --resource_data=$file --threads=3
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

rm -rf $dirname/*
export TMPDIR=$dirname
echo $TMPDIR
cp ../../terarkschema/dbmeta_wikiarticles_index.json $dirname/dbmeta.json
echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export TerarkDb_WrSegCacheSizeMB=256
../../db_wikiarticles_terark_index --benchmarks=fillrandom --num=$record_num --sync_index=0 --db=$dirname --resource_data=$file --threads=6
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

dstatpid=`ps aux | grep dstat | awk '{if($0 !~ "grep"){print $2}}'`
for i in $dstatpid
do
        kill -9 $i
done
