# �Ō�̃R�~�b�g����̍������o

prefix=../diff/`date '+%Y%m%d_%H%M%S'`/${PWD##*/}/

count=0
existCount=-1

# �V�K�t�@�C���̓X�e�[�W���O����Ă��Ȃ��ƒ��o�ł��Ȃ�����
git add --a

# �����t�@�C���𒊏o(�ύX�O) ������ɂ���ăt�H���_�\��������邽�߃R�s�[���₷��
git checkout-index -f --prefix=$prefix `git diff --diff-filter=d --name-only ^HEAD`



# �����������t�@�C���𒊏o(�ύX��)������

# �����t�@�C���̖��O+�p�X���擾
diffs=`git diff --diff-filter=d --name-only ^HEAD`

count=0

# �����t�@�C����S�ăR�s�[���Ă���
for diff in $diffs
do
    count=$(($count+1))
    cp $diff $prefix$diff
done
existCount=`ls -a -R -F $prefix | grep -v / | grep -v : | grep -v '^\s*$' | wc -l`

# �`�F�b�N�@�\
if [ $count -eq $existCount ];
then
    echo �u$existCount�v�̃t�@�C���𒊏o���܂����B
else
    echo ���o�Ɏ��s���܂����B
fi

echo �������������o�����t�@�C������������
ls -a -R -F $prefix | grep -v / | grep -v : | grep -v '^\s*$'
