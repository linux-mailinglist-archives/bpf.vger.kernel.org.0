Return-Path: <bpf+bounces-70557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79953BC2F15
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A53C64EB02B
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 23:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48052690EC;
	Tue,  7 Oct 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl1SUXfW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F1266565;
	Tue,  7 Oct 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879630; cv=none; b=U2DvwMpYNDcvcusem1a6DRtNsWvKv7LuaCplcqon3UbyRiRhU0pFVIPxXiq9JmSoyNtEAM/xFGXDr+X3j3XJzQEDvD3gHM2ZVO0RUUvQSHsyn4aSnpYSqll5GvOVu5TNBGT9TSOLbw3KS9FO3ptNR9PCcziRUWZYP72C1dRtbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879630; c=relaxed/simple;
	bh=3D6LfzlYAcLJut2sToQWr9f8yn1co/XkxDAXx6vyLT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP2eEgGjvHz1MVAYU+BH0vUCE/SvZXbCFC67KKmhM4HDF2xWbiuZtfS1Dy8uTmDLU8hp1Ufwf0rWm+VLD96jyFKsQgYIt4vJk8R+a+FUSG1qO3+YUmutKf9mowatuvOBTreeczfCqwYw+aktJv0WKJuadWD7NselxvuudGn83iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl1SUXfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E77C4CEF1;
	Tue,  7 Oct 2025 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879630;
	bh=3D6LfzlYAcLJut2sToQWr9f8yn1co/XkxDAXx6vyLT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nl1SUXfWEIxa69XLiN45R33Yt9YKWWbPoTOfakWik3XMP5l+baj2n045g0gVFbOnO
	 mRZu9kpXuHedD0UK2d4Axq6ewM+3+m067nCNTbDVG3dIy6XQ4whg2uzvvBzw0QqLz/
	 u3XiZNAPv7aMNM4Tspy1ZYwOCp3NVyoxRqe+VGa9ilmIZslxbpwwkjmTJA9HZmruZD
	 3s0ylYSh5qQDJ6ZZyAvT0Q4QOC0FpbQsHSNS8AZ5mSG/M3qFHweJpjYlvJTbip5kSZ
	 T4KuhX2rC6KKumfjwDB0IFYnxisMPJzmuRHsnTPweX1FmbVJrkehdG/YKetiybX7V5
	 /pISsYSCjRglw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com
Subject: [PATCH net v2 6/9] eth: fbnic: fix reporting of alloc_failed qstats
Date: Tue,  7 Oct 2025 16:26:50 -0700
Message-ID: <20251007232653.2099376-7-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rx processing under normal circumstances has 3 rings - 2 buffer
rings (heads, payloads) and a completion ring. All the rings
have a struct fbnic_ring. Make sure we expose alloc_failed
counter from the buffer rings, previously only the alloc_failed
from the completion ring was reported, even tho all ring types
may increment this counter (buffer rings in __fbnic_fill_bdq()).

This makes the pp_alloc_fail.py test pass, it expects the qstat
to be incrementing as page pool injections happen.

Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 67dc4eb5fc92 ("eth: fbnic: report software Rx queue stats")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: mohsin.bashr@gmail.com
CC: vadim.fedorenko@linux.dev
CC: jdamato@fastly.com
CC: aleksander.lobakin@intel.com
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  5 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  4 +--
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 23 ++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 36 +++++++++++++++----
 5 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index e84e0527c3a9..b0a87c57910f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -68,6 +68,7 @@ struct fbnic_net {
 	/* Storage for stats after ring destruction */
 	struct fbnic_queue_stats tx_stats;
 	struct fbnic_queue_stats rx_stats;
+	struct fbnic_queue_stats bdq_stats;
 	u64 link_down_events;
 
 	/* Time stamping filter config */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 4a41e21ed542..ca37da5a0b17 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -92,6 +92,9 @@ struct fbnic_queue_stats {
 			u64 csum_none;
 			u64 length_errors;
 		} rx;
+		struct {
+			u64 alloc_failed;
+		} bdq;
 	};
 	u64 dropped;
 	struct u64_stats_sync syncp;
@@ -165,6 +168,8 @@ fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
 
 void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 				      struct fbnic_ring *rxr);
+void fbnic_aggregate_ring_bdq_counters(struct fbnic_net *fbn,
+				       struct fbnic_ring *rxr);
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 				      struct fbnic_ring *txr);
 void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index a37906b70c3a..95fac020eb93 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -190,8 +190,8 @@ static void fbnic_aggregate_vector_counters(struct fbnic_net *fbn,
 	}
 
 	for (j = 0; j < nv->rxt_count; j++, i++) {
-		fbnic_aggregate_ring_rx_counters(fbn, &nv->qt[i].sub0);
-		fbnic_aggregate_ring_rx_counters(fbn, &nv->qt[i].sub1);
+		fbnic_aggregate_ring_bdq_counters(fbn, &nv->qt[i].sub0);
+		fbnic_aggregate_ring_bdq_counters(fbn, &nv->qt[i].sub1);
 		fbnic_aggregate_ring_rx_counters(fbn, &nv->qt[i].cmpl);
 	}
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index d12b4cad84a5..e95be0e7bd9e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -543,17 +543,21 @@ static const struct net_device_ops fbnic_netdev_ops = {
 static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 				     struct netdev_queue_stats_rx *rx)
 {
+	u64 bytes, packets, alloc_fail, alloc_fail_bdq;
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_ring *rxr = fbn->rx[idx];
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_queue_stats *stats;
-	u64 bytes, packets, alloc_fail;
 	u64 csum_complete, csum_none;
+	struct fbnic_q_triad *qt;
 	unsigned int start;
 
 	if (!rxr)
 		return;
 
+	/* fbn->rx points to completion queues */
+	qt = container_of(rxr, struct fbnic_q_triad, cmpl);
+
 	stats = &rxr->stats;
 	do {
 		start = u64_stats_fetch_begin(&stats->syncp);
@@ -564,6 +568,20 @@ static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 		csum_none = stats->rx.csum_none;
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
+	stats = &qt->sub0.stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		alloc_fail_bdq = stats->bdq.alloc_failed;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+	alloc_fail += alloc_fail_bdq;
+
+	stats = &qt->sub1.stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		alloc_fail_bdq = stats->bdq.alloc_failed;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+	alloc_fail += alloc_fail_bdq;
+
 	rx->bytes = bytes;
 	rx->packets = packets;
 	rx->alloc_fail = alloc_fail;
@@ -641,7 +659,8 @@ static void fbnic_get_base_stats(struct net_device *dev,
 
 	rx->bytes = fbn->rx_stats.bytes;
 	rx->packets = fbn->rx_stats.packets;
-	rx->alloc_fail = fbn->rx_stats.rx.alloc_failed;
+	rx->alloc_fail = fbn->rx_stats.rx.alloc_failed +
+		fbn->bdq_stats.bdq.alloc_failed;
 	rx->csum_complete = fbn->rx_stats.rx.csum_complete;
 	rx->csum_none = fbn->rx_stats.rx.csum_none;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 26328e8090c6..b1e8ce89870f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -904,7 +904,7 @@ static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 		netmem = page_pool_dev_alloc_netmems(bdq->page_pool);
 		if (!netmem) {
 			u64_stats_update_begin(&bdq->stats.syncp);
-			bdq->stats.rx.alloc_failed++;
+			bdq->stats.bdq.alloc_failed++;
 			u64_stats_update_end(&bdq->stats.syncp);
 
 			break;
@@ -1414,6 +1414,17 @@ void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 	BUILD_BUG_ON(sizeof(fbn->rx_stats.rx) / 8 != 4);
 }
 
+void fbnic_aggregate_ring_bdq_counters(struct fbnic_net *fbn,
+				       struct fbnic_ring *bdq)
+{
+	struct fbnic_queue_stats *stats = &bdq->stats;
+
+	/* Capture stats from queues before dissasociating them */
+	fbn->bdq_stats.bdq.alloc_failed += stats->bdq.alloc_failed;
+	/* Remember to add new stats here */
+	BUILD_BUG_ON(sizeof(fbn->rx_stats.bdq) / 8 != 1);
+}
+
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 				      struct fbnic_ring *txr)
 {
@@ -1486,6 +1497,15 @@ static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
 	fbn->rx[rxr->q_idx] = NULL;
 }
 
+static void fbnic_remove_bdq_ring(struct fbnic_net *fbn,
+				  struct fbnic_ring *bdq)
+{
+	if (!(bdq->flags & FBNIC_RING_F_STATS))
+		return;
+
+	fbnic_aggregate_ring_bdq_counters(fbn, bdq);
+}
+
 static void fbnic_free_qt_page_pools(struct fbnic_q_triad *qt)
 {
 	page_pool_destroy(qt->sub0.page_pool);
@@ -1505,8 +1525,8 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	for (j = 0; j < nv->rxt_count; j++, i++) {
-		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
-		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
+		fbnic_remove_bdq_ring(fbn, &nv->qt[i].sub0);
+		fbnic_remove_bdq_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
 	}
 
@@ -1705,11 +1725,13 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	while (rxt_count) {
 		/* Configure header queue */
 		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_BDQ_HPQ_TAIL];
-		fbnic_ring_init(&qt->sub0, db, 0, FBNIC_RING_F_CTX);
+		fbnic_ring_init(&qt->sub0, db, 0,
+				FBNIC_RING_F_CTX | FBNIC_RING_F_STATS);
 
 		/* Configure payload queue */
 		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_BDQ_PPQ_TAIL];
-		fbnic_ring_init(&qt->sub1, db, 0, FBNIC_RING_F_CTX);
+		fbnic_ring_init(&qt->sub1, db, 0,
+				FBNIC_RING_F_CTX | FBNIC_RING_F_STATS);
 
 		/* Configure Rx completion queue */
 		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_RCQ_HEAD];
@@ -2828,8 +2850,8 @@ static int fbnic_queue_start(struct net_device *dev, void *qmem, int idx)
 	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
 	nv = fbn->napi[idx % fbn->num_napi];
 
-	fbnic_aggregate_ring_rx_counters(fbn, &real->sub0);
-	fbnic_aggregate_ring_rx_counters(fbn, &real->sub1);
+	fbnic_aggregate_ring_bdq_counters(fbn, &real->sub0);
+	fbnic_aggregate_ring_bdq_counters(fbn, &real->sub1);
 	fbnic_aggregate_ring_rx_counters(fbn, &real->cmpl);
 
 	memcpy(real, qmem, sizeof(*real));
-- 
2.51.0


