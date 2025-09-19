Return-Path: <bpf+bounces-68987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD0B8B5A4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C2C5C0015
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D32DA740;
	Fri, 19 Sep 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IS0GWjJk"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9C2D8790;
	Fri, 19 Sep 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317534; cv=none; b=JqAMiTSFC/TJvYulQ+d3lHdtfNQzE7LIfd/+xNNa0O/6O62/TziPevhLtzNTcO90Ldblu9HggaFwWyt3kht7f/rc9PL2eaXgwbgb6yRdJxIcq3PDy+BHJUbHzUYqEUQDvfeftCdlOtJmAsT6VgexdTp/ZzZg0hFp1+Ujc0mPbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317534; c=relaxed/simple;
	bh=08Xgi6mMAc6Ob3tzrk4hj/Yht6egIK6FCAR8f42MoyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM91OizvI3+wBqqe2vsuUroWg+BuF6eRsPC7luWcRUi8otxfF5QEBd/dl8DBZGkfd0jdBzTb+7K7zVTJO9LU8gApREaI570QkdszrQLyPAsStmta+7N/NzdRGxAH14KfgIh06tlRKeOnAlvtDgopIReGP4tdVHTttO7QzvVNSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IS0GWjJk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pSKBMby6Bk/UWyyeR+r2sbXoGu7jx463UrN3PrdnwZs=; b=IS0GWjJkFPIBu9sEImdBs6UtOY
	IWiD36ePbsQIVvHWrBb/7PZ2Zbs4KEZ1t54UX7ZNgrDrve9lWXNUekC583BZcofqyWUiOIAUlwGjg
	YAy70P1nfAmRHjJqFbFdPGg+vyVjDC4aCDJY7RKRRvkIMc+OrBg0BfW3KP2aM2Ee//9PocO44CAot
	6TZ3vg+J0ddpbBgNkZ9xcAA62VG2tbmcZkv536v32qE/d4/juC8jr3MdUmLWtScaVIzJvoUACI/fg
	g5/wm55y4T1SLs6cjc35cMzOU5dAOLWVV1oCHZYR+LbHjXQ3tCe/L9jh0lpBMtsOBKE+dg794vfNo
	3/5ZTzdQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii5-000NrY-1K;
	Fri, 19 Sep 2025 23:32:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 11/20] xsk: Add small helper xp_pool_bindable
Date: Fri, 19 Sep 2025 23:31:44 +0200
Message-ID: <20250919213153.103606-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

Add another small helper called xp_pool_bindable and move the current
dev_get_min_mp_channel_count test into this helper. Pass in the pool
object, such that we derive the netdev from the prior registered pool.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk_buff_pool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 375696f895d4..d2109d683fe5 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -54,6 +54,11 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 	return 0;
 }
 
+static bool xp_pool_bindable(struct xsk_buff_pool *pool)
+{
+	return dev_get_min_mp_channel_count(pool->netdev) == 0;
+}
+
 struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 						struct xdp_umem *umem)
 {
@@ -199,7 +204,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-	if (dev_get_min_mp_channel_count(netdev)) {
+	if (!xp_pool_bindable(pool)) {
 		err = -EBUSY;
 		goto err_unreg_pool;
 	}
-- 
2.43.0


