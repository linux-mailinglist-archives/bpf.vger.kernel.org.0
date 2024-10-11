Return-Path: <bpf+bounces-41730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C7999F9E
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB93FB21A70
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432B20CCF4;
	Fri, 11 Oct 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gWkLflfx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlvPtJEK"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6F1F1309;
	Fri, 11 Oct 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637274; cv=none; b=igCip5NxO01jgRbYxNr3rxLkN3KvcXQ8wlf3fpM20Hxt9u67Mpuf6BNFdW9njq1712ozH+mJXTURNWSdQmqTW5M1lo/LmBE4jcD9+6/DUh82T1aIP8uqGCKOnzBGevbVXWteka8ypSTeu/DWtV1dQde3Rxfg6gQJMWOdBrEtNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637274; c=relaxed/simple;
	bh=74jsZ+62mr+a1yqXV0NUvAoSViZ47MBnqpPQR73bTxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qV7uMHztCiwH3D6uFkb5xIIqr6A1Al2J3V98xzvqTCfL2GjL+w/lYBzDhgDzR/5VoGGzdADiLy1t7figCuvtnwS+G6NPr56DHYQsh8wQdFUv+hc7XGet76wmApE7KnCTjGw0zu6EHL+4pp2d0yY2nIEkLa2AbH45syeHI+IvgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gWkLflfx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlvPtJEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728637271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2bTcW6y0QDgJnpnRNaBgyP6IWxETDf7zUSTCoSVLmY=;
	b=gWkLflfxQ6gBvK/jC5dxGlJ66OUyr+ibg7lqMcgJD3xTR2RBm/+Bzqy6oO7p7fbI6JAWvF
	H7r1ahA/XwdBgYfdMalLnoMkun7PNX6TR6ogv3munzWOhwmXfQpqlQ3+PSZqvLaB+6OTZF
	N47cnfdJkCySdC/6O0wfC9KmwUgYPvIizrTVLR+kDUrSsN+UErxASGig6WmtqGdsWtECnF
	PYCahA7K3L9BpqjtRWsR0TF1EWdU8+u45N2SwHYHmvwV+E7BH1ot+sq3tEfi8AA/0n6or0
	OslaCLsEM494pMJW9uaxa3UEH8Or8rt97GCjHVdaWq31j2fNRcTigsXlrlUtrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728637271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2bTcW6y0QDgJnpnRNaBgyP6IWxETDf7zUSTCoSVLmY=;
	b=zlvPtJEK6RIIUcK8OF4O0ONW9Smyds3VlarvESUl5KPX42AL6pgARLinxTptnczs2BF64K
	SpPPlAjzgCZF6pBw==
Date: Fri, 11 Oct 2024 11:01:01 +0200
Subject: [PATCH iwl-next v8 3/6] igb: Introduce XSK data structures and
 helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-b4-igb_zero_copy-v8-3-83862f726a9e@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10281; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=uEb/YZ+77KZ/pXdt1cbkwtAciGe8zlGUYa+Zl1o9MWc=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnCOlT1aRtXWUOZqQjoPhj67k9kjT93Q+tyPok3
 1FANPY4CZuJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwjpUwAKCRDBk9HyqkZz
 glB8D/wMchq8KrpbmIVr2oNK+ZtGRnoKaCgLvhDxKc2Gf4cP198wDNMlx1AOMbgQU74Dmeg/LR0
 Dc2Op1pk+53CeEWOsu1yMXpwPKGar+NARmFKNMN0IlPVaWJ3SGJoA2gzcsN6FleaM3BgMAfFtYB
 fF/NydAimAnvfHK3G05eRW5u/hTxqEuFaD860w9YwAnHtEOIPIpXs548MnY/xdVQs8sKSFfow+R
 n2ynEmuT3oLAXQo7hDkKvBOcbAEn4x5AsqaA27wO2mgVujfj+zwdyHNh2011ehNdhdLZ2iq7cEc
 dPSYhbWGbNDcgxU2eLz3Pq2oCw4fPvv1T0tS0NgSAYLAoc3Ufb5aTV6otsPp7gVukpJS18urgFP
 TEqAyzeVLokGFQ/K16yc/5x+JYKnNUjJonZw7Aa6c71t0VpWRLXMCA8PA4iIPDjm86/CtzLkrG2
 ubh/cuCrxOiW1ruj5BlP5PcNmh5Vy/zE3PVinjUD0WPg/hJxJaQjJBggVo9cxVPVFC3iXfHkj9u
 xGbnZwhEMD1PkN9U3B2nIoClb2hVEehiLieaYhZ0Ga6B7gn6u1mDUmgtQJx9kHwiB2HQVNKOtn1
 yj0wkiNiIxHIDPC5+5/UgIlXDG4TFuaa2STOug9+ypjoFfgymeDvxECszOD7fGmWrcg68Ul7Oow
 pmDpo9LcIT8akMw==
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
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
index 6e2b61ecff68..c30d6f9708f8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 struct igb_adapter;
 
@@ -321,6 +322,7 @@ struct igb_ring {
 	union {				/* array of buffer info structs */
 		struct igb_tx_buffer *tx_buffer_info;
 		struct igb_rx_buffer *rx_buffer_info;
+		struct xdp_buff **rx_buffer_info_zc;
 	};
 	void *desc;			/* descriptor ring memory */
 	unsigned long flags;		/* ring specific flags */
@@ -358,6 +360,7 @@ struct igb_ring {
 		};
 	};
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
 } ____cacheline_internodealigned_in_smp;
 
 struct igb_q_vector {
@@ -385,7 +388,8 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
-	IGB_RING_FLAG_TX_DETECT_HANG
+	IGB_RING_FLAG_TX_DETECT_HANG,
+	IGB_RING_FLAG_TX_DISABLED
 };
 
 #define ring_uses_large_buffer(ring) \
@@ -841,4 +845,11 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
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
index fc30966282c5..341b83e39019 100644
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
@@ -3015,6 +3020,7 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_setup_tc		= igb_setup_tc,
 	.ndo_bpf		= igb_xdp,
 	.ndo_xdp_xmit		= igb_xdp_xmit,
+	.ndo_xsk_wakeup         = igb_xsk_wakeup,
 };
 
 /**
@@ -4337,6 +4343,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
+	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
+
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -4732,6 +4740,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
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
2.39.5


