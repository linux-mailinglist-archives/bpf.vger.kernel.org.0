Return-Path: <bpf+bounces-57508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91124AAC210
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD40F3B3190
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3027AC5E;
	Tue,  6 May 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mtGajJ+2"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAE278E6B;
	Tue,  6 May 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529599; cv=none; b=YTOZzKwC1Z/YGDJNe8HvCrQyIPmeQ9rbB/nG7vcHdalOdeh8USRUiymhR1PtrKGZfq6qwoIvgM8f9hFqQ9f1ZQoZa8p4C7ccgpPzzN5sWJwrYxfjFNfeU5FALMaQsARCe5vUduVpw3dNF2gp/bRWf421rttAye/Z3bvODlH8V8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529599; c=relaxed/simple;
	bh=pPG4A69Jzv1j/u680hscZcO9XMsYyYhAZW5FYEahAQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETJnASNOSW+VRXde5sa7TVGKd24R5d98WXk1ZO0sAgeI3zuYR76ZrIAUAJWl+a+odGQD5hQMhKc8YBB1Mu2PFmJZwr7E+RBvtIyPOmJM8dGBurOL/frHCo2smycKZQyJJe3UsdADzU0byiD+kOvNyfdbqCtcOLWqsR2nFWjuskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mtGajJ+2; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546B61Z8485503
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746529561;
	bh=RpHmsXnTE8Ah4aeveKhPrmGpWgl0nHpMPDu8HAWcLjI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mtGajJ+2ocilvtKLbYDb2fA4eaC6yhkid+AANZKiHs/wo99xmiAUbXhyqIAZ/9EeG
	 9FxgLhpalUm3bdpHxcsZZJLsGioZ7tXeIS9RTsLNNvYU0Nf9ESwUdxOvkwITi+omZc
	 Xhn77h3nhSEZV3fStZNG8j4T61STZj8Dveqp86HU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546B61Dw003211
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 May 2025 06:06:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 06:06:01 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 06:06:00 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546B60II102224;
	Tue, 6 May 2025 06:06:00 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 546B5xXU010352;
	Tue, 6 May 2025 06:06:00 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <horms@kernel.org>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2 3/3] net: ti: icssg-prueth: Report BQL before sending XDP packets
Date: Tue, 6 May 2025 16:35:46 +0530
Message-ID: <20250506110546.4065715-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506110546.4065715-1-m-malladi@ti.com>
References: <20250506110546.4065715-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When sending out any kind of traffic, it is essential that the driver
keeps reporting BQL of the number of bytes that have been sent so that
BQL can track the amount of data in the queue and prevents it from
overflowing. If BQL is not reported, the driver may continue sending
packets even when the queue is full, leading to packet loss, congestion
and decreased network performance. Currently this is missing in
emac_xmit_xdp_frame() and this patch fixes it.

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v1 (v2-v1):
- reordered the patches in the series as suggested by Jakub Kicinski <kuba@kernel.org>
- Dropped patch 3/4 from v1 as suggested by Jakub Kicinski <kuba@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 36d5cb25c017..5b8fdb882172 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -187,7 +187,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			xdp_return_frame(xdpf);
 			break;
 		default:
-			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
 			prueth_xmit_free(tx_chn, desc_tx);
 			ndev->stats.tx_dropped++;
 			continue;
@@ -567,6 +566,7 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 {
 	struct cppi5_host_desc_t *first_desc;
 	struct net_device *ndev = emac->ndev;
+	struct netdev_queue *netif_txq;
 	struct prueth_tx_chn *tx_chn;
 	dma_addr_t desc_dma, buf_dma;
 	struct prueth_swdata *swdata;
@@ -620,12 +620,17 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 		swdata->data.xdpf = xdpf;
 	}
 
+	/* Report BQL before sending the packet */
+	netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
+	netdev_tx_sent_queue(netif_txq, xdpf->len);
+
 	cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
 	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
 
 	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
 	if (ret) {
 		netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
+		netdev_tx_completed_queue(netif_txq, 1, xdpf->len);
 		goto drop_free_descs;
 	}
 
@@ -984,6 +989,7 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
 	if (ret) {
 		netdev_err(ndev, "tx: push failed: %d\n", ret);
+		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
 		goto drop_free_descs;
 	}
 
-- 
2.43.0


