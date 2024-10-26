Return-Path: <bpf+bounces-43201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A09B1473
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 05:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98305283478
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 03:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F41898E8;
	Sat, 26 Oct 2024 03:57:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454F178CF6;
	Sat, 26 Oct 2024 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915073; cv=none; b=gSoONY0uzIKgVz3wsqmWsyQv80AMjP91OF1esbzqsNad7CSn4IpAil9SBKo3hpa5BxeFNbWvx/V7oe1vjU+yC1iq/w3dVXwHEk6nEcemYpdA3RlPOy37a7IlFjWcHkxxVYJNtzc5h4i43jSj+I1C23cZEqFZwNOdq5+yTBsbDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915073; c=relaxed/simple;
	bh=HEdK7Cl/NMR0ubFOMazAruj8y/1j7/+ZqT5IBWle8NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM8LwBohlOnjdJ7aWPLJhD1T67Td3+kt23BBdYMXobmUQloJhS1ZD9y1cd2l/jMkSuiqzcayO1T2kSfjLrNK0reqJg+5+tFanBSXkBk9M1yYl2qdEYD4tpQQqFFf/4kZ/zk8YFuK/+NZFyzZx3SzD6MFERNuOlqpiD8TZf1gu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xb5RX3P6kzyTjN;
	Sat, 26 Oct 2024 11:56:08 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E7FF6140258;
	Sat, 26 Oct 2024 11:57:42 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 11:57:41 +0800
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
Subject: [PATCH v4 net-next 1/4] igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
Date: Sat, 26 Oct 2024 12:12:46 +0800
Message-ID: <20241026041249.1267664-2-yuehaibing@huawei.com>
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

igc_xdp_run_prog() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
igc_clean_rx_irq(). Remove this error pointer handing instead use plain
int return value to fix this smatch warnings:

drivers/net/ethernet/intel/igc/igc_main.c:2533
 igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'

Fixes: 26575105d6ed ("igc: Add initial XDP support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..5e44c2546a12 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2123,10 +2123,6 @@ static bool igc_cleanup_headers(struct igc_ring *rx_ring,
 				union igc_adv_rx_desc *rx_desc,
 				struct sk_buff *skb)
 {
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	if (unlikely(igc_test_staterr(rx_desc, IGC_RXDEXT_STATERR_RXE))) {
 		struct net_device *netdev = rx_ring->netdev;
 
@@ -2515,8 +2511,7 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
 	}
 }
 
-static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
-					struct xdp_buff *xdp)
+static int igc_xdp_run_prog(struct igc_adapter *adapter, struct xdp_buff *xdp)
 {
 	struct bpf_prog *prog;
 	int res;
@@ -2530,7 +2525,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 	res = __igc_xdp_run_prog(adapter, prog, xdp);
 
 out:
-	return ERR_PTR(-res);
+	return res;
 }
 
 /* This function assumes __netif_tx_lock is held by the caller. */
@@ -2585,6 +2580,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = igc_desc_unused(rx_ring);
 	int xdp_status = 0, rx_buffer_pgcnt;
+	int xdp_res = 0;
 
 	while (likely(total_packets < budget)) {
 		struct igc_xdp_buff ctx = { .rx_ts = NULL };
@@ -2630,12 +2626,10 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 			xdp_buff_clear_frags_flag(&ctx.xdp);
 			ctx.rx_desc = rx_desc;
 
-			skb = igc_xdp_run_prog(adapter, &ctx.xdp);
+			xdp_res = igc_xdp_run_prog(adapter, &ctx.xdp);
 		}
 
-		if (IS_ERR(skb)) {
-			unsigned int xdp_res = -PTR_ERR(skb);
-
+		if (xdp_res) {
 			switch (xdp_res) {
 			case IGC_XDP_CONSUMED:
 				rx_buffer->pagecnt_bias++;
@@ -2657,7 +2651,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_failed++;
 			rx_buffer->pagecnt_bias++;
 			set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
@@ -2672,7 +2666,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 			continue;
 
 		/* verify the packet layout is correct */
-		if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res || igc_cleanup_headers(rx_ring, rx_desc, skb)) {
 			skb = NULL;
 			continue;
 		}
-- 
2.34.1


