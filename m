Return-Path: <bpf+bounces-41733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8C999FA4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916661C22F3B
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B372101AD;
	Fri, 11 Oct 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouAIVm86";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtVjuhLI"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7E20CCF5;
	Fri, 11 Oct 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637277; cv=none; b=TFshn4o7++gQPchZ8jsM46ZSpevMc+aWuXkyoxz3OelXbvNFRMaDi21AEmIMaBIKIi3uNRTuPYrIez5DujUoIvSIRS/PhO6KI4mgFcNESA285y8vj2tlJiaPLSLKJpJF3lbg725hNEW/4Lj4ARFNVQFU9mSlkhysrzzF689JbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637277; c=relaxed/simple;
	bh=bGazxzRboOYIi8ShpCE9gAtGVJcUzZxGFywLKHNaKU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1u9H6w9rZHqohZJfcvAmCHkLIVw8xjt9/WZjUVXffoSOoP7EHZ8Q1dtFwPX0rmv9b8nRpHdvq6ST9ymIaivCWoUd8YqtAR9OayxVENELSD30+W6FinpJogVkJ51fnJw5LY+Do6nNrwK4S7n3As3g7I60t0uG6BWoBRBL3MaFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ouAIVm86; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtVjuhLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728637272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE+XHIqGGT3NeP0I4x04vh/+FEpLBcy8QPubokAFJS0=;
	b=ouAIVm86dxOUdhv86lasfFSFr+WZf67RiJIcRL2PU0zOqP4pIpYf6CygEI7OIeib1GU2+M
	5sgUSnFepyHm2m4MuCekwDd+/Tfsshf2wH7qLxAwyu6qIGaLpFzviq63AhMJWFWy8thA5A
	Ae4v7TvUU/yaFiytgdSKs12YTP4opoxAQ4CBR4M24qXQUrZu+M3aggbopTwK05SFoP3a1U
	Ih4f2xpTqHuYy777Lm9a3bI9vcj7EkpgO27Zqd6WHCjZM1iMF+3TaJm1vvmwx8daJAG8jO
	ridVBg+ZSY4K101b/KJv4hzMfX0LYQPxZsHihg5+ZS8w38yZ6jWPOJVHylj2xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728637272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE+XHIqGGT3NeP0I4x04vh/+FEpLBcy8QPubokAFJS0=;
	b=TtVjuhLIygAk+xow5OchR1GdyQTQ6lEXbNhgFaC4eDeN+3HAZuudb+OsWfY0a6c6mkMwMA
	kVmf1TNv5YMqSDCg==
Date: Fri, 11 Oct 2024 11:01:03 +0200
Subject: [PATCH iwl-next v8 5/6] igb: Add AF_XDP zero-copy Rx support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-b4-igb_zero_copy-v8-5-83862f726a9e@linutronix.de>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
In-Reply-To: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Benjamin Steinke <benjamin.steinke@woks-audio.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=16474; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=rlBinlHTkWXuGcrk07oRACAdfEUyqOjIhS18hOfLKpg=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnCOlTOrvy+zEZwUuH/Mu7jOGs5g9lof0Pl+Jwo
 ER+oLM7Vw6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwjpUwAKCRDBk9HyqkZz
 gjAsEACeqLan91BBmhWk9JcX25KBC2w5poUIH9FJQnehkBLEs+QDo63SNyf2ikxG78VUL3Dxg9s
 WOKYt5fyMDa+GtZWyHDk5oPtumIn5ZivmY6wdctTyNY2vlEhgnpCsA/IyqgOu0ZANEnqxdPpg8L
 vX1CMJIbT1aSDSn2xDsUuy6fk45lANkbUq2o1bWo1X1tb8yQZi8rheGBLKWtyiMiJAQx02chsvD
 S54na5lstqK4k6HpUTHNZZ/x1X0hs6snHXnXIOSuE5i1c+ifewcnBFgUTlru4AX8LmcXwDXhsES
 hAZPyVZfNCpHQxdfH7F2Ztl7lQjtZ48MBLNuxa6OXBI9ovNsehhuV+HaO5X0gyd+Od3cDGsrqHS
 AdNF1UGzB0BJzaMjVhg0MNL0os8/mto1zwiDWIrflelMc/rreGMz76r4s4+dpnZmYrKiE80ZRgx
 h4XAf5osnYS+XScDdoKS00lI/W98uO8J5Tgj4jt/rrNGZVD1ezTGJCcftjUJWa0WkFxQNah7duD
 Ut3S1NETjukKjcErqJqLGGcA097BC3lDgduGHvUpmlk5pA63qM2uNJJitHG+NbMG8s3fV2GLhiS
 uCVLOg2hsPC1+s3Ci1T5OD+aq9alhlOdgy/UQ+N418ao6EqA7IZypka+mS7XL/HSCf2dDmIPsgx
 YlfLbmTmERFSRyQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Add support for AF_XDP zero-copy receive path.

When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
xsk buff pool using igb_alloc_rx_buffers_zc().

Use xsk_pool_get_rx_frame_size() to set SRRCTL rx buf size when zero-copy
is enabled.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Port to v6.12 and provide napi_id for xdp_rxq_info_reg(),
       RCT, remove NETDEV_XDP_ACT_XSK_ZEROCOPY, update NTC handling,
       READ_ONCE() xsk_pool, likelyfy for XDP_REDIRECT case]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |   6 +
 drivers/net/ethernet/intel/igb/igb_main.c |  79 ++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 298 +++++++++++++++++++++++++++++-
 3 files changed, 364 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1e65b41a48d8..e4a85867aa18 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -88,6 +88,7 @@ struct igb_adapter;
 #define IGB_XDP_CONSUMED	BIT(0)
 #define IGB_XDP_TX		BIT(1)
 #define IGB_XDP_REDIR		BIT(2)
+#define IGB_XDP_EXIT		BIT(3)
 
 struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
@@ -853,6 +854,11 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		       struct xsk_buff_pool *pool,
 		       u16 qid);
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
+			     struct xsk_buff_pool *xsk_pool, u16 count);
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
+			struct xsk_buff_pool *xsk_pool, const int budget);
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4d3aed6cd848..711b60cab594 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
 
 		for (i = 0; i < rx_ring->count; i++) {
 			const char *next_desc;
-			struct igb_rx_buffer *buffer_info;
-			buffer_info = &rx_ring->rx_buffer_info[i];
+			dma_addr_t dma = (dma_addr_t)0;
+			struct igb_rx_buffer *buffer_info = NULL;
 			rx_desc = IGB_RX_DESC(rx_ring, i);
 			u0 = (struct my_u0 *)rx_desc;
 			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
 
+			if (!rx_ring->xsk_pool) {
+				buffer_info = &rx_ring->rx_buffer_info[i];
+				dma = buffer_info->dma;
+			}
+
 			if (i == rx_ring->next_to_use)
 				next_desc = " NTU";
 			else if (i == rx_ring->next_to_clean)
@@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
 					"R  ", i,
 					le64_to_cpu(u0->a),
 					le64_to_cpu(u0->b),
-					(u64)buffer_info->dma,
+					(u64)dma,
 					next_desc);
 
 				if (netif_msg_pktdata(adapter) &&
-				    buffer_info->dma && buffer_info->page) {
+				    buffer_info && dma && buffer_info->page) {
 					print_hex_dump(KERN_INFO, "",
 					  DUMP_PREFIX_ADDRESS,
 					  16, 1,
@@ -1983,7 +1988,11 @@ static void igb_configure(struct igb_adapter *adapter)
 	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
-		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
+		if (ring->xsk_pool)
+			igb_alloc_rx_buffers_zc(ring, ring->xsk_pool,
+						igb_desc_unused(ring));
+		else
+			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
 	}
 }
 
@@ -4405,7 +4414,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-			       rx_ring->queue_index, 0);
+			       rx_ring->queue_index,
+			       rx_ring->q_vector->napi.napi_id);
 	if (res < 0) {
 		dev_err(dev, "Failed to register xdp_rxq index %u\n",
 			rx_ring->queue_index);
@@ -4701,12 +4711,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
 	struct e1000_hw *hw = &adapter->hw;
 	int reg_idx = ring->reg_idx;
 	u32 srrctl = 0;
+	u32 buf_size;
 
-	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	if (ring_uses_large_buffer(ring))
-		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+	if (ring->xsk_pool)
+		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+	else if (ring_uses_large_buffer(ring))
+		buf_size = IGB_RXBUFFER_3072;
 	else
-		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+		buf_size = IGB_RXBUFFER_2048;
+
+	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
+	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
 	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
 	if (hw->mac.type >= e1000_82580)
 		srrctl |= E1000_SRRCTL_TIMESTAMP;
@@ -4738,9 +4753,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	u32 rxdctl = 0;
 
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
-	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					   MEM_TYPE_PAGE_SHARED, NULL));
 	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
+	if (ring->xsk_pool) {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_XSK_BUFF_POOL,
+						   NULL));
+		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
+	} else {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_PAGE_SHARED,
+						   NULL));
+	}
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
@@ -4767,9 +4790,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	rxdctl |= IGB_RX_HTHRESH << 8;
 	rxdctl |= IGB_RX_WTHRESH << 16;
 
-	/* initialize rx_buffer_info */
-	memset(ring->rx_buffer_info, 0,
-	       sizeof(struct igb_rx_buffer) * ring->count);
+	if (ring->xsk_pool)
+		memset(ring->rx_buffer_info_zc, 0,
+		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
+	else
+		memset(ring->rx_buffer_info, 0,
+		       sizeof(*ring->rx_buffer_info) * ring->count);
 
 	/* initialize Rx descriptor 0 */
 	rx_desc = IGB_RX_DESC(ring, 0);
@@ -4957,8 +4983,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
 
 	rx_ring->xdp_prog = NULL;
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	vfree(rx_ring->rx_buffer_info);
-	rx_ring->rx_buffer_info = NULL;
+	if (rx_ring->xsk_pool) {
+		vfree(rx_ring->rx_buffer_info_zc);
+		rx_ring->rx_buffer_info_zc = NULL;
+	} else {
+		vfree(rx_ring->rx_buffer_info);
+		rx_ring->rx_buffer_info = NULL;
+	}
 
 	/* if not set, then don't free */
 	if (!rx_ring->desc)
@@ -4996,6 +5027,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 	dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;
 
+	if (rx_ring->xsk_pool) {
+		igb_clean_rx_ring_zc(rx_ring);
+		goto skip_for_xsk;
+	}
+
 	/* Free all the Rx ring sk_buffs */
 	while (i != rx_ring->next_to_alloc) {
 		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
@@ -5023,6 +5059,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 			i = 0;
 	}
 
+skip_for_xsk:
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -8177,6 +8214,7 @@ static int igb_poll(struct napi_struct *napi, int budget)
 	struct igb_q_vector *q_vector = container_of(napi,
 						     struct igb_q_vector,
 						     napi);
+	struct xsk_buff_pool *xsk_pool;
 	bool clean_complete = true;
 	int work_done = 0;
 
@@ -8188,7 +8226,12 @@ static int igb_poll(struct napi_struct *napi, int budget)
 		clean_complete = igb_clean_tx_irq(q_vector, budget);
 
 	if (q_vector->rx.ring) {
-		int cleaned = igb_clean_rx_irq(q_vector, budget);
+		int cleaned;
+
+		xsk_pool = READ_ONCE(q_vector->rx.ring->xsk_pool);
+		cleaned = xsk_pool ?
+			igb_clean_rx_irq_zc(q_vector, xsk_pool, budget) :
+			igb_clean_rx_irq(q_vector, budget);
 
 		work_done += cleaned;
 		if (cleaned >= budget)
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 7b632be3e7e3..22d234db0fab 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -70,7 +70,11 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 	 * at least 1 descriptor unused to make sure
 	 * next_to_use != next_to_clean
 	 */
-	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+	if (rx_ring->xsk_pool)
+		igb_alloc_rx_buffers_zc(rx_ring, rx_ring->xsk_pool,
+					igb_desc_unused(rx_ring));
+	else
+		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
 
 	/* Rx/Tx share the same napi context. */
 	napi_enable(&rx_ring->q_vector->napi);
@@ -169,6 +173,298 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		igb_xsk_pool_disable(adapter, qid);
 }
 
+static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
+			     union e1000_adv_rx_desc *rx_desc, u16 count)
+{
+	dma_addr_t dma;
+	u16 buffs;
+	int i;
+
+	/* nothing to do */
+	if (!count)
+		return 0;
+
+	buffs = xsk_buff_alloc_batch(pool, xdp, count);
+	for (i = 0; i < buffs; i++) {
+		dma = xsk_buff_xdp_get_dma(*xdp);
+		rx_desc->read.pkt_addr = cpu_to_le64(dma);
+		rx_desc->wb.upper.length = 0;
+
+		rx_desc++;
+		xdp++;
+	}
+
+	return buffs;
+}
+
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
+			     struct xsk_buff_pool *xsk_pool, u16 count)
+{
+	u32 nb_buffs_extra = 0, nb_buffs = 0;
+	union e1000_adv_rx_desc *rx_desc;
+	u16 ntu = rx_ring->next_to_use;
+	u16 total_count = count;
+	struct xdp_buff **xdp;
+
+	rx_desc = IGB_RX_DESC(rx_ring, ntu);
+	xdp = &rx_ring->rx_buffer_info_zc[ntu];
+
+	if (ntu + count >= rx_ring->count) {
+		nb_buffs_extra = igb_fill_rx_descs(xsk_pool, xdp, rx_desc,
+						   rx_ring->count - ntu);
+		if (nb_buffs_extra != rx_ring->count - ntu) {
+			ntu += nb_buffs_extra;
+			goto exit;
+		}
+		rx_desc = IGB_RX_DESC(rx_ring, 0);
+		xdp = rx_ring->rx_buffer_info_zc;
+		ntu = 0;
+		count -= nb_buffs_extra;
+	}
+
+	nb_buffs = igb_fill_rx_descs(xsk_pool, xdp, rx_desc, count);
+	ntu += nb_buffs;
+	if (ntu == rx_ring->count)
+		ntu = 0;
+
+	/* clear the length for the next_to_use descriptor */
+	rx_desc = IGB_RX_DESC(rx_ring, ntu);
+	rx_desc->wb.upper.length = 0;
+
+exit:
+	if (rx_ring->next_to_use != ntu) {
+		rx_ring->next_to_use = ntu;
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64).
+		 */
+		wmb();
+		writel(ntu, rx_ring->tail);
+	}
+
+	return total_count == (nb_buffs + nb_buffs_extra);
+}
+
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
+{
+	u16 ntc = rx_ring->next_to_clean;
+	u16 ntu = rx_ring->next_to_use;
+
+	while (ntc != ntu) {
+		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
+
+		xsk_buff_free(xdp);
+		ntc++;
+		if (ntc >= rx_ring->count)
+			ntc = 0;
+	}
+}
+
+static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
+					    struct xdp_buff *xdp,
+					    ktime_t timestamp)
+{
+	unsigned int totalsize = xdp->data_end - xdp->data_meta;
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+
+	net_prefetch(xdp->data_meta);
+
+	/* allocate a skb to store the frags */
+	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
+	if (unlikely(!skb))
+		return NULL;
+
+	if (timestamp)
+		skb_hwtstamps(skb)->hwtstamp = timestamp;
+
+	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
+	       ALIGN(totalsize, sizeof(long)));
+
+	if (metasize) {
+		skb_metadata_set(skb, metasize);
+		__skb_pull(skb, metasize);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *igb_run_xdp_zc(struct igb_adapter *adapter,
+				      struct igb_ring *rx_ring,
+				      struct xdp_buff *xdp,
+				      struct xsk_buff_pool *xsk_pool,
+				      struct bpf_prog *xdp_prog)
+{
+	int err, result = IGB_XDP_PASS;
+	u32 act;
+
+	prefetchw(xdp->data_hard_start); /* xdp_frame write */
+
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+
+	if (likely(act == XDP_REDIRECT)) {
+		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
+		if (!err) {
+			result = IGB_XDP_REDIR;
+			goto xdp_out;
+		}
+
+		if (xsk_uses_need_wakeup(xsk_pool) &&
+		    err == -ENOBUFS)
+			result = IGB_XDP_EXIT;
+		else
+			result = IGB_XDP_CONSUMED;
+		goto out_failure;
+	}
+
+	switch (act) {
+	case XDP_PASS:
+		break;
+	case XDP_TX:
+		result = igb_xdp_xmit_back(adapter, xdp);
+		if (result == IGB_XDP_CONSUMED)
+			goto out_failure;
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+out_failure:
+		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		result = IGB_XDP_CONSUMED;
+		break;
+	}
+xdp_out:
+	return ERR_PTR(-result);
+}
+
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
+			struct xsk_buff_pool *xsk_pool, const int budget)
+{
+	struct igb_adapter *adapter = q_vector->adapter;
+	unsigned int total_bytes = 0, total_packets = 0;
+	struct igb_ring *rx_ring = q_vector->rx.ring;
+	u32 ntc = rx_ring->next_to_clean;
+	struct bpf_prog *xdp_prog;
+	unsigned int xdp_xmit = 0;
+	bool failure = false;
+	u16 entries_to_alloc;
+	struct sk_buff *skb;
+
+	/* xdp_prog cannot be NULL in the ZC path */
+	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+
+	while (likely(total_packets < budget)) {
+		union e1000_adv_rx_desc *rx_desc;
+		ktime_t timestamp = 0;
+		struct xdp_buff *xdp;
+		unsigned int size;
+
+		rx_desc = IGB_RX_DESC(rx_ring, ntc);
+		size = le16_to_cpu(rx_desc->wb.upper.length);
+		if (!size)
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		dma_rmb();
+
+		xdp = rx_ring->rx_buffer_info_zc[ntc];
+		xsk_buff_set_size(xdp, size);
+		xsk_buff_dma_sync_for_cpu(xdp);
+
+		/* pull rx packet timestamp if available and valid */
+		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+			int ts_hdr_len;
+
+			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
+							 xdp->data,
+							 &timestamp);
+
+			xdp->data += ts_hdr_len;
+			xdp->data_meta += ts_hdr_len;
+			size -= ts_hdr_len;
+		}
+
+		skb = igb_run_xdp_zc(adapter, rx_ring, xdp, xsk_pool, xdp_prog);
+
+		if (IS_ERR(skb)) {
+			unsigned int xdp_res = -PTR_ERR(skb);
+
+			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
+				xdp_xmit |= xdp_res;
+			} else if (xdp_res == IGB_XDP_EXIT) {
+				failure = true;
+				break;
+			} else if (xdp_res == IGB_XDP_CONSUMED) {
+				xsk_buff_free(xdp);
+			}
+
+			total_packets++;
+			total_bytes += size;
+			ntc++;
+			if (ntc == rx_ring->count)
+				ntc = 0;
+			continue;
+		}
+
+		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
+
+		/* exit if we failed to retrieve a buffer */
+		if (!skb) {
+			rx_ring->rx_stats.alloc_failed++;
+			break;
+		}
+
+		xsk_buff_free(xdp);
+		ntc++;
+		if (ntc == rx_ring->count)
+			ntc = 0;
+
+		if (eth_skb_pad(skb))
+			continue;
+
+		/* probably a little skewed due to removing CRC */
+		total_bytes += skb->len;
+
+		/* populate checksum, timestamp, VLAN, and protocol */
+		igb_process_skb_fields(rx_ring, rx_desc, skb);
+
+		napi_gro_receive(&q_vector->napi, skb);
+
+		/* update budget accounting */
+		total_packets++;
+	}
+
+	rx_ring->next_to_clean = ntc;
+
+	if (xdp_xmit)
+		igb_finalize_xdp(adapter, xdp_xmit);
+
+	igb_update_rx_stats(q_vector, total_packets, total_bytes);
+
+	entries_to_alloc = igb_desc_unused(rx_ring);
+	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
+		failure |= !igb_alloc_rx_buffers_zc(rx_ring, xsk_pool,
+						    entries_to_alloc);
+
+	if (xsk_uses_need_wakeup(xsk_pool)) {
+		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+			xsk_set_rx_need_wakeup(xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(xsk_pool);
+
+		return (int)total_packets;
+	}
+	return failure ? budget : (int)total_packets;
+}
+
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);

-- 
2.39.5


