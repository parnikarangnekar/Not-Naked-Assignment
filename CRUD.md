## Create customer

    FUNCTION createCustomer(shopifyCustomerData):
    
    # Step 1: Map Shopify API response to CDP schema
    
    customerId = generateUUID()
    email = shopifyCustomerData["email"]
    firstName = shopifyCustomerData["first_name"]
    lastName = shopifyCustomerData["last_name"]
    phone = shopifyCustomerData["phone"]

    # Step 2: Insert into Customer table
    
    INSERT INTO Customer (customerId, email, firstName, lastName, phone, createdAt, updatedAt)
    VALUES (customerId, email, firstName, lastName, phone, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)

    RETURN customerId

## Updating Customer

    FUNCTION updateCustomer(customerId, shopifyCustomerData):
    # Step 1: Check if customer exists
    existingCustomer = SELECT * FROM Customer WHERE customerId = customerId

    IF existingCustomer IS NULL:
        RETURN "Customer not found"

    # Step 2: Update customer details
    UPDATE Customer
    SET email = shopifyCustomerData["email"],
        firstName = shopifyCustomerData["first_name"],
        lastName = shopifyCustomerData["last_name"],
        phone = shopifyCustomerData["phone"],
        updatedAt = CURRENT_TIMESTAMP
    WHERE customerId = customerId

    RETURN "Customer updated successfully"

## Deleting Customer

    FUNCTION deleteCustomer(customerId):
    # Step 1: Check if customer exists
    existingCustomer = SELECT * FROM Customer WHERE customerId = customerId

    IF existingCustomer IS NULL:
        RETURN "Customer not found"

    # Step 2: Delete customer record
    DELETE FROM Customer WHERE customerId = customerId

    RETURN "Customer deleted successfully"

    
