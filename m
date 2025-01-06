Return-Path: <bpf+bounces-48020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685BA03297
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B50016491F
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966E1E32BE;
	Mon,  6 Jan 2025 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HocDoRTz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9A1E2308;
	Mon,  6 Jan 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201983; cv=none; b=AWvLzHHKVawWO85/DiWVAwgzoQdyt2CLMtuM92U85BifOHkyGnJ3+0exHhJrcT4JCEt+6/QnkF2IDZNAFuCh2I1xjXqgaeaYp1643HiJzkMV44uUQIZ9X8vBmnViyf8qCbQWF/T/HZJ96xdj5GXXnG1Hf6Vlh/5pZ0H84TlZwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201983; c=relaxed/simple;
	bh=IQIZAuqLquG2SDwCSIq+H2RvwPCPND70qOHLo4aqBLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRWZZ7RcmoHlUD3IOZqVkQmVc+UkVmj4LzHLw8day1+McYjZjMBrvUQ4IEwMDu7Ga/BYDJFjup2pJf/KbCJXj6g4w5IFj+15u0jJ42yJBnJZmF8oACp+c9QQEajo0xOTEtKmNaSZDDybUYdVDhEZ2WRCiynY64uFoug1A5Th/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HocDoRTz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201982; x=1767737982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQIZAuqLquG2SDwCSIq+H2RvwPCPND70qOHLo4aqBLs=;
  b=HocDoRTzNG7yyESQFv160mUV7xhqyS6QKqVfg1ik7PFiY1BK+rTBSrMi
   hYXCkUEoz4nno2mufmx/YX5PUOKF9TfgwbrT2v6aRV7zzYomEaCfCghEA
   7ra81rLwkpi7+c+de8NDSeMXraYJrqp3AcRCoj4+VV+t9Ewv0SfJkJLS+
   R2ddpvdooF0Ek5pGnDK8UdjCuzhMZ+7p1eHW6KZLER6NUZ/Pqsix3zwnc
   0up2STGps0tfW8XKO6d/ctIRL1FDJJNUOcjKSPUjUY9vC3gWCXKI4ovza
   nb0s3LS1/3cOlYeZsqk3qlX1pS+hkkKP8E9QQpuFfzlHGLUdojSuozmHf
   Q==;
X-CSE-ConnectionGUID: b41bVaB+Q0yX+4RzzEC0jQ==
X-CSE-MsgGUID: elbYuVIKR9adJDntmXx9bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858719"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858719"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:39 -0800
X-CSE-ConnectionGUID: /tqwEAteRs+6ziX3MjNOKA==
X-CSE-MsgGUID: /z5Z58A/RIacG8Huqp8hcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368472"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	horms@kernel.org,
	sven.auhagen@voleatech.de,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 08/15] igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
Date: Mon,  6 Jan 2025 14:19:16 -0800
Message-ID: <20250106221929.956999-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..d6626761ed41 100644
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
2.47.1


