Return-Path: <bpf+bounces-46652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879E99ED38B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDA283608
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67446203707;
	Wed, 11 Dec 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7KdBl1W"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1E202F96;
	Wed, 11 Dec 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938138; cv=none; b=HBYs5iTsA0rgYRVQbVhxgQYIHcQTPnXbBWzI2ujR0N9sWPqfrtlr+y5zsYsFiUKDFgiyb7xEYVsg56TQcGYtVNRg4uZd8sX5FSiLo6jX0qcckotqGbXmAlK21pHuTRpKRt/1fAzAC9aRtTibf5bjIYbM225FzjtUouzAgQNDvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938138; c=relaxed/simple;
	bh=M9Ciy3tkJShPPbC2RKdcmdtYSeXJngDCkPUGImKkRFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze+mzc6N3PmoVZaLIx8SlAezPsAnFKLbSFImD3pUb6VkrfV7vI7iJ6OtpNUORrCxvYV5GJHeayBk4mC1RX7icZlr70P77FGQ8tt/SKSuPaSs1SBdU30fL+Hu/xRzdhIGQ8hDjY/w5EDV4NOfVHVI/hxwCbUGYf6n5ItyWV7Kmmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7KdBl1W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938136; x=1765474136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9Ciy3tkJShPPbC2RKdcmdtYSeXJngDCkPUGImKkRFw=;
  b=D7KdBl1Wn2VeWW0vCMmKsDpcX8Bu6d1zsldisnUXkvsh7M2zuRMwQOgR
   gwmMM12KmfN2uoXlb7nq5Cp3vx4A3UGzi/F+Yi74q/y9Z87clm0hCTmMs
   vim//z3BPnLf2510yezDKouaomi+gBEFgb8n3CKDEhmbn9tJKzvyxXzwS
   IPxSj4EX8mkUvqdQS7Ja9sJ9WBHTQrm2nUQkaaGC2cqs8Ze+8me1uBLIZ
   7sGIpfp1lbDtAp9tfujix1pR2E105DkQ4Dedewz5r0dv5Dy9Bjc/cOQBJ
   PmrilSwZ0Z+LeEIKA3iGt2pCR8bPLnvrMsPWlzCPjJK1wjbMvRj15Tdo8
   g==;
X-CSE-ConnectionGUID: 4UK6RYS4RbK+MPutg13NXA==
X-CSE-MsgGUID: 6JbKwcWvSFmCd6dWeBLx1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859521"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859521"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:28:56 -0800
X-CSE-ConnectionGUID: rnJl5QmMRiqZAwxtTn8rNw==
X-CSE-MsgGUID: VB1Tt8HkSF6OHDZHjvTjyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122164"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:28:50 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/12] xdp: add generic xdp_buff_add_frag()
Date: Wed, 11 Dec 2024 18:26:41 +0100
Message-ID: <20241211172649.761483-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code piece which would attach a frag to &xdp_buff is almost
identical across the drivers supporting XDP multi-buffer on Rx.
Make it a generic elegant "oneliner".
Also, I see lots of drivers calculating frags_truesize as
`xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
frags might be backed by chunks of different sizes, especially with
stuff like the header split. Even page_pool_alloc() can give you two
different truesizes on two subsequent requests to allocate the same
buffer size. Add a field to &skb_shared_info (unionized as there's no
free slot currently on x86_64) to track the "true" truesize. It can
be used later when updating an skb.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 16 +++++--
 include/net/xdp.h      | 96 +++++++++++++++++++++++++++++++++++++++++-
 net/core/xdp.c         | 11 +++++
 3 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 69624b394cd9..8bcf14ae6789 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -608,11 +608,19 @@ struct skb_shared_info {
 	 * Warning : all fields before dataref are cleared in __alloc_skb()
 	 */
 	atomic_t	dataref;
-	unsigned int	xdp_frags_size;
 
-	/* Intermediate layers must ensure that destructor_arg
-	 * remains valid until skb destructor */
-	void *		destructor_arg;
+	union {
+		struct {
+			u32		xdp_frags_size;
+			u32		xdp_frags_truesize;
+		};
+
+		/*
+		 * Intermediate layers must ensure that destructor_arg
+		 * remains valid until skb destructor.
+		 */
+		void		*destructor_arg;
+	};
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
diff --git a/include/net/xdp.h b/include/net/xdp.h
index d2089cfecefd..11139c210b49 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -167,6 +167,93 @@ xdp_get_buff_len(const struct xdp_buff *xdp)
 	return len;
 }
 
+void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp);
+
+/**
+ * __xdp_buff_add_frag - attach frag to &xdp_buff
+ * @xdp: XDP buffer to attach the frag to
+ * @netmem: network memory containing the frag
+ * @offset: offset at which the frag starts
+ * @size: size of the frag
+ * @truesize: total memory size occupied by the frag
+ * @try_coalesce: whether to try coalescing the frags (not valid for XSk)
+ *
+ * Attach frag to the XDP buffer. If it currently has no frags attached,
+ * initialize the related fields, otherwise check that the frag number
+ * didn't reach the limit of ``MAX_SKB_FRAGS``. If possible, try coalescing
+ * the frag with the previous one.
+ * The function doesn't check/update the pfmemalloc bit. Please use the
+ * non-underscored wrapper in drivers.
+ *
+ * Return: true on success, false if there's no space for the frag in
+ * the shared info struct.
+ */
+static inline bool __xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
+				       u32 offset, u32 size, u32 truesize,
+				       bool try_coalesce)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	skb_frag_t *prev;
+	u32 nr_frags;
+
+	if (!xdp_buff_has_frags(xdp)) {
+		xdp_buff_set_frags_flag(xdp);
+
+		nr_frags = 0;
+		sinfo->xdp_frags_size = 0;
+		sinfo->xdp_frags_truesize = 0;
+
+		goto fill;
+	}
+
+	nr_frags = sinfo->nr_frags;
+	prev = &sinfo->frags[nr_frags - 1];
+
+	if (try_coalesce && netmem == skb_frag_netmem(prev) &&
+	    offset == skb_frag_off(prev) + skb_frag_size(prev)) {
+		skb_frag_size_add(prev, size);
+		/* Guaranteed to only decrement the refcount */
+		xdp_return_frag(netmem, xdp);
+	} else if (unlikely(nr_frags == MAX_SKB_FRAGS)) {
+		return false;
+	} else {
+fill:
+		__skb_fill_netmem_desc_noacc(sinfo, nr_frags++, netmem,
+					     offset, size);
+	}
+
+	sinfo->nr_frags = nr_frags;
+	sinfo->xdp_frags_size += size;
+	sinfo->xdp_frags_truesize += truesize;
+
+	return true;
+}
+
+/**
+ * xdp_buff_add_frag - attach frag to &xdp_buff
+ * @xdp: XDP buffer to attach the frag to
+ * @netmem: network memory containing the frag
+ * @offset: offset at which the frag starts
+ * @size: size of the frag
+ * @truesize: total memory size occupied by the frag
+ *
+ * Version of __xdp_buff_add_frag() which takes care of the pfmemalloc bit.
+ *
+ * Return: true on success, false if there's no space for the frag in
+ * the shared info struct.
+ */
+static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
+				     u32 offset, u32 size, u32 truesize)
+{
+	if (!__xdp_buff_add_frag(xdp, netmem, offset, size, truesize, true))
+		return false;
+
+	if (unlikely(netmem_is_pfmemalloc(netmem)))
+		xdp_buff_set_frag_pfmemalloc(xdp);
+
+	return true;
+}
+
 struct xdp_frame {
 	void *data;
 	u32 len;
@@ -230,7 +317,14 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 			   unsigned int size, unsigned int truesize,
 			   bool pfmemalloc)
 {
-	skb_shinfo(skb)->nr_frags = nr_frags;
+	struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+	sinfo->nr_frags = nr_frags;
+	/*
+	 * ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
+	 * reset it after that these fields aren't used anymore.
+	 */
+	sinfo->destructor_arg = NULL;
 
 	skb->len += size;
 	skb->data_len += size;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f1165a35411b..a66a4e036f53 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -535,6 +535,17 @@ void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
 
+/**
+ * xdp_return_frag -- free one XDP frag or decrement its refcount
+ * @netmem: network memory reference to release
+ * @xdp: &xdp_buff to release the frag for
+ */
+void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp)
+{
+	__xdp_return(netmem, xdp->rxq->mem.type, true, NULL);
+}
+EXPORT_SYMBOL_GPL(xdp_return_frag);
+
 void xdp_return_buff(struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo;
-- 
2.47.1


