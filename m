Return-Path: <bpf+bounces-56840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422AEA9F045
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 14:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AAB189E3F1
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714726AA85;
	Mon, 28 Apr 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DTiiK5OT"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A526A098;
	Mon, 28 Apr 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841940; cv=none; b=X8hrCfA9o/x5mm7MLMBBhuA2ntr0aH86o7j9E3zYwh1RU8/aoAx7Z36B3KP9YVFjTdmOjBzvJl/IBqAHoWUZZ/3w4pKAMUjuNSwdz+Xp1FNEUQ719yZdN6bB4KxiwuJkv3BdGLFI5ZlpenYXEUr8BlywsOPR/bLuOrj0X96lmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841940; c=relaxed/simple;
	bh=8Gw7PZxetBy1RCwUT9rI04H1JYafJVt7sfEm7hf2k8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biL18CVfpyVfzYn9Ki7zqXaEA2+xPSFJEhYEbAv0spUgykP0ZbzExwRi/jUOudM7zSawtzS5eK1zERzqlUiQyZfauY8Nx0bQvwrCAhwE7XPmOT89NpaNKTsgrtXoYTTA1RvmFtnAlXcp+ris+fKwDx4tIXY6VW2bPDXjNQ0dU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DTiiK5OT; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC5IvP3393357
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745841918;
	bh=UOnsX2khC4QQb5DzauQ7MTn2WKff96OYmxGALdbK5CM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DTiiK5OTcuPZ7OW1xtZa+Ig0wRwTCT/hRNr354wkAlhVPgAP62gLS0hDK/8/nz1RW
	 c/3LWpMjWGDhyAYtsZI6BQqEoJdSxJCqhEIoELehC21TSm6EAx3vHl2f712kebwXCB
	 4a1P8WSNmXQuuldUIpoQR7C/E/5SKsJcUgrTS1eY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC5IpX038345
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 07:05:18 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 07:05:17 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 07:05:17 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SC5H95098287;
	Mon, 28 Apr 2025 07:05:17 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53SC5G1B016903;
	Mon, 28 Apr 2025 07:05:17 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <m-malladi@ti.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 4/4] net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue access
Date: Mon, 28 Apr 2025 17:34:59 +0530
Message-ID: <20250428120459.244525-5-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428120459.244525-1-m-malladi@ti.com>
References: <20250428120459.244525-1-m-malladi@ti.com>
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
 drivers/net/ethernet/ti/icssg/icssg_common.c | 7 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a120ff6fec8f..e509b6ff81e7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -660,6 +660,8 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 			struct page *page, u32 *len)
 {
 	struct net_device *ndev = emac->ndev;
+	struct netdev_queue *netif_txq;
+	int cpu = smp_processor_id();
 	struct bpf_prog *xdp_prog;
 	struct xdp_frame *xdpf;
 	u32 pkt_len = *len;
@@ -679,8 +681,11 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
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
index ee35fecf61e7..b31060e7f698 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1075,20 +1075,25 @@ static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame
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
 
 	for (i = 0; i < n; i++) {
 		xdpf = frames[i];
+		__netif_tx_lock(netif_txq, cpu);
 		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
+		__netif_tx_unlock(netif_txq);
 		if (err != ICSSG_XDP_TX) {
 			ndev->stats.tx_dropped++;
 			break;
-- 
2.43.0


