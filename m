Return-Path: <bpf+bounces-34637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041D92F764
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869B4B226AD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF9148825;
	Fri, 12 Jul 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kfsuBc/H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZV6NWZFC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B7143743;
	Fri, 12 Jul 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774558; cv=none; b=dGkIiFStE1dxqnvkusZ/Wt7GvyTpKeJb9bDK2Q/aY43ZFdiB4FoY43Vz8jhSTzApaqltFf5+YaGHcRRBXKHNeCh5jTPnOpEGifZZBWngkEJVwt1kzvf7xaeM85A21P1OETIlBdbgVIk7/juqeOs6kn3XuR6pK1mdZo+lh4vER3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774558; c=relaxed/simple;
	bh=UX1K7CpwwnkV0dv4J8rDelcJkGDraY0qj0GGxYz+YHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZADjeD2cBLw/d/Y2N1lMzzZnNZDdusf1k1gJqRcNQHsAyXAsZRf6kwN9Izxwf1FoDgpjZ/76+YQ2AaHVYcZ8NgN11P0O/tMZEDuOJEfx/cXnAfiz1yD3aA2nBg4Y0z237o0L4LeL9hIZ6dbhDtolaPJs8YhTLcwSi7W5urCIEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kfsuBc/H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZV6NWZFC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720774554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssrE1dENjYOWX+omaQIOEmmXuhB42nS6FGCvY6DG/YA=;
	b=kfsuBc/HI0BxZ7eW3Paw0zo9bA2yzaGAls2TBsk5NWEXdmVHe1T39D0ZJsono0bNn9+bkK
	k0ZUNb9IM+UbDx0IDuvbog+9IrGKUWgzOcM7crhhcBIkbwVruJE73JuhGAN0bNNr3AG+6R
	w11Z7K4t9yNMjJwhAkrXyFxeMd4r9dL8m1JFIiwsKlgKpr/O9idyaV4S1Bb7/9Ns5VuWFI
	sVTVXtRPX5v78QGSxbzVOhZiPZxkqrwUjT4NSAdaZQKT+I069RxqDMVeNdumLWHUh7xuSZ
	tyHlmcCh2pzJYiPyiZ5BHjpn/Zevrhyo8cECuNvmFKrfeGvc1E0GBSgDWhWcdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720774554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssrE1dENjYOWX+omaQIOEmmXuhB42nS6FGCvY6DG/YA=;
	b=ZV6NWZFC2JB884RYw5Ai5L7jS97qaHoyzJaF6giDmynSD3tlhKFuSgccvR8dVMeXg9JLJ7
	eqbs5AidcOdRAfAw==
Date: Fri, 12 Jul 2024 10:55:31 +0200
Subject: [PATCH iwl-next v5 3/4] igb: add AF_XDP zero-copy Rx support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-igb_zero_copy-v5-3-f3f455113b11@linutronix.de>
References: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
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
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=17084; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=0JIgbz4/m8tYGtwWiNrFP+wsDia4eif+jduJm6RTo9U=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmkO+WBlTW9k3Hmo1/4DmvdYH2NWKc+BYMnNUqW
 U/2onvrWK2JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZpDvlgAKCRDBk9HyqkZz
 gubGD/4vabZ9jJ9V01emJ8nSYFvHbvxdT7wFUUR6vd2fC0BudOq8KFt39VXpFFlWuMy33VnBzqe
 5d2iYHoaPZXiCYSC7j1bfGhXhDGCZ5vUmM/RmzysJvQ4qs8dCiy9SPj34MapaNWUNr2QsPQjMb5
 J13ITjFraP3n4zRV+RXgRF/5inyBifpFx4ITu++ZiEKPzphPom+fSJiqL6LDg/AwvUCmJZ1/CpM
 MmdJFMgLLvIsJEn8oUtm1e8Ge387MPzgIy7LA6Qv1Sm8X2v2DFRe2RlQEJaqniVsC1/GOnAHVCM
 PO+h8fES8rYfwtdqiDIEKJ6G2DlMzfUZo/1fYHahmoK1ztTawTS2MFJEbLZWV2FX3p9cpl15Zyu
 bQYjL5bb8jWem5RXv2E3ADzxP20fPbE3d8zXkRowYE10+2SEbHifOTvL92jRtnsqMtgHDFdoR2k
 wVFsy3WqZRTUPKM09yFyt0Qoe/l5Fa73GBNlGHzgES2rD9WjGA8l+fD3zyZooaWQa+/UWdDNTky
 +E+wEWJ2l07Ryly4d6VBgAv3bY0bT7MNWGxOziWhyhzDhD1+zIJCut8L6T2l5jHcuULhgZDwROw
 A8Il3m0oJ1N81iu6hNSSFy4eec6tEQuFxiWJoR/z5k3LhT+4bDLBE8FCZfZds0ILDaHKrZRx1NM
 ngQ/U4HIR18/4ug==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Add support for AF_XDP zero-copy receive path.

When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
xsk buff pool using igb_alloc_rx_buffers_zc.

Use xsk_pool_get_rx_frame_size to set SRRCTL rx buf size when zero-copy
is enabled.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Port to v6.10 and provide napi_id for xdp_rxq_info_reg()]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c |  95 ++++++++---
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 261 +++++++++++++++++++++++++++++-
 3 files changed, 337 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 053130c01480..4983a6ec718e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -87,6 +87,7 @@ struct igb_adapter;
 #define IGB_XDP_CONSUMED	BIT(0)
 #define IGB_XDP_TX		BIT(1)
 #define IGB_XDP_REDIR		BIT(2)
+#define IGB_XDP_EXIT		BIT(3)
 
 struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
@@ -832,6 +833,9 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		       struct xsk_buff_pool *pool,
 		       u16 qid);
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 28abe9664c44..8d65c9eca102 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -473,12 +473,17 @@ static void igb_dump(struct igb_adapter *adapter)
 
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
@@ -498,11 +503,11 @@ static void igb_dump(struct igb_adapter *adapter)
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
@@ -1984,7 +1989,10 @@ static void igb_configure(struct igb_adapter *adapter)
 	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
-		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
+		if (ring->xsk_pool)
+			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring));
+		else
+			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
 	}
 }
 
@@ -3336,7 +3344,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
@@ -4424,7 +4433,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-			       rx_ring->queue_index, 0);
+			       rx_ring->queue_index,
+			       rx_ring->q_vector->napi.napi_id);
 	if (res < 0) {
 		dev_err(dev, "Failed to register xdp_rxq index %u\n",
 			rx_ring->queue_index);
@@ -4720,12 +4730,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
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
@@ -4757,9 +4772,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	u32 rxdctl = 0;
 
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
-	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					   MEM_TYPE_PAGE_SHARED, NULL));
 	ring->xsk_pool = igb_xsk_pool(adapter, ring);
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
@@ -4786,9 +4809,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
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
@@ -4975,8 +5001,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
 
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
@@ -5014,6 +5045,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
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
@@ -5041,6 +5077,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 			i = 0;
 	}
 
+skip_for_xsk:
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -8196,7 +8233,9 @@ static int igb_poll(struct napi_struct *napi, int budget)
 		clean_complete = igb_clean_tx_irq(q_vector, budget);
 
 	if (q_vector->rx.ring) {
-		int cleaned = igb_clean_rx_irq(q_vector, budget);
+		int cleaned = q_vector->rx.ring->xsk_pool ?
+			igb_clean_rx_irq_zc(q_vector, budget) :
+			igb_clean_rx_irq(q_vector, budget);
 
 		work_done += cleaned;
 		if (cleaned >= budget)
@@ -8604,8 +8643,15 @@ struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
-		if (err)
+		if (err) {
+			if (rx_ring->xsk_pool &&
+			    xsk_uses_need_wakeup(rx_ring->xsk_pool) &&
+			    err == -ENOBUFS)
+				result = IGB_XDP_EXIT;
+			else
+				result = IGB_XDP_CONSUMED;
 			goto out_failure;
+		}
 		result = IGB_XDP_REDIR;
 		break;
 	default:
@@ -8862,12 +8908,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
+	unsigned int total_bytes = 0, total_packets = 0;
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
-	struct sk_buff *skb = rx_ring->skb;
-	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
+	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8995,7 +9043,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 925bf97f7caa..66cdc30e9b6e 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -66,7 +66,10 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 	 * at least 1 descriptor unused to make sure
 	 * next_to_use != next_to_clean
 	 */
-	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+	if (rx_ring->xsk_pool)
+		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring));
+	else
+		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
 
 	/* Rx/Tx share the same napi context. */
 	napi_enable(&rx_ring->q_vector->napi);
@@ -172,6 +175,262 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
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
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
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
+		nb_buffs_extra = igb_fill_rx_descs(rx_ring->xsk_pool, xdp,
+						   rx_desc,
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
+	nb_buffs = igb_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
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
+static void igb_update_ntc(struct igb_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	/* fetch, update, and store next to clean */
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+
+	prefetch(IGB_RX_DESC(rx_ring, ntc));
+}
+
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget)
+{
+	struct igb_adapter *adapter = q_vector->adapter;
+	unsigned int total_bytes = 0, total_packets = 0;
+	struct igb_ring *rx_ring = q_vector->rx.ring;
+	int cpu = smp_processor_id();
+	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
+	bool failure = false;
+	u16 entries_to_alloc;
+	struct sk_buff *skb;
+
+	while (likely(total_packets < budget)) {
+		union e1000_adv_rx_desc *rx_desc;
+		struct xdp_buff *xdp;
+		ktime_t timestamp = 0;
+		unsigned int size;
+
+		rx_desc = IGB_RX_DESC(rx_ring, rx_ring->next_to_clean);
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
+		xdp = rx_ring->rx_buffer_info_zc[rx_ring->next_to_clean];
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
+		skb = igb_run_xdp(adapter, rx_ring, xdp);
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
+
+			igb_update_ntc(rx_ring);
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
+		igb_update_ntc(rx_ring);
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
+	if (xdp_xmit & IGB_XDP_REDIR)
+		xdp_do_flush();
+
+	if (xdp_xmit & IGB_XDP_TX) {
+		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
+
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
+		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
+	}
+
+	u64_stats_update_begin(&rx_ring->rx_syncp);
+	rx_ring->rx_stats.packets += total_packets;
+	rx_ring->rx_stats.bytes += total_bytes;
+	u64_stats_update_end(&rx_ring->rx_syncp);
+	q_vector->rx.total_packets += total_packets;
+	q_vector->rx.total_bytes += total_bytes;
+
+	entries_to_alloc = igb_desc_unused(rx_ring);
+	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
+		failure |= !igb_alloc_rx_buffers_zc(rx_ring, entries_to_alloc);
+
+	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
+		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+			xsk_set_rx_need_wakeup(rx_ring->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rx_ring->xsk_pool);
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
2.39.2


