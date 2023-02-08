PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title VARCHAR(80) NOT NULL,
    body VARCHAR(300) NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
); 

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    body VARCHAR(300) NOT NULL,
    parent_reply INTEGER,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Seeding users
INSERT INTO users (fname, lname)
VALUES ('michael', 'gastello');
INSERT INTO users (fname, lname)
VALUES ('gary', 'hor');
INSERT INTO users (fname, lname)
VALUES ('alvin', 'zablan');


-- Seeding questions
INSERT INTO questions (title, body, user_id)
VALUES ('SQLite3',
    'how we do dis',
    (SELECT id FROM users WHERE fname = 'michael'));
INSERT INTO questions (title, body, user_id)
VALUES ('supreme',
    'testing waters $100',
    (SELECT id FROM users WHERE fname = 'gary'));
INSERT INTO questions (title, body, user_id)
VALUES ('app academy',
    'miss you guys',
    (SELECT id FROM users WHERE fname = 'alvin'));


-- Seeding question_follows
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT id FROM questions WHERE user_id = 3),
    (SELECT id FROM users WHERE fname = 'michael')
    );
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT id FROM questions WHERE user_id = 3),
    (SELECT id FROM users WHERE fname = 'gary')
    );
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT id FROM questions WHERE user_id = 1),
    (SELECT id FROM users WHERE fname = 'gary')
    );
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT id FROM questions WHERE user_id = 2),
    (SELECT id FROM users WHERE fname = 'michael')
    );


-- Seeding replies
INSERT INTO replies (question_id, body, parent_reply, user_id)
VALUES (3, 'miss you too bro :/', NULL, 1);
INSERT INTO replies (question_id, body, parent_reply, user_id)
VALUES (3, 'miss you too bro :(', NULL, 2);
INSERT INTO replies (question_id, body, parent_reply, user_id)
VALUES (2, '$69 firm', NULL, 3);
INSERT INTO replies (question_id, body, parent_reply, user_id)
VALUES (2, 'only if you come back to AA', 3, 2);
INSERT INTO replies (question_id, body, parent_reply, user_id)
VALUES (2, 'bet', 4, 3);

-- Seeding question_likes

INSERT INTO question_likes (user_id, question_id)
VALUES (3, 1);
INSERT INTO question_likes (user_id, question_id)
VALUES (3, 2);
INSERT INTO question_likes (user_id, question_id)
VALUES (3, 3);