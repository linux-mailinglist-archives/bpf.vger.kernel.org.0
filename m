Return-Path: <bpf+bounces-5286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435427596A4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EF028180D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7F156CB;
	Wed, 19 Jul 2023 13:25:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860AB154B6;
	Wed, 19 Jul 2023 13:25:06 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600411B;
	Wed, 19 Jul 2023 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773105; x=1721309105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfUbNvwx1lGKw0FHeEsM90swSpFTaNID4KuxnClJkPs=;
  b=lPIPLahBZXL8f15CSMph2nb9KYhOnbel33d9LwlNrDC9doK4RDitXCW9
   EluhDXdKxHyJoF1uAwrCTG4tBdCslBjHOFyT3jiOYrV8iSLRQEgS3nkuv
   n4ArcgPLMkBIkF5zjcx2hsE5Vsne9/e7cKQ+zbXEvFOmd7Co5FxA/AoTC
   W4h+h2yRP3cnqHU5TZlX2nNy+wf3Hvriq8lQl/c6JP89pX9VWNoKFoDTz
   nsIr9xP24EkGfZYqhZUzDmm1SAEEKl90jKCjoueyTYbTzfkoPNPovQLMW
   ND5Z40fTDXkqXnrcAurEFpXVDk4pu/dVdFxc7en9zWgLW8rPJPynRJGFS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920497"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717977992"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717977992"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:36 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com
Subject: [PATCH v7 bpf-next 01/24] xsk: prepare 'options' in xdp_desc for multi-buffer use
Date: Wed, 19 Jul 2023 15:23:58 +0200
Message-Id: <20230719132421.584801-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Use the 'options' field in xdp_desc as a packet continuity marker. Since
'options' field was unused till now and was expected to be set to 0, the
'eop' descriptor will have it set to 0, while the non-eop descriptors
will have to set it to 1. This ensures legacy applications continue to
work without needing any change for single-buffer packets.

Add helper functions and extend xskq_prod_reserve_desc() to use the
'options' field.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 include/uapi/linux/if_xdp.h |  7 +++++++
 net/xdp/xsk.c               |  8 ++++----
 net/xdp/xsk_queue.h         | 12 +++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index a78a8096f4ce..434f313dc26c 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -108,4 +108,11 @@ struct xdp_desc {
 
 /* UMEM descriptor is __u64 */
 
+/* Flag indicating that the packet continues with the buffer pointed out by the
+ * next frame in the ring. The end of the packet is signalled by setting this
+ * bit to zero. For single buffer packets, every descriptor has 'options' set
+ * to 0 and this maintains backward compatibility.
+ */
+#define XDP_PKT_CONTD (1 << 0)
+
 #endif /* _LINUX_IF_XDP_H */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 31dca4ecb2c5..914a80cd55d3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -135,14 +135,14 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 	return 0;
 }
 
-static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
+static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len, u32 flags)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
 	u64 addr;
 	int err;
 
 	addr = xp_get_handle(xskb);
-	err = xskq_prod_reserve_desc(xs->rx, addr, len);
+	err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
 	if (err) {
 		xs->rx_queue_full++;
 		return err;
@@ -189,7 +189,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	}
 
 	xsk_copy_xdp(xsk_xdp, xdp, len);
-	err = __xsk_rcv_zc(xs, xsk_xdp, len);
+	err = __xsk_rcv_zc(xs, xsk_xdp, len, 0);
 	if (err) {
 		xsk_buff_free(xsk_xdp);
 		return err;
@@ -259,7 +259,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 
 	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL) {
 		len = xdp->data_end - xdp->data;
-		return __xsk_rcv_zc(xs, xdp, len);
+		return __xsk_rcv_zc(xs, xdp, len, 0);
 	}
 
 	err = __xsk_rcv(xs, xdp);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 6d40a77fccbe..2f1aacae81af 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -130,6 +130,11 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
 	return false;
 }
 
+static inline bool xp_unused_options_set(u32 options)
+{
+	return options & ~XDP_PKT_CONTD;
+}
+
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 					    struct xdp_desc *desc)
 {
@@ -141,7 +146,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 	if (desc->addr >= pool->addrs_cnt)
 		return false;
 
-	if (desc->options)
+	if (xp_unused_options_set(desc->options))
 		return false;
 	return true;
 }
@@ -158,7 +163,7 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
 		return false;
 
-	if (desc->options)
+	if (xp_unused_options_set(desc->options))
 		return false;
 	return true;
 }
@@ -360,7 +365,7 @@ static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_de
 }
 
 static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
-					 u64 addr, u32 len)
+					 u64 addr, u32 len, u32 flags)
 {
 	struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 	u32 idx;
@@ -372,6 +377,7 @@ static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
 	idx = q->cached_prod++ & q->ring_mask;
 	ring->desc[idx].addr = addr;
 	ring->desc[idx].len = len;
+	ring->desc[idx].options = flags;
 
 	return 0;
 }
-- 
2.34.1


