Return-Path: <bpf+bounces-54851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E213DA7482F
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E581B61B6C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1621B9D1;
	Fri, 28 Mar 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CTqGd2zy"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED121018A;
	Fri, 28 Mar 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157507; cv=none; b=eJgC3DUmd/sk/Z2Aa14TDLbaEnAPhSbnJEnS367liqPMBLI97H/22Qne0Lxuugn6C4MAOCgZPjegnKDneg5Az7oU0VjKKOBPlJH/E2qJuzdTauC+vWJMz8mujDVyCUf0UOXfbQBO4RDWc1xMAlgeM8dSvVsajVtiieBXBAuCOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157507; c=relaxed/simple;
	bh=eBxOFKShgRogUBGzNBkigdXiTEF2/l+d7oANavRdgRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN9gnqifL+dG4Cu0nBdq+KBsDI7r/Mc2EBBWmPC2UqBWmfl6xPngcvs2RWDuyf7hTPxhFiNewQsLNhfOYrBjopPOphgtTAoebJYbc2e2SDaVzarjpToekFT+X42oAABcSPrvRoGpBPF5HSsY7yRZ0xHC1ef4o1Ip7yFjdXQueHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CTqGd2zy; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SAOE3g2096882
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 05:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743157454;
	bh=/2fyyslEH42du+dba92RsnS5u2wD2cNErCJYqvVHUdY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CTqGd2zy5ZqBynCWQyzVJo1o/DmKcCtjbnX3UT7Qz6vX3aqUY+Mk9eNc6IOxo/JD4
	 ZWm0GpkBv65zGg8+mylN/PuSxope1AoQsBreMyr9X5YogCzdPtuhMgLMF9MVOLWKOC
	 ywva6nKg62zgYGMyTARjUO8BwBYXpQWjt7HYdVM0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAOESF079362;
	Fri, 28 Mar 2025 05:24:14 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 05:24:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 05:24:13 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SAODhZ101879;
	Fri, 28 Mar 2025 05:24:13 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52SAOCgn024937;
	Fri, 28 Mar 2025 05:24:13 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <namcao@linutronix.de>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v3 2/3] net: ti: icssg-prueth: Fix possible NULL pointer dereference inside emac_xmit_xdp_frame()
Date: Fri, 28 Mar 2025 15:54:02 +0530
Message-ID: <20250328102403.2626974-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328102403.2626974-1-m-malladi@ti.com>
References: <20250328102403.2626974-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There is an error check inside emac_xmit_xdp_frame() function which
is called when the driver wants to transmit XDP frame, to check if
the allocated tx descriptor is NULL, if true to exit and return
ICSSG_XDP_CONSUMED implying failure in transmission.

In this case trying to free a descriptor which is NULL will result
in kernel crash due to NULL pointer dereference. Fix this error handling
and increase netdev tx_dropped stats in the caller of this function
if the function returns ICSSG_XDP_CONSUMED.

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain/
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---

Changes from v2(v3-v2):
- Add Reported-by tag and link to the bug reported by Dan Carpenter <dan.carpenter@linaro.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 3c0ea9044e18..15c092a923d7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -583,7 +583,7 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
 	if (!first_desc) {
 		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
-		goto drop_free_descs;	/* drop */
+		return ICSSG_XDP_CONSUMED;	/* drop */
 	}
 
 	if (page) { /* already DMA mapped by page_pool */
@@ -671,8 +671,10 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 
 		q_idx = smp_processor_id() % emac->tx_ch_num;
 		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
-		if (result == ICSSG_XDP_CONSUMED)
+		if (result == ICSSG_XDP_CONSUMED) {
+			ndev->stats.tx_dropped++;
 			goto drop;
+		}
 
 		dev_sw_netstats_rx_add(ndev, xdpf->len);
 		return result;
-- 
2.43.0


