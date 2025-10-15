Return-Path: <bpf+bounces-70989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB13BDEE6E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92EA483BF4
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3A262FF6;
	Wed, 15 Oct 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kkuCcbZb"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49A258CCC;
	Wed, 15 Oct 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536930; cv=none; b=VC/EFQsUq9JqbkzQ1wAGyYfV+8Iq5WQ7hj/TdE1JfPnPBLrRv0R7S8iZWVitoo3KgcBXpASa+ufD5aZ1lW8rqKBv1/0vA9HsSMlRq2qJMmKYq3xTdxHlHieMDx1aP3PRNBkMfoSii1dDKFdvGapCkKRr516IFtl0+D1582l4tas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536930; c=relaxed/simple;
	bh=WD2n69XZR58OEhICnjwP/shHQLduaiisQ0RidQldT/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY3/XvPJR0V4ggxlWsT6tvk0HJgo8J1pGq1cdsArId/5+Bu2sHsRPHnu3TJjlF8Uc1+Ei8dgyy4pO4+p54hu28CMjt0fhW/LUs8LvRMmDLM9Ouz7V58du0CIntzQilfjOMosGUF8ZFK6lL04oBqN+aNIciX4q+6jBoeVF2FeD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=kkuCcbZb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iQep+LJD+MoD+/Z8nqH0V4AMAyaAfYgmLkpNaHp8z48=; b=kkuCcbZbi3JByqo5gwV5jWB4Gb
	CHX+gz1YITPib1Lexuv3U6/X0w6GTiTFt2Av9oReLUw0THp/hHZ+g5nEK5g6bTVkQ+HBQIzxTVdrJ
	P2+7lrQUoOvVx7Mm90wa8I/y4UY7eHaIngLwMovA42jAH7jBKddKs67clZ5D2DaXSgY1JDR1vi+JY
	jSUbzWQRXsgqFZrx8fBzudkb2G4j6+oXM5y6N0KmkbhZQt+8OoNeVdGpRhqoS2pytcEPavpkHnNwU
	sHjH2uzsdaeNlGHM/RsbyLZtUggcltYJqDEE1eV7FkL0q5ko7yYO8tXO8lx/xBz5J8nI6hTN7rBsC
	6M61GVSA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924c-000H7P-0M;
	Wed, 15 Oct 2025 16:01:50 +0200
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
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v2 07/15] xsk: Move pool registration into single function
Date: Wed, 15 Oct 2025 16:01:32 +0200
Message-ID: <20251015140140.62273-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015140140.62273-1-daniel@iogearbox.net>
References: <20251015140140.62273-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27793/Wed Oct 15 11:29:40 2025)

Small refactor to move the pool registration into xsk_reg_pool_at_qid,
such that the netdev and queue_id can be registered there. No change
in functionality.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c           | 5 +++++
 net/xdp/xsk_buff_pool.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..0e9a385f5680 100644
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
index 26165baf99f4..62a176996f02 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -173,11 +173,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
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
-- 
2.43.0


