Return-Path: <bpf+bounces-46509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0F9EB2D7
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1161881DEE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254B1AAE23;
	Tue, 10 Dec 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZQTz5EYi"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913801AAA1F;
	Tue, 10 Dec 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839980; cv=none; b=iYQXXvlBGn3Cyzoo5fIMDzn2aTuMwM/TsN7bXecRIMvRMi3BKWssLMWS2ubVHN5DqltYhYNlpB5y4+7/8I+2AyCK6AtwFHMUJlFLWpcqC64mwuw0i49IQxAqCwb7JmnKfk+B2HgG15ivTPLF00iaCKjp9Py2Uw3D1LmmcqQffw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839980; c=relaxed/simple;
	bh=SM2IrEFYDHRCO0M5Uj3aTtBdScOXylhhut0GfOBIwsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFESZ6L92nShSGQVH81cxzmienIfta6L6sJRaIxaerGXMn9J8mFEV2kczWaJzmedmiaEHAtrgd0+5B4xackAimAr+AtMHGZK9N+XESEOsHYb87Mp8OFip4BtWA7PPphj5C/pt4/+7fFpBwqukm+W4s9FFmCFfhgHhfC60EKiFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZQTz5EYi; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=mgCMs5KHNqA2IaprbLh7578kvE0JKS2ne9H+fT97Y8w=; b=ZQTz5EYi0q4COyLPi2vyeGGdvR
	YKvDGfgBEAtvA1ZQlWiu/MRc5VGsGk2W0HcYKuaanp2pM8+4MxVhIqX/iReyuEs9r9DzOk3UmeDxi
	IJsy75RKmO8hcboOV7mGN5oGfrnqCiEQkwmXaTvwhxG3VD/BQncKx3IhW2UfOoLtTgL9ZL0U+FlFP
	4Eau8Wp3i8CGLRkxjAxr2i5sgDRsC6Y3fHl4ZeSUVJ7Ymp15M5CDSCOdFTnI1lYy5TnVpcgjrYHGS
	YKx07mTdFteZp5SKmvPQZf8hsOF31jv501YFPOde12qEzDGkSkE+8XP6ojZwWaU/ncSYz3exzlQQv
	72S9dvaw==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tL0yk-000Jg5-5b; Tue, 10 Dec 2024 15:12:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net 1/5] net, team, bonding: Add netdev_base_features helper
Date: Tue, 10 Dec 2024 15:12:41 +0100
Message-ID: <20241210141245.327886-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27483/Tue Dec 10 10:38:50 2024)

Both bonding and team driver have logic to derive the base feature
flags before iterating over their slave devices to refine the set
via netdev_increment_features().

Add a small helper netdev_base_features() so this can be reused
instead of having it open-coded multiple times.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 4 +---
 drivers/net/team/team_core.c    | 3 +--
 include/linux/netdev_features.h | 7 +++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 49dd4fe195e5..42c835c60cd8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1520,9 +1520,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	struct slave *slave;
 
 	mask = features;
-
-	features &= ~NETIF_F_ONE_FOR_ALL;
-	features |= NETIF_F_ALL_FOR_ALL;
+	features = netdev_base_features(features);
 
 	bond_for_each_slave(bond, slave, iter) {
 		features = netdev_increment_features(features,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index a1b27b69f010..1df062c67640 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2011,8 +2011,7 @@ static netdev_features_t team_fix_features(struct net_device *dev,
 	netdev_features_t mask;
 
 	mask = features;
-	features &= ~NETIF_F_ONE_FOR_ALL;
-	features |= NETIF_F_ALL_FOR_ALL;
+	features = netdev_base_features(features);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(port, &team->port_list, list) {
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 66e7d26b70a4..11be70a7929f 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -253,4 +253,11 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+static inline netdev_features_t netdev_base_features(netdev_features_t features)
+{
+	features &= ~NETIF_F_ONE_FOR_ALL;
+	features |= NETIF_F_ALL_FOR_ALL;
+	return features;
+}
+
 #endif	/* _LINUX_NETDEV_FEATURES_H */
-- 
2.43.0


