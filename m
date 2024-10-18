Return-Path: <bpf+bounces-42364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E009A3298
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 04:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BEA1F2467A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC216F0CF;
	Fri, 18 Oct 2024 02:20:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752015383B;
	Fri, 18 Oct 2024 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218053; cv=none; b=A3u93sqqjc1IHzai7CjTana0JOFjLPPNN99xIcarKJi8l8sNX5za+aHx3f0uHpBKzAzCvqD9QjGtcGRgjCuHb51UM8QocrUKXCHfOq76aL7hAo6l0ofky+NNXIvuABPdbRgYXR6hahcHUFtE3MD9BW5RmWXDBtBPtsA5dYLJE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218053; c=relaxed/simple;
	bh=ZAdOfCJflPq+GrEYfUATws0guiiEbaONG0bAC5Q5BOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kvz6V1ZtYSDjFe4wRzYIriF4vivFpBafT75bpdst30RxgMwIrwbVx1p9yqOpYCG9vv46d1MclyRZYUTRR4cbIoYEqkoeIfQPObJHpugJFSPi56WOEK1f4jkJEvNrN7sUJaeCqJniIY6zKlYqxkYHrcIftlcUkUHHdYwIzeuM9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XV7fP3pNpzfdHD;
	Fri, 18 Oct 2024 10:18:21 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CDCD1402C8;
	Fri, 18 Oct 2024 10:20:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 10:20:48 +0800
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
Subject: [PATCH v2 net 4/4] ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()
Date: Fri, 18 Oct 2024 10:37:34 +0800
Message-ID: <20241018023734.1912166-5-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018023734.1912166-1-yuehaibing@huawei.com>
References: <20241018023734.1912166-1-yuehaibing@huawei.com>
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

ixgbevf_run_xdp() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use
plain int return value.

Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 149911e3002a..183d2305d058 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -732,10 +732,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
 				    union ixgbe_adv_rx_desc *rx_desc,
 				    struct sk_buff *skb)
 {
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	/* verify that the packet does not have any known errors */
 	if (unlikely(ixgbevf_test_staterr(rx_desc,
 					  IXGBE_RXDADV_ERR_FRAME_ERR_MASK))) {
@@ -1044,9 +1040,9 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 	return IXGBEVF_XDP_TX;
 }
 
-static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
-				       struct ixgbevf_ring  *rx_ring,
-				       struct xdp_buff *xdp)
+static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
+			   struct ixgbevf_ring *rx_ring,
+			   struct xdp_buff *xdp)
 {
 	int result = IXGBEVF_XDP_PASS;
 	struct ixgbevf_ring *xdp_ring;
@@ -1080,7 +1076,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 		break;
 	}
 xdp_out:
-	return ERR_PTR(-result);
+	return result;
 }
 
 static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
@@ -1122,6 +1118,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	struct sk_buff *skb = rx_ring->skb;
 	bool xdp_xmit = false;
 	struct xdp_buff xdp;
+	int xdp_res;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
@@ -1165,11 +1162,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
 			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
 #endif
-			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
+			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
 		}
 
-		if (IS_ERR(skb)) {
-			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX) {
+		if (xdp_res) {
+			if (xdp_res == IXGBEVF_XDP_TX) {
 				xdp_xmit = true;
 				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
 						       size);
@@ -1189,7 +1186,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -1203,7 +1200,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
 			skb = NULL;
 			continue;
 		}
-- 
2.34.1


