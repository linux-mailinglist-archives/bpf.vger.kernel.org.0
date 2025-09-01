Return-Path: <bpf+bounces-67089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F29B3DF7E
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF561188D001
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B130E834;
	Mon,  1 Sep 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cnv71cRR"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA21DF252;
	Mon,  1 Sep 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721007; cv=none; b=n5cB97jlapAWEGtQSh1OZq4qCiLGMeCfx5GisgWvkbekslyYT8cjJyU+ow1k/Fm3uhJD0lQ8JxbBlNsFNjQAz87+4vRSGoRPJjZAtznE3F75zjcUykKxHIH356ED7qdnTkX+NM1Q+M5K26IHVxq/A+QNhYr0qtVvF7eNh8/8Ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721007; c=relaxed/simple;
	bh=bGS8v1J0b0p1K9U2TIIgdW5uPN7uV7zVYPo2qQUOfuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iINsVgdSJ9Wq/PEVUwuij+1dgiPlPIn3VdDULh+EC2WQm5xeiAnsFCvhnN0TwFwVoC70t9uKKaxxspIVCQ7k4pOssoPqawZIectPp1Oidy5o8BnoQHB3OPv4Ffr3NlfQRk80vPWrf0oIX/+b/zxfFT90rSJuXf1B+tUw9dy9GUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cnv71cRR; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581A2edR2348382;
	Mon, 1 Sep 2025 05:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756720960;
	bh=Og393ppvo7xj6OyQpMypbOVc0Nkv4L0thZQ4Z83MSdQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Cnv71cRRKXRwN1hsTBD0rS/4HJBdwPDFdj6FkPUGQy86nTH1TqSz5tL7ebYzLgtVn
	 o3FTBALLFVvB+byCvhovrmHg78TAc21pol2SVZJSsbfy8+dZbO4s84FogzLKjWFtxU
	 +GAUeim/ICH3ornxya2NILle0RnZI9pgHKEOg8ik=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581A2ebt2647437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 05:02:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 05:02:39 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 05:02:39 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581A2drN159792;
	Mon, 1 Sep 2025 05:02:39 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 581A2clE011154;
	Mon, 1 Sep 2025 05:02:39 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
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
Subject: [PATCH net-next v2 2/6] net: ti: icssg-prueth: Add XSK pool helpers
Date: Mon, 1 Sep 2025 15:32:23 +0530
Message-ID: <20250901100227.1150567-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901100227.1150567-1-m-malladi@ti.com>
References: <20250901100227.1150567-1-m-malladi@ti.com>
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

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 133 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   7 +
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 5d31873492b6..8a0ebe011960 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -752,7 +752,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	}
 
 	pa = page_address(page);
-	if (emac->xdp_prog) {
+	if (prueth_xdp_is_enabled(emac)) {
 		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index ab8c240a6e8a..942f78a9016b 100644
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
 
@@ -1206,6 +1209,111 @@ static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
 	return 0;
 }
 
+static int prueth_xsk_pool_enable(struct prueth_emac *emac,
+				  struct xsk_buff_pool *pool, u16 queue_id)
+{
+	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
+	bool need_update = false;
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
+	need_update = netif_running(emac->ndev) || prueth_xdp_is_enabled(emac);
+
+	if (need_update) {
+		prueth_destroy_txq(emac);
+		prueth_destroy_rxq(emac);
+	}
+
+	emac->xsk_qid = queue_id;
+
+	if (netif_running(emac->ndev)) {
+		ret = prueth_create_rxq(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
+			return ret;
+		}
+
+		ret = prueth_create_txq(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "Failed to create TX queue: %d\n", ret);
+			prueth_destroy_rxq(emac);
+			emac->xdp_prog = NULL;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
+{
+	struct xsk_buff_pool *pool;
+	bool need_update = false;
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
+	need_update = netif_running(emac->ndev) || prueth_xdp_is_enabled(emac);
+
+	if (need_update) {
+		prueth_destroy_txq(emac);
+		prueth_destroy_rxq(emac);
+		synchronize_rcu();
+	}
+
+	xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
+	emac->xsk_qid = -EINVAL;
+
+	if (netif_running(emac->ndev)) {
+		ret = prueth_create_rxq(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
+			return ret;
+		}
+
+		ret = prueth_create_txq(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "Failed to create TX queue: %d\n", ret);
+			prueth_destroy_rxq(emac);
+			emac->xdp_prog = NULL;
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
@@ -1220,11 +1328,35 @@ static int emac_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
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
 
+static int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (!netif_running(ndev) || !netif_carrier_ok(ndev))
+		return -ENETDOWN;
+
+	if (!prueth_xdp_is_enabled(emac) || emac->xsk_qid != qid) {
+		netdev_err(ndev, "XSK queue %d not registered or XDP not enabled\n", qid);
+		return -EINVAL;
+	}
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
@@ -1241,6 +1373,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
 	.ndo_bpf = emac_ndo_bpf,
 	.ndo_xdp_xmit = emac_xdp_xmit,
+	.ndo_xsk_wakeup = prueth_xsk_wakeup,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index e0dadbfca45a..2f64ec97b454 100644
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
@@ -241,6 +243,7 @@ struct prueth_emac {
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
+	int xsk_qid;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -499,5 +502,9 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 			unsigned int q_idx);
 void prueth_rx_cleanup(void *data, dma_addr_t desc_dma);
 void prueth_tx_cleanup(void *data, dma_addr_t desc_dma);
+static inline bool prueth_xdp_is_enabled(struct prueth_emac *emac)
+{
+	return !!READ_ONCE(emac->xdp_prog);
+}
 
 #endif /* __NET_TI_ICSSG_PRUETH_H */
-- 
2.43.0


