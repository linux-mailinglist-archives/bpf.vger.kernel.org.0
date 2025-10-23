Return-Path: <bpf+bounces-71882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E48C00502
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 11:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8717F3B00C0
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F022EC0B1;
	Thu, 23 Oct 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xEujc/4M"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7606309DB1;
	Thu, 23 Oct 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212430; cv=none; b=cGz7XuGiA/Qb0pnj87IqZiN2IwroVbvKKM3MjBaydSqwzQl0u7a0iXak0sF95j+4vTiyPrUfUVdTQTSvsa8F5KkkK2+W2UaTp5vtRIa+GPafSrWvIlE35RyR9wG/O1QaVTCzv3+cFEqgQNA+OThpKbqNg2sUXmZToCDYfmyFpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212430; c=relaxed/simple;
	bh=baYvyIqqOz03lfMkEWIGND3X08CzjFSUeAkinaL8bV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfx1gS3/B69tbXyOY2aw3I5YhDIbeNhy7E9RWIHUg+pPl8oQXnYYhuo00QNTOxtyXbD6ypKQI+zjv+IYhaL+OGo/kN3ea4kHYSMpcfkNh4ecYBu5v3heEfkw4GCplNR03zK4fEOpzxJKV82Gdhjm2+ERcsy2KgvXg/F70aHn9ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xEujc/4M; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59N9dfOw496853;
	Thu, 23 Oct 2025 04:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761212381;
	bh=R+uhaQsqo33IznYaS1WEGxKoUqICz9fNXvBuRUlWTws=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xEujc/4M+Y9osvpqUTJtxdca1UjFLUkKJ7hk/wN+1wb5PjNeOu1PnP4Q/dCpKn4oG
	 fkx7iXHb4XLxIa3wVS4rf7fY3aDBFZWKAwYIfIXYi3w+Rx7Cx1XhF+C90EGU0qLa5W
	 10/vZ/Y+X8pCOUh26JXdKqC2tO8NnGpk3ij9aN+o=
Received: from DFLE214.ent.ti.com (dfle214.ent.ti.com [10.64.6.72])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59N9dfsO3036315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 04:39:41 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 04:39:40 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 04:39:40 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59N9defB146926;
	Thu, 23 Oct 2025 04:39:40 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 59N9ddV0014019;
	Thu, 23 Oct 2025 04:39:40 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <horms@kernel.org>, <namcao@linutronix.de>, <vadim.fedorenko@linux.dev>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v4 2/6] net: ti: icssg-prueth: Add XSK pool helpers
Date: Thu, 23 Oct 2025 15:09:23 +0530
Message-ID: <20251023093927.1878411-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023093927.1878411-1-m-malladi@ti.com>
References: <20251023093927.1878411-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Implement XSK NDOs (setup, wakeup) and create XSK
Rx and Tx queues. xsk_qid stores the queue id for
a given port which has been registered for zero copy
AF_XDP and used to acquire UMEM pointer if registered.

Based on the xsk_qid and the xsk_pool (umem) the driver
is either in copy or zero copy mode. In case of copy mode
the xsk_qid value will be invalid and will be set to valid
queue id when enabling zero copy. To enable zero copy, the
Rx queues are destroyed, i.e., descriptors pushed to fq
and cq are freed to remap them to xdp buffers from the umem.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 138 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  10 ++
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 94021751b6b7..cc52cff70d7e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -754,7 +754,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	}
 
 	pa = page_address(page);
-	if (emac->xdp_prog) {
+	if (prueth_xdp_is_enabled(emac)) {
 		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index fa2d0bd329ab..fcdc1d0a004b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -47,6 +47,9 @@
 						 NETIF_F_HW_HSR_TAG_INS | \
 						 NETIF_F_HW_HSR_TAG_RM)
 
+#define PRUETH_RX_DMA_ATTR			(DMA_ATTR_SKIP_CPU_SYNC |\
+						 DMA_ATTR_WEAK_ORDERING)
+
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
@@ -735,6 +738,20 @@ static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
 	return 0;
 }
 
+static void prueth_set_xsk_pool(struct prueth_emac *emac, u16 queue_id)
+{
+	struct prueth_tx_chn *tx_chn = &emac->tx_chns[queue_id];
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+
+	if (emac->xsk_qid != queue_id) {
+		rx_chn->xsk_pool = NULL;
+		tx_chn->xsk_pool = NULL;
+	} else {
+		rx_chn->xsk_pool = xsk_get_pool_from_qid(emac->ndev, queue_id);
+		tx_chn->xsk_pool = xsk_get_pool_from_qid(emac->ndev, queue_id);
+	}
+}
+
 static void prueth_destroy_txq(struct prueth_emac *emac)
 {
 	int ret, i;
@@ -875,6 +892,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
+	emac->xsk_qid = -EINVAL;
 	init_completion(&emac->cmd_complete);
 	ret = prueth_init_tx_chns(emac);
 	if (ret) {
@@ -1200,6 +1218,109 @@ static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
 	return 0;
 }
 
+static int prueth_xsk_pool_enable(struct prueth_emac *emac,
+				  struct xsk_buff_pool *pool, u16 queue_id)
+{
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	u32 frame_size;
+	int ret;
+
+	if (queue_id >= PRUETH_MAX_RX_FLOWS ||
+	    queue_id >= emac->tx_ch_num) {
+		netdev_err(emac->ndev, "Invalid XSK queue ID %d\n", queue_id);
+		return -EINVAL;
+	}
+
+	frame_size = xsk_pool_get_rx_frame_size(pool);
+	if (frame_size < PRUETH_MAX_PKT_SIZE)
+		return -EOPNOTSUPP;
+
+	ret = xsk_pool_dma_map(pool, rx_chn->dma_dev, PRUETH_RX_DMA_ATTR);
+	if (ret) {
+		netdev_err(emac->ndev, "Failed to map XSK pool: %d\n", ret);
+		return ret;
+	}
+
+	if (netif_running(emac->ndev)) {
+		/* stop packets from wire for graceful teardown */
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
+		if (ret)
+			return ret;
+		prueth_destroy_rxq(emac);
+	}
+
+	emac->xsk_qid = queue_id;
+	prueth_set_xsk_pool(emac, queue_id);
+
+	if (netif_running(emac->ndev)) {
+		ret = prueth_create_rxq(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
+			return ret;
+		}
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+		if (ret) {
+			prueth_destroy_rxq(emac);
+			return ret;
+		}
+		ret = prueth_xsk_wakeup(emac->ndev, queue_id, XDP_WAKEUP_RX);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
+{
+	struct xsk_buff_pool *pool;
+	int ret;
+
+	if (queue_id >= PRUETH_MAX_RX_FLOWS ||
+	    queue_id >= emac->tx_ch_num) {
+		netdev_err(emac->ndev, "Invalid XSK queue ID %d\n", queue_id);
+		return -EINVAL;
+	}
+
+	if (emac->xsk_qid != queue_id) {
+		netdev_err(emac->ndev, "XSK queue ID %d not registered\n", queue_id);
+		return -EINVAL;
+	}
+
+	pool = xsk_get_pool_from_qid(emac->ndev, queue_id);
+	if (!pool) {
+		netdev_err(emac->ndev, "No XSK pool registered for queue %d\n", queue_id);
+		return -EINVAL;
+	}
+
+	if (netif_running(emac->ndev)) {
+		/* stop packets from wire for graceful teardown */
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
+		if (ret)
+			return ret;
+		prueth_destroy_rxq(emac);
+	}
+
+	xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
+	emac->xsk_qid = -EINVAL;
+	prueth_set_xsk_pool(emac, queue_id);
+
+	if (netif_running(emac->ndev)) {
+		ret = prueth_create_rxq(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
+			return ret;
+		}
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+		if (ret) {
+			prueth_destroy_rxq(emac);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * emac_ndo_bpf - implements ndo_bpf for icssg_prueth
  * @ndev: network adapter device
@@ -1214,11 +1335,27 @@ static int emac_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
 		return emac_xdp_setup(emac, bpf);
+	case XDP_SETUP_XSK_POOL:
+		return bpf->xsk.pool ?
+			prueth_xsk_pool_enable(emac, bpf->xsk.pool, bpf->xsk.queue_id) :
+			prueth_xsk_pool_disable(emac, bpf->xsk.queue_id);
 	default:
 		return -EINVAL;
 	}
 }
 
+int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (qid >= PRUETH_MAX_RX_FLOWS || qid >= emac->tx_ch_num) {
+		netdev_err(ndev, "Invalid XSK queue ID %d\n", qid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -1237,6 +1374,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_xdp_xmit = emac_xdp_xmit,
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
+	.ndo_xsk_wakeup = prueth_xsk_wakeup,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5cc90b66035a..a5e3774b0388 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -38,6 +38,8 @@
 #include <net/devlink.h>
 #include <net/xdp.h>
 #include <net/page_pool/helpers.h>
+#include <net/xsk_buff_pool.h>
+#include <net/xdp_sock_drv.h>
 
 #include "icssg_config.h"
 #include "icss_iep.h"
@@ -126,6 +128,7 @@ struct prueth_tx_chn {
 	char name[32];
 	struct hrtimer tx_hrtimer;
 	unsigned long tx_pace_timeout_ns;
+	struct xsk_buff_pool *xsk_pool;
 };
 
 struct prueth_rx_chn {
@@ -138,6 +141,7 @@ struct prueth_rx_chn {
 	char name[32];
 	struct page_pool *pg_pool;
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
 };
 
 enum prueth_swdata_type {
@@ -241,6 +245,7 @@ struct prueth_emac {
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
+	int xsk_qid;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -503,5 +508,10 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 			unsigned int q_idx);
 void prueth_rx_cleanup(void *data, dma_addr_t desc_dma);
 void prueth_tx_cleanup(void *data, dma_addr_t desc_dma);
+int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags);
+static inline bool prueth_xdp_is_enabled(struct prueth_emac *emac)
+{
+	return !!READ_ONCE(emac->xdp_prog);
+}
 
 #endif /* __NET_TI_ICSSG_PRUETH_H */
-- 
2.43.0


