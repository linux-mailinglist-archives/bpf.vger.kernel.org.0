Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D251DAF43
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgETJtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 05:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETJtN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 05:49:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AEC061A0E;
        Wed, 20 May 2020 02:49:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 5so1006882pjd.0;
        Wed, 20 May 2020 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1dqQiCUAKey5IKmhS8Rr5u0JayAKZpb//8QP4uIvcM=;
        b=iNdjp6mJsMnMB2VpI0WgkAYqQwE5i6RkJAn1y+eSY/Baq2ANFeD3fPBwwBEaQKrF+q
         j4/HL5jel9ubmtEWaqBfPm7mnOl6WB2SbC5fLbTSaMw13DZeYQNfsKSPMds2mXZUj/T6
         JN7ATsNc5I1jwL2rmUMm0NuYO8mnd9sm5Elp6Z3RG35wINk5HiJapAY9OjS//G/xxxkH
         qeXMEiDLHWDFYm/eUKCheNxk2daKY3FfoV6WINIL+8DFmzsVUGYeBX88ahZCYDYefqFY
         PjKcCx+We6mHUK+7vXi6l7lDJxsx7oeWZR4X5tL1Vh306dtXfZAZNJ/nuAGB3bWyR8IS
         shIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1dqQiCUAKey5IKmhS8Rr5u0JayAKZpb//8QP4uIvcM=;
        b=HeUBA/zCcDv5eHmOVAe4mLysVCVnH1mOyoSftSMGe1nlxzuGG14FDIhtqMQ27fZQDi
         ZxtUaBdv+XQUAKLy1LCnMpFGgBi7jaKrkx+xEn0XYRUO6Ag75qfzA255IoWC+b4j6j6J
         pLYL21dZ/wHZnOT3l78+4PM6wW9STZaXAWZFWtBfWa9fUaszE7ikMLMs5LVOCqQDgL+h
         xcLPeX2gvPDoqjYA/OJY6SH+ThRXbllSpRnX36eiJnLK9V3+pwAP5+ZP0ypklrE0cRLQ
         oCGmQejMaRHUvE+7k4GfTOjEZiI5Tm+/bgo16Mr27pqj7ESZ+Lr2oQXESaDB5TNHT+HF
         1kwQ==
X-Gm-Message-State: AOAM531AAXYbvONvIoyEfHA+RnHmJyitJqb9/whdLRAJmhiWMddvhWv5
        DmU2kDTJwR/y9dSnlb8OoJcN5xipKhZmM+Lt
X-Google-Smtp-Source: ABdhPJxQpCcy4NTo1/bsD/PMXefYCLKR4nUlUAFu8A2nf87/M9T2HX/lNw0/enAR1lBecRnMd35Xqw==
X-Received: by 2002:a17:90a:8815:: with SMTP id s21mr4524049pjn.154.1589968152495;
        Wed, 20 May 2020 02:49:12 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id c124sm1707494pfb.187.2020.05.20.02.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:49:11 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        jeffrey.t.kirsher@intel.com
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        maximmi@mellanox.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH bpf-next v4 10/15] ixgbe, xsk: migrate to new MEM_TYPE_XSK_BUFF_POOL
Date:   Wed, 20 May 2020 11:47:37 +0200
Message-Id: <20200520094742.337678-11-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200520094742.337678-1-bjorn.topel@gmail.com>
References: <20200520094742.337678-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Remove MEM_TYPE_ZERO_COPY in favor of the new MEM_TYPE_XSK_BUFF_POOL
APIs.

v1->v2: Fixed xdp_buff data_end update. (Björn)

Cc: intel-wired-lan@lists.osuosl.org
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   9 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  15 +-
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 307 +++---------------
 4 files changed, 62 insertions(+), 271 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 2833e4f041ce..5ddfc83a1e46 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -224,17 +224,17 @@ struct ixgbe_tx_buffer {
 };
 
 struct ixgbe_rx_buffer {
-	struct sk_buff *skb;
-	dma_addr_t dma;
 	union {
 		struct {
+			struct sk_buff *skb;
+			dma_addr_t dma;
 			struct page *page;
 			__u32 page_offset;
 			__u16 pagecnt_bias;
 		};
 		struct {
-			void *addr;
-			u64 handle;
+			bool discard;
+			struct xdp_buff *xdp;
 		};
 	};
 };
@@ -351,7 +351,6 @@ struct ixgbe_ring {
 	};
 	struct xdp_rxq_info xdp_rxq;
 	struct xdp_umem *xsk_umem;
-	struct zero_copy_allocator zca; /* ZC allocator anchor */
 	u16 ring_idx;		/* {rx,tx,xdp}_ring back reference idx */
 	u16 rx_buf_len;
 } ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index eab5934b04f5..45fc7ce1a543 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -35,7 +35,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/vxlan.h>
 #include <net/mpls.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include <net/xfrm.h>
 
 #include "ixgbe.h"
@@ -3745,8 +3745,7 @@ static void ixgbe_configure_srrctl(struct ixgbe_adapter *adapter,
 
 	/* configure the packet buffer length */
 	if (rx_ring->xsk_umem) {
-		u32 xsk_buf_len = rx_ring->xsk_umem->chunk_size_nohr -
-				  XDP_PACKET_HEADROOM;
+		u32 xsk_buf_len = xsk_umem_get_rx_frame_size(rx_ring->xsk_umem);
 
 		/* If the MAC support setting RXDCTL.RLPML, the
 		 * SRRCTL[n].BSIZEPKT is set to PAGE_SIZE and
@@ -4093,11 +4092,10 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
 	ring->xsk_umem = ixgbe_xsk_umem(adapter, ring);
 	if (ring->xsk_umem) {
-		ring->zca.free = ixgbe_zca_free;
 		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-						   MEM_TYPE_ZERO_COPY,
-						   &ring->zca));
-
+						   MEM_TYPE_XSK_BUFF_POOL,
+						   NULL));
+		xsk_buff_set_rxq_info(ring->xsk_umem, &ring->xdp_rxq);
 	} else {
 		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						   MEM_TYPE_PAGE_SHARED, NULL));
@@ -4153,8 +4151,7 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 	}
 
 	if (ring->xsk_umem && hw->mac.type != ixgbe_mac_82599EB) {
-		u32 xsk_buf_len = ring->xsk_umem->chunk_size_nohr -
-				  XDP_PACKET_HEADROOM;
+		u32 xsk_buf_len = xsk_umem_get_rx_frame_size(ring->xsk_umem);
 
 		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
 			    IXGBE_RXDCTL_RLPML_EN);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index 6d01700b46bc..7887ae4aaf4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -35,7 +35,7 @@ int ixgbe_xsk_umem_setup(struct ixgbe_adapter *adapter, struct xdp_umem *umem,
 
 void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
 
-void ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count);
+bool ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count);
 int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 			  struct ixgbe_ring *rx_ring,
 			  const int budget);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 82e4effae704..86add9fbd36c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -20,54 +20,11 @@ struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
 	return xdp_get_umem_from_qid(adapter->netdev, qid);
 }
 
-static int ixgbe_xsk_umem_dma_map(struct ixgbe_adapter *adapter,
-				  struct xdp_umem *umem)
-{
-	struct device *dev = &adapter->pdev->dev;
-	unsigned int i, j;
-	dma_addr_t dma;
-
-	for (i = 0; i < umem->npgs; i++) {
-		dma = dma_map_page_attrs(dev, umem->pgs[i], 0, PAGE_SIZE,
-					 DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
-		if (dma_mapping_error(dev, dma))
-			goto out_unmap;
-
-		umem->pages[i].dma = dma;
-	}
-
-	return 0;
-
-out_unmap:
-	for (j = 0; j < i; j++) {
-		dma_unmap_page_attrs(dev, umem->pages[i].dma, PAGE_SIZE,
-				     DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
-		umem->pages[i].dma = 0;
-	}
-
-	return -1;
-}
-
-static void ixgbe_xsk_umem_dma_unmap(struct ixgbe_adapter *adapter,
-				     struct xdp_umem *umem)
-{
-	struct device *dev = &adapter->pdev->dev;
-	unsigned int i;
-
-	for (i = 0; i < umem->npgs; i++) {
-		dma_unmap_page_attrs(dev, umem->pages[i].dma, PAGE_SIZE,
-				     DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
-
-		umem->pages[i].dma = 0;
-	}
-}
-
 static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 				 struct xdp_umem *umem,
 				 u16 qid)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct xdp_umem_fq_reuse *reuseq;
 	bool if_running;
 	int err;
 
@@ -78,13 +35,7 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 	    qid >= netdev->real_num_tx_queues)
 		return -EINVAL;
 
-	reuseq = xsk_reuseq_prepare(adapter->rx_ring[0]->count);
-	if (!reuseq)
-		return -ENOMEM;
-
-	xsk_reuseq_free(xsk_reuseq_swap(umem, reuseq));
-
-	err = ixgbe_xsk_umem_dma_map(adapter, umem);
+	err = xsk_buff_dma_map(umem, &adapter->pdev->dev, IXGBE_RX_DMA_ATTR);
 	if (err)
 		return err;
 
@@ -124,7 +75,7 @@ static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
 		ixgbe_txrx_ring_disable(adapter, qid);
 
 	clear_bit(qid, adapter->af_xdp_zc_qps);
-	ixgbe_xsk_umem_dma_unmap(adapter, umem);
+	xsk_buff_dma_unmap(umem, IXGBE_RX_DMA_ATTR);
 
 	if (if_running)
 		ixgbe_txrx_ring_enable(adapter, qid);
@@ -143,19 +94,14 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 			    struct ixgbe_ring *rx_ring,
 			    struct xdp_buff *xdp)
 {
-	struct xdp_umem *umem = rx_ring->xsk_umem;
 	int err, result = IXGBE_XDP_PASS;
 	struct bpf_prog *xdp_prog;
 	struct xdp_frame *xdpf;
-	u64 offset;
 	u32 act;
 
 	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	offset = xdp->data - xdp->data_hard_start;
-
-	xdp->handle = xsk_umem_adjust_offset(umem, xdp->handle, offset);
 
 	switch (act) {
 	case XDP_PASS:
@@ -186,140 +132,16 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 	return result;
 }
 
-static struct
-ixgbe_rx_buffer *ixgbe_get_rx_buffer_zc(struct ixgbe_ring *rx_ring,
-					unsigned int size)
-{
-	struct ixgbe_rx_buffer *bi;
-
-	bi = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
-
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev,
-				      bi->dma, 0,
-				      size,
-				      DMA_BIDIRECTIONAL);
-
-	return bi;
-}
-
-static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
-				     struct ixgbe_rx_buffer *obi)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct ixgbe_rx_buffer *nbi;
-
-	nbi = &rx_ring->rx_buffer_info[rx_ring->next_to_alloc];
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* transfer page from old buffer to new buffer */
-	nbi->dma = obi->dma;
-	nbi->addr = obi->addr;
-	nbi->handle = obi->handle;
-
-	obi->addr = NULL;
-	obi->skb = NULL;
-}
-
-void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
-{
-	struct ixgbe_rx_buffer *bi;
-	struct ixgbe_ring *rx_ring;
-	u64 hr, mask;
-	u16 nta;
-
-	rx_ring = container_of(alloc, struct ixgbe_ring, zca);
-	hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
-	mask = rx_ring->xsk_umem->chunk_mask;
-
-	nta = rx_ring->next_to_alloc;
-	bi = rx_ring->rx_buffer_info;
-
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	handle &= mask;
-
-	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
-	bi->dma += hr;
-
-	bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
-	bi->addr += hr;
-
-	bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
-					    rx_ring->xsk_umem->headroom);
-}
-
-static bool ixgbe_alloc_buffer_zc(struct ixgbe_ring *rx_ring,
-				  struct ixgbe_rx_buffer *bi)
-{
-	struct xdp_umem *umem = rx_ring->xsk_umem;
-	void *addr = bi->addr;
-	u64 handle, hr;
-
-	if (addr)
-		return true;
-
-	if (!xsk_umem_peek_addr(umem, &handle)) {
-		rx_ring->rx_stats.alloc_rx_page_failed++;
-		return false;
-	}
-
-	hr = umem->headroom + XDP_PACKET_HEADROOM;
-
-	bi->dma = xdp_umem_get_dma(umem, handle);
-	bi->dma += hr;
-
-	bi->addr = xdp_umem_get_data(umem, handle);
-	bi->addr += hr;
-
-	bi->handle = xsk_umem_adjust_offset(umem, handle, umem->headroom);
-
-	xsk_umem_release_addr(umem);
-	return true;
-}
-
-static bool ixgbe_alloc_buffer_slow_zc(struct ixgbe_ring *rx_ring,
-				       struct ixgbe_rx_buffer *bi)
-{
-	struct xdp_umem *umem = rx_ring->xsk_umem;
-	u64 handle, hr;
-
-	if (!xsk_umem_peek_addr_rq(umem, &handle)) {
-		rx_ring->rx_stats.alloc_rx_page_failed++;
-		return false;
-	}
-
-	handle &= rx_ring->xsk_umem->chunk_mask;
-
-	hr = umem->headroom + XDP_PACKET_HEADROOM;
-
-	bi->dma = xdp_umem_get_dma(umem, handle);
-	bi->dma += hr;
-
-	bi->addr = xdp_umem_get_data(umem, handle);
-	bi->addr += hr;
-
-	bi->handle = xsk_umem_adjust_offset(umem, handle, umem->headroom);
-
-	xsk_umem_release_addr_rq(umem);
-	return true;
-}
-
-static __always_inline bool
-__ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count,
-			    bool alloc(struct ixgbe_ring *rx_ring,
-				       struct ixgbe_rx_buffer *bi))
+bool ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 count)
 {
 	union ixgbe_adv_rx_desc *rx_desc;
 	struct ixgbe_rx_buffer *bi;
 	u16 i = rx_ring->next_to_use;
+	dma_addr_t dma;
 	bool ok = true;
 
 	/* nothing to do */
-	if (!cleaned_count)
+	if (!count)
 		return true;
 
 	rx_desc = IXGBE_RX_DESC(rx_ring, i);
@@ -327,21 +149,18 @@ __ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count,
 	i -= rx_ring->count;
 
 	do {
-		if (!alloc(rx_ring, bi)) {
+		bi->xdp = xsk_buff_alloc(rx_ring->xsk_umem);
+		if (!bi->xdp) {
 			ok = false;
 			break;
 		}
 
-		/* sync the buffer for use by the device */
-		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
-						 bi->page_offset,
-						 rx_ring->rx_buf_len,
-						 DMA_BIDIRECTIONAL);
+		dma = xsk_buff_xdp_get_dma(bi->xdp);
 
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma);
+		rx_desc->read.pkt_addr = cpu_to_le64(dma);
 
 		rx_desc++;
 		bi++;
@@ -355,17 +174,14 @@ __ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count,
 		/* clear the length for the next_to_use descriptor */
 		rx_desc->wb.upper.length = 0;
 
-		cleaned_count--;
-	} while (cleaned_count);
+		count--;
+	} while (count);
 
 	i += rx_ring->count;
 
 	if (rx_ring->next_to_use != i) {
 		rx_ring->next_to_use = i;
 
-		/* update next to alloc since we have filled the ring */
-		rx_ring->next_to_alloc = i;
-
 		/* Force memory writes to complete before letting h/w
 		 * know there are new descriptors to fetch.  (Only
 		 * applicable for weak-ordered memory model archs,
@@ -378,40 +194,27 @@ __ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count,
 	return ok;
 }
 
-void ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 count)
-{
-	__ixgbe_alloc_rx_buffers_zc(rx_ring, count,
-				    ixgbe_alloc_buffer_slow_zc);
-}
-
-static bool ixgbe_alloc_rx_buffers_fast_zc(struct ixgbe_ring *rx_ring,
-					   u16 count)
-{
-	return __ixgbe_alloc_rx_buffers_zc(rx_ring, count,
-					   ixgbe_alloc_buffer_zc);
-}
-
 static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
-					      struct ixgbe_rx_buffer *bi,
-					      struct xdp_buff *xdp)
+					      struct ixgbe_rx_buffer *bi)
 {
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	unsigned int datasize = xdp->data_end - xdp->data;
+	unsigned int metasize = bi->xdp->data - bi->xdp->data_meta;
+	unsigned int datasize = bi->xdp->data_end - bi->xdp->data;
 	struct sk_buff *skb;
 
 	/* allocate a skb to store the frags */
 	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
-			       xdp->data_end - xdp->data_hard_start,
+			       bi->xdp->data_end - bi->xdp->data_hard_start,
 			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
+	skb_reserve(skb, bi->xdp->data - bi->xdp->data_hard_start);
+	memcpy(__skb_put(skb, datasize), bi->xdp->data, datasize);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
-	ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+	xsk_buff_free(bi->xdp);
+	bi->xdp = NULL;
 	return skb;
 }
 
@@ -431,14 +234,9 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct ixgbe_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
-	struct xdp_umem *umem = rx_ring->xsk_umem;
 	unsigned int xdp_res, xdp_xmit = 0;
 	bool failure = false;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
-
-	xdp.rxq = &rx_ring->xdp_rxq;
-	xdp.frame_sz = xsk_umem_xdp_frame_sz(umem);
 
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
@@ -448,8 +246,8 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		/* return some buffers to hardware, one at a time is too slow */
 		if (cleaned_count >= IXGBE_RX_BUFFER_WRITE) {
 			failure = failure ||
-				  !ixgbe_alloc_rx_buffers_fast_zc(rx_ring,
-								 cleaned_count);
+				  !ixgbe_alloc_rx_buffers_zc(rx_ring,
+							     cleaned_count);
 			cleaned_count = 0;
 		}
 
@@ -464,42 +262,40 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		 */
 		dma_rmb();
 
-		bi = ixgbe_get_rx_buffer_zc(rx_ring, size);
+		bi = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
 
 		if (unlikely(!ixgbe_test_staterr(rx_desc,
 						 IXGBE_RXD_STAT_EOP))) {
 			struct ixgbe_rx_buffer *next_bi;
 
-			ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+			xsk_buff_free(bi->xdp);
+			bi->xdp = NULL;
 			ixgbe_inc_ntc(rx_ring);
 			next_bi =
 			       &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
-			next_bi->skb = ERR_PTR(-EINVAL);
+			next_bi->discard = true;
 			continue;
 		}
 
-		if (unlikely(bi->skb)) {
-			ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+		if (unlikely(bi->discard)) {
+			xsk_buff_free(bi->xdp);
+			bi->xdp = NULL;
+			bi->discard = false;
 			ixgbe_inc_ntc(rx_ring);
 			continue;
 		}
 
-		xdp.data = bi->addr;
-		xdp.data_meta = xdp.data;
-		xdp.data_hard_start = xdp.data - XDP_PACKET_HEADROOM;
-		xdp.data_end = xdp.data + size;
-		xdp.handle = bi->handle;
-
-		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, &xdp);
+		bi->xdp->data_end = bi->xdp->data + size;
+		xsk_buff_dma_sync_for_cpu(bi->xdp);
+		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, bi->xdp);
 
 		if (xdp_res) {
-			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
+			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR))
 				xdp_xmit |= xdp_res;
-				bi->addr = NULL;
-				bi->skb = NULL;
-			} else {
-				ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
-			}
+			else
+				xsk_buff_free(bi->xdp);
+
+			bi->xdp = NULL;
 			total_rx_packets++;
 			total_rx_bytes += size;
 
@@ -509,7 +305,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		}
 
 		/* XDP_PASS path */
-		skb = ixgbe_construct_skb_zc(rx_ring, bi, &xdp);
+		skb = ixgbe_construct_skb_zc(rx_ring, bi);
 		if (!skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
@@ -561,17 +357,17 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 
 void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
 {
-	u16 i = rx_ring->next_to_clean;
-	struct ixgbe_rx_buffer *bi = &rx_ring->rx_buffer_info[i];
+	struct ixgbe_rx_buffer *bi;
+	u16 i;
 
-	while (i != rx_ring->next_to_alloc) {
-		xsk_umem_fq_reuse(rx_ring->xsk_umem, bi->handle);
-		i++;
-		bi++;
-		if (i == rx_ring->count) {
-			i = 0;
-			bi = rx_ring->rx_buffer_info;
-		}
+	for (i = 0; i < rx_ring->count; i++) {
+		bi = &rx_ring->rx_buffer_info[i];
+
+		if (!bi->xdp)
+			continue;
+
+		xsk_buff_free(bi->xdp);
+		bi->xdp = NULL;
 	}
 }
 
@@ -594,10 +390,9 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &desc))
 			break;
 
-		dma = xdp_umem_get_dma(xdp_ring->xsk_umem, desc.addr);
-
-		dma_sync_single_for_device(xdp_ring->dev, dma, desc.len,
-					   DMA_BIDIRECTIONAL);
+		dma = xsk_buff_raw_get_dma(xdp_ring->xsk_umem, desc.addr);
+		xsk_buff_raw_dma_sync_for_device(xdp_ring->xsk_umem, dma,
+						 desc.len);
 
 		tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
 		tx_bi->bytecount = desc.len;
-- 
2.25.1

