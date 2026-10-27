package com.joutio.leaderboard.domain.port.in;

import com.joutio.leaderboard.domain.model.LeaderboardRank;
import com.joutio.leaderboard.domain.model.LeaderboardScope;
import com.joutio.leaderboard.domain.model.TopicLeaderboardEntry;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;

/**
 * Port entrant — lecture du classement d'un thème (all-time / mensuel), dans une
 * portée donnée (monde / amis / pays), et du rang d'un joueur dans ce thème.
 */
public interface GetLeaderboardUseCase {

    /**
     * @param month mois {@code YYYY-MM} pour le classement mensuel ; {@code null} = mois courant.
     */
    CompletableFuture<List<TopicLeaderboardEntry>> topByTopic(
            String topicId,
            boolean monthly,
            String month,
            int limit,
            LeaderboardScope scope,
            String requesterId
    );

    CompletableFuture<Optional<LeaderboardRank>> rankOf(
            String topicId,
            String userId,
            boolean monthly,
            String month,
            LeaderboardScope scope
    );
}
