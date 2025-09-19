Return-Path: <bpf+bounces-68986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C82B8B59E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B25A4404
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA42D97BE;
	Fri, 19 Sep 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fnukwFJz"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCC2D73A9;
	Fri, 19 Sep 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317533; cv=none; b=bTblullWEoJfIt46OJErmhu9T29Lmi2fSk1vP687136Ddizb6GF9INeUTsg/6Vv/X0uxYY4/kWxlojznjdQ1nPcVOe3+xcHh0KdzriglhcjhsOzgXGQRLzNNn18j1yal1qgpUeUpnUXbuBrFJbmeuRYLD16AZQIKdYDV+lOcyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317533; c=relaxed/simple;
	bh=nMAJGDVXaD2zPl2n/jzjIhtWZKiqCfdsAvbhTrDqyT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYQGwt2iUkt21IsKz/nq6Y4oby8gW/PgZC6aQk+g36xkbHo+AFg5hPb1/Zg7ov+T8WHUTqmdeQbK+p6eTGqm8ZI22nYku99RYccdMO2ZpGKbbyM8NQrmlaJ0llF0gtbmGpxIFEQ9U6kjR3SvREYtNuBJq59BI1NRJ/sUAk0zp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fnukwFJz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+hQ02ZsJbvhhhXA30y8P6qWQNd/mW3tXz98hNKXP74A=; b=fnukwFJzlbIPIP1QKCOTz1XX+i
	AaTjBZOXPxGqQsBBxyf8BaB3LmwjOFLzItRkW0HcpRvqVRLAFrRRAWhhmwtGGIOhfDBtzFH0BCiyo
	ZiAIat/eKklianq3b7OjHxcbsZReI8PexWO/+zABCDBqGU0CkUDNCaB39xk1Lz36ck1uqY0Bpuqis
	ClrBWINiWwvy0xcM4RLB2KbYdklu77X5fvETNFaClt3ryvWi2+O586kw7tKm31u7FCadgZ+72LKon
	y3luM/XCSzu6YIWKrmJvghv80IGboSFYUromWV/x5VS1dGyNXXLC2M1gnY1kel9sguKsWxeyPrMXO
	kpqIfEYA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii4-000NrD-1i;
	Fri, 19 Sep 2025 23:32:04 +0200
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
Subject: [PATCH net-next 10/20] xsk: Move pool registration into single function
Date: Fri, 19 Sep 2025 23:31:43 +0200
Message-ID: <20250919213153.103606-11-daniel@iogearbox.net>
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

Small refactor to move the pool registration into xsk_reg_pool_at_qid,
such that the netdev and queue_id can be registered there. No change
in functionality.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c           |  5 +++++
 net/xdp/xsk_buff_pool.c | 16 +++-------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72e34bd2d925..82ad89f6ba35 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -141,6 +141,11 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			      dev->real_num_rx_queues,
 			      dev->real_num_tx_queues))
 		return -EINVAL;
+	if (xsk_get_pool_from_qid(dev, queue_id))
+		return -EBUSY;
+
+	pool->netdev = dev;
+	pool->queue_id = queue_id;
 
 	if (queue_id < dev->real_num_rx_queues)
 		dev->_rx[queue_id].pool = pool;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 26165baf99f4..375696f895d4 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -169,32 +169,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 
 	force_zc = flags & XDP_ZEROCOPY;
 	force_copy = flags & XDP_COPY;
-
 	if (force_zc && force_copy)
 		return -EINVAL;
 
-	if (xsk_get_pool_from_qid(netdev, queue_id))
-		return -EBUSY;
-
-	pool->netdev = netdev;
-	pool->queue_id = queue_id;
 	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
 	if (err)
 		return err;
 
 	if (flags & XDP_USE_SG)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
-
 	if (flags & XDP_USE_NEED_WAKEUP)
 		pool->uses_need_wakeup = true;
-	/* Tx needs to be explicitly woken up the first time.  Also
-	 * for supporting drivers that do not implement this
-	 * feature. They will always have to call sendto() or poll().
+	/* Tx needs to be explicitly woken up the first time. Also
+	 * for supporting drivers that do not implement this feature.
+	 * They will always have to call sendto() or poll().
 	 */
 	pool->cached_need_wakeup = XDP_WAKEUP_TX;
 
 	dev_hold(netdev);
-
 	if (force_copy)
 		/* For copy-mode, we are done. */
 		return 0;
@@ -203,12 +195,10 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-
 	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-
 	if (dev_get_min_mp_channel_count(netdev)) {
 		err = -EBUSY;
 		goto err_unreg_pool;
-- 
2.43.0


