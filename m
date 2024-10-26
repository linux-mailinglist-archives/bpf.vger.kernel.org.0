Return-Path: <bpf+bounces-43202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB21F9B1476
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 05:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8961C22488
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1001922CF;
	Sat, 26 Oct 2024 03:57:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4817965E;
	Sat, 26 Oct 2024 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915074; cv=none; b=dPX+tgFQGtpGbyb4V3ZXamkwUbvN2R6kaSDnpvA7zoWl4uTU6DxOWYbY+wZo15EU6AT5KJB7pRTjU8fcoWJbaoqO3WR0xUY1OjbWieUgHqnKIXHV3JZIAhaVIi8GpUTTQeEBnnyGKPS0I/ZjDVc8Rk830NWyRozQXl4v0l7Tmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915074; c=relaxed/simple;
	bh=lZ1bnjQFeXfWkJLEQSnLHKuLo0tlD67J4Hgui1RoWjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eImbwjLDB5Zst/Y1S3XKJ/k4507Nvf5lrC6WeSP+8LnwATaFkXNZ7mr+uw/bPFgpeR2SwcI0wRm8HqUmvVbW+BwN3Q8JcMU1fIuqJT9ya5RVXdIAPkgkf+PHLLuFW+e/60dCznLz1Y7K4Zd/W8BqqNJc7MdJl+0tBXY7olw+Y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xb5RY34p4zyTlL;
	Sat, 26 Oct 2024 11:56:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D9C751800DB;
	Sat, 26 Oct 2024 11:57:43 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 11:57:42 +0800
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
Subject: [PATCH v4 net-next 2/4] igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
Date: Sat, 26 Oct 2024 12:12:47 +0800
Message-ID: <20241026041249.1267664-3-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241026041249.1267664-1-yuehaibing@huawei.com>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

igb_run_xdp() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
igb_clean_rx_irq(). Remove this error pointer handing instead use plain
int return value.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f1d088168723..50c23dfcf304 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8584,9 +8584,8 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 	return skb;
 }
 
-static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
-				   struct igb_ring *rx_ring,
-				   struct xdp_buff *xdp)
+static int igb_run_xdp(struct igb_adapter *adapter, struct igb_ring *rx_ring,
+		       struct xdp_buff *xdp)
 {
 	int err, result = IGB_XDP_PASS;
 	struct bpf_prog *xdp_prog;
@@ -8626,7 +8625,7 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	}
 xdp_out:
-	return ERR_PTR(-result);
+	return result;
 }
 
 static unsigned int igb_rx_frame_truesize(struct igb_ring *rx_ring,
@@ -8752,10 +8751,6 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
 				union e1000_adv_rx_desc *rx_desc,
 				struct sk_buff *skb)
 {
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	if (unlikely((igb_test_staterr(rx_desc,
 				       E1000_RXDEXT_ERR_FRAME_ERR_MASK)))) {
 		struct net_device *netdev = rx_ring->netdev;
@@ -8879,6 +8874,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
+	int xdp_res = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
@@ -8936,12 +8932,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
 			xdp.frame_sz = igb_rx_frame_truesize(rx_ring, size);
 #endif
-			skb = igb_run_xdp(adapter, rx_ring, &xdp);
+			xdp_res = igb_run_xdp(adapter, rx_ring, &xdp);
 		}
 
-		if (IS_ERR(skb)) {
-			unsigned int xdp_res = -PTR_ERR(skb);
-
+		if (xdp_res) {
 			if (xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR)) {
 				xdp_xmit |= xdp_res;
 				igb_rx_buffer_flip(rx_ring, rx_buffer, size);
@@ -8960,7 +8954,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 						&xdp, timestamp);
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -8974,7 +8968,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 			continue;
 
 		/* verify the packet layout is correct */
-		if (igb_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res || igb_cleanup_headers(rx_ring, rx_desc, skb)) {
 			skb = NULL;
 			continue;
 		}
-- 
2.34.1


