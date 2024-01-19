Return-Path: <bpf+bounces-19941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9750833183
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4191C23866
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14945A0F0;
	Fri, 19 Jan 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNEqu9Fl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE85A0E9;
	Fri, 19 Jan 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707065; cv=none; b=cS58doOckN7VOk8EePUmglB4h/e/1lwWI5EwLMWZow0IgDNvAajs4dtUFNBCbBpyyQ/lTaHydCywkLirEY7EfFxm2zV5AwWDnD2MnTwC1IA5xyKvG6jtTLY6nE4vftMhyb18a0KKGSJyDCv/WuXcGXbAMurLiiGbPec9HnFzFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707065; c=relaxed/simple;
	bh=cOVAeHrs0kqbdh4sWPWFBuE+qdHFXP1QuAfmOSxXlpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQIDtVCK4fa6C90gZB0Zsj1rMFai6raXO/sHTXnscNLZWO2WvMvjrDPnZp2MTDy92MJeVzMvkVYw+gpyzfFwDNWaIspyBpxzOGDjtq5zmXSucVG4s4u+q6M3C4Yi+I9TM6Mo/CFQWdA060ulkywvkmbN7Zq9Nh/LDXlXru5k2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNEqu9Fl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707064; x=1737243064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOVAeHrs0kqbdh4sWPWFBuE+qdHFXP1QuAfmOSxXlpw=;
  b=MNEqu9FlmmxPy+4pHjvyraW49aUE41komMAv5SBxB9tAt4jzyetI4Wz4
   uqobA/BkiHvGijfzQPgiDK/5kEhL3XnVTXaCAK2XZbeHgRImrmJYzLUjk
   zP+nTVlWw4JkGa0EFoeGA+rFL+rGtiRj9jiGWOsZjD43pzMiUTYVjW2bB
   Yi6T/xbsYdMgKM0tftBrz92TLVQ3XO91+yuwZUat2Q3dzmCswaka4J8Aq
   94bkZLuI8B0KJM3kqoJc2/G+pgvMdHnh7v7hUGIoVlPmGvo/WDpGriiFe
   zata29Ji/YZhIDkIQRAEQZFVKobZ1QkWtFFdUZJst1ST2FnHDWa/DClIO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771575"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771575"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277427"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277427"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:00 -0800
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
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 04/11] ice: work on pre-XDP prog frag count
Date: Sat, 20 Jan 2024 00:30:30 +0100
Message-Id: <20240119233037.537084-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
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
index 59617f055e35..1760e81379cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -603,9 +603,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		ret = ICE_XDP_CONSUMED;
 	}
 exit:
-	rx_buf->act = ret;
-	if (unlikely(xdp_buff_has_frags(xdp)))
-		ice_set_rx_bufs_act(xdp, rx_ring, ret);
+	ice_set_rx_bufs_act(xdp, rx_ring, ret);
 }
 
 /**
@@ -893,14 +891,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
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
@@ -1251,6 +1252,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		xdp->data = NULL;
 		rx_ring->first_desc = ntc;
+		rx_ring->nr_frags = 0;
 		continue;
 construct_skb:
 		if (likely(ice_ring_uses_build_skb(rx_ring)))
@@ -1266,10 +1268,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
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
index b3379ff73674..af955b0e5dc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -358,6 +358,7 @@ struct ice_rx_ring {
 	struct ice_tx_ring *xdp_ring;
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
+	u32 nr_frags;
 	dma_addr_t dma;			/* physical address of ring */
 	u16 rx_buf_len;
 	u8 dcb_tc;			/* Traffic class of ring */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 762047508619..afcead4baef4 100644
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


