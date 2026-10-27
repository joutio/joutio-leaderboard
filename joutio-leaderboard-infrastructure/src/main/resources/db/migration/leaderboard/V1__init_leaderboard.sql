-- Joutio leaderboard — baseline schema (squashed)
-- Generated from a fresh PostgreSQL 16 database after applying the legacy migrations.

--
-- PostgreSQL database dump
--


-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: player_identity_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.player_identity_entry (
    user_id character varying(255) NOT NULL,
    pseudonym character varying(255),
    country character varying(60),
    avatar_options text,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: TABLE player_identity_entry; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.player_identity_entry IS 'Identité publique locale (alimentée par les événements profile) — aucune query de profil dans les projections';


--
-- Name: topic_leaderboard_awarded_game; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_leaderboard_awarded_game (
    topic_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    game_id character varying(255) NOT NULL
);


--
-- Name: topic_leaderboard_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_leaderboard_entry (
    entry_id character varying(520) NOT NULL,
    topic_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    total_xp integer DEFAULT 0 NOT NULL,
    country character varying(60),
    updated_at timestamp without time zone NOT NULL,
    pseudonym character varying(255),
    avatar_options text
);


--
-- Name: TABLE topic_leaderboard_entry; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.topic_leaderboard_entry IS 'Classement all-time par thème : XP cumulée + identité/niveau dénormalisés';


--
-- Name: topic_leaderboard_monthly_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_leaderboard_monthly_entry (
    entry_id character varying(550) NOT NULL,
    topic_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    month character varying(7) NOT NULL,
    monthly_xp integer DEFAULT 0 NOT NULL,
    pseudonym character varying(255),
    avatar_options text,
    country character varying(60),
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: TABLE topic_leaderboard_monthly_entry; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.topic_leaderboard_monthly_entry IS 'Classement mensuel par thème : XP du mois, historique conservé';


--
-- Name: player_identity_entry player_identity_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_identity_entry
    ADD CONSTRAINT player_identity_entry_pkey PRIMARY KEY (user_id);


--
-- Name: topic_leaderboard_awarded_game topic_leaderboard_awarded_game_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_leaderboard_awarded_game
    ADD CONSTRAINT topic_leaderboard_awarded_game_pkey PRIMARY KEY (topic_id, user_id, game_id);


--
-- Name: topic_leaderboard_entry topic_leaderboard_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_leaderboard_entry
    ADD CONSTRAINT topic_leaderboard_entry_pkey PRIMARY KEY (entry_id);


--
-- Name: topic_leaderboard_monthly_entry topic_leaderboard_monthly_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_leaderboard_monthly_entry
    ADD CONSTRAINT topic_leaderboard_monthly_entry_pkey PRIMARY KEY (entry_id);


--
-- Name: topic_leaderboard_monthly_entry uq_topic_leaderboard_monthly_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_leaderboard_monthly_entry
    ADD CONSTRAINT uq_topic_leaderboard_monthly_user UNIQUE (topic_id, user_id, month);


--
-- Name: topic_leaderboard_entry uq_topic_leaderboard_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_leaderboard_entry
    ADD CONSTRAINT uq_topic_leaderboard_user UNIQUE (topic_id, user_id);


--
-- Name: idx_topic_lb_all_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topic_lb_all_time ON public.topic_leaderboard_entry USING btree (topic_id, total_xp DESC);


--
-- Name: idx_topic_lb_country; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topic_lb_country ON public.topic_leaderboard_entry USING btree (topic_id, country, total_xp DESC);


--
-- Name: idx_topic_lb_monthly_country; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topic_lb_monthly_country ON public.topic_leaderboard_monthly_entry USING btree (topic_id, month, country, monthly_xp DESC);


--
-- Name: idx_topic_lb_monthly_xp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_topic_lb_monthly_xp ON public.topic_leaderboard_monthly_entry USING btree (topic_id, month, monthly_xp DESC);


--
-- PostgreSQL database dump complete
--


