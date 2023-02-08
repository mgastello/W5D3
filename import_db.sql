PRAGMA foreign_keys = ON;

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title VARCHAR(80) NOT NULL,
    body VARCHAR(300) NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
); 

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject_question INTEGER NOT NULL,
    body VARCHAR(300) NOT NULL,
    parent_reply INTEGER,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (subject_question) REFERENCES questions(id),
    FOREIGN KEY (parent_reply) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Seeding users
INSERT INTO users (fname, lname)
VALUES ('michael', 'gastello')
INSERT INTO users (fname, lname)
VALUES ('gary', 'hor')
INSERT INTO users (fname, lname)
VALUES ('alvin', 'zablan')


-- Seeding questions
INSERT INTO questions (title, body, user_id)
VALUES ('SQLite3',
    'how we do dis',
    (SELECT id FROM users WHERE fname = 'michael'))
INSERT INTO questions (title, body, user_id)
VALUES ('supreme',
    'testing waters $100',
    (SELECT id FROM users WHERE fname = 'gary'))
INSERT INTO questions (title, body, user_id)
VALUES ('app academy',
    'miss you guys',
    (SELECT id FROM users WHERE fname = 'alvin'))


-- Seeding question_follows
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT question_id FROM questions WHERE user_id = 3),
    (SELECT id FROM users WHERE fname = 'michael')
    )
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT question_id FROM questions WHERE user_id = 3),
    (SELECT id FROM users WHERE fname = 'gary')
    )
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT question_id FROM questions WHERE user_id = 1),
    (SELECT id FROM users WHERE fname = 'gary')
    )
INSERT INTO question_follows (question_id, user_id)
VALUES ((SELECT question_id FROM questions WHERE user_id = 2),
    (SELECT id FROM users WHERE fname = 'michael')
    )


-- Seeding replies
INSERT INTO replies (subject_question, body, parent_reply, user_id)
VALUES ()