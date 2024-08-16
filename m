Return-Path: <bpf+bounces-37357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9237295456B
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4110B21CD6
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79DF145A03;
	Fri, 16 Aug 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldmwSP7l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqyEh+An"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D613F426;
	Fri, 16 Aug 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800256; cv=none; b=ULeSbUsSfxX/E0CPFKILqZdv1dWvcMkve3y/AHcC60n1mqMPAoYYDmkAgIS4+f69JxyHKo6X6wIdhAY32ihhpL44irBMNQ34NKBihGm6SiS/1PH4k/LYUxovkCTFydDA3dgKBbtvK2oNI1Go3PKGt7lfbdiszQDNI37pVE/1ZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800256; c=relaxed/simple;
	bh=zwqVV72Zbny6oJwgOYdzdOqVoBp8a4C1br611q5SXXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/rs70uNDXdZy6dHTMl2pXiY+fJncdSFIWXdFoWsHxQpUBkUKbj0enCKY1m3JVOS2XPe4rd95LRZD3Ki88Q8Uqn5nP9KW3P53AzFLxABg5MvSZqd9YLpsQa+1ccvPZoXyADaq7wev41UWnN7EII+3Jl0In0qQPAwhFEWOUPHzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldmwSP7l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqyEh+An; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723800247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RaBDnckgLsEADXQ5SmWoAlA9svRPFOwL49saaqXgkw=;
	b=ldmwSP7laHsNK8fZ8Eb9KmgHBaF0JKP40CNNJ4lphatYBIDbfRSOhR+DMKM6QuC3p0/Okp
	USxSM1aqDNd2NkLQV2cJf1FAyVTxgOkiEQ3TRzMYbY8xjbcZoYDRLGT0EfdG0z/aimQLh4
	pjfz3DfliSTLejWslvvUlsfPzee2pmnEvxdXmClP8ANHLwcymAFqNL8NrK4pCHFzvmO14B
	eaGT+eLuUWLBR6MmbdGEwMXjmFtzwXKIbOfWSc0+4/o93f095sg8OWWiyTFVyZbwUEhPyo
	/giIBL293Pd4eb4Nq8Q3Rb+bdAptPrB7SOgplDx8HNtKBetYnVc0u+qrG16GoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723800247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RaBDnckgLsEADXQ5SmWoAlA9svRPFOwL49saaqXgkw=;
	b=NqyEh+AnRixwFos1pA6pmbaSxp466dPyPahBqt9mbt4QUBuV0/Las2pFm5hfI8XJ7xTGmn
	UwWI6EtnmXc3T2CA==
Date: Fri, 16 Aug 2024 11:24:03 +0200
Subject: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10214; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=RKBGCq7JD2rG3Y9Ymi6uliDDlkk8sghR1sc8hDYXu1w=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmvxqy0i3lA7k2UlCI2iIs3y43SStz0NiVlN9/R
 F1H1tyOL/yJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZr8asgAKCRDBk9HyqkZz
 gpZmD/9x1W+FaTDDaCkxXg+q2smJuZVPJQKb4xVdzudULPB1uUeiDWD0EByoY3r4eAuGX1dy7py
 zMkH1NwSnNiCFuLzeK+VizI7lLk4PFfhFDV6WSGo4T3vVTn9oA3UWZrJuUciEXbflNkht77qjX2
 n5OT1FMOnNXliSXa3vvpfGOTwzH5YxVdYbO87zccH/dw5I9OeqLTNJmj3QBjSfmVFM7aw4TBJkB
 eOH1Fp8SzFaISTIUIDSIfq9f6cESfCgTCO/Xa9PwMTMo+xgw4cSZHaKfaBW9oNqNJj1og6NJdAq
 IJUl8QuEjf3dG54Xxb6EeGxq2AC8RZwR/Ejfuo1HPHn9w8qHOVFRneb8cFP0clTwmFYY2KJySMD
 YlmP2yI43/jEakG8oK0zh/+buf0ECh5wEbD41UTFjQ+9Egu9dZtiASvQhMSl7cVvPxM2zfnz7MP
 CO+d+vr75yu4eBHophJC8/wh3LlPTh+lOKdtrd3/kK8igC0FB/0U/AmjDSNVSc6EOSnASyDE1TY
 ZAUxsEA954Ar35n6tA21mEEykH6SQjHJrRkBzS+Q0YtJfJEjfGaz8wemXYSm30TeA0QRvumUPyo
 vcGrEl0wmcncSzBDhPVxfa86uKPT/5yBp4QAauXcJLdCB6xJF09dNU6/92gH1U5fUnh8wJrVABm
 6/PQ9eXfTCxFmng==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Add the following ring flag:
- IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)

Add a xdp_buff array for use with XSK receive batch API, and a pointer
to xsk_pool in igb_adapter.

Add enable/disable functions for TX and RX rings.
Add enable/disable functions for XSK pool.
Add xsk wakeup function.

None of the above functionality will be active until
NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Add READ/WRITE_ONCE(), synchronize_net(),
       remove IGB_RING_FLAG_AF_XDP_ZC]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  13 +-
 drivers/net/ethernet/intel/igb/igb_main.c |   9 ++
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 207 ++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
index 463c0d26b9d4..6c1b702fd992 100644
--- a/drivers/net/ethernet/intel/igb/Makefile
+++ b/drivers/net/ethernet/intel/igb/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_IGB) += igb.o
 
 igb-y := igb_main.o igb_ethtool.o e1000_82575.o \
 	 e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
-	 e1000_i210.o igb_ptp.o igb_hwmon.o
+	 e1000_i210.o igb_ptp.o igb_hwmon.o igb_xsk.o
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index dbba193241b9..8db5b44b4576 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 struct igb_adapter;
 
@@ -320,6 +321,7 @@ struct igb_ring {
 	union {				/* array of buffer info structs */
 		struct igb_tx_buffer *tx_buffer_info;
 		struct igb_rx_buffer *rx_buffer_info;
+		struct xdp_buff **rx_buffer_info_zc;
 	};
 	void *desc;			/* descriptor ring memory */
 	unsigned long flags;		/* ring specific flags */
@@ -357,6 +359,7 @@ struct igb_ring {
 		};
 	};
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
 } ____cacheline_internodealigned_in_smp;
 
 struct igb_q_vector {
@@ -384,7 +387,8 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
-	IGB_RING_FLAG_TX_DETECT_HANG
+	IGB_RING_FLAG_TX_DETECT_HANG,
+	IGB_RING_FLAG_TX_DISABLED
 };
 
 #define ring_uses_large_buffer(ring) \
@@ -820,4 +824,11 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
 int igb_del_mac_steering_filter(struct igb_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags);
 
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring);
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid);
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index db1598876424..9234c768a600 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2904,9 +2904,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 
 static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
+	struct igb_adapter *adapter = netdev_priv(dev);
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return igb_xdp_setup(dev, xdp);
+	case XDP_SETUP_XSK_POOL:
+		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
+					  xdp->xsk.queue_id);
 	default:
 		return -EINVAL;
 	}
@@ -3035,6 +3040,7 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_setup_tc		= igb_setup_tc,
 	.ndo_bpf		= igb_xdp,
 	.ndo_xdp_xmit		= igb_xdp_xmit,
+	.ndo_xsk_wakeup         = igb_xsk_wakeup,
 };
 
 /**
@@ -4357,6 +4363,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
+	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
+
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -4752,6 +4760,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
 	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 					   MEM_TYPE_PAGE_SHARED, NULL));
+	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
new file mode 100644
index 000000000000..7b632be3e7e3
--- /dev/null
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2018 Intel Corporation. */
+
+#include <linux/bpf_trace.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xdp.h>
+
+#include "e1000_hw.h"
+#include "igb.h"
+
+static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
+{
+	int size = pool_present ?
+		sizeof(*ring->rx_buffer_info_zc) * ring->count :
+		sizeof(*ring->rx_buffer_info) * ring->count;
+	void *buff_info = vmalloc(size);
+
+	if (!buff_info)
+		return -ENOMEM;
+
+	if (pool_present) {
+		vfree(ring->rx_buffer_info);
+		ring->rx_buffer_info = NULL;
+		ring->rx_buffer_info_zc = buff_info;
+	} else {
+		vfree(ring->rx_buffer_info_zc);
+		ring->rx_buffer_info_zc = NULL;
+		ring->rx_buffer_info = buff_info;
+	}
+
+	return 0;
+}
+
+static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+	struct e1000_hw *hw = &adapter->hw;
+
+	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+
+	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
+
+	synchronize_net();
+
+	/* Rx/Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
+	igb_clean_tx_ring(tx_ring);
+	igb_clean_rx_ring(rx_ring);
+
+	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
+	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
+}
+
+static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+
+	igb_configure_tx_ring(adapter, tx_ring);
+	igb_configure_rx_ring(adapter, rx_ring);
+
+	synchronize_net();
+
+	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+
+	/* call igb_desc_unused which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean
+	 */
+	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+
+	/* Rx/Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+}
+
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring)
+{
+	int qid = ring->queue_index;
+	struct xsk_buff_pool *pool;
+
+	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
+
+	if (!igb_xdp_is_enabled(adapter))
+		return NULL;
+
+	return (pool && pool->dev) ? pool : NULL;
+}
+
+static int igb_xsk_pool_enable(struct igb_adapter *adapter,
+			       struct xsk_buff_pool *pool,
+			       u16 qid)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct igb_ring *rx_ring;
+	bool if_running;
+	int err;
+
+	if (qid >= adapter->num_rx_queues)
+		return -EINVAL;
+
+	if (qid >= netdev->real_num_rx_queues ||
+	    qid >= netdev->real_num_tx_queues)
+		return -EINVAL;
+
+	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
+	if (err)
+		return err;
+
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	if (if_running) {
+		err = igb_realloc_rx_buffer_info(rx_ring, true);
+		if (!err) {
+			igb_txrx_ring_enable(adapter, qid);
+			/* Kick start the NAPI context so that receiving will start */
+			err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
+		}
+
+		if (err) {
+			xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct xsk_buff_pool *pool;
+	struct igb_ring *rx_ring;
+	bool if_running;
+	int err;
+
+	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+
+	if (if_running) {
+		err = igb_realloc_rx_buffer_info(rx_ring, false);
+		if (err)
+			return err;
+
+		igb_txrx_ring_enable(adapter, qid);
+	}
+
+	return 0;
+}
+
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid)
+{
+	return pool ? igb_xsk_pool_enable(adapter, pool, qid) :
+		igb_xsk_pool_disable(adapter, qid);
+}
+
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
+{
+	struct igb_adapter *adapter = netdev_priv(dev);
+	struct e1000_hw *hw = &adapter->hw;
+	struct igb_ring *ring;
+	u32 eics = 0;
+
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return -ENETDOWN;
+
+	if (!igb_xdp_is_enabled(adapter))
+		return -EINVAL;
+
+	if (qid >= adapter->num_tx_queues)
+		return -EINVAL;
+
+	ring = adapter->tx_ring[qid];
+
+	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
+		return -ENETDOWN;
+
+	if (!READ_ONCE(ring->xsk_pool))
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
+		/* Cause software interrupt */
+		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
+			eics |= ring->q_vector->eims_value;
+			wr32(E1000_EICS, eics);
+		} else {
+			wr32(E1000_ICS, E1000_ICS_RXDMT0);
+		}
+	}
+
+	return 0;
+}

-- 
2.39.2


