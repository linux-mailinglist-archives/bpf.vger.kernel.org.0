Return-Path: <bpf+bounces-52323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEFBA41BF8
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED2F174740
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A5E2580DA;
	Mon, 24 Feb 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ueOiR4gx"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A04134D4;
	Mon, 24 Feb 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394917; cv=none; b=ZII/61b4Z7Iu0L/TYpS0VmklJjqPNb9jcG+6Zrm+a+lZm1QaGhNPCk7kZyBqdykZVhSu69zcjwWI5eTDuB9VbXoYdWYVjxc+n49pLz+zw3ahD5oz1rw2uyKqmLslO6vojnlnpSQH69r/BWFh31wTe6401xSYUOlqmLxWLgt2cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394917; c=relaxed/simple;
	bh=kpiuZoDJ5h8Cabu1D1ieF5PtxkRpYwWXV6XXaB98Gsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWkK8pbrf9Ai5HVAfb/RrUYzu9S8xIizVCJw9946Tf9P1paRj6p/W3+pQCc9Cw3mHJHD13YvJalqjCqvAddpsSsh59t7c3C1h2fdyo4E6r4hqIj2uUSS3blDWCwgD2M3AKl3fhjbAbhBmIwV315smwf8uY8hEXSusigm2o5QlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ueOiR4gx; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OB1Ah41472225
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 05:01:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740394870;
	bh=2H3x8wyJ8rYQLrG3zFhzL0n0sPM4DUqcnGFE6Hjv/Ow=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ueOiR4gx5Tqg3A4cnDeq7le4u/FCWcCt/ldSYzFH84cBGBNQ25WCnfkf7CTeH7kL8
	 5+WgKVPJ2xw2nRtlrozHsbcNaW5dSIFxsD1YSIWgB7lL1R1XubqJd9PpDMgrKoCWG1
	 mt7hoqBZrphJlNwsbIp0LirUt9SiUzEbLQ2rPW14=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51OB1AEn000953
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 05:01:10 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 05:01:09 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 05:01:10 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OB19vH037030;
	Mon, 24 Feb 2025 05:01:09 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51OB18v0002035;
	Mon, 24 Feb 2025 05:01:09 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <matthias.schiffer@ew.tq-group.com>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <schnelle@linux.ibm.com>, <diogo.ivo@siemens.com>,
        <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v3 1/3] net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
Date: Mon, 24 Feb 2025 16:31:00 +0530
Message-ID: <20250224110102.1528552-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224110102.1528552-1-m-malladi@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Roger Quadros <rogerq@kernel.org>

This is to prepare for native XDP support.

The page pool API is more faster in allocating pages than
__alloc_skb(). Drawback is that it works at PAGE_SIZE granularity
so we are not efficient in memory usage.
i.e. we are using PAGE_SIZE (4KB) memory for 1.5KB max packet size.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
Changes since v2 (v3-v2):
- few cosmetic changes for all the patches as suggested by 
Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 174 ++++++++++++------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  14 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  21 ++-
 4 files changed, 139 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0d5a862cd78a..b461281d31b6 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -204,6 +204,7 @@ config TI_ICSSG_PRUETH_SR1
 	select PHYLIB
 	select TI_ICSS_IEP
 	select TI_K3_CPPI_DESC_POOL
+	select PAGE_POOL
 	depends on PRU_REMOTEPROC
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 74f0f200a89d..acbb79ad8b0c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -45,6 +45,11 @@ void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 			    struct prueth_rx_chn *rx_chn,
 			    int max_rflows)
 {
+	if (rx_chn->pg_pool) {
+		page_pool_destroy(rx_chn->pg_pool);
+		rx_chn->pg_pool = NULL;
+	}
+
 	if (rx_chn->desc_pool)
 		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
 
@@ -461,17 +466,17 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 }
 EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
 
-int prueth_dma_rx_push(struct prueth_emac *emac,
-		       struct sk_buff *skb,
-		       struct prueth_rx_chn *rx_chn)
+int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
+			      struct prueth_rx_chn *rx_chn,
+			      struct page *page, u32 buf_len)
 {
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
-	u32 pkt_len = skb_tailroom(skb);
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
 	void **swdata;
 
+	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
 	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
 	if (!desc_rx) {
 		netdev_err(ndev, "rx push: failed to allocate descriptor\n");
@@ -479,25 +484,18 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
 	}
 	desc_dma = k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
 
-	buf_dma = dma_map_single(rx_chn->dma_dev, skb->data, pkt_len, DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(rx_chn->dma_dev, buf_dma))) {
-		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
-		netdev_err(ndev, "rx push: failed to map rx pkt buffer\n");
-		return -EINVAL;
-	}
-
 	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
 			 PRUETH_NAV_PS_DATA_SIZE);
 	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
-	cppi5_hdesc_attach_buf(desc_rx, buf_dma, skb_tailroom(skb), buf_dma, skb_tailroom(skb));
+	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	*swdata = skb;
+	*swdata = page;
 
-	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0,
+	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
 					desc_rx, desc_dma);
 }
-EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
+EXPORT_SYMBOL_GPL(prueth_dma_rx_push_mapped);
 
 u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
 {
@@ -541,12 +539,16 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	u32 buf_dma_len, pkt_len, port_id = 0;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
-	struct sk_buff *skb, *new_skb;
 	dma_addr_t desc_dma, buf_dma;
+	struct page *page, *new_page;
+	struct page_pool *pool;
+	struct sk_buff *skb;
 	void **swdata;
 	u32 *psdata;
+	void *pa;
 	int ret;
 
+	pool = rx_chn->pg_pool;
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
 	if (ret) {
 		if (ret != -ENODATA)
@@ -558,15 +560,9 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 		return 0;
 
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
-
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	skb = *swdata;
-
-	psdata = cppi5_hdesc_get_psdata(desc_rx);
-	/* RX HW timestamp */
-	if (emac->rx_ts_enabled)
-		emac_rx_timestamp(emac, skb, psdata);
-
+	page = *swdata;
+	page_pool_dma_sync_for_cpu(pool, page, 0, PAGE_SIZE);
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
@@ -574,32 +570,51 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	pkt_len -= 4;
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
 
-	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	skb->dev = ndev;
-	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
 	/* if allocation fails we drop the packet but push the
-	 * descriptor back to the ring with old skb to prevent a stall
+	 * descriptor back to the ring with old page to prevent a stall
 	 */
-	if (!new_skb) {
+	new_page = page_pool_dev_alloc_pages(pool);
+	if (unlikely(!new_page)) {
+		new_page = page;
 		ndev->stats.rx_dropped++;
-		new_skb = skb;
-	} else {
-		/* send the filled skb up the n/w stack */
-		skb_put(skb, pkt_len);
-		if (emac->prueth->is_switch_mode)
-			skb->offload_fwd_mark = emac->offload_fwd_mark;
-		skb->protocol = eth_type_trans(skb, ndev);
-		napi_gro_receive(&emac->napi_rx, skb);
-		ndev->stats.rx_bytes += pkt_len;
-		ndev->stats.rx_packets++;
+		goto requeue;
+	}
+
+	/* prepare skb and send to n/w stack */
+	pa = page_address(page);
+	skb = napi_build_skb(pa, PAGE_SIZE);
+	if (!skb) {
+		ndev->stats.rx_dropped++;
+		page_pool_recycle_direct(pool, page);
+		goto requeue;
 	}
 
+	skb_reserve(skb, PRUETH_HEADROOM);
+	skb_put(skb, pkt_len);
+	skb->dev = ndev;
+
+	psdata = cppi5_hdesc_get_psdata(desc_rx);
+	/* RX HW timestamp */
+	if (emac->rx_ts_enabled)
+		emac_rx_timestamp(emac, skb, psdata);
+
+	if (emac->prueth->is_switch_mode)
+		skb->offload_fwd_mark = emac->offload_fwd_mark;
+	skb->protocol = eth_type_trans(skb, ndev);
+
+	skb_mark_for_recycle(skb);
+	napi_gro_receive(&emac->napi_rx, skb);
+	ndev->stats.rx_bytes += pkt_len;
+	ndev->stats.rx_packets++;
+
+requeue:
 	/* queue another RX DMA */
-	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_chns);
+	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
+					PRUETH_MAX_PKT_SIZE);
 	if (WARN_ON(ret < 0)) {
-		dev_kfree_skb_any(new_skb);
+		page_pool_recycle_direct(pool, new_page);
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_dropped++;
 	}
@@ -611,22 +626,16 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct prueth_rx_chn *rx_chn = data;
 	struct cppi5_host_desc_t *desc_rx;
-	struct sk_buff *skb;
-	dma_addr_t buf_dma;
-	u32 buf_dma_len;
+	struct page_pool *pool;
+	struct page *page;
 	void **swdata;
 
+	pool = rx_chn->pg_pool;
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	skb = *swdata;
-	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
-	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
-
-	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len,
-			 DMA_FROM_DEVICE);
+	page = *swdata;
+	page_pool_recycle_direct(pool, page);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
-
-	dev_kfree_skb_any(skb);
 }
 
 static int prueth_tx_ts_cookie_get(struct prueth_emac *emac)
@@ -907,29 +916,71 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 }
 EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
 
+static struct page_pool *prueth_create_page_pool(struct prueth_emac *emac,
+						 struct device *dma_dev,
+						 int size)
+{
+	struct page_pool_params pp_params = { 0 };
+	struct page_pool *pool;
+
+	pp_params.order = 0;
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.pool_size = size;
+	pp_params.nid = dev_to_node(emac->prueth->dev);
+	pp_params.dma_dir = DMA_BIDIRECTIONAL;
+	pp_params.dev = dma_dev;
+	pp_params.napi = &emac->napi_rx;
+	pp_params.max_len = PAGE_SIZE;
+
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool))
+		netdev_err(emac->ndev, "cannot create rx page pool\n");
+
+	return pool;
+}
+
 int prueth_prepare_rx_chan(struct prueth_emac *emac,
 			   struct prueth_rx_chn *chn,
 			   int buf_size)
 {
-	struct sk_buff *skb;
+	struct page_pool *pool;
+	struct page *page;
 	int i, ret;
 
+	pool = prueth_create_page_pool(emac, chn->dma_dev, chn->descs_num);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	chn->pg_pool = pool;
+
 	for (i = 0; i < chn->descs_num; i++) {
-		skb = __netdev_alloc_skb_ip_align(NULL, buf_size, GFP_KERNEL);
-		if (!skb)
-			return -ENOMEM;
+		/* NOTE: we're not using memory efficiently here.
+		 * 1 full page (4KB?) used here instead of
+		 * PRUETH_MAX_PKT_SIZE (~1.5KB?)
+		 */
+		page = page_pool_dev_alloc_pages(pool);
+		if (!page) {
+			netdev_err(emac->ndev, "couldn't allocate rx page\n");
+			ret = -ENOMEM;
+			goto recycle_alloc_pg;
+		}
 
-		ret = prueth_dma_rx_push(emac, skb, chn);
+		ret = prueth_dma_rx_push_mapped(emac, chn, page, buf_size);
 		if (ret < 0) {
 			netdev_err(emac->ndev,
-				   "cannot submit skb for rx chan %s ret %d\n",
+				   "cannot submit page for rx chan %s ret %d\n",
 				   chn->name, ret);
-			kfree_skb(skb);
-			return ret;
+			page_pool_recycle_direct(pool, page);
+			goto recycle_alloc_pg;
 		}
 	}
 
 	return 0;
+
+recycle_alloc_pg:
+	prueth_reset_rx_chan(&emac->rx_chns, PRUETH_MAX_RX_FLOWS, false);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
 
@@ -958,6 +1009,9 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 					  prueth_rx_cleanup, !!i);
 	if (disable)
 		k3_udma_glue_disable_rx_chn(chn->rx_chn);
+
+	page_pool_destroy(chn->pg_pool);
+	chn->pg_pool = NULL;
 }
 EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 329b46e9ee53..c7b906de18af 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -33,6 +33,8 @@
 #include <linux/dma/k3-udma-glue.h>
 
 #include <net/devlink.h>
+#include <net/xdp.h>
+#include <net/page_pool/helpers.h>
 
 #include "icssg_config.h"
 #include "icss_iep.h"
@@ -131,6 +133,7 @@ struct prueth_rx_chn {
 	u32 descs_num;
 	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
 	char name[32];
+	struct page_pool *pg_pool;
 };
 
 /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
@@ -210,6 +213,10 @@ struct prueth_emac {
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 };
 
+/* The buf includes headroom compatible with both skb and xdpf */
+#define PRUETH_HEADROOM_NA (max(XDP_PACKET_HEADROOM, NET_SKB_PAD) + NET_IP_ALIGN)
+#define PRUETH_HEADROOM  ALIGN(PRUETH_HEADROOM_NA, sizeof(long))
+
 /**
  * struct prueth_pdata - PRUeth platform data
  * @fdqring_mode: Free desc queue mode
@@ -410,9 +417,10 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 			struct prueth_rx_chn *rx_chn,
 			char *name, u32 max_rflows,
 			u32 max_desc_num);
-int prueth_dma_rx_push(struct prueth_emac *emac,
-		       struct sk_buff *skb,
-		       struct prueth_rx_chn *rx_chn);
+int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
+			      struct prueth_rx_chn *rx_chn,
+			      struct page *page, u32 buf_len);
+unsigned int prueth_rxbuf_total_len(unsigned int len);
 void emac_rx_timestamp(struct prueth_emac *emac,
 		       struct sk_buff *skb, u32 *psdata);
 enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 64a19ff39562..aeeb8a50376b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -274,10 +274,12 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
 	struct prueth_rx_chn *rx_chn = &emac->rx_mgm_chn;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
-	struct sk_buff *skb, *new_skb;
+	struct page *page, *new_page;
 	dma_addr_t desc_dma, buf_dma;
 	u32 buf_dma_len, pkt_len;
+	struct sk_buff *skb;
 	void **swdata;
+	void *pa;
 	int ret;
 
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
@@ -299,32 +301,35 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
 	}
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	skb = *swdata;
+	page = *swdata;
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
 
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
+	new_page = page_pool_dev_alloc_pages(rx_chn->pg_pool);
 	/* if allocation fails we drop the packet but push the
 	 * descriptor back to the ring with old skb to prevent a stall
 	 */
-	if (!new_skb) {
+	if (!new_page) {
 		netdev_err(ndev,
-			   "skb alloc failed, dropped mgm pkt from flow %d\n",
+			   "page alloc failed, dropped mgm pkt from flow %d\n",
 			   flow_id);
-		new_skb = skb;
+		new_page = page;
 		skb = NULL;	/* return NULL */
 	} else {
 		/* return the filled skb */
+		pa = page_address(page);
+		skb = napi_build_skb(pa, PAGE_SIZE);
 		skb_put(skb, pkt_len);
 	}
 
 	/* queue another DMA */
-	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_mgm_chn);
+	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
+					PRUETH_MAX_PKT_SIZE);
 	if (WARN_ON(ret < 0))
-		dev_kfree_skb_any(new_skb);
+		page_pool_recycle_direct(rx_chn->pg_pool, new_page);
 
 	return skb;
 }
-- 
2.43.0


