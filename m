Return-Path: <bpf+bounces-20046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FFE8375F3
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6452287544
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270548CFA;
	Mon, 22 Jan 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPuDRHIs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91120495C1;
	Mon, 22 Jan 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961797; cv=none; b=XtRQYlFqDmWvWsA329gw9YOM4RTUvOlAuay3sLASCaUQ73dY763WHjKqtAIVaN1ZM3S8CcB8lOsIsqCymo1KdhxfXP7682+iYPDhaPBtjQS0zgq2k+AKKe0+LH8WA9q6rQpYL83xFERYHOApY4e1+QsJU8mMTXow63avFdUBkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961797; c=relaxed/simple;
	bh=wqytYehJ0f65mZf/YLqmrftMhhzrOoyWw5t1Qbw4MZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmuoZIAbA451n3StEi0+K7rRnYmYI0AMYU7CCeE0qGhTJTGoHPdMCf8IaETC9BaKlhvOyd2vghgQe6nqAde0NXwxlDv/3g/3m4yfk2Ac8MpjeoMNaMaH2ZGCWT2Fx8RQj1cZ9EUXHYlPR26iVMjjxkWgNHAmpJn/ZexhmRpJmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPuDRHIs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961796; x=1737497796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wqytYehJ0f65mZf/YLqmrftMhhzrOoyWw5t1Qbw4MZg=;
  b=JPuDRHIsa+eBtgj2nz7QxS9mW6VavHs9eAn7AABdtDkjVi8PIwXeAvtK
   y49ZAmVUuv9j6iO29NdnEV4X2SBmbcE1Kda7jFUrXjl8SCEXrpPFICPJC
   dqNBht52JzYd4F04A5CXDFqajsiQ8QJ/waS9gvzTNb2yb8MLaDKJRILJP
   JFmjTIuNdX3ldAOkWSHTTQSYq4phycf012vRlgKg5dk6tQLJmoQfWBrZd
   HF600vgNOhQ8Wes1uNbZ2lBEa4ofid1KSoT1hCDfc/IiR+S6PMGLPS33x
   62kgJvON76bMnqpMDBj42majpcnSaKLr6g4Y2Y0grazY2pA6BtCOByo09
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995575"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360594"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:31 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH v5 bpf 05/11] i40e: handle multi-buffer packets that are shrunk by xdp prog
Date: Mon, 22 Jan 2024 23:16:04 +0100
Message-Id: <20240122221610.556746-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

XDP programs can shrink packets by calling the bpf_xdp_adjust_tail()
helper function. For multi-buffer packets this may lead to reduction of
frag count stored in skb_shared_info area of the xdp_buff struct. This
results in issues with the current handling of XDP_PASS and XDP_DROP
cases.

For XDP_PASS, currently skb is being built using frag count of
xdp_buffer before it was processed by XDP prog and thus will result in
an inconsistent skb when frag count gets reduced by XDP prog. To fix
this, get correct frag count while building the skb instead of using
pre-obtained frag count.

For XDP_DROP, current page recycling logic will not reuse the page but
instead will adjust the pagecnt_bias so that the page can be freed. This
again results in inconsistent behavior as the page refcnt has already
been changed by the helper while freeing the frag(s) as part of
shrinking the packet. To fix this, only adjust pagecnt_bias for buffers
that are stillpart of the packet post-xdp prog run.

Fixes: e213ced19bef ("i40e: add support for XDP multi-buffer Rx")
Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 40 ++++++++++++---------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b82df5bdfac0..377e05dc0c68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2099,7 +2099,8 @@ static void i40e_put_rx_buffer(struct i40e_ring *rx_ring,
 static void i40e_process_rx_buffs(struct i40e_ring *rx_ring, int xdp_res,
 				  struct xdp_buff *xdp)
 {
-	u32 next = rx_ring->next_to_clean;
+	u32 nr_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
+	u32 next = rx_ring->next_to_clean, i = 0;
 	struct i40e_rx_buffer *rx_buffer;
 
 	xdp->flags = 0;
@@ -2112,10 +2113,10 @@ static void i40e_process_rx_buffs(struct i40e_ring *rx_ring, int xdp_res,
 		if (!rx_buffer->page)
 			continue;
 
-		if (xdp_res == I40E_XDP_CONSUMED)
-			rx_buffer->pagecnt_bias++;
-		else
+		if (xdp_res != I40E_XDP_CONSUMED)
 			i40e_rx_buffer_flip(rx_buffer, xdp->frame_sz);
+		else if (i++ <= nr_frags)
+			rx_buffer->pagecnt_bias++;
 
 		/* EOP buffer will be put in i40e_clean_rx_irq() */
 		if (next == rx_ring->next_to_process)
@@ -2129,20 +2130,20 @@ static void i40e_process_rx_buffs(struct i40e_ring *rx_ring, int xdp_res,
  * i40e_construct_skb - Allocate skb and populate it
  * @rx_ring: rx descriptor ring to transact packets on
  * @xdp: xdp_buff pointing to the data
- * @nr_frags: number of buffers for the packet
  *
  * This function allocates an skb.  It then populates it with the page
  * data from the current receive descriptor, taking care to set up the
  * skb correctly.
  */
 static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
-					  struct xdp_buff *xdp,
-					  u32 nr_frags)
+					  struct xdp_buff *xdp)
 {
 	unsigned int size = xdp->data_end - xdp->data;
 	struct i40e_rx_buffer *rx_buffer;
+	struct skb_shared_info *sinfo;
 	unsigned int headlen;
 	struct sk_buff *skb;
+	u32 nr_frags = 0;
 
 	/* prefetch first cache line of first page */
 	net_prefetch(xdp->data);
@@ -2180,6 +2181,10 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 	memcpy(__skb_put(skb, headlen), xdp->data,
 	       ALIGN(headlen, sizeof(long)));
 
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+	}
 	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
 	/* update all of the pointers */
 	size -= headlen;
@@ -2199,9 +2204,8 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 	}
 
 	if (unlikely(xdp_buff_has_frags(xdp))) {
-		struct skb_shared_info *sinfo, *skinfo = skb_shinfo(skb);
+		struct skb_shared_info *skinfo = skb_shinfo(skb);
 
-		sinfo = xdp_get_shared_info_from_buff(xdp);
 		memcpy(&skinfo->frags[skinfo->nr_frags], &sinfo->frags[0],
 		       sizeof(skb_frag_t) * nr_frags);
 
@@ -2224,17 +2228,17 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
  * i40e_build_skb - Build skb around an existing buffer
  * @rx_ring: Rx descriptor ring to transact packets on
  * @xdp: xdp_buff pointing to the data
- * @nr_frags: number of buffers for the packet
  *
  * This function builds an skb around an existing Rx buffer, taking care
  * to set up the skb correctly and avoid any memcpy overhead.
  */
 static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
-				      struct xdp_buff *xdp,
-				      u32 nr_frags)
+				      struct xdp_buff *xdp)
 {
 	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct skb_shared_info *sinfo;
 	struct sk_buff *skb;
+	u32 nr_frags;
 
 	/* Prefetch first cache line of first page. If xdp->data_meta
 	 * is unused, this points exactly as xdp->data, otherwise we
@@ -2243,6 +2247,11 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 	 */
 	net_prefetch(xdp->data_meta);
 
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+	}
+
 	/* build an skb around the page buffer */
 	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
 	if (unlikely(!skb))
@@ -2255,9 +2264,6 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 		skb_metadata_set(skb, metasize);
 
 	if (unlikely(xdp_buff_has_frags(xdp))) {
-		struct skb_shared_info *sinfo;
-
-		sinfo = xdp_get_shared_info_from_buff(xdp);
 		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size,
 					   nr_frags * xdp->frame_sz,
@@ -2602,9 +2608,9 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			total_rx_bytes += size;
 		} else {
 			if (ring_uses_build_skb(rx_ring))
-				skb = i40e_build_skb(rx_ring, xdp, nfrags);
+				skb = i40e_build_skb(rx_ring, xdp);
 			else
-				skb = i40e_construct_skb(rx_ring, xdp, nfrags);
+				skb = i40e_construct_skb(rx_ring, xdp);
 
 			/* drop if we failed to retrieve a buffer */
 			if (!skb) {
-- 
2.34.1


