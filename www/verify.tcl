ad_page_contract {
    Verify an authentication token issued by login.tcl.
    If verification is successful, returns an XML document with user information.
} {
    token:notnull,string_length(min|41)
}

set user_id [auth::server::verify_token -token $token]

if { [empty_string_p $user_id] } {
    ns_return 200 text/plain "Sorry, there was an error authenticating."
    return
}

# Get and return user information
acs_user::get -user_id $user_id -array user
auth::authority::get -authority_id $user(authority_id) -array authority

ns_return 200 application/xml "<?xml version=\"1.0\"?>
<User>
    <firstNames>[ad_quotehtml $user(first_names)]</firstNames>
    <lastName>[ad_quotehtml $user(last_name)]</lastName>
    <email>[ad_quotehtml $user(email)]</email>
    <authority>[ad_quotehtml $authority(short_name)]</authority>
    <username>[ad_quotehtml $user(username)]</username>
    <screenName>[ad_quotehtml $user(screen_name)]</screenName>
    <userID>[ad_quotehtml $user(user_id)]</userID>
</User>"

