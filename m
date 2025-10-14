Return-Path: <bpf+bounces-70887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0237BBD8D83
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B561242411E
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F8306B08;
	Tue, 14 Oct 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NViuIYzE"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC52FDC55;
	Tue, 14 Oct 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439430; cv=none; b=jfMEp58p1b7UgtJVeGNFXUDijae5VJr1NPvgfV7dEdX17WHAC1fYz1vTAQuufZiHz/PgIt0jCvVtvmzI0HiNx3l6jt45LzFT9hTFFombNE6ISeEx22cxkt5haUqV18m9WvvS8NcLo7MNpcD4ESD/mWKkv42ZVPA0gLP5ceIE+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439430; c=relaxed/simple;
	bh=SgLT88p73unqoGLgqgewCnupBfsN2oHsCvUjfZbB+vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5dvb/RFDCUpl1Dvofg/Rf0Be8Txghd0LUzku/neomSRS3vU8F7s6Qun+xZ6yybLSkETF331bO32oTDi9+N9+l/ZUDSe1cInYWcgwRPj9dOyKvy4en8LmkYEh/BcLYvpdDeaMRostcGP0PMh6FXPqSvZQ4NhIgpWaxVwFZinpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NViuIYzE; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59EAubh41487485;
	Tue, 14 Oct 2025 05:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760439397;
	bh=4I9IeP5+v23+fU9SgOJKXWPke6g0irOYHRWxEeXH2CE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NViuIYzE9BrqSHlrAbA3dMJVsw67+Yeu0gms3JAyt+E1o/OgoYrZKO0+NxCjsstWk
	 tt3IRql9i9ZtZ+x0f+AImu2TPUlSqh7eWEdJXXcnv//0YxVmzIlnhX7t2fmbBq8D1Z
	 UGWqUMqZx2agTUmc5VlIT2iKxyHbKuxP+UqxFHTI=
Received: from DFLE215.ent.ti.com (dfle215.ent.ti.com [10.64.6.73])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59EAub39387009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 05:56:37 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 05:56:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 05:56:36 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59EAuaHE3439828;
	Tue, 14 Oct 2025 05:56:36 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 59EAuZQR010693;
	Tue, 14 Oct 2025 05:56:36 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <horms@kernel.org>, <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <christian.koenig@amd.com>,
        <sumit.semwal@linaro.org>, <sdf@fomichev.me>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 6/6] net: ti: icssg-prueth: Enable zero copy in XDP features
Date: Tue, 14 Oct 2025 16:26:12 +0530
Message-ID: <20251014105613.2808674-7-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014105613.2808674-1-m-malladi@ti.com>
References: <20251014105613.2808674-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Enable the zero copy feature flag in xdp_set_features_flag()
for a given ndev to get the AF-XDP zero copy support running
for both Tx and Rx.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 92f2c33affda..9894f1f30b58 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1545,7 +1545,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	xdp_set_features_flag(ndev,
 			      NETDEV_XDP_ACT_BASIC |
 			      NETDEV_XDP_ACT_REDIRECT |
-			      NETDEV_XDP_ACT_NDO_XMIT);
+			      NETDEV_XDP_ACT_NDO_XMIT |
+			      NETDEV_XDP_ACT_XSK_ZEROCOPY);
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	hrtimer_setup(&emac->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
-- 
2.43.0


