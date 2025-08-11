Return-Path: <bpf+bounces-65396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE5B217BD
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F134A17B207
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A02E3B15;
	Mon, 11 Aug 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i57A8b2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911C2E3AEF;
	Mon, 11 Aug 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949388; cv=none; b=rAEKKHkdj73X1/t5Ne/+OdgSn9JadLHPD4FWspi74uYXnpWR1N80voZOki9pfnBQYtPp1AljxP722bEoPARmDL+UujNslMomE/iY1EeXDyDt1Zfp/0gvxJ1Jhh6g7pP6vrOFiM9AhMrK0/i4oBK+OnfUhe/sscQzEbo67OtzW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949388; c=relaxed/simple;
	bh=yDmsPPzMpSUIeZYkwULpgR5D39aD8aQCAvbNN+VBvcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRjkLBeYurh41Egd0XBULJP6fQ2ErYplPgCWKtdfLQOzP1ihQTWtwyajPdKU2HeuPwilHNyUgWeeYZV9rsjBIz4idQ9INDEFJxX7j4EBbGI81JyAB569d294ZxGQWygP0qG0a7uSWRLVOvl61kX7QgxgsxOGUKIL1BjegqRMQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i57A8b2U; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so45154185e9.0;
        Mon, 11 Aug 2025 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949384; x=1755554184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7MofNOWfafs71/3kw2PQY8/ELx/YneERPxKbYpJjDY=;
        b=i57A8b2UkiiKaLv+bpfwppDR/VNC91RrX40ZgCGBb/dCO4LgIGFtG1g1oC3yKx7SJN
         VTiHvx83dcW1mOyXD5+8+qm3OO9i1JfFsQWVyTuK7EDiTYJ93/87iGklasfXwySRoGFk
         avCHDkaTu06rQuMJ1W1zwHmUmmDF4wVoOgkq7Ct5GSSFMKrtTJvFGAvdk8QrdxfGWxr2
         wYBWF8naUY4Ee4j6ZgFa9ANTBjaSLx9bTlRI5v/XmiXYv96M3sc9Hz/0efGPqnjla5kA
         3HcEqeyi/Ls0EvN1t8vqDJeau8yABAFGoTUMnx6Q0q++KJWlPJGDnEuoRYw4wZuKPsXC
         wynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949384; x=1755554184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7MofNOWfafs71/3kw2PQY8/ELx/YneERPxKbYpJjDY=;
        b=oi9Dlf/+gJPwXOydHaQaaWzQKXSPbkhyWCPQjKHK9EKozu68/k272Ecz4xnmPOrJ43
         igKwnLkrQk+q1+IivaKlvOP/CRP2slmJN154iq33A51IJ2YelYhMnuPoFX+4/6u6FVgs
         FldisJRPXRpC6gTwi5jPKGQf2xhXbLKIXVegIW4cRwPSWIAJSWFS8f5kqzhYIGO1PNuk
         zobDYLufTwbYTV7lItFpQtNC1aVVsH6+EGER7E6+Qrh4jrKFUmc0Gq3G42Rxmuty06rZ
         aEN3Y887riysfDu2qZKPKQ4uhHeEGU5DGGAQXz/PggIqAEIIbdZI1mno9Zo2IcLDvslW
         QD8w==
X-Forwarded-Encrypted: i=1; AJvYcCWekeXQsBDeWF7yF4ljuOafGPeUAivxl11XfFY3mr0s+VyCmAlT5H0k65WgDxwage9ALrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVqluywVU+o/ElKWokj/Kv9p4KFGtCyQ+/nSt/TVCriEHZqwo
	sko7O2e7UOE8RGbPw6dxHiH/42hQ3eWVlDsq8VXV4CwDtIYsiFS/POeIBIus3J1y
X-Gm-Gg: ASbGncsmX0Cbuawkk5FK0kE3ZzPA+NZlHXrfUfkTSENo8IwsBOuA2QGs46vanAh7Cvh
	g1GqUBgQCATiAnGXZuI4E54vTLY16TeV5O1oIRchaADVrSnYnEuoI9YWsZekHwaKU/oCaMoNagq
	J+O+XRS20pB+XH6X/iSZ1QCWQHjHHXoXH5ANvjQJNBKWnhHocZB7mLHmMxK0LOjlfRnQm9CBfIb
	Tc5VL8FwrIjGdTnNfvRHFpmt/6uR4D5IgpPA9yyr6y95nx10KRFRelee8iUDQ2HEq/9zoE5HYUV
	+JeYhYrUTofynSqM1ffD9atC8khgw324qjM2jIb+dH5dqupQLk4H8UVQZHcQiSkjZTqzAu8dlK6
	OWzmxgzzhvrsBcIeYFGeE
X-Google-Smtp-Source: AGHT+IHOyuLmPWS+mox0MJVUOobmm0ESTmJtg4Z9hMTP/YsWp3bj5fACBE6fv7voWyw2exWmlXzDBw==
X-Received: by 2002:a05:6000:24c5:b0:3b7:83c0:a9e0 with SMTP id ffacd0b85a97d-3b900b5103dmr11343799f8f.25.1754949384150;
        Mon, 11 Aug 2025 14:56:24 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533e6sm43056930f8f.35.2025.08.11.14.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:56:22 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
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
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 8/9] eth: fbnic: Collect packet statistics for XDP
Date: Mon, 11 Aug 2025 14:56:20 -0700
Message-ID: <20250811215620.1061335-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
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
index 9b63311982bf..7e695f699825 100644
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


