ad_library {
    Library routines for authentication server.

    @cvs-id $Id$
}

namespace eval auth::server {}

ad_proc -public auth::server::generate_token {} {
    Generate a secret token which can be used to verify 
    the identity of the current user to a remote system.
    
    @return token, or the empty string if no user is logged in
} {
    if { [ad_conn user_id] == 0 } {
        return {}
    }
    
    # Generate a 40 character random string.
    set random_string [ad_generate_random_string 40]
    
    # Do the insert.
    set user_id [ad_conn user_id]
    set token_id [db_nextval auth_server_token_id_seq]
    db_dml insert_token {
        insert into authentication_server_token 
        (token_id, user_id, random_string)
        values (:token_id, :user_id, :random_string)
    }

    set token "${random_string}${token_id}"

    return $token
}


ad_proc -public auth::server::verify_token {
    {-token:required}
} {
    Verifies and authentication server token, and returns user_id if the token 
    was valid, or empty string if there was a problem.

    @return user_id or empty_string.
} {
    # Token has the following structure:
    # First 40 characters are the random string.
    # All remaining characters are the id key.
    
    set random_string [string range $token 0 39]
    set token_id [string range $token 40 end]
    
    # check syntax
    if { ![regexp {^[1-9][0-9]*$} $token_id] } {
        return {}
    }
    
    set user_id [db_string select_user_id { 
        select user_id 
        from   authentication_server_token
        where  token_id = :token_id
        and    random_string = :random_string
        and    consumed_on is null
    } -default {}]
    
    # Mark the token consumed
    db_dml mark_token {}

    if { [db_resultrows] == 0 } {
        return {}
    }

    return $user_id
}


