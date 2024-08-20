Return-Path: <bpf+bounces-37654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABB95900A
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 23:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F51F23689
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 21:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA921C7B86;
	Tue, 20 Aug 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Il6KrC8G"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E861C68B8;
	Tue, 20 Aug 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190992; cv=none; b=Qg8Ng6MdvtoYUsQExfylR5lbRDKicda3xzowNGzKvayheaHIcscYZwggel9rDnoGCkzH414LWPAIeSTc7Q4FrK/lVnTRbcVXq2BdizAsyO/+FmW0HsQWTf11RgrMNLL8Q5vE1FO6b+QomOlnof/0FjGepPYNdsUlxQdL1nEXvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190992; c=relaxed/simple;
	bh=Lb/Ehf65q7tsiYxP3mnqhYBxjHJUzbXChgkfsw1N1GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHG4IY1gij+oANUyI16l2L31jeRDOGsNAqfOd6F76BDA2NilYN61u9y+hWASxn/kHUsmDKTBiNLUFytwj52K9voW9+v0YSRot+GPwWQ/oK/hxUpBgL1f2HEt6m3bafGpFXF8UTsUuDVVoefiXazdAHrlVBWZnwYxyB/OYOzJqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Il6KrC8G; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190990; x=1755726990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lb/Ehf65q7tsiYxP3mnqhYBxjHJUzbXChgkfsw1N1GQ=;
  b=Il6KrC8G9uIoCvT2e3ah2rljN3iz7vs3DyFUK/J4FiSG+bJxRrJdMdCD
   U94IwhpQ+1QRf4eLtYuXYRCPHFsfdk3bWoa1ell0cmMyRItIalfUBFJGj
   vaP7sxHOqAVv1ig1q8B9i3YxSQLybnVsyfXBkTboHANMHvcpS/uUdWt0E
   vRrAjIijt8dg0xu95MBjLAgXAMt4SFe+lZgO3Z3C8rZCMI0SLHqmXzKHT
   +/tb0xQEhP1ajafTCYvpwzYDwLa5JyOepGmUrRgtQjQPn46IKVzfEHLp+
   gWUtpTTcYkBPzvJdh6dVsF3PYPqdUqmhcdvqcYGW5p2ymKJgwImQHeEZL
   w==;
X-CSE-ConnectionGUID: Pw+0EjOdTseD4wkHABknxg==
X-CSE-MsgGUID: FL7xxhKGScOdg9t7ZWBOKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39979354"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39979354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:56:27 -0700
X-CSE-ConnectionGUID: mBJTlRScQtGVJldGZ+160A==
X-CSE-MsgGUID: TGIdQL88R36zgnCVxF1d2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65833199"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2024 14:56:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 3/4] ice: fix truesize operations for PAGE_SIZE >= 8192
Date: Tue, 20 Aug 2024 14:56:17 -0700
Message-ID: <20240820215620.1245310-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

When working on multi-buffer packet on arch that has PAGE_SIZE >= 8192,
truesize is calculated and stored in xdp_buff::frame_sz per each
processed Rx buffer. This means that frame_sz will contain the truesize
based on last received buffer, but commit 1dc1a7e7f410 ("ice:
Centrallize Rx buffer recycling") assumed this value will be constant
for each buffer, which breaks the page recycling scheme and mess up the
way we update the page::page_offset.

To fix this, let us work on constant truesize when PAGE_SIZE >= 8192
instead of basing this on size of a packet read from Rx descriptor. This
way we can simplify the code and avoid calculating truesize per each
received frame and on top of that when using
xdp_update_skb_shared_info(), current formula for truesize update will
be valid.

This means ice_rx_frame_truesize() can be removed altogether.
Furthermore, first call to it within ice_clean_rx_irq() for 4k PAGE_SIZE
was redundant as xdp_buff::frame_sz is initialized via xdp_init_buff()
in ice_vsi_cfg_rxq(). This should have been removed at the point where
xdp_buff struct started to be a member of ice_rx_ring and it was no
longer a stack based variable.

There are two fixes tags as my understanding is that the first one
exposed us to broken truesize and page_offset handling and then second
introduced broken skb_shared_info update in ice_{construct,build}_skb().

Reported-and-tested-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/netdev/8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com/
Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 21 ++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c | 33 -----------------------
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1facf179a96f..f448d3a84564 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -512,6 +512,25 @@ static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
 	xsk_pool_fill_cb(ring->xsk_pool, &desc);
 }
 
+/**
+ * ice_get_frame_sz - calculate xdp_buff::frame_sz
+ * @rx_ring: the ring being configured
+ *
+ * Return frame size based on underlying PAGE_SIZE
+ */
+static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
+{
+	unsigned int frame_sz;
+
+#if (PAGE_SIZE >= 8192)
+	frame_sz = rx_ring->rx_buf_len;
+#else
+	frame_sz = ice_rx_pg_size(rx_ring) / 2;
+#endif
+
+	return frame_sz;
+}
+
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -576,7 +595,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
-	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, ice_get_frame_sz(ring), &ring->xdp_rxq);
 	ring->xdp.data = NULL;
 	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
 	err = ice_setup_rx_ctx(ring);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4b690952bb40..c9bc3f1add5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -521,30 +521,6 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 	return -ENOMEM;
 }
 
-/**
- * ice_rx_frame_truesize
- * @rx_ring: ptr to Rx ring
- * @size: size
- *
- * calculate the truesize with taking into the account PAGE_SIZE of
- * underlying arch
- */
-static unsigned int
-ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
-{
-	unsigned int truesize;
-
-#if (PAGE_SIZE < 8192)
-	truesize = ice_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
-#else
-	truesize = rx_ring->rx_offset ?
-		SKB_DATA_ALIGN(rx_ring->rx_offset + size) +
-		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
-		SKB_DATA_ALIGN(size);
-#endif
-	return truesize;
-}
-
 /**
  * ice_run_xdp - Executes an XDP program on initialized xdp_buff
  * @rx_ring: Rx ring
@@ -1154,11 +1130,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	bool failure;
 	u32 first;
 
-	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
-#if (PAGE_SIZE < 8192)
-	xdp->frame_sz = ice_rx_frame_truesize(rx_ring, 0);
-#endif
-
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog) {
 		xdp_ring = rx_ring->xdp_ring;
@@ -1217,10 +1188,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
 				     offset;
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
-#if (PAGE_SIZE > 4096)
-			/* At larger PAGE_SIZE, frame_sz depend on len size */
-			xdp->frame_sz = ice_rx_frame_truesize(rx_ring, size);
-#endif
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
 			break;
-- 
2.42.0


