Return-Path: <bpf+bounces-65471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC6B23BCB
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F74F583504
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EB2E0915;
	Tue, 12 Aug 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtVn9Sm1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623027604E;
	Tue, 12 Aug 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037380; cv=none; b=VDMWZcWJZ9eO98BmBswBrdwVmz5WXMjO1jvdDQoJp15A9b8oYsPKW8DsuWtYWPcYnsCm6qGG6QZzMAKItVjTR2VDNWqL25gNdM7XeIZ5ZkCzzfowf2Wq5PiJ/J02ajSYveRM+/ck/wDbKX2jH/P/h+CkVgms8LFG6AZU53mRvAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037380; c=relaxed/simple;
	bh=+sFQSTHIOhzJPPTHZ6mF3BRYYIb5lhP24qtZkAGLV1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otqOSj2J6Se+oiFEWwrVU+T8RIH+a5bwlcikhFAxLVxX/Eelrx3IYm5H/Y6mFGdPUH757f9oDFdhEKsIx4zY4+kAlKj6q0pMmebUJSKbybDbAj7SjtxaQ7KIjPTfC//ig9y2M0d1V0vD/cuEbVLSVEGUXxNFAWQ7QFYqIbDKVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtVn9Sm1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so6032179f8f.1;
        Tue, 12 Aug 2025 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755037376; x=1755642176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS7bmnIloASKqNj5zXPdW4P/ppO3Xb5AJCzOr3LRULg=;
        b=WtVn9Sm1er9w2S2dhCRa/YPxh+NukpEh4fzb1d75371b+ezHkXCoG9yiMcDd1r1UOX
         j59vCquJEQdmw7CHpjo75AhgAujBBkIGrGwdMKcwFXB2AV0WZYKJSYZBoqw08gptG9oS
         Awjpq3/xPyW7Lc3SE/A45oGuuiJ0prQnJ1VOXncJQzZy7FJI9y6sqFwQvrpknA9JmMV3
         aV6YNgm6XP6IQewbN7XJ0InYRYZj+0OQv7p3hNZi1Wo1fjlmaPuBH9YXN1lu7+SM1LaT
         AobkHNPpE9tgt4K7ewmspC2c3/iyvg0IeiU5NnXCPR9EoeVDEbjedKejRcVx1aCO4X22
         y3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037376; x=1755642176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS7bmnIloASKqNj5zXPdW4P/ppO3Xb5AJCzOr3LRULg=;
        b=QOvaLXeMLleuJ2B9/8Cz1v58Z+yzwuU/XgAEQrgtHXifHECNgNjCAVSFMbylGFFApU
         z2s8lXtVrUXdFBo2lSxoowDFPtqMTifNn9XcsSypR1S9eA+Y/pE8KR06+MkCRrS3hlk+
         w2upGskl2GQrbZGBGTEgqnz+ZF8e+rrjWSeTfAgeRYPa0UkuCLb0RiwBDPWjyDp6CwUC
         /NQI5EGBHAe95JFTQDucw7jX4AG+CRBBxTfUr/CsSfVyqA0fnrebcdH50+x43o8kW8IB
         itszekPeNSVkmpR6PRgLeNNrpI7y4QDR5sC7Y65Naf5RX4GdfyURN4MBkWt4BZb3sedI
         oFkg==
X-Forwarded-Encrypted: i=1; AJvYcCWkgUfxcn7/DeugyhQbJ5NFHTgsrYRZsW3cg493wdwSJQxWedU4HdyyikTls1OoQHx7HuUnIsuxjjjl@vger.kernel.org, AJvYcCWt2WptgWUGy+3uD2q5e9nNHEQOyRFe+7/UE3v4Dof6vRimJEvr5desBML/LgLFp8UK8/I=@vger.kernel.org, AJvYcCXyIhBYvmO9SYnZ6JQetBtiNU1cXJDXPDQVvDoqxVvxneZX9TruQF1fEi9xtaH1SD0ZusxaoWOfognOz6iM@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOiPUusywhPMHL95Awffl6a9me7HMXAiobpVT6bEk3UdX9EjM
	J9lHRqVsmrmoW6AWp1vMO03zMot3tx5BBiHxdx0SyEP5xmHHmvU68J3keFhDxRtQ
X-Gm-Gg: ASbGncuv3FneQ0lZ8kENhFRt+K7QW3yLQ6O0h0jvYhg6JRlr4ZZvCOR4JTpAGfYjEd5
	D4/6mFpPr9NP1R4iRQ/Q8t7iWUGFuZQ40yrZX3AR5D/qcKVKs+j7frZUGh7elcN2zsBC8jW+U5u
	iBCE1RZUB0qS7wJk6JxMHHOX59KWp27xHqbYTVPLfG5kkq1Ad+f1lB9X4RjblQt6fZeEJdKuxIL
	zHu362iMhqPYESKKbGCNamqko4ZhGZp/8+QxyiBsZDb8854kqjOosAhP55nrsv0eDcVHpnvmK05
	Z4yvkgeqZSJiaXRwUTR0a3q/573XNk8wYqwPql+pikUP/zUSEIrKrEbSE5qbY6BrH55+1dnBqfY
	eskyXo40eQuWJSqSvPc3h
X-Google-Smtp-Source: AGHT+IGRW8XazU5RzfUKZN+cRS1p89FzfLhMPSsUMxnRANlZxTviQk72arFfrz8BYdCTYEyuoMn1Jg==
X-Received: by 2002:a5d:5f56:0:b0:3b7:6828:5f78 with SMTP id ffacd0b85a97d-3b917e2da18mr371805f8f.4.1755037375963;
        Tue, 12 Aug 2025 15:22:55 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16dffb63sm3812225e9.29.2025.08.12.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:22:55 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V3 8/9] eth: fbnic: Collect packet statistics for XDP
Date: Tue, 12 Aug 2025 15:22:52 -0700
Message-ID: <20250812222252.261779-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for XDP statistics collection and reporting via rtnl_link
and netdev_queue API.

For XDP programs without frags support, fbnic requires MTU to be less
than the HDS threshold. If an over-sized frame is received, the frame
is dropped and recorded as rx_length_errors reported via ip stats to
highlight that this is an error.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    | 11 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 36 ++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 51 +++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 4 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index afb8353daefd..fb6559fa4be4 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -160,3 +160,14 @@ behavior and potential performance bottlenecks.
 	  credit exhaustion
         - ``pcie_ob_rd_no_np_cred``: Read requests dropped due to non-posted
 	  credit exhaustion
+
+XDP Length Error:
+~~~~~~~~~~~~~~~~~
+
+For XDP programs without frags support, fbnic tries to make sure that MTU fits
+into a single buffer. If an oversized frame is received and gets fragmented,
+it is dropped and the following netlink counters are updated
+
+   - ``rx-length``: number of frames dropped due to lack of fragmentation
+     support in the attached XDP program
+   - ``rx-errors``: total number of packets with errors received on the interface
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index fb81d1a7bc51..b8b684ad376b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -407,11 +407,12 @@ static void fbnic_get_stats64(struct net_device *dev,
 			      struct rtnl_link_stats64 *stats64)
 {
 	u64 rx_bytes, rx_packets, rx_dropped = 0, rx_errors = 0;
+	u64 rx_over = 0, rx_missed = 0, rx_length = 0;
 	u64 tx_bytes, tx_packets, tx_dropped = 0;
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_queue_stats *stats;
-	u64 rx_over = 0, rx_missed = 0;
+
 	unsigned int start, i;
 
 	fbnic_get_hw_stats(fbd);
@@ -489,6 +490,7 @@ static void fbnic_get_stats64(struct net_device *dev,
 	stats64->rx_missed_errors = rx_missed;
 
 	for (i = 0; i < fbn->num_rx_queues; i++) {
+		struct fbnic_ring *xdpr = fbn->tx[FBNIC_MAX_TXQS + i];
 		struct fbnic_ring *rxr = fbn->rx[i];
 
 		if (!rxr)
@@ -500,11 +502,29 @@ static void fbnic_get_stats64(struct net_device *dev,
 			rx_bytes = stats->bytes;
 			rx_packets = stats->packets;
 			rx_dropped = stats->dropped;
+			rx_length = stats->rx.length_errors;
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		stats64->rx_bytes += rx_bytes;
 		stats64->rx_packets += rx_packets;
 		stats64->rx_dropped += rx_dropped;
+		stats64->rx_errors += rx_length;
+		stats64->rx_length_errors += rx_length;
+
+		if (!xdpr)
+			continue;
+
+		stats = &xdpr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			tx_bytes = stats->bytes;
+			tx_packets = stats->packets;
+			tx_dropped = stats->dropped;
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats64->tx_bytes += tx_bytes;
+		stats64->tx_packets += tx_packets;
+		stats64->tx_dropped += tx_dropped;
 	}
 }
 
@@ -603,6 +623,7 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct fbnic_ring *txr = fbn->tx[idx];
 	struct fbnic_queue_stats *stats;
 	u64 stop, wake, csum, lso;
+	struct fbnic_ring *xdpr;
 	unsigned int start;
 	u64 bytes, packets;
 
@@ -626,6 +647,19 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	tx->hw_gso_wire_packets = lso;
 	tx->stop = stop;
 	tx->wake = wake;
+
+	xdpr = fbn->tx[FBNIC_MAX_TXQS + idx];
+	if (xdpr) {
+		stats = &xdpr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			bytes = stats->bytes;
+			packets = stats->packets;
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		tx->bytes += bytes;
+		tx->packets += packets;
+	}
 }
 
 static void fbnic_get_base_stats(struct net_device *dev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 3ce1762bd11d..fd22e8f83962 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -620,8 +620,8 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 			     struct fbnic_ring *ring, bool discard,
 			     unsigned int hw_head)
 {
+	u64 total_bytes = 0, total_packets = 0;
 	unsigned int head = ring->head;
-	u64 total_bytes = 0;
 
 	while (hw_head != head) {
 		struct page *page;
@@ -633,6 +633,11 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 		twd = le64_to_cpu(ring->desc[head]);
 		page = ring->tx_buf[head];
 
+		/* TYPE_AL is 2, TYPE_LAST_AL is 3. So this trick gives
+		 * us one increment per packet, with no branches.
+		 */
+		total_packets += FIELD_GET(FBNIC_TWD_TYPE_MASK, twd) -
+				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
 		page_pool_put_page(nv->page_pool, page, -1, pp_allow_direct);
@@ -645,6 +650,18 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 		return;
 
 	ring->head = head;
+
+	if (discard) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.dropped += total_packets;
+		u64_stats_update_end(&ring->stats.syncp);
+		return;
+	}
+
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.bytes += total_bytes;
+	ring->stats.packets += total_packets;
+	u64_stats_update_end(&ring->stats.syncp);
 }
 
 static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
@@ -1040,8 +1057,12 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 		frag = &shinfo->frags[0];
 	}
 
-	if (fbnic_desc_unused(ring) < nsegs)
+	if (fbnic_desc_unused(ring) < nsegs) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.dropped++;
+		u64_stats_update_end(&ring->stats.syncp);
 		return -FBNIC_XDP_CONSUME;
+	}
 
 	page = virt_to_page(pkt->buff.data_hard_start);
 	offset = offset_in_page(pkt->buff.data);
@@ -1181,8 +1202,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			   struct fbnic_q_triad *qt, int budget)
 {
 	unsigned int packets = 0, bytes = 0, dropped = 0, alloc_failed = 0;
+	u64 csum_complete = 0, csum_none = 0, length_errors = 0;
 	s32 head0 = -1, head1 = -1, pkt_tail = -1;
-	u64 csum_complete = 0, csum_none = 0;
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
 	__le64 *raw_rcd, done;
@@ -1247,6 +1268,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				if (!skb) {
 					alloc_failed++;
 					dropped++;
+				} else if (PTR_ERR(skb) == -FBNIC_XDP_LEN_ERR) {
+					length_errors++;
 				} else {
 					dropped++;
 				}
@@ -1276,6 +1299,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	rcq->stats.rx.alloc_failed += alloc_failed;
 	rcq->stats.rx.csum_complete += csum_complete;
 	rcq->stats.rx.csum_none += csum_none;
+	rcq->stats.rx.length_errors += length_errors;
 	u64_stats_update_end(&rcq->stats.syncp);
 
 	if (pkt_tail >= 0)
@@ -1359,8 +1383,9 @@ void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 	fbn->rx_stats.rx.alloc_failed += stats->rx.alloc_failed;
 	fbn->rx_stats.rx.csum_complete += stats->rx.csum_complete;
 	fbn->rx_stats.rx.csum_none += stats->rx.csum_none;
+	fbn->rx_stats.rx.length_errors += stats->rx.length_errors;
 	/* Remember to add new stats here */
-	BUILD_BUG_ON(sizeof(fbn->rx_stats.rx) / 8 != 3);
+	BUILD_BUG_ON(sizeof(fbn->rx_stats.rx) / 8 != 4);
 }
 
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
@@ -1382,6 +1407,22 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 6);
 }
 
+static void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
+					      struct fbnic_ring *xdpr)
+{
+	struct fbnic_queue_stats *stats = &xdpr->stats;
+
+	if (!(xdpr->flags & FBNIC_RING_F_STATS))
+		return;
+
+	/* Capture stats from queues before dissasociating them */
+	fbn->rx_stats.bytes += stats->bytes;
+	fbn->rx_stats.packets += stats->packets;
+	fbn->rx_stats.dropped += stats->dropped;
+	fbn->tx_stats.bytes += stats->bytes;
+	fbn->tx_stats.packets += stats->packets;
+}
+
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
 				 struct fbnic_ring *txr)
 {
@@ -1401,6 +1442,8 @@ static void fbnic_remove_xdp_ring(struct fbnic_net *fbn,
 	if (!(xdpr->flags & FBNIC_RING_F_STATS))
 		return;
 
+	fbnic_aggregate_ring_xdp_counters(fbn, xdpr);
+
 	/* Remove pointer to the Tx ring */
 	WARN_ON(fbn->tx[xdpr->q_idx] && fbn->tx[xdpr->q_idx] != xdpr);
 	fbn->tx[xdpr->q_idx] = NULL;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 0e92d11115a6..873440ca6a31 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -90,6 +90,7 @@ struct fbnic_queue_stats {
 			u64 alloc_failed;
 			u64 csum_complete;
 			u64 csum_none;
+			u64 length_errors;
 		} rx;
 	};
 	u64 dropped;
-- 
2.47.3


