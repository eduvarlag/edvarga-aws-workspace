export KEYPATH=".sekrets"
export KEYNAME="deploy-aws"
export AWS_DEFAULT_PROFILE=edvarga
export AWS_PROFILE=edvarga

openssl genrsa -out "$KEYPATH/aws.pem" 4096
openssl rsa -in "$KEYPATH/aws.pem" -pubout > "$KEYPATH/aws.pub"

chmod 400 "$KEYPATH/aws.pem"

echo $KEYNAME
echo "$(grep -v PUBLIC $KEYPATH/aws.pub |
           tr -d '\n')"
aws ec2 import-key-pair \
  --key-name $KEYNAME \
  --public-key-material \
        "$(grep -v PUBLIC $KEYPATH/aws.pub | 
           tr -d '\n')" \
#  --region eu-west-1

cp $KEYPATH/aws.pem $HOME/.ssh/$KEYNAME.pem
cp $KEYPATH/aws.pub $HOME/.ssh/$KEYNAME.pub

