<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="auth::server::verify_token.mark_token">
        <querytext>
            update authentication_server_token
            set    consumed_on = sysdate
            where  token_id = :token_id
            and    random_string = :random_string
            and    consumed_on is null
        </querytext>
    </fullquery>

</queryset>
