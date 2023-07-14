Return-Path: <bpf+bounces-5008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395EC7539EF
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E592822E9
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCE125C2;
	Fri, 14 Jul 2023 11:37:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E77486;
	Fri, 14 Jul 2023 11:37:32 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC255210A;
	Fri, 14 Jul 2023 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334651; x=1720870651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJvC7QQ53I6mT8mf34YRI85G2NMmwVR3lbjd2u8Dgq0=;
  b=m+ELux1W80/XL/ZQV830FtdFb7np9H/Je23vA6sNlSRbal2Kuu2pxgUt
   LfceC45PuZsfxLb0Oy0TtbRAHKPiU4WXsyJ3Q4Gw7gxj32IoaCfcYOtmU
   /I0tdlQoT5t3MNxWM03FjBGENXcHShM+Q9GI33yJqHf8FPiNRep+aL4u5
   sbwHfuFZBJPZCKIS7KkxPeP9ltscRf32tdjrgYzHWRwj4gIaJItI70iGx
   IRn9nXIj5ghqshC+99Q65HFG2Pi0qZuqX/TC+Zoxk93003ZMZWxS44sMM
   8wAI3wEQCmU/HjUtnzYKaUcOnznoCtwbVriT7xx3cnHZMcnW/WUYuSq6S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345048271"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345048271"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846425208"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="846425208"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 04:37:28 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v6 bpf-next 15/24] ice: xsk: Tx multi-buffer support
Date: Fri, 14 Jul 2023 13:36:31 +0200
Message-Id: <20230714113640.556893-16-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
References: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Most of this patch is about actually supporting XDP_TX action. Pure Tx
ZC support is only about looking at XDP_PKT_CONTD presence at options
field and based on that generating EOP bit on Tx HW descriptor. This is
that simple due to the implementation on
xsk_tx_peek_release_desc_batch() where we are making sure that last
produced descriptor is an EOP one.

Overwrite xdp_zc_max_segs with a value that defines max scatter-gatter
count on Tx side that HW can handle.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 83 ++++++++++++++++-------
 2 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 93979ab18bc1..f854e61e5ea2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3392,6 +3392,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
 			       NETDEV_XDP_ACT_RX_SG;
+	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 91cdd5e4790d..2a3f0834e139 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -613,7 +613,7 @@ ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
  * ice_clean_xdp_irq_zc - produce AF_XDP descriptors to CQ
  * @xdp_ring: XDP Tx ring
  */
-static void ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring)
+static u32 ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring)
 {
 	u16 ntc = xdp_ring->next_to_clean;
 	struct ice_tx_desc *tx_desc;
@@ -635,7 +635,7 @@ static void ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring)
 	}
 
 	if (!completed_frames)
-		return;
+		return 0;
 
 	if (likely(!xdp_ring->xdp_tx_active)) {
 		xsk_frames = completed_frames;
@@ -665,6 +665,8 @@ static void ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring)
 		xdp_ring->next_to_clean -= cnt;
 	if (xsk_frames)
 		xsk_tx_completed(xdp_ring->xsk_pool, xsk_frames);
+
+	return completed_frames;
 }
 
 /**
@@ -682,37 +684,72 @@ static void ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring)
 static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
 			      struct ice_tx_ring *xdp_ring)
 {
+	struct skb_shared_info *sinfo = NULL;
 	u32 size = xdp->data_end - xdp->data;
 	u32 ntu = xdp_ring->next_to_use;
 	struct ice_tx_desc *tx_desc;
 	struct ice_tx_buf *tx_buf;
-	dma_addr_t dma;
+	struct xdp_buff *head;
+	u32 nr_frags = 0;
+	u32 free_space;
+	u32 frag = 0;
 
-	if (ICE_DESC_UNUSED(xdp_ring) < ICE_RING_QUARTER(xdp_ring)) {
-		ice_clean_xdp_irq_zc(xdp_ring);
-		if (!ICE_DESC_UNUSED(xdp_ring)) {
-			xdp_ring->ring_stats->tx_stats.tx_busy++;
-			return ICE_XDP_CONSUMED;
-		}
-	}
+	free_space = ICE_DESC_UNUSED(xdp_ring);
+	if (free_space < ICE_RING_QUARTER(xdp_ring))
+		free_space += ice_clean_xdp_irq_zc(xdp_ring);
 
-	dma = xsk_buff_xdp_get_dma(xdp);
-	xsk_buff_raw_dma_sync_for_device(xdp_ring->xsk_pool, dma, size);
+	if (unlikely(!free_space))
+		goto busy;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+		if (free_space < nr_frags + 1)
+			goto busy;
+	}
 
-	tx_buf = &xdp_ring->tx_buf[ntu];
-	tx_buf->xdp = xdp;
-	tx_buf->type = ICE_TX_BUF_XSK_TX;
 	tx_desc = ICE_TX_DESC(xdp_ring, ntu);
-	tx_desc->buf_addr = cpu_to_le64(dma);
-	tx_desc->cmd_type_offset_bsz = ice_build_ctob(ICE_TX_DESC_CMD_EOP,
-						      0, size, 0);
-	xdp_ring->xdp_tx_active++;
+	tx_buf = &xdp_ring->tx_buf[ntu];
+	head = xdp;
+
+	for (;;) {
+		dma_addr_t dma;
+
+		dma = xsk_buff_xdp_get_dma(xdp);
+		xsk_buff_raw_dma_sync_for_device(xdp_ring->xsk_pool, dma, size);
+
+		tx_buf->xdp = xdp;
+		tx_buf->type = ICE_TX_BUF_XSK_TX;
+		tx_desc->buf_addr = cpu_to_le64(dma);
+		tx_desc->cmd_type_offset_bsz = ice_build_ctob(0, 0, size, 0);
+		/* account for each xdp_buff from xsk_buff_pool */
+		xdp_ring->xdp_tx_active++;
+
+		if (++ntu == xdp_ring->count)
+			ntu = 0;
+
+		if (frag == nr_frags)
+			break;
+
+		tx_desc = ICE_TX_DESC(xdp_ring, ntu);
+		tx_buf = &xdp_ring->tx_buf[ntu];
+
+		xdp = xsk_buff_get_frag(head);
+		size = skb_frag_size(&sinfo->frags[frag]);
+		frag++;
+	}
 
-	if (++ntu == xdp_ring->count)
-		ntu = 0;
 	xdp_ring->next_to_use = ntu;
+	/* update last descriptor from a frame with EOP */
+	tx_desc->cmd_type_offset_bsz |=
+		cpu_to_le64(ICE_TX_DESC_CMD_EOP << ICE_TXD_QW1_CMD_S);
 
 	return ICE_XDP_TX;
+
+busy:
+	xdp_ring->ring_stats->tx_stats.tx_busy++;
+
+	return ICE_XDP_CONSUMED;
 }
 
 /**
@@ -960,7 +997,7 @@ static void ice_xmit_pkt(struct ice_tx_ring *xdp_ring, struct xdp_desc *desc,
 
 	tx_desc = ICE_TX_DESC(xdp_ring, xdp_ring->next_to_use++);
 	tx_desc->buf_addr = cpu_to_le64(dma);
-	tx_desc->cmd_type_offset_bsz = ice_build_ctob(ICE_TX_DESC_CMD_EOP,
+	tx_desc->cmd_type_offset_bsz = ice_build_ctob(xsk_is_eop_desc(desc),
 						      0, desc->len, 0);
 
 	*total_bytes += desc->len;
@@ -987,7 +1024,7 @@ static void ice_xmit_pkt_batch(struct ice_tx_ring *xdp_ring, struct xdp_desc *de
 
 		tx_desc = ICE_TX_DESC(xdp_ring, ntu++);
 		tx_desc->buf_addr = cpu_to_le64(dma);
-		tx_desc->cmd_type_offset_bsz = ice_build_ctob(ICE_TX_DESC_CMD_EOP,
+		tx_desc->cmd_type_offset_bsz = ice_build_ctob(xsk_is_eop_desc(&descs[i]),
 							      0, descs[i].len, 0);
 
 		*total_bytes += descs[i].len;
-- 
2.34.1


