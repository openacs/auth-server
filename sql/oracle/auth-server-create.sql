--
-- Data model for auth-server
--
-- @author Andrew Grumet (aegrumet@mit.edu)
-- @author Lars Pind (lars@collaboraid.biz)
--
-- @creation-date 20003-10-08
--
-- @cvs-id $Id$
--

create sequence auth_server_token_id_seq start with 1;
    
create table authentication_server_token (
    token_id                    integer
                                constraint auth_srv_token_pk
                                primary key,
    user_id                     integer
                                constraint auth_srv_user_id_nn
                                not null
                                constraint auth_srv_user_id_fk
                                references users,
    random_string               char(40)
                                constraint auth_srv_rand_str_nn
                                not null,
    consumed_on                 date
);

