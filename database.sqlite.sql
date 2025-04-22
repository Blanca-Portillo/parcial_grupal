BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "attendeestbl" ("id" integer primary key autoincrement not null, "first_name" varchar not null, "last_name" varchar not null, "email" varchar not null, "phone" varchar, "qr_code" varchar not null, "event_id" integer not null, "created_at" datetime, "updated_at" datetime, "deleted_at" datetime, foreign key("event_id") references "events"("id") on delete cascade);
CREATE TABLE IF NOT EXISTS "cache" ("key" varchar not null, "value" text not null, "expiration" integer not null, primary key ("key"));
CREATE TABLE IF NOT EXISTS "cache_locks" ("key" varchar not null, "owner" varchar not null, "expiration" integer not null, primary key ("key"));
CREATE TABLE IF NOT EXISTS "check_instbl" ("id" integer primary key autoincrement not null, "attendee_id" integer not null, "check_in_time" datetime not null, "checked_by" varchar, "created_at" datetime, "updated_at" datetime, foreign key("attendee_id") references "attendees"("id") on delete cascade);
CREATE TABLE IF NOT EXISTS "eventstbl" ("id" integer primary key autoincrement not null, "name" varchar not null, "description" text, "start_date" datetime not null, "end_date" datetime not null, "location" varchar not null, "type" varchar check ("type" in ('conference', 'workshop', 'seminar', 'social')) not null, "status" varchar check ("status" in ('planned', 'ongoing', 'completed', 'cancelled')) not null, "organizer_id" integer not null, "created_at" datetime, "updated_at" datetime, "deleted_at" datetime, foreign key("organizer_id") references "users"("id") on delete cascade);
CREATE TABLE IF NOT EXISTS "failed_jobs" ("id" integer primary key autoincrement not null, "uuid" varchar not null, "connection" text not null, "queue" text not null, "payload" text not null, "exception" text not null, "failed_at" datetime not null default CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS "job_batches" ("id" varchar not null, "name" varchar not null, "total_jobs" integer not null, "pending_jobs" integer not null, "failed_jobs" integer not null, "failed_job_ids" text not null, "options" text, "cancelled_at" integer, "created_at" integer not null, "finished_at" integer, primary key ("id"));
CREATE TABLE IF NOT EXISTS "jobs" ("id" integer primary key autoincrement not null, "queue" varchar not null, "payload" text not null, "attempts" integer not null, "reserved_at" integer, "available_at" integer not null, "created_at" integer not null);
CREATE TABLE IF NOT EXISTS "migrations" ("id" integer primary key autoincrement not null, "migration" varchar not null, "batch" integer not null);
CREATE TABLE IF NOT EXISTS "password_reset_tokens" ("email" varchar not null, "token" varchar not null, "created_at" datetime, primary key ("email"));
CREATE TABLE IF NOT EXISTS "password_reset_tokenstbl" ("email" varchar not null, "token" varchar not null, "created_at" datetime, primary key ("email"));
CREATE TABLE IF NOT EXISTS "permissionstbl" ("id" integer primary key autoincrement not null, "name" varchar not null, "description" varchar, "created_at" datetime, "updated_at" datetime);
CREATE TABLE IF NOT EXISTS "role_permissionstbl" ("id" integer primary key autoincrement not null, "role_id" integer not null, "permission_id" integer not null, "created_at" datetime, "updated_at" datetime, foreign key("role_id") references "roles"("id") on delete cascade, foreign key("permission_id") references "permissions"("id") on delete cascade);
CREATE TABLE IF NOT EXISTS "rolestbl" ("id" integer primary key autoincrement not null, "name" varchar not null, "description" varchar, "created_at" datetime, "updated_at" datetime);
CREATE TABLE IF NOT EXISTS "sessions" ("id" varchar not null, "user_id" integer, "ip_address" varchar, "user_agent" text, "payload" text not null, "last_activity" integer not null, primary key ("id"));
CREATE TABLE IF NOT EXISTS "user_rolestbl" ("id" integer primary key autoincrement not null, "user_id" integer not null, "role_id" integer not null, "created_at" datetime, "updated_at" datetime, foreign key("user_id") references "users"("id") on delete cascade, foreign key("role_id") references "roles"("id") on delete cascade);
CREATE TABLE IF NOT EXISTS "users" ("id" integer primary key autoincrement not null, "name" varchar not null, "email" varchar not null, "email_verified_at" datetime, "password" varchar not null, "remember_token" varchar, "created_at" datetime, "updated_at" datetime);
INSERT INTO "migrations" ("id","migration","batch") VALUES (1,'0001_01_01_000000_create_users_table',1),
 (2,'0001_01_01_000001_create_cache_table',1),
 (3,'0001_01_01_000002_create_jobs_table',1),
 (4,'2025_04_22_004921_userstbl',2),
 (5,'2025_04_22_005003_userstbl',3),
 (14,'2025_04_22_005755_create_password_reset_tokenstbl',4),
 (15,'2025_04_22_005908_create_rolestbl',4),
 (16,'2025_04_22_005930_create_permissionstbl',4),
 (17,'2025_04_22_010011_create_role_permissionstbl',4),
 (18,'2025_04_22_010028_create_user_rolestbl',4),
 (19,'2025_04_22_010113_create_eventstbl',4),
 (20,'2025_04_22_010129_create_attendeestbl',4),
 (21,'2025_04_22_010305_create_check_instbl',4);
INSERT INTO "permissionstbl" ("id","name","description","created_at","updated_at") VALUES (1,'Anderson','Admin',NULL,NULL);
INSERT INTO "rolestbl" ("id","name","description","created_at","updated_at") VALUES (1,'Anderson','Admin',NULL,NULL);
INSERT INTO "users" ("id","name","email","email_verified_at","password","remember_token","created_at","updated_at") VALUES (1,'Jorge','jorge@gmail.com','jorge@gmail.com','1234',NULL,NULL,NULL),
 (2,'','',NULL,'',NULL,NULL,NULL);
CREATE UNIQUE INDEX "attendeestbl_qr_code_unique" on "attendeestbl" ("qr_code");
CREATE UNIQUE INDEX "failed_jobs_uuid_unique" on "failed_jobs" ("uuid");
CREATE INDEX "jobs_queue_index" on "jobs" ("queue");
CREATE UNIQUE INDEX "permissionstbl_name_unique" on "permissionstbl" ("name");
CREATE UNIQUE INDEX "rolestbl_name_unique" on "rolestbl" ("name");
CREATE INDEX "sessions_last_activity_index" on "sessions" ("last_activity");
CREATE INDEX "sessions_user_id_index" on "sessions" ("user_id");
CREATE UNIQUE INDEX "users_email_unique" on "users" ("email");
COMMIT;
