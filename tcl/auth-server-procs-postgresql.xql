<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="auth::server::verify_token.mark_token">
        <querytext>
            update authentication_server_token
            set    consumed_on = current_timestamp
            where  token_id = :token_id
            and    random_string = :random_string
            and    consumed_on is null
        </querytext>
    </fullquery>

</queryset>
