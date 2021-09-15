# 最後のコミットからの差分抽出

prefix=../diff/`date '+%Y%m%d_%H%M%S'`/${PWD##*/}/

count=0
existCount=-1

# 新規ファイルはステージングされていないと抽出できないため
git add --a

# 差分ファイルを抽出(変更前) ※これによってフォルダ構成も作られるためコピーしやすい
git checkout-index -f --prefix=$prefix `git diff --diff-filter=d --name-only ^HEAD`



# ↓↓↓差分ファイルを抽出(変更後)↓↓↓

# 差分ファイルの名前+パスを取得
diffs=`git diff --diff-filter=d --name-only ^HEAD`

count=0

# 差分ファイルを全てコピーしていく
for diff in $diffs
do
    count=$(($count+1))
    cp $diff $prefix$diff
done
existCount=`ls -a -R -F $prefix | grep -v / | grep -v : | grep -v '^\s*$' | wc -l`

# チェック機能
if [ $count -eq $existCount ];
then
    echo 「$existCount」つのファイルを抽出しました。
else
    echo 抽出に失敗しました。
fi

echo ↓↓↓↓↓抽出したファイル↓↓↓↓↓
ls -a -R -F $prefix | grep -v / | grep -v : | grep -v '^\s*$'
