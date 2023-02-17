Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDCB69B31D
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBQTaD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 14:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBQT34 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 14:29:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC638651;
        Fri, 17 Feb 2023 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676662193; x=1708198193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D77/4pyyDf9LtjKrMkoLgm95MxV1I2dKWdQyrIEInlo=;
  b=BiGhOWDDvKGV1qM373+ABJP84e8cqu87CenUVh0buxXybcEVUyJIq+yo
   ipZVvDxF+oiokjrcKlQpkor+Eq2sZqxdvIL1DJwjpvMW7uw0P6Q1ubG0C
   30jYi3gTCh5RjVpGGJlzbd1hzYyfdP8lmaoQPt2vucq5LAIi2c2w3D8kU
   X14bqIx0k2j/Zb72d4vo+l88OSDv9u/M1asLzGlaWVZoaeC6O/tnpSP/f
   o6iKH7p3ro+7zyfvtGsWlrvYlxtHHRn+5o9oZWYuhrlPToJGb+ERbNSo+
   hTLPVby6Y0mMP7rsVKsaPrL595Ac7JX/UgVXm20fG6dypkdyGRkWDj2bm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="394550082"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="394550082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 11:29:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="701013397"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="701013397"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 11:29:52 -0800
From:   Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        tirthendu.sarkar@intel.com
Subject: [PATCH intel-next v6 7/8] i40e: add xdp_buff to i40e_ring struct
Date:   Sat, 18 Feb 2023 00:45:14 +0530
Message-Id: <20230217191515.166819-8-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217191515.166819-1-tirthendu.sarkar@intel.com>
References: <20230217191515.166819-1-tirthendu.sarkar@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Store xdp_buff on Rx ring struct in preparation for XDP multi-buffer
support. This will allow us to combine fragmented frames across
separate NAPI cycles in the same way as currently skb fragments are
handled. This means that skb pointer on Rx ring will become redundant
and will be removed in a later patch. As a consequence i40e_trace() now
uses xdp instead of skb pointer.

Truesize only needs to be calculated for page sizes bigger than 4k as it
is always half-page for 4k pages. With xdp_buff on ring, frame size can
now be set during xdp_init_buff() and need not be repopulated in each
NAPI call for 4k pages. As a consequence i40e_rx_frame_truesize() is now
used only for bigger pages.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c  |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_trace.h | 20 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c  | 33 ++++++++------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h  |  7 +++++
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 49e6cd1ef6cd..b7247971d20e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3616,6 +3616,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		}
 	}
 
+	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 79d587ad5409..33b4e30f5e00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -162,45 +162,45 @@ DECLARE_EVENT_CLASS(
 
 	TP_PROTO(struct i40e_ring *ring,
 		 union i40e_16byte_rx_desc *desc,
-		 struct sk_buff *skb),
+		 struct xdp_buff *xdp),
 
-	TP_ARGS(ring, desc, skb),
+	TP_ARGS(ring, desc, xdp),
 
 	TP_STRUCT__entry(
 		__field(void*, ring)
 		__field(void*, desc)
-		__field(void*, skb)
+		__field(void*, xdp)
 		__string(devname, ring->netdev->name)
 	),
 
 	TP_fast_assign(
 		__entry->ring = ring;
 		__entry->desc = desc;
-		__entry->skb = skb;
+		__entry->xdp = xdp;
 		__assign_str(devname, ring->netdev->name);
 	),
 
 	TP_printk(
-		"netdev: %s ring: %p desc: %p skb %p",
+		"netdev: %s ring: %p desc: %p xdp %p",
 		__get_str(devname), __entry->ring,
-		__entry->desc, __entry->skb)
+		__entry->desc, __entry->xdp)
 );
 
 DEFINE_EVENT(
 	i40e_rx_template, i40e_clean_rx_irq,
 	TP_PROTO(struct i40e_ring *ring,
 		 union i40e_16byte_rx_desc *desc,
-		 struct sk_buff *skb),
+		 struct xdp_buff *xdp),
 
-	TP_ARGS(ring, desc, skb));
+	TP_ARGS(ring, desc, xdp));
 
 DEFINE_EVENT(
 	i40e_rx_template, i40e_clean_rx_irq_rx,
 	TP_PROTO(struct i40e_ring *ring,
 		 union i40e_16byte_rx_desc *desc,
-		 struct sk_buff *skb),
+		 struct xdp_buff *xdp),
 
-	TP_ARGS(ring, desc, skb));
+	TP_ARGS(ring, desc, xdp));
 
 DECLARE_EVENT_CLASS(
 	i40e_xmit_template,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 94c50fa223bd..dc2c9aae0ffe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1619,21 +1619,19 @@ void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	writel(val, rx_ring->tail);
 }
 
+#if (PAGE_SIZE >= 8192)
 static unsigned int i40e_rx_frame_truesize(struct i40e_ring *rx_ring,
 					   unsigned int size)
 {
 	unsigned int truesize;
 
-#if (PAGE_SIZE < 8192)
-	truesize = i40e_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
-#else
 	truesize = rx_ring->rx_offset ?
 		SKB_DATA_ALIGN(size + rx_ring->rx_offset) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
 		SKB_DATA_ALIGN(size);
-#endif
 	return truesize;
 }
+#endif
 
 /**
  * i40e_alloc_mapped_page - recycle or make a new page
@@ -2405,21 +2403,16 @@ static void i40e_inc_ntp(struct i40e_ring *rx_ring)
 static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			     unsigned int *rx_cleaned)
 {
-	unsigned int total_rx_bytes = 0, total_rx_packets = 0, frame_sz = 0;
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
 	unsigned int offset = rx_ring->rx_offset;
+	struct xdp_buff *xdp = &rx_ring->xdp;
 	struct sk_buff *skb = rx_ring->skb;
 	unsigned int xdp_xmit = 0;
 	struct bpf_prog *xdp_prog;
 	bool failure = false;
-	struct xdp_buff xdp;
 	int xdp_res = 0;
 
-#if (PAGE_SIZE < 8192)
-	frame_sz = i40e_rx_frame_truesize(rx_ring, 0);
-#endif
-	xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
-
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
@@ -2467,7 +2460,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		if (!size)
 			break;
 
-		i40e_trace(clean_rx_irq, rx_ring, rx_desc, skb);
+		i40e_trace(clean_rx_irq, rx_ring, rx_desc, xdp);
 		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
 
 		/* retrieve a buffer from the ring */
@@ -2476,19 +2469,19 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 
 			hard_start = page_address(rx_buffer->page) +
 				     rx_buffer->page_offset - offset;
-			xdp_prepare_buff(&xdp, hard_start, offset, size, true);
-			xdp_buff_clear_frags_flag(&xdp);
+			xdp_prepare_buff(xdp, hard_start, offset, size, true);
+			xdp_buff_clear_frags_flag(xdp);
 #if (PAGE_SIZE > 4096)
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
-			xdp.frame_sz = i40e_rx_frame_truesize(rx_ring, size);
+			xdp->frame_sz = i40e_rx_frame_truesize(rx_ring, size);
 #endif
-			xdp_res = i40e_run_xdp(rx_ring, &xdp, xdp_prog);
+			xdp_res = i40e_run_xdp(rx_ring, xdp, xdp_prog);
 		}
 
 		if (xdp_res) {
 			if (xdp_res & (I40E_XDP_TX | I40E_XDP_REDIR)) {
 				xdp_xmit |= xdp_res;
-				i40e_rx_buffer_flip(rx_buffer, xdp.frame_sz);
+				i40e_rx_buffer_flip(rx_buffer, xdp->frame_sz);
 			} else {
 				rx_buffer->pagecnt_bias++;
 			}
@@ -2497,9 +2490,9 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		} else if (skb) {
 			i40e_add_rx_frag(rx_ring, rx_buffer, skb, size);
 		} else if (ring_uses_build_skb(rx_ring)) {
-			skb = i40e_build_skb(rx_ring, rx_buffer, &xdp);
+			skb = i40e_build_skb(rx_ring, rx_buffer, xdp);
 		} else {
-			skb = i40e_construct_skb(rx_ring, rx_buffer, &xdp);
+			skb = i40e_construct_skb(rx_ring, rx_buffer, xdp);
 		}
 
 		/* exit if we failed to retrieve a buffer */
@@ -2528,7 +2521,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		/* populate checksum, VLAN, and protocol */
 		i40e_process_skb_fields(rx_ring, rx_desc, skb);
 
-		i40e_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
+		i40e_trace(clean_rx_irq_rx, rx_ring, rx_desc, xdp);
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 		skb = NULL;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 6e0fd73367df..e86abc25bb5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -338,6 +338,13 @@ struct i40e_ring {
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 __iomem *tail;
 
+	/* Storing xdp_buff on ring helps in saving the state of partially built
+	 * packet when i40e_clean_rx_ring_irq() must return before it sees EOP
+	 * and to resume packet building for this ring in the next call to
+	 * i40e_clean_rx_ring_irq().
+	 */
+	struct xdp_buff xdp;
+
 	/* Next descriptor to be processed; next_to_clean is updated only on
 	 * processing EOP descriptor
 	 */
-- 
2.34.1

