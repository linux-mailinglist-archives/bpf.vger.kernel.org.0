Return-Path: <bpf+bounces-61001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81665ADF833
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EB81898CA3
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F02206A8;
	Wed, 18 Jun 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whRoxbmN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4921E08A
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280182; cv=none; b=lLLfpeWuJgSU4J6zOIYfXRW8SwKPuaODhLXvX6eUlERb6aDBZGPBLGlemxee4RXj8buiF46CBIsc+zHs5vHrRzmscOdpnoGv3ejTnIsRD1M/TwaWnKsMJahCJonNEIj4Y5jgAYdmMOF9h2YgufJI5DeF2Dc2wGFuAFSntqFgGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280182; c=relaxed/simple;
	bh=lyvRRnsp6l5pRugPAYHMj7B0NyqWs1vdYXMkpdEORdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNQUSTjqP/WzPIOrRCqdafuzU//gE4C5IpapbSLOHnWQ5L8wLIZvziqr0EmGhI8i3tjjC3c91+xG4xwvbgspyCAf172TwWzcv+VxtxZsMyfqHUQSsgvAUtcRcR0yGfKUwNWQ6Bpsa3RCpql7TY7PVwavEmFaSKVHuWWCS5twQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whRoxbmN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3122368d82bso28370a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750280180; x=1750884980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohnc9c2GBtg2/C577rU/2xZdRfc1XtYqG1puYAyumB4=;
        b=whRoxbmNirmPItd35cyuHOVYdZUlsmHjl2DPuVM2kABf36WYyM3dCQkMJaAu4GNxaf
         R5/hX8ZzFZeIPWP7/8zPEIRlNIlj8XhhfKQpTnE0Gsht6hHfWUuJCKZO4hv1jz/DLnuW
         cIu0WjTccAyPwg551308oGLxebGWJYUOgujYnIMmTbiasaRwwsrMexStwRLtvuzPr1yT
         +KAxJVd/dEY16CY5joGqzMfg/ylgvQmTU/yW8vDu683OzVC3JdvAk9s7e7pIdz+Pw5mi
         VUFQt+biG67iGzE5MDjn54N+H+iSYck6XhpJCkmCE4mSgZnypYcdRT8yQ09A/QnEWs+Q
         pNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280180; x=1750884980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohnc9c2GBtg2/C577rU/2xZdRfc1XtYqG1puYAyumB4=;
        b=SMI5BQltalju5fl3fnYdp4NQUZclCYh814lAHgGz5bdJ5+h09ayQSelvzTs0PCnPNY
         HKtMPD0nRezG+Ru4vv/usoxaG0s2hTeVVj2Y8kbzuI0/isJ9T9xahzicKfWU4k6bV+Y4
         aKwrE/FB2RPP+Pqr237hsnxL43kG7jPf0eO4+ZlAxTpvTWrhNXx5pjxcKyap29tUsGtS
         0kdXSNACfzj6FbmBuMNkZvVKuGZ0UHMlfIuDNh16ASwosOGWPGd8nN+YbSgMwfOyUYen
         6MeQTK0Tjw/hQ4HO+LVUBAr6nlrxWZump1D6ukKLkeV38bYED20hRm05iW7ElXojH9w6
         yfWg==
X-Forwarded-Encrypted: i=1; AJvYcCXkq08xM7uAr90j295ha4UOssZlg/A0wxbPyEyGPB4t8we9unN9DSiyVmJUVcGGx/JYVAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynLBFAW7CSvWTOXxGkZtd8ZKQBVxWmeOCihIM/6NpJu8zTrG1I
	O7evYC6EgrzeKVR3/SECtDrNFtvakOExPIY+D9Gtwu+f9nCEONaPXDEjkl9rm7okmB4CAwwoAFq
	90vGdIcELuKLPKACuA+T2PYfvKg==
X-Google-Smtp-Source: AGHT+IGJrhDkOKYSMqJVtNS/B0KUQnbW9kBeCVjsBgIy3WneC6k4wWY5cCPgRhv4jJEF246l/S5gJOLXmMBnxRQNkw==
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:311:f699:df0a])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:274d:b0:312:959:dc4d with SMTP id 98e67ed59e1d1-313f1beafdcmr29661318a91.7.1750280180303;
 Wed, 18 Jun 2025 13:56:20 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:56:12 +0000
In-Reply-To: <20250618205613.1432007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618205613.1432007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250618205613.1432007-3-hramamurthy@google.com>
Subject: [PATCH net-next 2/3] gve: refactor DQO TX methods to be more generic
 for XDP
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	ziweixiao@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch performs various minor DQO TX datapath refactors in
preparation for adding XDP_TX and XDP_REDIRECT support. The following
refactors are performed:

1) gve_tx_fill_pkt_desc_dqo() relies on a SKB pointer to
   get whether checksum offloading should be enabled. This won't work
   for the XDP case, which does not have a SKB. This patch updates the
   method to use a boolean representing whether checksum offloading
   should be enabled directly.

2) gve_maybe_stop_dqo() contains some synchronization between the true
   TX head and the cached value, a synchronization which is common for
   XDP queues and normal netdev queues. However, that method is reserved
   for netdev TX queues. To avoid duplicate code, this logic is factored
   out into a new method, gve_has_tx_slots_available().

3) gve_tx_update_tail() is added to update the TX tail, a functionality
   that will be common between normal TX and XDP TX codepaths.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 85 +++++++++++---------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 9d705d94b065..ba6b5cdaa922 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -439,12 +439,28 @@ static u32 num_avail_tx_slots(const struct gve_tx_ring *tx)
 	return tx->mask - num_used;
 }
 
+/* Checks if the requested number of slots are available in the ring */
+static bool gve_has_tx_slots_available(struct gve_tx_ring *tx, u32 slots_req)
+{
+	u32 num_avail = num_avail_tx_slots(tx);
+
+	slots_req += GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
+
+	if (num_avail >= slots_req)
+		return true;
+
+	/* Update cached TX head pointer */
+	tx->dqo_tx.head = atomic_read_acquire(&tx->dqo_compl.hw_tx_head);
+
+	return num_avail_tx_slots(tx) >= slots_req;
+}
+
 static bool gve_has_avail_slots_tx_dqo(struct gve_tx_ring *tx,
 				       int desc_count, int buf_count)
 {
 	return gve_has_pending_packet(tx) &&
-		   num_avail_tx_slots(tx) >= desc_count &&
-		   gve_has_free_tx_qpl_bufs(tx, buf_count);
+		gve_has_tx_slots_available(tx, desc_count) &&
+		gve_has_free_tx_qpl_bufs(tx, buf_count);
 }
 
 /* Stops the queue if available descriptors is less than 'count'.
@@ -453,12 +469,6 @@ static bool gve_has_avail_slots_tx_dqo(struct gve_tx_ring *tx,
 static int gve_maybe_stop_tx_dqo(struct gve_tx_ring *tx,
 				 int desc_count, int buf_count)
 {
-	if (likely(gve_has_avail_slots_tx_dqo(tx, desc_count, buf_count)))
-		return 0;
-
-	/* Update cached TX head pointer */
-	tx->dqo_tx.head = atomic_read_acquire(&tx->dqo_compl.hw_tx_head);
-
 	if (likely(gve_has_avail_slots_tx_dqo(tx, desc_count, buf_count)))
 		return 0;
 
@@ -472,8 +482,6 @@ static int gve_maybe_stop_tx_dqo(struct gve_tx_ring *tx,
 	/* After stopping queue, check if we can transmit again in order to
 	 * avoid TOCTOU bug.
 	 */
-	tx->dqo_tx.head = atomic_read_acquire(&tx->dqo_compl.hw_tx_head);
-
 	if (likely(!gve_has_avail_slots_tx_dqo(tx, desc_count, buf_count)))
 		return -EBUSY;
 
@@ -500,11 +508,9 @@ static void gve_extract_tx_metadata_dqo(const struct sk_buff *skb,
 }
 
 static void gve_tx_fill_pkt_desc_dqo(struct gve_tx_ring *tx, u32 *desc_idx,
-				     struct sk_buff *skb, u32 len, u64 addr,
+				     bool enable_csum, u32 len, u64 addr,
 				     s16 compl_tag, bool eop, bool is_gso)
 {
-	const bool checksum_offload_en = skb->ip_summed == CHECKSUM_PARTIAL;
-
 	while (len > 0) {
 		struct gve_tx_pkt_desc_dqo *desc =
 			&tx->dqo.tx_ring[*desc_idx].pkt;
@@ -515,7 +521,7 @@ static void gve_tx_fill_pkt_desc_dqo(struct gve_tx_ring *tx, u32 *desc_idx,
 			.buf_addr = cpu_to_le64(addr),
 			.dtype = GVE_TX_PKT_DESC_DTYPE_DQO,
 			.end_of_packet = cur_eop,
-			.checksum_offload_enable = checksum_offload_en,
+			.checksum_offload_enable = enable_csum,
 			.compl_tag = cpu_to_le16(compl_tag),
 			.buf_size = cur_len,
 		};
@@ -612,6 +618,25 @@ gve_tx_fill_general_ctx_desc(struct gve_tx_general_context_desc_dqo *desc,
 	};
 }
 
+static void gve_tx_update_tail(struct gve_tx_ring *tx, u32 desc_idx)
+{
+	u32 last_desc_idx = (desc_idx - 1) & tx->mask;
+	u32 last_report_event_interval =
+			(last_desc_idx - tx->dqo_tx.last_re_idx) & tx->mask;
+
+	/* Commit the changes to our state */
+	tx->dqo_tx.tail = desc_idx;
+
+	/* Request a descriptor completion on the last descriptor of the
+	 * packet if we are allowed to by the HW enforced interval.
+	 */
+
+	if (unlikely(last_report_event_interval >= GVE_TX_MIN_RE_INTERVAL)) {
+		tx->dqo.tx_ring[last_desc_idx].pkt.report_event = true;
+		tx->dqo_tx.last_re_idx = last_desc_idx;
+	}
+}
+
 static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 				      struct sk_buff *skb,
 				      struct gve_tx_pending_packet_dqo *pkt,
@@ -619,6 +644,7 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 				      u32 *desc_idx,
 				      bool is_gso)
 {
+	bool enable_csum = skb->ip_summed == CHECKSUM_PARTIAL;
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	int i;
 
@@ -644,7 +670,7 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 		dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
 		++pkt->num_bufs;
 
-		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
+		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, enable_csum, len, addr,
 					 completion_tag,
 					 /*eop=*/shinfo->nr_frags == 0, is_gso);
 	}
@@ -664,7 +690,7 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 					  dma[pkt->num_bufs], addr);
 		++pkt->num_bufs;
 
-		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
+		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, enable_csum, len, addr,
 					 completion_tag, is_eop, is_gso);
 	}
 
@@ -709,6 +735,7 @@ static int gve_tx_add_skb_copy_dqo(struct gve_tx_ring *tx,
 				   u32 *desc_idx,
 				   bool is_gso)
 {
+	bool enable_csum = skb->ip_summed == CHECKSUM_PARTIAL;
 	u32 copy_offset = 0;
 	dma_addr_t dma_addr;
 	u32 copy_len;
@@ -730,7 +757,7 @@ static int gve_tx_add_skb_copy_dqo(struct gve_tx_ring *tx,
 		copy_offset += copy_len;
 		dma_sync_single_for_device(tx->dev, dma_addr,
 					   copy_len, DMA_TO_DEVICE);
-		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb,
+		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, enable_csum,
 					 copy_len,
 					 dma_addr,
 					 completion_tag,
@@ -800,24 +827,7 @@ static int gve_tx_add_skb_dqo(struct gve_tx_ring *tx,
 
 	tx->dqo_tx.posted_packet_desc_cnt += pkt->num_bufs;
 
-	/* Commit the changes to our state */
-	tx->dqo_tx.tail = desc_idx;
-
-	/* Request a descriptor completion on the last descriptor of the
-	 * packet if we are allowed to by the HW enforced interval.
-	 */
-	{
-		u32 last_desc_idx = (desc_idx - 1) & tx->mask;
-		u32 last_report_event_interval =
-			(last_desc_idx - tx->dqo_tx.last_re_idx) & tx->mask;
-
-		if (unlikely(last_report_event_interval >=
-			     GVE_TX_MIN_RE_INTERVAL)) {
-			tx->dqo.tx_ring[last_desc_idx].pkt.report_event = true;
-			tx->dqo_tx.last_re_idx = last_desc_idx;
-		}
-	}
-
+	gve_tx_update_tail(tx, desc_idx);
 	return 0;
 
 err:
@@ -951,9 +961,8 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 
 	/* Metadata + (optional TSO) + data descriptors. */
 	total_num_descs = 1 + skb_is_gso(skb) + num_buffer_descs;
-	if (unlikely(gve_maybe_stop_tx_dqo(tx, total_num_descs +
-			GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP,
-			num_buffer_descs))) {
+	if (unlikely(gve_maybe_stop_tx_dqo(tx, total_num_descs,
+					   num_buffer_descs))) {
 		return -1;
 	}
 
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


