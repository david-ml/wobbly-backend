-- @david-ml: initial attempts at SQL schema recreation --

-- CREATE TYPE File AS (
CREATE EXTENSION citext;

-- create email as case-insensitive text, validate using regex
CREATE DOMAIN email AS citext CHECK (
  VALUE ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'
);
CREATE SEQUENCE id_seq;
 
CREATE DOMAIN id INT DEFAULT NEXTVAL('id_seq') NOT NULL;

-- create id as md5 hash
CREATE DOMAIN id_md5 AS (
    md5(VALUE)::uuid;



CREATE DOMAIN File AS (
    contentType VARCHAR NOT NULL,
    createdAt   DATETIME NOT NULL,
    id          REQUIRED NOT NULL UNIQUE,
    name        ,
    secret      ,
    size        ,
    updatedAt   ,
    url         ,
);

---- Original GraphQL Schema ----

type File  {
  contentType: String!
  createdAt: DateTime!
  id: ID! @unique
  name: String!
  secret: String! @unique
  size: Int!
  updatedAt: DateTime!
  url: String! @unique
}

type User {
  createdAt: DateTime!
  id: ID! @unique
  updatedAt: DateTime!
  username: String! @unique
  groups: [Group!]! @relation(name: "GroupOnUser")
  posts: [Post!]! @relation(name: "PostOnUser")
  bio: String @default(value: "Just Another Wobbly User")
  comments: [Comment!]! @relation(name: "CommentOnUser")
  email: String @unique
  imageUrl: String @default(value: "http://placekitten.com/g/50/50")
  password: String
  accessGroups: [AccessGroup!]! @relation(name: "AccessGroupMembers")
  ownGroups: [Group!]! @relation(name: "GroupOnOwner")
}

type Post  {
  createdAt: DateTime!
  id: ID! @unique
  updatedAt: DateTime!
  title: String!
  content: String!
  imageUrl: String @default(value: "someimage.png")
  group: Group! @relation(name: "PostOnGroup")
  user: User! @relation(name: "PostOnUser")
  keywords: [Keyword!]! @relation(name: "PostOnKeyword")
  comments: [Comment!]! @relation(name: "CommentOnPost")
  commentCount: Int
}

type Group  {
  createdAt: DateTime!
  id: ID! @unique
  updatedAt: DateTime!
  name: String! @unique
  slug: String! @unique
  users: [User!]! @relation(name: "GroupOnUser")
  posts: [Post!]! @relation(name: "PostOnGroup")
  keywords: [Keyword!]! @relation(name: "KeywordOnGroup")
  accessGroups: [AccessGroup!]! @relation(name: "AccessGroups", onDelete: CASCADE)
  owner: User! @relation(name: "GroupOnOwner")
}

type Keyword  {
  createdAt: DateTime!
  id: ID! @unique
  updatedAt: DateTime!
  name: String! @unique
  posts: [Post!]! @relation(name: "PostOnKeyword")
  groups: [Group!]! @relation(name: "KeywordOnGroup")
}

type Comment  {
  createdAt: DateTime!
  id: ID! @unique
  updatedAt: DateTime!
  content: String!
  replyToComment: Comment @relation(name: "CommentOnComment")
  comments: [Comment!]! @relation(name: "CommentOnComment")
  post: Post! @relation(name: "CommentOnPost")
  user: User! @relation(name: "CommentOnUser")
}

type AccessGroup  {
  id: ID! @unique
  operation: AccessGroupOperation!
  members: [User!]! @relation(name: "AccessGroupMembers")
  group: Group @relation(name: "AccessGroups")
}

enum AccessGroupOperation {
  READ
  UPDATE
  DELETE
}
