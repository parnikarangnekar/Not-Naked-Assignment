-- Enum table for Party Types (Person / Group)
CREATE TABLE party_enum (
    enum_id VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- Enum table for Role Types
CREATE TABLE role_type_enum (
    enum_id VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- Core Party table
CREATE TABLE party (
    party_id VARCHAR(50) PRIMARY KEY,
    party_type_id VARCHAR(50) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),

    CONSTRAINT fk_party_type FOREIGN KEY (party_type_id) REFERENCES party_enum(enum_id)
);

-- Person table (specialization of Party)
CREATE TABLE person (
    party_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(10),
    birth_date DATE,

    CONSTRAINT fk_person_party FOREIGN KEY (party_id) REFERENCES party(party_id)
);

-- Party Group table (specialization of Party)
CREATE TABLE party_group (
    party_id VARCHAR(50) PRIMARY KEY,
    group_name VARCHAR(255),

    CONSTRAINT fk_group_party FOREIGN KEY (party_id) REFERENCES party(party_id)
);

-- Party Role (links Party with a Role Type)
CREATE TABLE party_role (
    party_id VARCHAR(50) NOT NULL,
    role_type_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (party_id, role_type_id),

    CONSTRAINT fk_role_party FOREIGN KEY (party_id) REFERENCES party(party_id),
    CONSTRAINT fk_role_type FOREIGN KEY (role_type_id) REFERENCES role_type_enum(enum_id)
);

-- Party Classification (tagging / grouping of Party)
CREATE TABLE party_classification (
    classification_id VARCHAR(50) PRIMARY KEY,
    party_id VARCHAR(50) NOT NULL,
    classification_type VARCHAR(100),
    from_date DATE,
    thru_date DATE,

    CONSTRAINT fk_class_party FOREIGN KEY (party_id) REFERENCES party(party_id)
);

-- User Login table
CREATE TABLE user_login (
    user_login_id VARCHAR(50) PRIMARY KEY,
    current_password VARCHAR(255) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE
);

-- Mapping between Party and User Login
CREATE TABLE party_user_login (
    party_id VARCHAR(50) NOT NULL,
    user_login_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (party_id, user_login_id),

    CONSTRAINT fk_pul_party FOREIGN KEY (party_id) REFERENCES party(party_id),
    CONSTRAINT fk_pul_user FOREIGN KEY (user_login_id) REFERENCES user_login(user_login_id)
);

-- Security Group
CREATE TABLE security_group (
    group_id VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255)
);

-- Security Group Permissions
CREATE TABLE security_group_permissions (
    group_id VARCHAR(50) NOT NULL,
    permission_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (group_id, permission_id),

    CONSTRAINT fk_sgp_group FOREIGN KEY (group_id) REFERENCES security_group(group_id)
);

-- UserLogin - SecurityGroup Mapping
CREATE TABLE user_login_security_group (
    user_login_id VARCHAR(50) NOT NULL,
    group_id VARCHAR(50) NOT NULL,
    from_date DATE,
    thru_date DATE,
    PRIMARY KEY (user_login_id, group_id),

    CONSTRAINT fk_ulsg_user FOREIGN KEY (user_login_id) REFERENCES user_login(user_login_id),
    CONSTRAINT fk_ulsg_group FOREIGN KEY (group_id) REFERENCES security_group(group_id)
);
