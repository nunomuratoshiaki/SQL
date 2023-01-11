import os, boto3

Name = os.environ['Name']
EmailAddress = os.environ['EmailAddress']
account = boto3.client('account')
organizations = boto3.client('organizations')

def lambda_handler(event, context):
    
    try:
        account_id = event["detail"]["serviceEventDetails"]["createAccountStatus"]["accountId"]
        
        print('Account ID is ' + account_id)
        response = account.put_alternate_contact(
            Title = "課長", 
            PhoneNumber = "+81-3-5276-3652", 
            Name = Name, 
            EmailAddress = EmailAddress, 
            AlternateContactType = "OPERATIONS", 
            AccountId = str(account_id)
        )
        
        print('■Result of executing put_alternate_contact')
        print(response)

    except:
        print('An error has occurred. Failed to add contact informations.')

    return