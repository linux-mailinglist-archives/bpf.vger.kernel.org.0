Return-Path: <bpf+bounces-46513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776B9EB2E1
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE909188246A
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50EF1B3940;
	Tue, 10 Dec 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GmlNZvty"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF681AAA28;
	Tue, 10 Dec 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839982; cv=none; b=KKNBu4kpEkagZvaq6a0xdz8NZSx1K51kFdyKBBZ4jzAqRXmiJ7eQX6VDiF7zMRht6y+R1iEaBeWWkJGkpmMGWfBIuPjnMuPbkEugUSBDjueuiIMt8G4MAkEHEcgPOlAKBRdGDAk7HKSt6LSxiDALZGb9u5IUesTz11c5iISP/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839982; c=relaxed/simple;
	bh=1EL0iOX9z299d9g1AXg7Po7x/SmaYN3U5tpAeRyXgcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCusogbz0+YV726TVySxulfNuwyPlFijP59qDDQNPE3AeGrQxZYfF4eSdv1xhKan91aiZa7QNDPYwVI+5f6yRSn22f+4Eo6BX6hY3XyFy5annHLYBAdejjlG1ZqOcW/yvM+PTzryJSukvN80U1sv1wcW7h3SQeCtXwBBoONuZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GmlNZvty; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w7R2RpmAicgOmiJ/9kqO9DMW80VXog3hrYYgYAvbmzs=; b=GmlNZvtySufPUfIHw6S+moU3L6
	vgDir2yglOSCnN3DUM6n6Ro5DrAKzRqY9KUnQrTaw2Oef0egr2WPtP6Bu7SP0OuFVBX6fcONkxNnJ
	mGRkidLAkSMREjmfUT/IyzTsjztTcVKo1HHegw8UQ3crGEW8NQN38L/6eHom/C6QRk3x5rE0H9DiQ
	ywR1IlxN7v9+Xj0T2c5I6OpSUCDqJSGRo6tVUGMYRRyyGqt4S1DGxC3S5n2b2ZO6xCXHj6pCYNEYc
	BZXCvTERgfu3v+ajZJjFkf1qm11dZsxbFXXmMJjGFrG1DHEfrQis6EdhyhknUv0PmFtiyDYo89KKQ
	E2ytnr3Q==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tL0ym-000Jgg-KD; Tue, 10 Dec 2024 15:12:48 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net 5/5] team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
Date: Tue, 10 Dec 2024 15:12:45 +0100
Message-ID: <20241210141245.327886-5-daniel@iogearbox.net>
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

Similar to bonding driver, add NETIF_F_GSO_ENCAP_ALL to TEAM_VLAN_FEATURES
in order to support slave devices which propagate NETIF_F_GSO_UDP_TUNNEL &
NETIF_F_GSO_UDP_TUNNEL_CSUM as vlan_features.

Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/team/team_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 306416fc1db0..69ea2c3c76bf 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -983,7 +983,8 @@ static void team_port_disable(struct team *team,
 
 #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
 			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO)
+			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
+			    NETIF_F_GSO_ENCAP_ALL)
 
 #define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
-- 
2.43.0


