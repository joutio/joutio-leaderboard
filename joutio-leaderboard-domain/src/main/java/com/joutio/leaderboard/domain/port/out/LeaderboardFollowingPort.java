package com.joutio.leaderboard.domain.port.out;

import java.util.List;

/**
 * Port sortant inter-module : identifiants des joueurs **suivis** (joutio-social), pour la
 * portée « abonnements » du classement.
 */
public interface LeaderboardFollowingPort {

    List<String> getFollowingIds(String userId);
}
