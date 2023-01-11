# AWS��Python�ŗ��p���邽�߂�SDK boto3���C���|�[�g����
import boto3

from boto3.dynamodb.conditions import Key, Attr
 
# Function�̎��s���O���o��
print('Loading function')
 
# DynamoDB�Ɛڑ�
dynamodb = boto3.resource('dynamodb')
 
# �e�[�u������ID���w�肵�ăf�[�^���Y������item���擾����
def lambda_handler(event, context):
    table_name = "testdb"
    partition_key = {"id": event["id"]}
    dynamotable = dynamodb.Table(table_name)
    res = dynamotable.get_item(Key=partition_key)
    item = res["Item"]
    
    return item


#API�p�̐ݒ�
{
    "id" : "$input.params('id')"
}



#�e�X�g�p�̐ݒ�
{
  "id": "1001"
}
