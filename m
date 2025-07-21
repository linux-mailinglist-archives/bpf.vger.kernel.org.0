Return-Path: <bpf+bounces-63911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE7B0C471
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E3B1AA3FC8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644D2D541F;
	Mon, 21 Jul 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TVF/fyyL"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243D27FB22;
	Mon, 21 Jul 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102217; cv=none; b=moLGo/05ObRIrDMjdh0p2R0bA8qr1Oq8QofDfsGwU6TmVdG610EBZwVYTzsaE+oG6drYNn1ShRiIEYxClGZvlskNFhKFH9E2zA5s5Wk5NetXUnqTxIWXgveh0FtaeYi4pnap21T7+l0t3qnteGROpSE/nN1oAHTRzm288occxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102217; c=relaxed/simple;
	bh=nfONOnBrUIPIfQklNyqnZWtI5QFfM2AOm84lkmUoLZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AIb/7NrIIix3MpcsDdPdid/WogZdgZfOO4cS3hq3/6+c+rdyLVrvmMgEPrfDD8TkTP2gzlXtuvEdOQidY6qm3c/s2u7RPaPv/+OuOfyObgJXDpfPlhuEPwaZ1B/H0gLmA3Hr0rp0LBaT4tp7egGHaPcku8GixP7lj7wXvyx1LP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TVF/fyyL; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56LCnOtE805016;
	Mon, 21 Jul 2025 07:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753102164;
	bh=gl6XjWOd36sg6clLSodrsTq+/Bqq5Lfk1BOVUUxIzyg=;
	h=From:To:CC:Subject:Date;
	b=TVF/fyyL9+rKglDbVEtN+yMvMLu3FtzN3zG41NqtbKozP8K31Wu5FoHgKNPWhh2sK
	 ebKcnGtYdut1NDUw7p/qnAmulScsbl9KcI9X5VavdI12aRMm/RwTwqu+wKaRp336qq
	 t+gfuwrk1BBO+DfaaEkRLN3yCKBG9p01CkVz55vQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56LCnOtZ280684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 21 Jul 2025 07:49:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 07:49:23 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 07:49:23 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56LCnNFK2685222;
	Mon, 21 Jul 2025 07:49:23 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56LCnMVg012710;
	Mon, 21 Jul 2025 07:49:22 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix skb handling for XDP_PASS
Date: Mon, 21 Jul 2025 18:19:18 +0530
Message-ID: <20250721124918.3347679-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

emac_rx_packet() is a common function for handling traffic
for both xdp and non-xdp use cases. Use common logic for
handling skb with or without xdp to prevent any incorrect
packet processing. This patch fixes ping working with
XDP_PASS for icssg driver.

Fixes: 62aa3246f4623 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 12f25cec6255..a0e7def33e8e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -757,15 +757,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
 		*xdp_state = emac_run_xdp(emac, &xdp, page, &pkt_len);
-		if (*xdp_state == ICSSG_XDP_PASS)
-			skb = xdp_build_skb_from_buff(&xdp);
-		else
+		if (*xdp_state != ICSSG_XDP_PASS)
 			goto requeue;
-	} else {
-		/* prepare skb and send to n/w stack */
-		skb = napi_build_skb(pa, PAGE_SIZE);
 	}
 
+	/* prepare skb and send to n/w stack */
+	skb = napi_build_skb(pa, PAGE_SIZE);
 	if (!skb) {
 		ndev->stats.rx_dropped++;
 		page_pool_recycle_direct(pool, page);

base-commit: 81e0db8e839822b8380ce4716cd564a593ccbfc5
-- 
2.43.0


