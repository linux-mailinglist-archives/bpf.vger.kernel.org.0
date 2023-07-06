Return-Path: <bpf+bounces-4318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932574A547
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C461828109D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941117725;
	Thu,  6 Jul 2023 20:47:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C23174D0;
	Thu,  6 Jul 2023 20:47:57 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744AA1992;
	Thu,  6 Jul 2023 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676476; x=1720212476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TTkBDhyBMaGtPqnbB7xm4pcqp9kUCuhNiRsR2PRqJ48=;
  b=XaGLNTabBemGc12EkcwtN+DoMsA+x+Ki3cMNP31/qypN10Ih84QUFN59
   ETUj5LjqCKUkNo2ObsuZpQp8/Xr9SzhddjoLpvVA4PTZ0FzkCJ/bi4kcH
   V5y7o8w+HD/1nI/cvNNqJ6OtuIn+OcD74z6CMWUmMGnqdEMBT/86DtaM7
   uxcTK+Kqjx7ZH1XkTGEMWXrr9MHl/iEX4QEFZcHYjrgMrpzTX/53NmlWr
   gUV4ly7YgPM21N4AZLXwAoc6OHNHSMWp1cCrN+cho6TRnH/xurhsMfjf3
   mS+KyC3lcz05jUfMNt/hwoq72KAqgMREWPaHeYgV2bnRyDOCmcjzOVNZe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195468"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195468"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059606"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059606"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:47:53 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 13/24] i40e: xsk: add RX multi-buffer support
Date: Thu,  6 Jul 2023 22:46:39 +0200
Message-Id: <20230706204650.469087-14-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

This patch is inspired from the multi-buffer support in non-zc path for
i40e as well as from the patch to support zc on ice. Each subsequent
frag is added to skb_shared_info of the first frag for possible xdp_prog
use as well to xsk buffer list for accessing the buffers in af_xdp.

For XDP_PASS, new pages are allocated for frags and contents are copied
from memory backed by xsk_buff_pool.

Replace next_to_clean with next_to_process as done in non-zc path and
advance it for every buffer and change the semantics of next_to_clean to
point to the first buffer of a packet. Driver will use next_to_process
in the same way next_to_clean was used previously.

For the non multi-buffer case, next_to_process and next_to_clean will
always be the same since each packet consists of a single buffer.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  5 --
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 91 ++++++++++++++++++---
 4 files changed, 84 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 29ad1797adce..1bd72cdedc8a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3585,11 +3585,6 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	if (ring->xsk_pool) {
 		ring->rx_buf_len =
 		  xsk_pool_get_rx_frame_size(ring->xsk_pool);
-		/* For AF_XDP ZC, we disallow packets to span on
-		 * multiple buffers, thus letting us skip that
-		 * handling in the fast-path.
-		 */
-		chain_len = 1;
 		ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL,
 						 NULL);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8b8bf4880faa..0b3a27f118fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2284,8 +2284,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
  * If the buffer is an EOP buffer, this function exits returning false,
  * otherwise return true indicating that this is in fact a non-EOP buffer.
  */
-static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
-			    union i40e_rx_desc *rx_desc)
+bool i40e_is_non_eop(struct i40e_ring *rx_ring,
+		     union i40e_rx_desc *rx_desc)
 {
 	/* if we are the last buffer then there is nothing else to do */
 #define I40E_RXD_EOF BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 8c3d24012c54..900b0d9ede9f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -473,6 +473,8 @@ int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
 int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		  u32 flags);
+bool i40e_is_non_eop(struct i40e_ring *rx_ring,
+		     union i40e_rx_desc *rx_desc);
 
 /**
  * i40e_get_head - Retrieve head from head writeback
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 05ec1181471e..89a8aca1153e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -294,8 +294,14 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 {
 	unsigned int totalsize = xdp->data_end - xdp->data_meta;
 	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct skb_shared_info *sinfo = NULL;
 	struct sk_buff *skb;
+	u32 nr_frags = 0;
 
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+	}
 	net_prefetch(xdp->data_meta);
 
 	/* allocate a skb to store the frags */
@@ -312,6 +318,28 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 		__skb_pull(skb, metasize);
 	}
 
+	if (likely(!xdp_buff_has_frags(xdp)))
+		goto out;
+
+	for (int i = 0; i < nr_frags; i++) {
+		struct skb_shared_info *skinfo = skb_shinfo(skb);
+		skb_frag_t *frag = &sinfo->frags[i];
+		struct page *page;
+		void *addr;
+
+		page = dev_alloc_page();
+		if (!page) {
+			dev_kfree_skb(skb);
+			return NULL;
+		}
+		addr = page_to_virt(page);
+
+		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
+
+		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
+					   addr, 0, skb_frag_size(frag));
+	}
+
 out:
 	xsk_buff_free(xdp);
 	return skb;
@@ -322,14 +350,13 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 				      union i40e_rx_desc *rx_desc,
 				      unsigned int *rx_packets,
 				      unsigned int *rx_bytes,
-				      unsigned int size,
 				      unsigned int xdp_res,
 				      bool *failure)
 {
 	struct sk_buff *skb;
 
 	*rx_packets = 1;
-	*rx_bytes = size;
+	*rx_bytes = xdp_get_buff_len(xdp_buff);
 
 	if (likely(xdp_res == I40E_XDP_REDIR) || xdp_res == I40E_XDP_TX)
 		return;
@@ -363,7 +390,6 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 			return;
 		}
 
-		*rx_bytes = skb->len;
 		i40e_process_skb_fields(rx_ring, rx_desc, skb);
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 		return;
@@ -374,6 +400,31 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 	WARN_ON_ONCE(1);
 }
 
+static int
+i40e_add_xsk_frag(struct i40e_ring *rx_ring, struct xdp_buff *first,
+		  struct xdp_buff *xdp, const unsigned int size)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(first);
+
+	if (!xdp_buff_has_frags(first)) {
+		sinfo->nr_frags = 0;
+		sinfo->xdp_frags_size = 0;
+		xdp_buff_set_frags_flag(first);
+	}
+
+	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
+		xsk_buff_free(first);
+		return -ENOMEM;
+	}
+
+	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
+				   virt_to_page(xdp->data_hard_start), 0, size);
+	sinfo->xdp_frags_size += size;
+	xsk_buff_add_frag(xdp);
+
+	return 0;
+}
+
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
@@ -384,13 +435,18 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	u16 next_to_process = rx_ring->next_to_process;
 	u16 next_to_clean = rx_ring->next_to_clean;
 	u16 count_mask = rx_ring->count - 1;
 	unsigned int xdp_res, xdp_xmit = 0;
+	struct xdp_buff *first = NULL;
 	struct bpf_prog *xdp_prog;
 	bool failure = false;
 	u16 cleaned_count;
 
+	if (next_to_process != next_to_clean)
+		first = *i40e_rx_bi(rx_ring, next_to_clean);
+
 	/* NB! xdp_prog will always be !NULL, due to the fact that
 	 * this path is enabled by setting an XDP program.
 	 */
@@ -404,7 +460,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		unsigned int size;
 		u64 qword;
 
-		rx_desc = I40E_RX_DESC(rx_ring, next_to_clean);
+		rx_desc = I40E_RX_DESC(rx_ring, next_to_process);
 		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 
 		/* This memory barrier is needed to keep us from reading
@@ -417,9 +473,9 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
-			bi = *i40e_rx_bi(rx_ring, next_to_clean);
+			bi = *i40e_rx_bi(rx_ring, next_to_process);
 			xsk_buff_free(bi);
-			next_to_clean = (next_to_clean + 1) & count_mask;
+			next_to_process = (next_to_process + 1) & count_mask;
 			continue;
 		}
 
@@ -428,22 +484,35 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		if (!size)
 			break;
 
-		bi = *i40e_rx_bi(rx_ring, next_to_clean);
+		bi = *i40e_rx_bi(rx_ring, next_to_process);
 		xsk_buff_set_size(bi, size);
 		xsk_buff_dma_sync_for_cpu(bi, rx_ring->xsk_pool);
 
-		xdp_res = i40e_run_xdp_zc(rx_ring, bi, xdp_prog);
-		i40e_handle_xdp_result_zc(rx_ring, bi, rx_desc, &rx_packets,
-					  &rx_bytes, size, xdp_res, &failure);
+		if (!first)
+			first = bi;
+		else if (i40e_add_xsk_frag(rx_ring, first, bi, size))
+			break;
+
+		next_to_process = (next_to_process + 1) & count_mask;
+
+		if (i40e_is_non_eop(rx_ring, rx_desc))
+			continue;
+
+		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
+		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
+					  &rx_bytes, xdp_res, &failure);
+		first->flags = 0;
+		next_to_clean = next_to_process;
 		if (failure)
 			break;
 		total_rx_packets += rx_packets;
 		total_rx_bytes += rx_bytes;
 		xdp_xmit |= xdp_res & (I40E_XDP_TX | I40E_XDP_REDIR);
-		next_to_clean = (next_to_clean + 1) & count_mask;
+		first = NULL;
 	}
 
 	rx_ring->next_to_clean = next_to_clean;
+	rx_ring->next_to_process = next_to_process;
 	cleaned_count = (next_to_clean - rx_ring->next_to_use - 1) & count_mask;
 
 	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
-- 
2.34.1


