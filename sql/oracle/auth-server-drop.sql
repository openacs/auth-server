--
-- Drop script for auth-server
--
-- @author Andrew Grumet (aegrumet@mit.edu)
-- @author Lars Pind (lars@collaboraid.biz)
--
-- @creation-date 20003-10-08
--
-- @cvs-id $Id$
--

drop sequence auth_server_token_id_seq;
    
drop table authentication_server_token;
