Return-Path: <bpf+bounces-46511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD8E9EB2D6
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A672822FA
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4751AE843;
	Tue, 10 Dec 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MhWnoUqI"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC11AAA2A;
	Tue, 10 Dec 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839980; cv=none; b=kKNZZL2b2bryZzw4cFH36H/1rmtz939A5A5yFQOitDJm5QLXZnksYJ1DWcrF2NpBlMAfDi6oI9iLGMrDtqRfiiaaqbAwbCHyqSz5SnTrtIr0GqPuYV9tZCLeUnsGvtLA72psoki6FPDv0o7xLPADKhJE7tUprbT/g9hmWlnzOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839980; c=relaxed/simple;
	bh=09qaNpq4AJuz9hfCoEjZOuxko+pXD+YneMHD9E479dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsrpcFpFhdhXBtxZuCC90jJrrKOiigboX3S/TMAHET+L7sNXmrPuT1JzlrxQ3X5mcqtYyk/lX6jR+BV/98OIciFJAs3dcMWXr0JAnCM3qCFYGxtq86k44cXUfGBSVMKAfEGX82vc7B1sspFHRjHdMjJv2J1tlarCQ8HZ7m5bW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MhWnoUqI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z6pqZZgfaOadgTc8G5zTaPHQbs4UwLMI64dEKXV+Eyo=; b=MhWnoUqId+xj2Mnt9FvpRsD9BM
	9D3e2pCojMQmY2McntNc3taTo29H6KEljPyogEiSZsPdz6mNbuW/kiJKoMbItrGhGU9jyC6gVor5l
	rUECBPumh+wqXJcX8pP8IOt52f1vtbBVSAg+Qmbubtm6fM+OmEP48RBQq6xG52J/Qf5H/klv+wDJJ
	XbV1xvQ8H0OHTVT+G6XS0JVu8S87X2NllADV6LahZXVRdxguuhOPeyfvj5KZ3ApZErhY063jHSYvM
	879UwNf09PzjP0ic5mfOhqsx35EoVZ/ziX3ci7s4cT1jXsB4ohuZ7MKwfQb+v8Hbe7ElWrUGkIGf2
	cFwkMOXQ==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tL0ym-000JgX-16; Tue, 10 Dec 2024 15:12:48 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net 4/5] team: Fix initial vlan_feature set in __team_compute_features
Date: Tue, 10 Dec 2024 15:12:44 +0100
Message-ID: <20241210141245.327886-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
References: <20241210141245.327886-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27483/Tue Dec 10 10:38:50 2024)

Similarly as with bonding, fix the calculation of vlan_features to reuse
netdev_base_features() in order derive the set in the same way as
ndo_fix_features before iterating through the slave devices to refine the
feature set.

Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/team/team_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 1df062c67640..306416fc1db0 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -991,13 +991,14 @@ static void team_port_disable(struct team *team,
 static void __team_compute_features(struct team *team)
 {
 	struct team_port *port;
-	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
-					  NETIF_F_ALL_FOR_ALL;
+	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
 	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
 	unsigned short max_hard_header_len = ETH_HLEN;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
 
+	vlan_features = netdev_base_features(vlan_features);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(port, &team->port_list, list) {
 		vlan_features = netdev_increment_features(vlan_features,
-- 
2.43.0


