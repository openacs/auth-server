ad_page_contract {
    This is a page which other services can redirect to. If the user is already
    authenticated in OpenACS, we will redirect the user to 'service' with a token 
    added to the URL.
    
    @param service The URL to redirect the browser to. Should be a URL on the remote system,
                   which accepts a 'token' query argument, then verifies it using verify.tcl.
    
} {
    service:notnull
}

auth::require_login

set return_url [export_vars -base $service { { token {[auth::server::generate_token]} } }]

ad_returnredirect $return_url
