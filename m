Return-Path: <bpf+bounces-17180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C7C80A238
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2B4B20BF7
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313451B289;
	Fri,  8 Dec 2023 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edJOBPLk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260731987;
	Fri,  8 Dec 2023 03:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702035017; x=1733571017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/LL2Zc/cGlkRKj2JZAkN6MYSO/3XxSNUyVniAZCKJc=;
  b=edJOBPLk8pNy4lvz+fLn/kbVL1KmEr/Suai5wY2sUg600WchT5nOpjb3
   5drmIJebqu1ukSmJ28/aJcy5GzI87TyPlHXKNT0akAOvycVXa59tiNs2X
   qOS8e+jPawXX1wgGnBeaoRleiHePKYFJ+datX2zySMcp5dGb7fZEkFh/m
   jZT6KM7qtebd/VNmWY86bm7CL3cWgHCt8O0cWv310ZY9XI1XUcpwUOKY2
   0ZWzUBYBtVW/xu9Y9B645MEaAALPEjonXhy0ed11VOHjhIZB7/vYw4mSK
   sR0t492k8/5RYTqvRJ2JOT/ja9JF/6GRUYyYttqfeAV0P6qa5e6CRSMFM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="458705904"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="458705904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862828193"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="862828193"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2023 03:30:13 -0800
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
	lorenzo@kernel.org
Subject: [PATCH bpf 3/3] ice: work on pre-XDP prog frag count
Date: Fri,  8 Dec 2023 12:29:45 +0100
Message-Id: <20231208112945.313687-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231208112945.313687-1-maciej.fijalkowski@intel.com>
References: <20231208112945.313687-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
socket.

Since support for handling multi-buffer frames was added to XDP, usage
of bpf_xdp_adjust_tail() helper within XDP program can free the page
that given fragment occupies and in turn decrease the fragment count
within skb_shared_info that is embedded in xdp_buff struct. In current
ice driver codebase, it can become problematic when page recycling logic
decides not to reuse the page. In such case, __page_frag_cache_drain()
is used with ice_rx_buf::pagecnt_bias that was not adjusted after
refcount of page was changed by XDP prog which in turn does not drain
the refcount to 0 and page is never freed.

To address this, let us store the count of frags before the XDP program
was executed on Rx ring struct. This will be used to compare with
current frag count from skb_shared_info embedded in xdp_buff. A smaller
value in the latter indicates that XDP prog freed frag(s). Then, for
given delta decrement pagecnt_bias for XDP_DROP verdict.

While at it, let us also handle the EOP frag within
ice_set_rx_bufs_act() to make our life easier, so all of the adjustments
needed to be applied against freed frags are performed in the single
place.

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++------
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 9e97ea863068..6878448ba112 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -600,9 +600,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		ret = ICE_XDP_CONSUMED;
 	}
 exit:
-	rx_buf->act = ret;
-	if (unlikely(xdp_buff_has_frags(xdp)))
-		ice_set_rx_bufs_act(xdp, rx_ring, ret);
+	ice_set_rx_bufs_act(xdp, rx_ring, ret);
 }
 
 /**
@@ -890,14 +888,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	}
 
 	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
-		if (unlikely(xdp_buff_has_frags(xdp)))
-			ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
+		ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
 		return -ENOMEM;
 	}
 
 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
 				   rx_buf->page_offset, size);
 	sinfo->xdp_frags_size += size;
+	/* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
+	 * can pop off frags but driver has to handle it on its own
+	 */
+	rx_ring->nr_frags = sinfo->nr_frags;
 
 	if (page_is_pfmemalloc(rx_buf->page))
 		xdp_buff_set_frag_pfmemalloc(xdp);
@@ -1249,6 +1250,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		xdp->data = NULL;
 		rx_ring->first_desc = ntc;
+		rx_ring->nr_frags = 0;
 		continue;
 construct_skb:
 		if (likely(ice_ring_uses_build_skb(rx_ring)))
@@ -1264,10 +1266,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 						    ICE_XDP_CONSUMED);
 			xdp->data = NULL;
 			rx_ring->first_desc = ntc;
+			rx_ring->nr_frags = 0;
 			break;
 		}
 		xdp->data = NULL;
 		rx_ring->first_desc = ntc;
+		rx_ring->nr_frags = 0;
 
 		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
 		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index daf7b9dbb143..b28b9826bbcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -333,6 +333,7 @@ struct ice_rx_ring {
 	struct ice_channel *ch;
 	struct ice_tx_ring *xdp_ring;
 	struct xsk_buff_pool *xsk_pool;
+	u32 nr_frags;
 	dma_addr_t dma;			/* physical address of ring */
 	u64 cached_phctime;
 	u16 rx_buf_len;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 115969ecdf7b..b0e56675f98b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -12,26 +12,39 @@
  * act: action to store onto Rx buffers related to XDP buffer parts
  *
  * Set action that should be taken before putting Rx buffer from first frag
- * to one before last. Last one is handled by caller of this function as it
- * is the EOP frag that is currently being processed. This function is
- * supposed to be called only when XDP buffer contains frags.
+ * to the last.
  */
 static inline void
 ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
 		    const unsigned int act)
 {
-	const struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	u32 first = rx_ring->first_desc;
-	u32 nr_frags = sinfo->nr_frags;
+	u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
+	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 idx = rx_ring->first_desc;
 	u32 cnt = rx_ring->count;
 	struct ice_rx_buf *buf;
 
 	for (int i = 0; i < nr_frags; i++) {
-		buf = &rx_ring->rx_buf[first];
+		buf = &rx_ring->rx_buf[idx];
 		buf->act = act;
 
-		if (++first == cnt)
-			first = 0;
+		if (++idx == cnt)
+			idx = 0;
+	}
+
+	/* adjust pagecnt_bias on frags freed by XDP prog */
+	if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
+		u32 delta = rx_ring->nr_frags - sinfo_frags;
+
+		while (delta) {
+			if (idx == 0)
+				idx = cnt - 1;
+			else
+				idx--;
+			buf = &rx_ring->rx_buf[idx];
+			buf->pagecnt_bias--;
+			delta--;
+		}
 	}
 }
 
-- 
2.34.1


