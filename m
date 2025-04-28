Return-Path: <bpf+bounces-56836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86AFA9F038
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520EC1A81794
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE9267AF4;
	Mon, 28 Apr 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o30MvfUp"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C062676FC;
	Mon, 28 Apr 2025 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841935; cv=none; b=WgxXxAS+w+l1ViYVW8OfjV83YYVRWXm7zQ2sE3xxSGb/SpgnbXprk0y4rRC6SiLem3L0OOMWf70CHwZFgHm6o/uutCTRqYv5u7tsNWV2lGEeaxDZgVwfjbu+QFYZ7+UKsG0bOgwSzn1LwcNZxTgWAT2DDW4vbpoCunlyeZ56FPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841935; c=relaxed/simple;
	bh=n6tPFBDBE/AoUx8+fT4xmiJ8DuWqqSs6nsXV22sbwkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaVb98l9Xe8OT59a46AVD3Y0Bd6q863AjKpLo4uTb0HCzLmtZe+iZz7/9c5VLnX6/JItDVfKQ9sMIMyEVRgqP5Cywfprf7SS1lKDZDKFJxR5rqC8aOXvAkMrD04MosbFHNb7OdT0KbBDuYzP4X8P/nE5wcD+iQsvAsgolrOnv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o30MvfUp; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC58bi3393345
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745841908;
	bh=q+GVsZWnoS5nmRtEMNMV00DrIRXTh5+Y65jXU6cuPT0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=o30MvfUpVOOWvdaeaNAsbGIIfBoFVS/pLK1CiYc5QzyJcmUtkv7gfGWDG8SUHpZDY
	 9RJhqMVbdevNacaVsdqoNvU5Y7gy3j45zG4ovjhbbQC+3q/r8NPswb/DlZD0vxGE8U
	 cj+qUeHdtWQDGMDQToJqR5VkfXRr/aHsOnLu63M8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC58WJ119440
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 07:05:08 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 07:05:07 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 07:05:07 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SC57is098201;
	Mon, 28 Apr 2025 07:05:07 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53SC5687026332;
	Mon, 28 Apr 2025 07:05:07 -0500
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
Subject: [PATCH net 1/4] net: ti: icssg-prueth: Set XDP feature flags for ndev
Date: Mon, 28 Apr 2025 17:34:56 +0530
Message-ID: <20250428120459.244525-2-m-malladi@ti.com>
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

xdp_features demonstrates what all XDP capabilities are supported
on a given network device. The driver needs to set these xdp_features
flag to let the network stack know what XDP features a given driver
is supporting. These flags need to be set for a given ndev irrespective
of any XDP program being loaded or not.

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 443f90fa6557..ee35fecf61e7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1109,11 +1109,6 @@ static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame
 static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
 {
 	struct bpf_prog *prog = bpf->prog;
-	xdp_features_t val;
-
-	val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-	      NETDEV_XDP_ACT_NDO_XMIT;
-	xdp_set_features_flag(emac->ndev, val);
 
 	if (!emac->xdpi.prog && !prog)
 		return 0;
@@ -1291,6 +1286,10 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
 	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
+	xdp_set_features_flag(ndev,
+			      NETDEV_XDP_ACT_BASIC |
+			      NETDEV_XDP_ACT_REDIRECT |
+			      NETDEV_XDP_ACT_NDO_XMIT);
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	hrtimer_setup(&emac->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
-- 
2.43.0


