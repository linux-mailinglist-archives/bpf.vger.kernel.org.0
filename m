Return-Path: <bpf+bounces-64965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89520B194B2
	for <lists+bpf@lfdr.de>; Sun,  3 Aug 2025 20:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417803B4A76
	for <lists+bpf@lfdr.de>; Sun,  3 Aug 2025 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E761DF755;
	Sun,  3 Aug 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vNhKEvAp"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BD19343B;
	Sun,  3 Aug 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754244204; cv=none; b=SrwKKMqxjEqQYVYIUBry5cIBZSf/xXSqqaqHPd1qh1aKpHEY8kp7laz2XnAS+VDSsPIiKrUiVmVB9FI/p2jh1hNloLOEyKP+MWkmUtZ8wG2kidGcLWhe01K832ImH73FSpVpFCLX5KwEkFZ1m9UTjGL52trt2P9rmNkLurac14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754244204; c=relaxed/simple;
	bh=oZGAmKfXTd6UkpeXB81oMb44tLp1mwkcCGK+lP31OSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=To77CstUZ/y+v/roRLR8/mSHKO38T0ttIYfChrRjNj9G8OODJFh8P61/rdLmaZZ929PlCc4kMHa8hXWto1KWDa6rQBo88gP5IFfelg4UDwulVKhmelBBkbeiPnAajyN6+H4wVxY6XT1wtGRa0Dc8PtgxvKwtkpZ7orAxaa/G7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vNhKEvAp; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 573I2NYB3665805;
	Sun, 3 Aug 2025 13:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754244143;
	bh=nAqOrU8mC0Z3rvF/se+5QTvub9P8PeKySL6x0gt1KT4=;
	h=From:To:CC:Subject:Date;
	b=vNhKEvApxFut0oTKQW0GFUaQpvUcq70BEJzyqpq+iAvtV0UTsLREnvYRWq7pyQZrA
	 Gs1gW6iCLmbPh2/5osMbTkZGnDzKaEZngfI8GxIIxXQgatUVAEOYJbTygKJaOAowNl
	 wt8jbmoqY/1oZje8oTMjhTM5Mk1hcSFHcXHS52lk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 573I2N3e2265990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 3 Aug 2025 13:02:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 3
 Aug 2025 13:02:22 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 3 Aug 2025 13:02:22 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 573I2MMp2180903;
	Sun, 3 Aug 2025 13:02:22 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 573I2KpU005223;
	Sun, 3 Aug 2025 13:02:21 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <r-gunasekaran@ti.com>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix skb handling for XDP_PASS
Date: Sun, 3 Aug 2025 23:32:16 +0530
Message-ID: <20250803180216.3569139-1-m-malladi@ti.com>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---

v2-v1:
- Collected RB tag from Jacob Keller <jacob.e.keller@intel.com>
- Populated headroom from xdp buffer instead of hardcoding as
  pointed out by Jakub Kicinski <kuba@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 12f25cec6255..57e5f1c88f50 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -706,9 +706,9 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	struct page_pool *pool;
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
+	int headroom, ret;
 	u32 *psdata;
 	void *pa;
-	int ret;
 
 	*xdp_state = 0;
 	pool = rx_chn->pg_pool;
@@ -757,22 +757,23 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
 		*xdp_state = emac_run_xdp(emac, &xdp, page, &pkt_len);
-		if (*xdp_state == ICSSG_XDP_PASS)
-			skb = xdp_build_skb_from_buff(&xdp);
-		else
+		if (*xdp_state != ICSSG_XDP_PASS)
 			goto requeue;
+		headroom = xdp.data - xdp.data_hard_start;
+		pkt_len = xdp.data_end - xdp.data;
 	} else {
-		/* prepare skb and send to n/w stack */
-		skb = napi_build_skb(pa, PAGE_SIZE);
+		headroom = PRUETH_HEADROOM;
 	}
 
+	/* prepare skb and send to n/w stack */
+	skb = napi_build_skb(pa, PAGE_SIZE);
 	if (!skb) {
 		ndev->stats.rx_dropped++;
 		page_pool_recycle_direct(pool, page);
 		goto requeue;
 	}
 
-	skb_reserve(skb, PRUETH_HEADROOM);
+	skb_reserve(skb, headroom);
 	skb_put(skb, pkt_len);
 	skb->dev = ndev;
 

base-commit: 759dfc7d04bab1b0b86113f1164dc1fec192b859
-- 
2.43.0


