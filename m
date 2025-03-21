Return-Path: <bpf+bounces-54532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA2A6B5E0
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 09:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2522A3ACFEC
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA81EF39F;
	Fri, 21 Mar 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sto7GVEJ"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB51EFFB0;
	Fri, 21 Mar 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544842; cv=none; b=ctVMID23+C93KvAeD9k2PNJyDBMHB/Kt0Nnvifu9xlxv21/NONKw1/YjNaQhq2aqreqIK7Fpcy+9Z570g9yXFTENFsPEzQFbgemEtZDvlNJtqfCBrTLAmwFT2LUvdJ5btrWoNpMCupXTKvX0j/MKY+z+KLanocw4Zg70jwRnohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544842; c=relaxed/simple;
	bh=JpD9u0twb5dAxGiFWUchmDBKnqRKrQEd8Fwfp/GhSNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvQ8Zvpnsr4zfBhwmiOlEwR1qh+elW0eBT6WHXBReDYCB9k8vbrDmABO6OcweibXLr3oJQzmwl7bTEgBOEioRy1V8H8wHxdaxM0SzJkw2fOD7ToE8OgKDAJG76qoASeLznadalzYNZRyx6P4juNz4U3g7g0eqMX+c/PjsItXJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sto7GVEJ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52L8DPbG855093
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 03:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742544805;
	bh=1QRNK+uPPm6yb6KBM5lbIV1SyTZ1Gd9sAIkbavrbAec=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sto7GVEJouptHh6GN3t6GCGUgDh+g46IXFvmSmtOvryCGGvtNFAw5OG7rR6LyJ5Lm
	 v6davIjJ1lDWvt0XRjj9UNuAxldmgVFwO4zXMH32TZCvSuz2JqpDmjApSaIk60oyi/
	 xx1bStAQykHr80s816v6Irmu5OW7qUe4kB+mW16w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52L8DPCs119303
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Mar 2025 03:13:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Mar 2025 03:13:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Mar 2025 03:13:24 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52L8DOEl092783;
	Fri, 21 Mar 2025 03:13:24 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52L8DNXE032434;
	Fri, 21 Mar 2025 03:13:24 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kory.maincent@bootlin.com>, <dan.carpenter@linaro.org>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2 2/3] net: ti: prueth: Fix possible NULL pointer dereference inside emac_xmit_xdp_frame()
Date: Fri, 21 Mar 2025 13:43:12 +0530
Message-ID: <20250321081313.37112-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321081313.37112-1-m-malladi@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---

Changes from v1(v2-v1):
- Collected RB tag from Simon Horman <horms@kernel.org>

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


