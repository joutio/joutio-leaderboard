# AGENTS.md — joutio-leaderboard

Classements **par sujet** : depuis toujours (XP cumulée dans le sujet) et mensuels (XP du mois,
une ligne par mois, historique conservé). Package `com.joutio.leaderboard`, base
`joutio_leaderboard`, port local 8091. Service headless, sans agrégat : projections seulement.

Lire : `../../AGENTS.md`, [`docs/backend/`](../../docs/backend/hexagonal.md), exposition dans
[`docs/api/sujets.md`](../../docs/api/sujets.md#catalogue-et-fiche-sujet).

## Projections

| Projection | Source | Écrit |
|---|---|---|
| `TopicLeaderboardProjection` | `XpAwardedEvent` (profile) | entrée depuis toujours et entrée du mois ; idempotence par `(topicId, userId, gameId)` (`topic_leaderboard_awarded_game`) |
| `PlayerIdentityProjection` | `ProfileCreatedEvent`, pseudonyme, pays, avatar (profile) | read model local `player_identity_entry`, identité dénormalisée sur les entrées |

- Les entraînements bot (`XpAwardedEvent.botGame`) sont **ignorés**.
- Aucune requête inter-service dans une projection : l'identité est matérialisée localement
  (anti-pattern 3).

## Lectures fournies (`LeaderboardQuery`)

- `TopByTopicQuery(topicId, monthly, month, page, size, memberIds, country)` → `LeaderboardPage`
  (`month` = `YYYY-MM`, `null` = mois courant).
- `GetTopicRankQuery` : rang au-delà du top 100 par un `COUNT` (départage par `userId`, comme
  l'ordre de la page).
- Portées :
  - `world` ;
  - `following` : `LeaderboardFollowingPort` → `GetUserFollowsQuery` de social, exception admise :
    requête distribuée dans un handler de requête ;
  - `country` : pays du demandeur lu dans le read model local, sans filtre si inconnu.

Contrats consommés : `joutio-profile-domain`, `joutio-social-domain`.

## Commandes

```bash
mvn -q -pl joutio-leaderboard-domain test
mvn -pl joutio-leaderboard-infrastructure test
```
