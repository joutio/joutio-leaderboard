package com.joutio.leaderboard.infrastructure.out.persistence.repository;

import com.joutio.leaderboard.infrastructure.out.persistence.entity.PlayerIdentityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlayerIdentityJpaRepository extends JpaRepository<PlayerIdentityEntity, String> {
}
