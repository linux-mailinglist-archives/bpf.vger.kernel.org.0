Return-Path: <bpf+bounces-55977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE51A8A56D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82558443002
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E187221542;
	Tue, 15 Apr 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgWvUo6z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0F21D594;
	Tue, 15 Apr 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738140; cv=none; b=jBIUAaArxgC/fuBTWvttJ5YbYlk0XWkX34lDR9U/xPHdhgCk+DBavF1OHmsLofVnVjJMWWZVk3gvXg7AUjredb/KwMVeIM8uCiYioyvOP1EzSKlyFpTKOULdhqcFa+LhSP63IP70M1oo3rruBojLynT4+Q5fIlX4OT1GtQLemmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738140; c=relaxed/simple;
	bh=J15pFQWfMktbS1e5HIo5JingsYHiRjmh+zigBRXJAHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntzXPg1gSOnevIVoypvKW/J0wls6KvCE+2Na//Abv2WFgnQT7XdW2JLhEsEO7eSeKvYDtri4IJoYJMr+ILydfTWEPvNlqMpexWvWT15ysPG3eou+O3hNgGITaxXoV2lA+odfaxzO+ZpTSLMGS/vH5XhwAc+cdZIwx7MskRo7OAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgWvUo6z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738138; x=1776274138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J15pFQWfMktbS1e5HIo5JingsYHiRjmh+zigBRXJAHg=;
  b=ZgWvUo6zbO8/I6OC1vjg+IcWfEJwKRdLN6MnMaB2+TC2LYJU9EJ4b4cv
   CvEZQqxwJDA4tIFD1sahG8F/54mSmiSo77ylVcwvSWBWrjCwJKJJhUdTP
   bh6zaGyxhPQ5Rzt+MQExYQ0lW6axor0sH72v5vjhGJoYinFDJyW668wTc
   HlnuhU5NZUVXugT4CFChN8GbsVVCf055C65W9sZh4Dyvuy2HRa3+BGdK5
   MxeuParH+nE14Lk7RjIzfExeIg02O4WNHaholxZAUucm2GubkngHoemzH
   C8fTJcW37baVF7Gp+LWFFs8MUkzBK9mrK5t8gZwJJ7p3Le+tFIXufdy1n
   g==;
X-CSE-ConnectionGUID: zlsEDk+AS1aQfQAVWw87nw==
X-CSE-MsgGUID: wYGDrGPwQWWqf1PnKIbS+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46275594"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46275594"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:28:58 -0700
X-CSE-ConnectionGUID: yWUKkOKmTAi1UhbaGDVVHg==
X-CSE-MsgGUID: HLwyN73sTTGUcqVGHQm8Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130729630"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2025 10:28:53 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH iwl-next 01/16] libeth: convert to netmem
Date: Tue, 15 Apr 2025 19:28:10 +0200
Message-ID: <20250415172825.3731091-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back when the libeth Rx core was initially written, devmem was a draft
and netmem_ref didn't exist in the mainline. Now that it's here, make
libeth MP-agnostic before introducing any new code or any new library
users.
When it's known that the created PP/FQ is for header buffers, use faster
"unsafe" underscored netmem <--> virt accessors as netmem_is_net_iov()
is always false in that case, but consumes some cycles (bit test +
true branch).
Misc: replace explicit EXPORT_SYMBOL_NS_GPL("NS") with
DEFAULT_SYMBOL_NAMESPACE.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/rx.h                       | 22 +++++++------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 14 ++++----
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 33 +++++++++++--------
 drivers/net/ethernet/intel/libeth/rx.c        | 20 ++++++-----
 5 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index ab05024be518..7d5dc58984b1 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (C) 2024 Intel Corporation */
+/* Copyright (C) 2024-2025 Intel Corporation */
 
 #ifndef __LIBETH_RX_H
 #define __LIBETH_RX_H
@@ -31,7 +31,7 @@
 
 /**
  * struct libeth_fqe - structure representing an Rx buffer (fill queue element)
- * @page: page holding the buffer
+ * @netmem: network memory reference holding the buffer
  * @offset: offset from the page start (to the headroom)
  * @truesize: total space occupied by the buffer (w/ headroom and tailroom)
  *
@@ -40,7 +40,7 @@
  * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
  */
 struct libeth_fqe {
-	struct page		*page;
+	netmem_ref		netmem;
 	u32			offset;
 	u32			truesize;
 } __aligned_largest;
@@ -102,15 +102,16 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->page = page_pool_dev_alloc(fq->pp, &buf->offset, &buf->truesize);
-	if (unlikely(!buf->page))
+	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
+						 &buf->truesize);
+	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
-	return page_pool_get_dma_addr(buf->page) + buf->offset +
+	return page_pool_get_dma_addr_netmem(buf->netmem) + buf->offset +
 	       fq->pp->p.offset;
 }
 
-void libeth_rx_recycle_slow(struct page *page);
+void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
  * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
@@ -126,18 +127,19 @@ void libeth_rx_recycle_slow(struct page *page);
 static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
 					  u32 len)
 {
-	struct page *page = fqe->page;
+	netmem_ref netmem = fqe->netmem;
 
 	/* Very rare, but possible case. The most common reason:
 	 * the last fragment contained FCS only, which was then
 	 * stripped by the HW.
 	 */
 	if (unlikely(!len)) {
-		libeth_rx_recycle_slow(page);
+		libeth_rx_recycle_slow(netmem);
 		return false;
 	}
 
-	page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
+	page_pool_dma_sync_netmem_for_cpu(netmem_get_pp(netmem), netmem,
+					  fqe->offset, len);
 
 	return true;
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 422312b8b54a..35d353d38129 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -723,7 +723,7 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
 	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
 		const struct libeth_fqe *rx_fqes = &rx_ring->rx_fqes[i];
 
-		page_pool_put_full_page(rx_ring->pp, rx_fqes->page, false);
+		libeth_rx_recycle_slow(rx_fqes->netmem);
 
 		if (unlikely(++i == rx_ring->count))
 			i = 0;
@@ -1197,10 +1197,11 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 			     const struct libeth_fqe *rx_buffer,
 			     unsigned int size)
 {
-	u32 hr = rx_buffer->page->pp->p.offset;
+	u32 hr = netmem_get_pp(rx_buffer->netmem)->p.offset;
 
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
-			rx_buffer->offset + hr, size, rx_buffer->truesize);
+	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
+			       rx_buffer->netmem, rx_buffer->offset + hr,
+			       size, rx_buffer->truesize);
 }
 
 /**
@@ -1214,12 +1215,13 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
-	u32 hr = rx_buffer->page->pp->p.offset;
+	struct page *buf_page = __netmem_to_page(rx_buffer->netmem);
+	u32 hr = buf_page->pp->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
 	/* prefetch first cache line of first page */
-	va = page_address(rx_buffer->page) + rx_buffer->offset;
+	va = page_address(buf_page) + rx_buffer->offset;
 	net_prefetch(va + hr);
 
 	/* build an skb around the page buffer */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index eae1b6f474e6..aeb2ca5f5a0a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1009,7 +1009,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 			break;
 
 skip_data:
-		rx_buf->page = NULL;
+		rx_buf->netmem = 0;
 
 		IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
 		cleaned_count++;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index bdf52cef3891..6254806c2072 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -382,12 +382,12 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
  */
 static void idpf_rx_page_rel(struct libeth_fqe *rx_buf)
 {
-	if (unlikely(!rx_buf->page))
+	if (unlikely(!rx_buf->netmem))
 		return;
 
-	page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
+	libeth_rx_recycle_slow(rx_buf->netmem);
 
-	rx_buf->page = NULL;
+	rx_buf->netmem = 0;
 	rx_buf->offset = 0;
 }
 
@@ -3096,10 +3096,10 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size)
 {
-	u32 hr = rx_buf->page->pp->p.offset;
+	u32 hr = netmem_get_pp(rx_buf->netmem)->p.offset;
 
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
-			rx_buf->offset + hr, size, rx_buf->truesize);
+	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags, rx_buf->netmem,
+			       rx_buf->offset + hr, size, rx_buf->truesize);
 }
 
 /**
@@ -3122,16 +3122,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 			     struct libeth_fqe *buf, u32 data_len)
 {
 	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
+	struct page *hdr_page, *buf_page;
 	const void *src;
 	void *dst;
 
-	if (!libeth_rx_sync_for_cpu(buf, copy))
+	if (unlikely(netmem_is_net_iov(buf->netmem)) ||
+	    !libeth_rx_sync_for_cpu(buf, copy))
 		return 0;
 
-	dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
-	src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
-	memcpy(dst, src, LARGEST_ALIGN(copy));
+	hdr_page = __netmem_to_page(hdr->netmem);
+	buf_page = __netmem_to_page(buf->netmem);
+	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
+	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
 
+	memcpy(dst, src, LARGEST_ALIGN(copy));
 	buf->offset += copy;
 
 	return copy;
@@ -3147,11 +3151,12 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
  */
 struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
 {
-	u32 hr = buf->page->pp->p.offset;
+	struct page *buf_page = __netmem_to_page(buf->netmem);
+	u32 hr = buf_page->pp->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
-	va = page_address(buf->page) + buf->offset;
+	va = page_address(buf_page) + buf->offset;
 	prefetch(va + hr);
 
 	skb = napi_build_skb(va, buf->truesize);
@@ -3302,7 +3307,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			u64_stats_update_end(&rxq->stats_sync);
 		}
 
-		hdr->page = NULL;
+		hdr->netmem = 0;
 
 payload:
 		if (!libeth_rx_sync_for_cpu(rx_buf, pkt_len))
@@ -3318,7 +3323,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			break;
 
 skip_data:
-		rx_buf->page = NULL;
+		rx_buf->netmem = 0;
 
 		idpf_rx_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 66d1d23b8ad2..aa5d878181f7 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2024 Intel Corporation */
+/* Copyright (C) 2024-2025 Intel Corporation */
+
+#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH"
 
 #include <net/libeth/rx.h>
 
@@ -186,7 +188,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 
 	return -ENOMEM;
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_fq_create);
 
 /**
  * libeth_rx_fq_destroy - destroy a &page_pool created by libeth
@@ -197,19 +199,19 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq)
 	kvfree(fq->fqes);
 	page_pool_destroy(fq->pp);
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_fq_destroy);
 
 /**
- * libeth_rx_recycle_slow - recycle a libeth page from the NAPI context
- * @page: page to recycle
+ * libeth_rx_recycle_slow - recycle libeth netmem
+ * @netmem: network memory to recycle
  *
  * To be used on exceptions or rare cases not requiring fast inline recycling.
  */
-void libeth_rx_recycle_slow(struct page *page)
+void __cold libeth_rx_recycle_slow(netmem_ref netmem)
 {
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_recycle_slow);
 
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
@@ -251,7 +253,7 @@ void libeth_rx_pt_gen_hash_type(struct libeth_rx_pt *pt)
 	pt->hash_type |= libeth_rx_pt_xdp_iprot[pt->inner_prot];
 	pt->hash_type |= libeth_rx_pt_xdp_pl[pt->payload_layer];
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_pt_gen_hash_type, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_pt_gen_hash_type);
 
 /* Module */
 
-- 
2.49.0


