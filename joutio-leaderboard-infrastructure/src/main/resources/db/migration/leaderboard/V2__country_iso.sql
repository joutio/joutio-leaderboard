-- Pays en code ISO 3166-1 alpha-2 (joutio-profile, 2026-11-13) : les codes sont mis en majuscules, les anciens noms
-- libres sont retirés ; ils reviennent normalisés au prochain ProfileCountryUpdatedEvent (CountryCodes.normalize).
UPDATE player_identity_entry SET country = CASE WHEN country ~* '^[a-z]{2}$' THEN UPPER(country) END WHERE country IS NOT NULL;
UPDATE topic_leaderboard_entry SET country = CASE WHEN country ~* '^[a-z]{2}$' THEN UPPER(country) END WHERE country IS NOT NULL;
UPDATE topic_leaderboard_monthly_entry SET country = CASE WHEN country ~* '^[a-z]{2}$' THEN UPPER(country) END WHERE country IS NOT NULL;
