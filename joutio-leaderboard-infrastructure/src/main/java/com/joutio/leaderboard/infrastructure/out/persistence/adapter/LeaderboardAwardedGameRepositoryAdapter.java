package com.joutio.leaderboard.infrastructure.out.persistence.adapter;

import com.joutio.leaderboard.domain.port.out.LeaderboardAwardedGameRepositoryPort;
import com.joutio.leaderboard.infrastructure.out.persistence.entity.LeaderboardAwardedGameEntity;
import com.joutio.leaderboard.infrastructure.out.persistence.repository.LeaderboardAwardedGameJpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class LeaderboardAwardedGameRepositoryAdapter implements LeaderboardAwardedGameRepositoryPort {

    private final LeaderboardAwardedGameJpaRepository repository;

    public LeaderboardAwardedGameRepositoryAdapter(LeaderboardAwardedGameJpaRepository repository) {
        this.repository = repository;
    }

    @Override
    @Transactional
    public boolean record(String topicId, String userId, String gameId) {
        LeaderboardAwardedGameEntity.AwardedGameId id =
                new LeaderboardAwardedGameEntity.AwardedGameId(topicId, userId, gameId);
        if (repository.existsById(id)) {
            return false;
        }
        repository.save(new LeaderboardAwardedGameEntity(topicId, userId, gameId));
        return true;
    }
}
