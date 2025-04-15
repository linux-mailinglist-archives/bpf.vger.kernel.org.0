Return-Path: <bpf+bounces-55934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70AA89775
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED9B189D0E0
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBF27FD61;
	Tue, 15 Apr 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PwQcfiOm"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7D275101;
	Tue, 15 Apr 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707984; cv=none; b=SCR2/wdUCfC84iBfBRz9gnahArkKaOTnQMAzpkZjQXBuug4Kn8CWC8uXTXDSsZ4CVPqP6lt+wjqqqETz2ArgRkz8DJgBhw00VRCepErk8mLXUU4t9Cu44kHdKJIHWjgXAIuiPoShpcb5CDVV8CxiSDEtEvhIVOqsR7Lnc9PuYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707984; c=relaxed/simple;
	bh=zff7jOxkONSsnLH2GSDVjIYio3MRfnsgdJCnZXqZNSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1FNgKcyVP22c6zeGL0UYellWuUebjuF7BZfjYCqKLulxv7XlXWKKfmgsp90/HE5McKRxKOgR3lFVSZhiPhRqajZdQdbNmMbNRCtx3NkcEdTDAw48SpqeHht1iPeDz3/5uiZHe14fvTpjQ2uhv6tJy5LYpgxUmJHXWATSPb5MHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PwQcfiOm; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95tdu2436554
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 04:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744707955;
	bh=NvqRn26wZctD+qgQJMKuzd+RSyeLXp69lVTwvYULYds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PwQcfiOmM8U7Mhb0hmFJ7WVJcjVjLOOhNLlDRB1rwl0yS+0RtR72GtayocvoNXAp5
	 bF/IrRafelecP+/phsJp6IVGBE3bDqibkn5TVHv2j1LXtIIpGvMWI6w4uTrLFYKt5b
	 Yy2D4o8phSRQMLgkM4OUKHSzWQaHDdZ/gg+soT5o=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95tUM102179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 04:05:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 04:05:54 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 04:05:54 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F95sdV072057;
	Tue, 15 Apr 2025 04:05:54 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53F95rH5010963;
	Tue, 15 Apr 2025 04:05:54 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <richardcochran@gmail.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v4 2/3] net: ti: icssg-prueth: Fix possible NULL pointer dereference inside emac_xmit_xdp_frame()
Date: Tue, 15 Apr 2025 14:35:42 +0530
Message-ID: <20250415090543.717991-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415090543.717991-1-m-malladi@ti.com>
References: <20250415090543.717991-1-m-malladi@ti.com>
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
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Changes from v3 (v4-v3):
- Collected RB tag from Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index ec643fb69d30..b4be76e13a2f 100644
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


