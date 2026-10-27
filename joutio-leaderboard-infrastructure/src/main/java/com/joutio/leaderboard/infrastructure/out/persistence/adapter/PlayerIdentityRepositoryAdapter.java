package com.joutio.leaderboard.infrastructure.out.persistence.adapter;

import com.joutio.leaderboard.domain.model.PlayerIdentity;
import com.joutio.leaderboard.domain.port.out.PlayerIdentityRepositoryPort;
import com.joutio.leaderboard.infrastructure.out.persistence.entity.PlayerIdentityEntity;
import com.joutio.leaderboard.infrastructure.out.persistence.repository.PlayerIdentityJpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Optional;

@Component
public class PlayerIdentityRepositoryAdapter implements PlayerIdentityRepositoryPort {

    private final PlayerIdentityJpaRepository repository;

    public PlayerIdentityRepositoryAdapter(PlayerIdentityJpaRepository repository) {
        this.repository = repository;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<PlayerIdentity> findById(String userId) {
        return repository.findById(userId).map(PlayerIdentityRepositoryAdapter::toDomain);
    }

    @Override
    @Transactional
    public void save(PlayerIdentity identity, Instant updatedAt) {
        PlayerIdentityEntity entity = repository.findById(identity.userId())
                .orElseGet(PlayerIdentityEntity::new);
        entity.setUserId(identity.userId());
        entity.setPseudonym(identity.pseudonym());
        entity.setCountry(identity.country());
        entity.setAvatarOptions(identity.avatarOptions());
        entity.setUpdatedAt(updatedAt);
        repository.save(entity);
    }

    private static PlayerIdentity toDomain(PlayerIdentityEntity entity) {
        return new PlayerIdentity(
                entity.getUserId(),
                entity.getPseudonym(),
                entity.getCountry(),
                entity.getAvatarOptions());
    }
}
