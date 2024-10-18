Return-Path: <bpf+bounces-42363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0574C9A3296
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 04:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F021F2462B
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B716BE17;
	Fri, 18 Oct 2024 02:20:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593B14A611;
	Fri, 18 Oct 2024 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218053; cv=none; b=nMfHIgz6ylog91UNc2r3ZzIXX5ROLBnA8HcGP8Mux2+5VA2Ybj6L9De7nDwayYhmEojf93P1bxFgDvBLwgUmEmFsDtVgL1s8O5n/dDjv6NJ2Ui9FCAcFLWsfFfLI+itSTPcbIC3o7M5QFCTt4UI+TIfsGnkJPAsrgs+2eADB03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218053; c=relaxed/simple;
	bh=Tj/tKyJPMhb1CaFlHl7vpQi6VQrw6dIc6BuUMFP1ILM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw4lHgyiTxUKa2sGXY4pXTst3fZYn74s9JGyPF0fVyzeG/FJb4IpF/hT/CZ0gnwMv2VQf/WYNvvL4kH4TAVvwrHwaG/e7x27YA3j9di3aW6vY5zOVK429p6jKTX3C65+rdaIYtEX5QKR50huOvUtw9H0kl2uEU/Emg5nExvhGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XV7fL4yq0zfdHK;
	Fri, 18 Oct 2024 10:18:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 83C91180087;
	Fri, 18 Oct 2024 10:20:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 10:20:45 +0800
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
Subject: [PATCH v2 net 1/4] igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
Date: Fri, 18 Oct 2024 10:37:31 +0800
Message-ID: <20241018023734.1912166-2-yuehaibing@huawei.com>
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

igc_xdp_run_prog() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
igc_clean_rx_irq(). Remove this error pointer handing instead use plain
int return value to fix this smatch warnings:

drivers/net/ethernet/intel/igc/igc_main.c:2533
 igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'

Fixes: 26575105d6ed ("igc: Add initial XDP support")
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


