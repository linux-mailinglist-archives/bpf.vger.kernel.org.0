Return-Path: <bpf+bounces-57505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AFAAC205
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A98E3A5E59
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35D279358;
	Tue,  6 May 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vGIG9+Fr"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A01474B8;
	Tue,  6 May 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529590; cv=none; b=fruTtskgMuL/EhtmuN+vjQpMX00tU4R5TczN7/neh/YuBmkBNQS8i4W0q8FjWD34SJyfQlrwDlSPRS9cibBnuulqJ5HqeVxH7wg7KLyGn70pbn66kb3NBhLu53ZX3NdCtJcaMPvESUyx2oAISowVWOp1tRIc2I17n4fMI5MY+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529590; c=relaxed/simple;
	bh=qNm+CmWA+REq11MX0pK+MB134jmTLdtEtOeioJpz41g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KG0wD1/SCiFH7B32FpYRQdvOjRv1PTgMbAvbnKXNzVmiS7FvguenBjjQK3VTxE/2mVQjVVdW/p0XLie2E3M7B4IRvb1J2gq4ZqbWlKpZ+zIm1fPkAzXrveXORyukd4g3wkCmSldJdcGYMJ+B421Bg/zfPXlpVfFzY5hP2GH1dUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vGIG9+Fr; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546B5wX71035554
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746529558;
	bh=lwn/nB2s1mWnia5rEGt+fuy0yNLE//GziOUFT14kOpg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vGIG9+Frwej8VHGdVitTr95aGGSLopkiZxto4Kjg+/Cvi2NAZ6DSl8M/Xy08Xhb52
	 h7KjBWW/SKDImsybPWDkqYiHG0ShGK6cx25v/VXVQMPzm566aUxC9IVOBl82Kp28/y
	 OvdKr9IM1/2Uu925eEpxsF+pAvzRowgxS48nL1ug=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546B5wEe055864
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 May 2025 06:05:58 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 06:05:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 06:05:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546B5vmb055972;
	Tue, 6 May 2025 06:05:57 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 546B5uUL010343;
	Tue, 6 May 2025 06:05:57 -0500
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
Subject: [PATCH net v2 2/3] net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue access
Date: Tue, 6 May 2025 16:35:45 +0530
Message-ID: <20250506110546.4065715-3-m-malladi@ti.com>
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

Add __netif_tx_lock() to ensure that only one packet is being
transmitted at a time to avoid race conditions in the netif_txq
struct and prevent packet data corruption. Failing to do so causes
kernel panic with the following error:

[ 2184.746764] ------------[ cut here ]------------
[ 2184.751412] kernel BUG at lib/dynamic_queue_limits.c:99!
[ 2184.756728] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP

logs: https://gist.github.com/MeghanaMalladiTI/9c7aa5fc3b7fb03f87c74aad487956e9

The lock is acquired before calling emac_xmit_xdp_frame() and released after the
call returns. This ensures that the TX queue is protected from concurrent access
during the transmission of XDP frames.

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Changes from v1 (v2-v1):
- Move netif_tx_lock/unlock outside of the loop, reported by Jesper Dangaard Brouer <hawk@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 7 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 79f2d86acf21..36d5cb25c017 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -650,6 +650,8 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 			struct page *page, u32 *len)
 {
 	struct net_device *ndev = emac->ndev;
+	struct netdev_queue *netif_txq;
+	int cpu = smp_processor_id();
 	struct bpf_prog *xdp_prog;
 	struct xdp_frame *xdpf;
 	u32 pkt_len = *len;
@@ -669,8 +671,11 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 			goto drop;
 		}
 
-		q_idx = smp_processor_id() % emac->tx_ch_num;
+		q_idx = cpu % emac->tx_ch_num;
+		netif_txq = netdev_get_tx_queue(ndev, q_idx);
+		__netif_tx_lock(netif_txq, cpu);
 		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
+		__netif_tx_unlock(netif_txq);
 		if (result == ICSSG_XDP_CONSUMED) {
 			ndev->stats.tx_dropped++;
 			goto drop;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index ee35fecf61e7..86fc1278127c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1075,17 +1075,21 @@ static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame
 {
 	struct prueth_emac *emac = netdev_priv(dev);
 	struct net_device *ndev = emac->ndev;
+	struct netdev_queue *netif_txq;
+	int cpu = smp_processor_id();
 	struct xdp_frame *xdpf;
 	unsigned int q_idx;
 	int nxmit = 0;
 	u32 err;
 	int i;
 
-	q_idx = smp_processor_id() % emac->tx_ch_num;
+	q_idx = cpu % emac->tx_ch_num;
+	netif_txq = netdev_get_tx_queue(ndev, q_idx);
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
+	__netif_tx_lock(netif_txq, cpu);
 	for (i = 0; i < n; i++) {
 		xdpf = frames[i];
 		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
@@ -1095,6 +1099,7 @@ static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame
 		}
 		nxmit++;
 	}
+	__netif_tx_unlock(netif_txq);
 
 	return nxmit;
 }
-- 
2.43.0


