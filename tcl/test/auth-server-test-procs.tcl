ad_library {
    Automated tests.

    @cvs-id $Id$
}

aa_register_case auth_server {
    Test authentication server.
} {    
    aa_run_with_teardown \
        -rollback \
        -test_code {
            
            set token [auth::server::generate_token]
            aa_false "Token is not empty" [empty_string_p $token]
            
            aa_equals "Token verified OK" [auth::server::verify_token -token $token] [ad_conn user_id]

            aa_equals "Token doesn't verify twice" [auth::server::verify_token -token $token] {}

            aa_equals "Random wrong token doesn't verify" [auth::server::verify_token -token "[ad_generate_random_string 40]123"] {}
        }
}

