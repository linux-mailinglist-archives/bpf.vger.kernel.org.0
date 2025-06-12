Return-Path: <bpf+bounces-60489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E503AD77AA
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D41673AE
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5129CB4F;
	Thu, 12 Jun 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgW0Kf3t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE6298CB2;
	Thu, 12 Jun 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744576; cv=none; b=EIy50FYzmLPQ3dgPWFqIVwHY1JD+8SDFW83c3Z1SI0XvfT1Q24qyHbKA5UgwwmDy8K1/9aT7LSfSRiTO0/K55SMPVHC3m2cbycb8vvq37JH4O96oISBDoWh8DsPNC62pIg+8p3IfpfOXtj14uprr4ju+/n4oSoGEpZxwAwsEz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744576; c=relaxed/simple;
	bh=lBMx7xpwcElr6JTSgSj365LnMhXIBLIk3ALzeaeTHFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAaaoABvjMTtN/X4UHUlQ+aK7T/BbhRr8EuNV4mMUFDRs1jqqCB4DtJ4pPD0mjLIn2W/99fNm8JFheyqN7Pfj0DE4MZZDAJ5Ux0PTJsGspNh9i9dMmWeysXYysNBpmdIJBAY3QMOJfCVE342IYhDE01/ohcE0v/TwIPTfKdQwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgW0Kf3t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744575; x=1781280575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBMx7xpwcElr6JTSgSj365LnMhXIBLIk3ALzeaeTHFs=;
  b=UgW0Kf3t49g8azJrb6vckzYrduohn9imKJbeYsTPqUChlOR/+RDutBW2
   +FZPMiq0QCatjgkrvncar28tNado1EfAt2mkWS1AXj6d53y1lDBX4GCxV
   p7deiPg36bZswMj36NVcIDxOllhHCrq+zp3AMAMzBZzc/UJ3CBNjOLMN9
   MPl96nTyyNr5pbLGo/GK3k2HSNX8yJOkkisbRkstnOunx+0nJWWuvEZTe
   F34AoQ5vrewbwnJH2+2Zd2wY5br9gJreNXwo7oroAE3J42zys+xn5zNmE
   oXxugmP6ZHtUabfY+s/n4fgVUdnNSjevtaan+ty4aYaTD0DKSi/9PKfDW
   A==;
X-CSE-ConnectionGUID: Tsn2TvR6RMuMaz56+5WW9g==
X-CSE-MsgGUID: 3r+9yWxXSVSdpIUMRU3t+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55738831"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55738831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:09:35 -0700
X-CSE-ConnectionGUID: bvf8lUYDSN2lXvuBwFRl+w==
X-CSE-MsgGUID: IeSPVj4QT2qKj4osacvXLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468559"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:09:30 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH iwl-next v2 02/17] libeth: convert to netmem
Date: Thu, 12 Jun 2025 18:02:19 +0200
Message-ID: <20250612160234.68682-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612160234.68682-1-aleksander.lobakin@intel.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/rx.h                       | 22 ++++++------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 14 ++++----
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 36 +++++++++++--------
 drivers/net/ethernet/intel/libeth/rx.c        |  8 ++---
 5 files changed, 46 insertions(+), 36 deletions(-)

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
index 23e786b9793d..aaf70c625655 100644
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
index 993c354aa27a..555879b1248d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1006,7 +1006,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 			break;
 
 skip_data:
-		rx_buf->page = NULL;
+		rx_buf->netmem = 0;
 
 		IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
 		cleaned_count++;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5cf440e09d0a..cef9dfb877e8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -383,12 +383,12 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
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
 
@@ -3240,10 +3240,10 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
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
@@ -3266,16 +3266,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
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
@@ -3291,11 +3295,12 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
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
@@ -3429,7 +3434,8 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 
 		if (unlikely(!hdr_len && !skb)) {
 			hdr_len = idpf_rx_hsplit_wa(hdr, rx_buf, pkt_len);
-			pkt_len -= hdr_len;
+			/* If failed, drop both buffers by setting len to 0 */
+			pkt_len -= hdr_len ? : pkt_len;
 
 			u64_stats_update_begin(&rxq->stats_sync);
 			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
@@ -3446,7 +3452,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			u64_stats_update_end(&rxq->stats_sync);
 		}
 
-		hdr->page = NULL;
+		hdr->netmem = 0;
 
 payload:
 		if (!libeth_rx_sync_for_cpu(rx_buf, pkt_len))
@@ -3462,7 +3468,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			break;
 
 skip_data:
-		rx_buf->page = NULL;
+		rx_buf->netmem = 0;
 
 		idpf_rx_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index c2c53552c440..2afa6e33f160 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -204,14 +204,14 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq)
 EXPORT_SYMBOL_GPL(libeth_rx_fq_destroy);
 
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
 EXPORT_SYMBOL_GPL(libeth_rx_recycle_slow);
 
-- 
2.49.0


