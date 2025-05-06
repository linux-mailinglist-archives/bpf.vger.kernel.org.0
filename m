Return-Path: <bpf+bounces-57507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF99AAC20B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E207B6FD6
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3827AC23;
	Tue,  6 May 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AkYVsM6T"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314A278E4C;
	Tue,  6 May 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529598; cv=none; b=bjJSk/BKSRYjyhafxbPhTQQqMLA+lR3Gfv6Vm1/8XHXOzPz4jXH7YliyC5/6IdW62P7Sna/CwtwKCGyQZZIiLN7onamQxelQpbOypHm08FWlKV3sqWKlK5v1bTBAl7DSlDbtW7lpPHYJAzL/Uxr7YR6YwZJAJS2RMA9dx4bejZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529598; c=relaxed/simple;
	bh=n6tPFBDBE/AoUx8+fT4xmiJ8DuWqqSs6nsXV22sbwkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1sOs0HkA3+1qnLWvt3gAmXet08JAT3q6scd/I25391JTbJ691iJDkTCIm2gbdBgAy8GDn6KFcSqoOWGyKAdyF2xZ1SxK3rFbyYwdoOJQIlf2OnUmtnb0awVFFObkR8dcEr7cKIMjp+mcelEduAxn+6siXImaF87LD5q/tQVYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AkYVsM6T; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546B5tNH1215272
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746529555;
	bh=q+GVsZWnoS5nmRtEMNMV00DrIRXTh5+Y65jXU6cuPT0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AkYVsM6T/utII73xP2x90ZHYLpufZvg9TxEc3roRETLDrlzAudfbqjLRN9UIkHoNy
	 nQZuzurJvcyzFgT0xKlyG+Y3sPXbCLZpXEG9qlSSL5U33oxMuHWwvGNtDO4rjmc/sg
	 93kf6sPsRoxyNSw4Xof8vfahFOQoilh7axjcu7+I=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546B5sEe024298
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 May 2025 06:05:55 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 06:05:54 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 06:05:54 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546B5sH3120214;
	Tue, 6 May 2025 06:05:54 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 546B5rHH010337;
	Tue, 6 May 2025 06:05:53 -0500
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
Subject: [PATCH net v2 1/3] net: ti: icssg-prueth: Set XDP feature flags for ndev
Date: Tue, 6 May 2025 16:35:44 +0530
Message-ID: <20250506110546.4065715-2-m-malladi@ti.com>
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


