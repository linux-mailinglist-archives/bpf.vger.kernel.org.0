Return-Path: <bpf+bounces-42752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA49A9A0B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931881F22C2C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D90314BF8F;
	Tue, 22 Oct 2024 06:38:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6E145B27;
	Tue, 22 Oct 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579134; cv=none; b=UYXS3dfhp25s1wQurSDd3YDOLOtEEY48Bx+4NiDtT4XUDNLBBppyFyO+ujcKhGe2PhU/8CwU2aJXSolkiWgdXFaaBeomZn0LVpAoC/0Vy7mzVdlzY/Ta3lRWqKESRrOyMScwxZ8M8WA7ZMrGM/4kbVBfGagW34GJaDcIrdPwLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579134; c=relaxed/simple;
	bh=iaOiwIF8M85ipvbpNznTo6qOvgcrsGD+lgT21q9ydjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZZDZUeoJFQvbPY4iJ/oqSHi+itZPbjwPi30ZnsWeVrS7LATTmFW+CyJ0GWTHn2LosUKXf9ZCUfiZjhu6cwnc8VznT1sZ4q1MJDQtnRVpbi3tEM4UszCoypeDmh2eraZXUzTUw42t0if3RguL/yhAZTV/Mb4zMov+4NywAsOLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXjCW6f2zz1jBNx;
	Tue, 22 Oct 2024 14:37:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AA6818002B;
	Tue, 22 Oct 2024 14:38:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 14:38:48 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v3 net 3/4] ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
Date: Tue, 22 Oct 2024 14:56:22 +0800
Message-ID: <20241022065623.1282224-4-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022065623.1282224-1-yuehaibing@huawei.com>
References: <20241022065623.1282224-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

ixgbe_run_xdp() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
ixgbe_clean_rx_irq(). Remove this error pointer handing instead use
plain int return value.

Fixes: 924708081629 ("ixgbe: add XDP support for pass and drop actions")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8b8404d8c946..78bf97ab0524 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1908,10 +1908,6 @@ bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
 {
 	struct net_device *netdev = rx_ring->netdev;
 
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	/* Verify netdev is present, and that packet does not have any
 	 * errors that would be unacceptable to the netdev.
 	 */
@@ -2219,9 +2215,9 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 	return skb;
 }
 
-static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
-				     struct ixgbe_ring *rx_ring,
-				     struct xdp_buff *xdp)
+static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
+			 struct ixgbe_ring *rx_ring,
+			 struct xdp_buff *xdp)
 {
 	int err, result = IXGBE_XDP_PASS;
 	struct bpf_prog *xdp_prog;
@@ -2271,7 +2267,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 		break;
 	}
 xdp_out:
-	return ERR_PTR(-result);
+	return result;
 }
 
 static unsigned int ixgbe_rx_frame_truesize(struct ixgbe_ring *rx_ring,
@@ -2329,6 +2325,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	unsigned int offset = rx_ring->rx_offset;
 	unsigned int xdp_xmit = 0;
 	struct xdp_buff xdp;
+	int xdp_res = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
@@ -2374,12 +2371,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
 			xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, size);
 #endif
-			skb = ixgbe_run_xdp(adapter, rx_ring, &xdp);
+			xdp_res = ixgbe_run_xdp(adapter, rx_ring, &xdp);
 		}
 
-		if (IS_ERR(skb)) {
-			unsigned int xdp_res = -PTR_ERR(skb);
-
+		if (xdp_res) {
 			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
 				xdp_xmit |= xdp_res;
 				ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
@@ -2399,7 +2394,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -2413,7 +2408,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
+		if (xdp_res || ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
 			continue;
 
 		/* probably a little skewed due to removing CRC */
-- 
2.34.1


