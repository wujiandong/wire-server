{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module V52 (migration) where

import Cassandra.Schema
import Text.RawString.QQ

migration :: Migration
migration = Migration 52 "Add service whitelist table" $
    -- NB. It's expected that for every team there'll only be a few
    -- whitelisted services (tens? maybe less).
    schema' [r|
        create table if not exists service_whitelist
            ( team     uuid
            , provider uuid
            , service  uuid
            , primary key (team, provider, service)
            ) with clustering order by (provider asc, service asc)
    |]
