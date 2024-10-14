Return-Path: <bpf+bounces-41857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631499C813
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539E71C24D41
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552221C3040;
	Mon, 14 Oct 2024 11:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B21A3A8D;
	Mon, 14 Oct 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903662; cv=none; b=dqTSU7ZNEkUtCmzIKFUd7WSC+yRfvPExhrvsqu83sY36zi8YSwgw+XKRnsiqwsSdS6SyrYuy+axewb1ML694B6tVlAP/870Kyi2d99MyMScXtuA3QERMk2pwn/VIB1GzVRL2gLV4dHsWJOSvfJJLaiBGM86h03xwbN1vpsyHR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903662; c=relaxed/simple;
	bh=tzdy785kFrFRI53xQ9lfWvkqL9ohQDSOol3AgCY29T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcCu1kNLHOoAx5llXTjRUsdKQTlln5J5gESeYi5D+H2w+R5eI1H/WwLrpzy92vYP8T8O+n4IwOorBA/exQHvWzhUAInGGHBBlgFM9eFjw95MPCmnmZAqQjqAK7TO6KZ7A0NA4dwobgVWNNhMe+PtMiMfJ1xP8WxxTcUXPWHwgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45F9016A3;
	Mon, 14 Oct 2024 04:01:29 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 635553F51B;
	Mon, 14 Oct 2024 04:00:56 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Paolo Abeni <pabeni@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v1 29/57] net: igb: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:36 +0100
Message-ID: <20241014105912.3207374-29-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Convert CPP conditionals to C conditionals. The compiler will dead code
strip when doing a compile-time page size build, for the same end
effect. But this will also work with boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/net/ethernet/intel/igb/igb.h      |  25 ++--
 drivers/net/ethernet/intel/igb/igb_main.c | 149 +++++++++++-----------
 2 files changed, 82 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 3c2dc7bdebb50..04aeebcd363b3 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -158,7 +158,6 @@ struct vf_mac_filter {
  *	 up negative.  In these cases we should fall back to the 3K
  *	 buffers.
  */
-#if (PAGE_SIZE < 8192)
 #define IGB_MAX_FRAME_BUILD_SKB (IGB_RXBUFFER_1536 - NET_IP_ALIGN)
 #define IGB_2K_TOO_SMALL_WITH_PADDING \
 ((NET_SKB_PAD + IGB_TS_HDR_LEN + IGB_RXBUFFER_1536) > SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048))
@@ -177,6 +176,9 @@ static inline int igb_skb_pad(void)
 {
 	int rx_buf_len;
 
+	if (PAGE_SIZE >= 8192)
+		return NET_SKB_PAD + NET_IP_ALIGN;
+
 	/* If a 2K buffer cannot handle a standard Ethernet frame then
 	 * optimize padding for a 3K buffer instead of a 1.5K buffer.
 	 *
@@ -196,9 +198,6 @@ static inline int igb_skb_pad(void)
 }
 
 #define IGB_SKB_PAD	igb_skb_pad()
-#else
-#define IGB_SKB_PAD	(NET_SKB_PAD + NET_IP_ALIGN)
-#endif
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IGB_RX_BUFFER_WRITE	16 /* Must be power of 2 */
@@ -280,7 +279,7 @@ struct igb_tx_buffer {
 struct igb_rx_buffer {
 	dma_addr_t dma;
 	struct page *page;
-#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
+#if (BITS_PER_LONG > 32) || (PAGE_SIZE_MAX >= 65536)
 	__u32 page_offset;
 #else
 	__u16 page_offset;
@@ -403,22 +402,20 @@ enum e1000_ring_flags_t {
 
 static inline unsigned int igb_rx_bufsz(struct igb_ring *ring)
 {
-#if (PAGE_SIZE < 8192)
-	if (ring_uses_large_buffer(ring))
-		return IGB_RXBUFFER_3072;
+	if (PAGE_SIZE < 8192) {
+		if (ring_uses_large_buffer(ring))
+			return IGB_RXBUFFER_3072;
 
-	if (ring_uses_build_skb(ring))
-		return IGB_MAX_FRAME_BUILD_SKB;
-#endif
+		if (ring_uses_build_skb(ring))
+			return IGB_MAX_FRAME_BUILD_SKB;
+	}
 	return IGB_RXBUFFER_2048;
 }
 
 static inline unsigned int igb_rx_pg_order(struct igb_ring *ring)
 {
-#if (PAGE_SIZE < 8192)
-	if (ring_uses_large_buffer(ring))
+	if (PAGE_SIZE < 8192 && ring_uses_large_buffer(ring))
 		return 1;
-#endif
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452a..4f2c53dece1a2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4797,9 +4797,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 				  struct igb_ring *rx_ring)
 {
-#if (PAGE_SIZE < 8192)
 	struct e1000_hw *hw = &adapter->hw;
-#endif
 
 	/* set build_skb and buffer size flags */
 	clear_ring_build_skb_enabled(rx_ring);
@@ -4810,12 +4808,11 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 
 	set_ring_build_skb_enabled(rx_ring);
 
-#if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	if (PAGE_SIZE < 8192 &&
+	    (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
 	    IGB_2K_TOO_SMALL_WITH_PADDING ||
-	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
+	    rd32(E1000_RCTL) & E1000_RCTL_SBP))
 		set_ring_uses_large_buffer(rx_ring);
-#endif
 }
 
 /**
@@ -5314,12 +5311,10 @@ static void igb_set_rx_mode(struct net_device *netdev)
 				     E1000_RCTL_VFE);
 	wr32(E1000_RCTL, rctl);
 
-#if (PAGE_SIZE < 8192)
-	if (!adapter->vfs_allocated_count) {
+	if (PAGE_SIZE < 8192 && !adapter->vfs_allocated_count) {
 		if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
 			rlpml = IGB_MAX_FRAME_BUILD_SKB;
 	}
-#endif
 	wr32(E1000_RLPML, rlpml);
 
 	/* In order to support SR-IOV and eventually VMDq it is necessary to set
@@ -5338,11 +5333,10 @@ static void igb_set_rx_mode(struct net_device *netdev)
 
 	/* enable Rx jumbo frames, restrict as needed to support build_skb */
 	vmolr &= ~E1000_VMOLR_RLPML_MASK;
-#if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
+	if (PAGE_SIZE < 8192 &&
+	    adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
 		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
 	else
-#endif
 		vmolr |= MAX_JUMBO_FRAME_SIZE;
 	vmolr |= E1000_VMOLR_LPE;
 
@@ -8435,17 +8429,17 @@ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
 	if (!dev_page_is_reusable(page))
 		return false;
 
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely((rx_buf_pgcnt - pagecnt_bias) > 1))
-		return false;
-#else
+	if (PAGE_SIZE < 8192) {
+		/* if we are only owner of page we can reuse it */
+		if (unlikely((rx_buf_pgcnt - pagecnt_bias) > 1))
+			return false;
+	} else {
 #define IGB_LAST_OFFSET \
 	(SKB_WITH_OVERHEAD(PAGE_SIZE) - IGB_RXBUFFER_2048)
 
-	if (rx_buffer->page_offset > IGB_LAST_OFFSET)
-		return false;
-#endif
+		if (rx_buffer->page_offset > IGB_LAST_OFFSET)
+			return false;
+	}
 
 	/* If we have drained the page fragment pool we need to update
 	 * the pagecnt_bias and page count so that we fully restock the
@@ -8473,20 +8467,22 @@ static void igb_add_rx_frag(struct igb_ring *rx_ring,
 			    struct sk_buff *skb,
 			    unsigned int size)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
+	unsigned int truesize;
+
+	if (PAGE_SIZE < 8192)
+		truesize = igb_rx_pg_size(rx_ring) / 2;
+	else
+		truesize = ring_uses_build_skb(rx_ring) ?
 				SKB_DATA_ALIGN(IGB_SKB_PAD + size) :
 				SKB_DATA_ALIGN(size);
-#endif
+
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->page_offset, size, truesize);
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
+
+	if (PAGE_SIZE < 8192)
+		rx_buffer->page_offset ^= truesize;
+	else
+		rx_buffer->page_offset += truesize;
 }
 
 static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
@@ -8494,16 +8490,16 @@ static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
 					 struct xdp_buff *xdp,
 					 ktime_t timestamp)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(xdp->data_end -
-					       xdp->data_hard_start);
-#endif
 	unsigned int size = xdp->data_end - xdp->data;
+	unsigned int truesize;
 	unsigned int headlen;
 	struct sk_buff *skb;
 
+	if (PAGE_SIZE < 8192)
+		truesize = igb_rx_pg_size(rx_ring) / 2;
+	else
+		truesize = SKB_DATA_ALIGN(xdp->data_end - xdp->data_hard_start);
+
 	/* prefetch first cache line of first page */
 	net_prefetch(xdp->data);
 
@@ -8529,11 +8525,10 @@ static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
 		skb_add_rx_frag(skb, 0, rx_buffer->page,
 				(xdp->data + headlen) - page_address(rx_buffer->page),
 				size, truesize);
-#if (PAGE_SIZE < 8192)
-		rx_buffer->page_offset ^= truesize;
-#else
-		rx_buffer->page_offset += truesize;
-#endif
+		if (PAGE_SIZE < 8192)
+			rx_buffer->page_offset ^= truesize;
+		else
+			rx_buffer->page_offset += truesize;
 	} else {
 		rx_buffer->pagecnt_bias++;
 	}
@@ -8546,16 +8541,17 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 				     struct xdp_buff *xdp,
 				     ktime_t timestamp)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
-#else
-	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(xdp->data_end -
-					       xdp->data_hard_start);
-#endif
 	unsigned int metasize = xdp->data - xdp->data_meta;
+	unsigned int truesize;
 	struct sk_buff *skb;
 
+	if (PAGE_SIZE < 8192)
+		truesize = igb_rx_pg_size(rx_ring) / 2;
+	else
+		truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
+			   SKB_DATA_ALIGN(xdp->data_end -
+					  xdp->data_hard_start);
+
 	/* prefetch first cache line of first page */
 	net_prefetch(xdp->data_meta);
 
@@ -8575,11 +8571,10 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 		skb_hwtstamps(skb)->hwtstamp = timestamp;
 
 	/* update buffer offset */
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
+	if (PAGE_SIZE < 8192)
+		rx_buffer->page_offset ^= truesize;
+	else
+		rx_buffer->page_offset += truesize;
 
 	return skb;
 }
@@ -8634,14 +8629,14 @@ static unsigned int igb_rx_frame_truesize(struct igb_ring *rx_ring,
 {
 	unsigned int truesize;
 
-#if (PAGE_SIZE < 8192)
-	truesize = igb_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
-#else
-	truesize = ring_uses_build_skb(rx_ring) ?
-		SKB_DATA_ALIGN(IGB_SKB_PAD + size) +
-		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
-		SKB_DATA_ALIGN(size);
-#endif
+	if (PAGE_SIZE < 8192)
+		truesize = igb_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
+	else
+		truesize = ring_uses_build_skb(rx_ring) ?
+			SKB_DATA_ALIGN(IGB_SKB_PAD + size) +
+			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
+			SKB_DATA_ALIGN(size);
+
 	return truesize;
 }
 
@@ -8650,11 +8645,11 @@ static void igb_rx_buffer_flip(struct igb_ring *rx_ring,
 			       unsigned int size)
 {
 	unsigned int truesize = igb_rx_frame_truesize(rx_ring, size);
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
+
+	if (PAGE_SIZE < 8192)
+		rx_buffer->page_offset ^= truesize;
+	else
+		rx_buffer->page_offset += truesize;
 }
 
 static inline void igb_rx_checksum(struct igb_ring *ring,
@@ -8825,12 +8820,12 @@ static struct igb_rx_buffer *igb_get_rx_buffer(struct igb_ring *rx_ring,
 	struct igb_rx_buffer *rx_buffer;
 
 	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
-	*rx_buf_pgcnt =
-#if (PAGE_SIZE < 8192)
-		page_count(rx_buffer->page);
-#else
-		0;
-#endif
+
+	if (PAGE_SIZE < 8192)
+		*rx_buf_pgcnt = page_count(rx_buffer->page);
+	else
+		*rx_buf_pgcnt = 0;
+
 	prefetchw(rx_buffer->page);
 
 	/* we are reusing so sync this buffer for CPU use */
@@ -8881,9 +8876,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	int rx_buf_pgcnt;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
-#if (PAGE_SIZE < 8192)
-	frame_sz = igb_rx_frame_truesize(rx_ring, 0);
-#endif
+	if (PAGE_SIZE < 8192)
+		frame_sz = igb_rx_frame_truesize(rx_ring, 0);
 	xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 
 	while (likely(total_packets < budget)) {
@@ -8932,10 +8926,9 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 
 			xdp_prepare_buff(&xdp, hard_start, offset, size, true);
 			xdp_buff_clear_frags_flag(&xdp);
-#if (PAGE_SIZE > 4096)
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
-			xdp.frame_sz = igb_rx_frame_truesize(rx_ring, size);
-#endif
+			if (PAGE_SIZE > 4096)
+				xdp.frame_sz = igb_rx_frame_truesize(rx_ring, size);
 			skb = igb_run_xdp(adapter, rx_ring, &xdp);
 		}
 
-- 
2.43.0


