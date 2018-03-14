
-- +migrate Up
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(256) NOT NULL,
    email_verification_code VARCHAR(64) NOT NULL,
    email_verification_code_sent_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    pwhash BYTEA NOT NULL,
    username VARCHAR(128) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO users
(
    email, 
    email_verification_code, 
    pwhash, 
    username
)
VALUES
(
    'aja@nicewrk.com',
    'mblBM77j7Q5rJ4553u4NfPxcLQe0zS8EZsI7xBHY9wxKpVHrOvveDsOcOkLWoxcD',
    crypt('4FF!%)"5ETr~wh{sR', gen_salt('bf', 16))::BYTEA,
    'aja'
);

-- +migrate Down
DROP TABLE IF EXISTS users;

DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS "pg_trgm";
DROP EXTENSION IF EXISTS "pgcrypto";
