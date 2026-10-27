package com.joutio.leaderboard.infrastructure.out.persistence.repository;

import com.joutio.leaderboard.infrastructure.out.persistence.entity.LeaderboardAwardedGameEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LeaderboardAwardedGameJpaRepository
        extends JpaRepository<LeaderboardAwardedGameEntity, LeaderboardAwardedGameEntity.AwardedGameId> {
}
