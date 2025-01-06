Return-Path: <bpf+bounces-48021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2BA03298
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43181164A5B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A02B1E32D9;
	Mon,  6 Jan 2025 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2E5i7Wa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371F1E2310;
	Mon,  6 Jan 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201984; cv=none; b=q/W3o3SZEbp5HtJcbhm/botfXpIdBKvZbLBlJhjqDLejTb/9a8Jc4dtNbpbtCgux7iikweq6JiWWnNsMJuwmKpPrVukoz8u6SeP/JxYKJqMU1+q8VZLynGLnOUndYb0rx+RnhZSlwGg5hbBfWKx9/B7uHE90AyTGrCdL1oDwQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201984; c=relaxed/simple;
	bh=P9LzlPgZI2C1hgTjU0QYrPJq0+RO/+c9SzrFkbpUhzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juKZ6wSHesOh5CCa1CQcd19xVff5Lgj/VURf5Pc51FaNN6OPDOZi2Kr7m4hQ9nLq0OOHHNBoXYTHBBtLfqS0RQbFnlzLsWywM+Ppz2vKVUbBJ6FooF1VXEutydVR07aoLDrEQI8koo1aQdPV8UsPRz8fKVUHLPwGEuANwMk8SBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2E5i7Wa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201982; x=1767737982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9LzlPgZI2C1hgTjU0QYrPJq0+RO/+c9SzrFkbpUhzY=;
  b=d2E5i7WaqK51Vcfete8eOu6w7Ci7IOv/sfwm4sZ6A0zPlh6bnYaGXAVO
   5BkCpqfoqeasmzNbQfNgOx/7XCYwUSA5b8GcSqo0PBCbWc+9S3HxwTzFW
   RhpiHyhbTHWWa8na084t+CM0HkxBNXhtYYsg3FA58yDnSTQsqMskHObAG
   b6ChMYgjKc942Thx0BXOt/Y5NFo5arNjjd/iStmWyPUBl9GPcF6Tsr7QY
   +y3XfQ5n08Gwf9vNeIxWEYaXMaxGR+L3uq6W701mOUg9IVrJq6Av+ghjh
   Y1r90w5CttlHw5nZJRze5IoI7CoTA+XuE7Wj7m6TiivCZ7CF2gfsf6QWc
   g==;
X-CSE-ConnectionGUID: 79OR1/JPQ2eOtpknFrIZRA==
X-CSE-MsgGUID: Vym5zbCJQJuh4ors1hJNFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858729"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858729"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:40 -0800
X-CSE-ConnectionGUID: eqf9JjIcQQak3+2HJC62Kg==
X-CSE-MsgGUID: 9RAHV6NVRtKyXcA6dZWC8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368476"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:39 -0800
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
	horms@kernel.org,
	sven.auhagen@voleatech.de,
	Jacob Keller <jacob.e.keller@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net-next 09/15] igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
Date: Mon,  6 Jan 2025 14:19:17 -0800
Message-ID: <20250106221929.956999-10-anthony.l.nguyen@intel.com>
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

igb_run_xdp() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
igb_clean_rx_irq(). Remove this error pointer handing instead use plain
int return value.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a466e97d8ccd..d368b753a467 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8658,9 +8658,8 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
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
@@ -8700,7 +8699,7 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	}
 xdp_out:
-	return ERR_PTR(-result);
+	return result;
 }
 
 static unsigned int igb_rx_frame_truesize(struct igb_ring *rx_ring,
@@ -8826,10 +8825,6 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
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
@@ -8983,6 +8978,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
+	int xdp_res = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
@@ -9040,12 +9036,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
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
@@ -9064,7 +9058,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 						&xdp, timestamp);
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -9078,7 +9072,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 			continue;
 
 		/* verify the packet layout is correct */
-		if (igb_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res || igb_cleanup_headers(rx_ring, rx_desc, skb)) {
 			skb = NULL;
 			continue;
 		}
-- 
2.47.1


