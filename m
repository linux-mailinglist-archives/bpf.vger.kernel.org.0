Return-Path: <bpf+bounces-48022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D321A0329A
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE371886358
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9691E3780;
	Mon,  6 Jan 2025 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5fN6iev"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124E1E1C3F;
	Mon,  6 Jan 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201985; cv=none; b=FijHrg+Kctl7wvIO3hE7t7O6Nv6d92KXIl5hJe5b1ZXF4F7ZWDxDaFIJEERPtFW59BFu3/PrwhGZvxlECQqLk7o7UehrpAk/RP15JfKGbZbnCMvAzRGiLMA2STlT7IQElmo54CU76JjPvqCjpKNu1bu9ablQ9J15CLLxIlHjuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201985; c=relaxed/simple;
	bh=YdEzWtqIfTJtqE1nyjyj6ZOF7MPuE/ukD59VxrgNk/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfI5C6p5rScFK+681TmCDG+TtNuvfem/f8FC+Z4yLjZbpizl2wtBjXZXkBql5MmKrcpz15UMrk2av55yl0t6rFE8mKKXXGKOWvvm8UE1HNOBFSsEeK5Mo5EHO/ZJgUskxEVyEC0peQc3CRdrrPcrCEahVHSOIPZCB35KsKl+noA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5fN6iev; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201983; x=1767737983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdEzWtqIfTJtqE1nyjyj6ZOF7MPuE/ukD59VxrgNk/M=;
  b=Q5fN6ievNq0SOIMyxTyon9SV73g6GE7Pj6BI857+OZ1+oB3wpmuPsNeD
   a7zxoN8GRsamXsZNYxT2z+An1+pjU5tl6yml5BCq2eX3aTkZJGXsNffZs
   SWR1Qvw7yiBHHoUXssDfdVrbqCpk8jbphNaw1njPXkS1Ailv6vwsH/zX8
   r0QOzZdKMXoyvAO6OR1G4tVtNWH0i+KHd24ybZQ08vKSSmo5FLOSBCVyK
   WJtK5AVqO8ITyqrF/yFOr8n/ux8xMFwJEUTeNxZE/mZEXNFo5PJUS01Ez
   kuEPck48gm6yiR0LZGIep2uePS05mhS3WryXwJvKFuq/zqTQ/FSfr9Caa
   A==;
X-CSE-ConnectionGUID: 5ZM+cTOGQHKgT6HqrfvP/A==
X-CSE-MsgGUID: 9gzeeSDERUqidlR+65RCxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858740"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858740"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:40 -0800
X-CSE-ConnectionGUID: e8AJ7yT0R3q0UAxy77yRNg==
X-CSE-MsgGUID: V5PUvApBRV6iz67GQt1Kmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368479"
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
Subject: [PATCH net-next 10/15] ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
Date: Mon,  6 Jan 2025 14:19:18 -0800
Message-ID: <20250106221929.956999-11-anthony.l.nguyen@intel.com>
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

ixgbe_run_xdp() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
ixgbe_clean_rx_irq(). Remove this error pointer handing instead use
plain int return value.

Fixes: 924708081629 ("ixgbe: add XDP support for pass and drop actions")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 336e08d35f97..7236f20c9a30 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1923,10 +1923,6 @@ bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
 {
 	struct net_device *netdev = rx_ring->netdev;
 
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	/* Verify netdev is present, and that packet does not have any
 	 * errors that would be unacceptable to the netdev.
 	 */
@@ -2234,9 +2230,9 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
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
@@ -2286,7 +2282,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 		break;
 	}
 xdp_out:
-	return ERR_PTR(-result);
+	return result;
 }
 
 static unsigned int ixgbe_rx_frame_truesize(struct ixgbe_ring *rx_ring,
@@ -2344,6 +2340,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	unsigned int offset = rx_ring->rx_offset;
 	unsigned int xdp_xmit = 0;
 	struct xdp_buff xdp;
+	int xdp_res = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
@@ -2389,12 +2386,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
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
@@ -2414,7 +2409,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -2428,7 +2423,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
+		if (xdp_res || ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
 			continue;
 
 		/* probably a little skewed due to removing CRC */
-- 
2.47.1


