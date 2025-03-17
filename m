Return-Path: <bpf+bounces-54182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C8CA64951
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7161673E7
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EC23A9BE;
	Mon, 17 Mar 2025 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GW7wqvAe"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7E2356C5;
	Mon, 17 Mar 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206597; cv=none; b=jONKua8cRaRRPQ8blXMWuoMbJQCAWZJ32gzdQD4t5v3XpsGakiksb4hzH3vaLaFy6sEgW9EqDVTh0AEbD9aIHPT7EfMx/m86YecBA0eyM4J8DsnZ+oS2XeVP+0DGtD6bH38Uqwr3IdeMnCqq5w21sgSPAkWR/5NOzWfw0hzC8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206597; c=relaxed/simple;
	bh=K34Aj+25gMhXmyalVQZpEdDh7YbkL+mgpz53TLbOa0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQWE5Gd6S3dMcsUiHXSX0iS8bzZVcrTjPrdHysfwIrESe07hSP9Ef4TmSFqiO+xro0agID7phxbCK7aC1gtKJtEEO3hHLIFY31NSBnzYtxYibB0fup5fAAdHkgwrcghbC9NYPCWP4kIyVCJRxfVORKxyPC6C7bui6tzr4+EwGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GW7wqvAe; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52HAG4rG2309540
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 05:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742206564;
	bh=OwguXbm0nOXrCmblsRIEMJtiGJGpKRrpwqdfvSa1Xx8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GW7wqvAeINklNQH9pjjztnXgVus4pzmC8UrBvquxECc8qJazAn12MQBSF1JYomnSK
	 Ad1/ub7lxGPgKLNFAmUXEBYfylMvC9cbegyQUcqMj910bK838DtGH7usobd943NAAo
	 BmTKUNBjTxUBPiFLXlRdDNBE5SDzCYOWyNeZ1OWA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52HAG4JM049932
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Mar 2025 05:16:04 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Mar 2025 05:16:03 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Mar 2025 05:16:04 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52HAG3GQ075275;
	Mon, 17 Mar 2025 05:16:03 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52HAG353019296;
	Mon, 17 Mar 2025 05:16:03 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kory.maincent@bootlin.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next 2/3] net: ti: prueth: Fix possible NULL pointer dereference inside emac_xmit_xdp_frame()
Date: Mon, 17 Mar 2025 15:45:49 +0530
Message-ID: <20250317101551.1005706-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317101551.1005706-1-m-malladi@ti.com>
References: <20250317101551.1005706-1-m-malladi@ti.com>
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
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index afa01c22dee8..f0224576b95f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -584,7 +584,7 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
 	if (!first_desc) {
 		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
-		goto drop_free_descs;	/* drop */
+		return ICSSG_XDP_CONSUMED;	/* drop */
 	}
 
 	if (page) { /* already DMA mapped by page_pool */
@@ -672,8 +672,10 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 
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


