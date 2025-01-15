Return-Path: <bpf+bounces-48941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE7AA12735
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340247A3636
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F21991AF;
	Wed, 15 Jan 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOC+bVG8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8E194A64;
	Wed, 15 Jan 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954402; cv=none; b=i+Gk1wPROQTDBwiGN/OmaTK15qKfEZ0KcSYsxVOwAUYenlbsm5lIovWVW4UfEVsPpL089W1tVdIdgZfH3gdZO5asPaDpksUd0DM4aphG5222VVYZaZUV7rOj5uivS0nxW4Y7r6dFe9h19V0MttkI0ty2zMnYqKfasdiWPza/q5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954402; c=relaxed/simple;
	bh=ccpEnGgtrMRmJlaRq5I0k3F41p3m93uLmAUoR9BiNp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSUWwzNwA0xNuFFNc+15kvBAxIEhATqEs7Eo6ANdoby8JugR+GosAtaZDrse9gS9bqKAEJeFbuuuEgy/MtxWbR161DH/nYq7l2u2wZnIo76811EidcCe2Ls4KteaVZazHyA1390aHoaP+xjRGisV9elH21ygdZTAEpohIpnd2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOC+bVG8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954401; x=1768490401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccpEnGgtrMRmJlaRq5I0k3F41p3m93uLmAUoR9BiNp8=;
  b=SOC+bVG8ma5JwFvYUdtqlMcbDzKeUlIBUfT5FfcN2HHQ+HZefKL8I2Ad
   RZer4JWKARro9YmgQJeQMMC3RVBqRnzx3keyrnXEDo9wuTOqeNLQ9qFQC
   bb5ncTUTLvRkjHsIEuJB7Hb0TPOc2BoNHOwD/9iblELijOa8GDl0YhvJM
   dmXW0n4QJchXJzaUDTTOZ5dKF4l0G9xT7VEu4wseM0/dlbj8edxWV2r8d
   wjRdh+5hrq2jpyX/YxOegdXPnuhRXLs3RjhYuX3GexBv5RtVc6bWk78NY
   DFVSB2gTmTCw+O8h2Nme3YUV6L4b2xA/ppHu307H7L6DnlySoztdSMz3m
   A==;
X-CSE-ConnectionGUID: WYRLAmPQRrOFD6xUqwLA5w==
X-CSE-MsgGUID: b95ZM9MjRHuYKYzBS4E7vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451822"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:20:01 -0800
X-CSE-ConnectionGUID: +PCEBH91TL2aeNaKof0b5A==
X-CSE-MsgGUID: PtlmznioRumC2lLs1Yv0Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116673"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:19:57 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/8] net: skbuff: introduce napi_skb_cache_get_bulk()
Date: Wed, 15 Jan 2025 16:18:58 +0100
Message-ID: <20250115151901.2063909-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to get an array of skbs from the NAPI percpu cache.
It's supposed to be a drop-in replacement for
kmem_cache_alloc_bulk(skbuff_head_cache, GFP_ATOMIC) and
xdp_alloc_skb_bulk(GFP_ATOMIC). The difference (apart from the
requirement to call it only from the BH) is that it tries to use
as many NAPI cache entries for skbs as possible, and allocate new
ones only if needed.

The logic is as follows:

* there is enough skbs in the cache: decache them and return to the
  caller;
* not enough: try refilling the cache first. If there is now enough
  skbs, return;
* still not enough: try allocating skbs directly to the output array
  with %GFP_ZERO, maybe we'll be able to get some. If there's now
  enough, return;
* still not enough: return as many as we were able to obtain.

Most of times, if called from the NAPI polling loop, the first one will
be true, sometimes (rarely) the second one. The third and the fourth --
only under heavy memory pressure.
It can save significant amounts of CPU cycles if there are GRO cycles
and/or Tx completion cycles (anything that descends to
napi_skb_cache_put()) happening on this CPU.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..1c089c7c14e1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1315,6 +1315,7 @@ struct sk_buff *build_skb_around(struct sk_buff *skb,
 				 void *data, unsigned int frag_size);
 void skb_attempt_defer_free(struct sk_buff *skb);
 
+u32 napi_skb_cache_get_bulk(void **skbs, u32 n);
 struct sk_buff *napi_build_skb(void *data, unsigned int frag_size);
 struct sk_buff *slab_build_skb(void *data);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..42eb31dcc9ce 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -367,6 +367,68 @@ static struct sk_buff *napi_skb_cache_get(void)
 	return skb;
 }
 
+/**
+ * napi_skb_cache_get_bulk - obtain a number of zeroed skb heads from the cache
+ * @skbs: pointer to an at least @n-sized array to fill with skb pointers
+ * @n: number of entries to provide
+ *
+ * Tries to obtain @n &sk_buff entries from the NAPI percpu cache and writes
+ * the pointers into the provided array @skbs. If there are less entries
+ * available, tries to replenish the cache and bulk-allocates the diff from
+ * the MM layer if needed.
+ * The heads are being zeroed with either memset() or %__GFP_ZERO, so they are
+ * ready for {,__}build_skb_around() and don't have any data buffers attached.
+ * Must be called *only* from the BH context.
+ *
+ * Return: number of successfully allocated skbs (@n if no actual allocation
+ *	   needed or kmem_cache_alloc_bulk() didn't fail).
+ */
+u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
+{
+	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
+	u32 bulk, total = n;
+
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+
+	if (nc->skb_count >= n)
+		goto get;
+
+	/* No enough cached skbs. Try refilling the cache first */
+	bulk = min(NAPI_SKB_CACHE_SIZE - nc->skb_count, NAPI_SKB_CACHE_BULK);
+	nc->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+					       GFP_ATOMIC | __GFP_NOWARN, bulk,
+					       &nc->skb_cache[nc->skb_count]);
+	if (likely(nc->skb_count >= n))
+		goto get;
+
+	/* Still not enough. Bulk-allocate the missing part directly, zeroed */
+	n -= kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+				   GFP_ATOMIC | __GFP_ZERO | __GFP_NOWARN,
+				   n - nc->skb_count, &skbs[nc->skb_count]);
+	if (likely(nc->skb_count >= n))
+		goto get;
+
+	/* kmem_cache didn't allocate the number we need, limit the output */
+	total -= n - nc->skb_count;
+	n = nc->skb_count;
+
+get:
+	for (u32 base = nc->skb_count - n, i = 0; i < n; i++) {
+		u32 cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
+
+		skbs[i] = nc->skb_cache[base + i];
+
+		kasan_mempool_unpoison_object(skbs[i], cache_size);
+		memset(skbs[i], 0, offsetof(struct sk_buff, tail));
+	}
+
+	nc->skb_count -= n;
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
+
+	return total;
+}
+EXPORT_SYMBOL_GPL(napi_skb_cache_get_bulk);
+
 static inline void __finalize_skb_around(struct sk_buff *skb, void *data,
 					 unsigned int size)
 {
-- 
2.48.0


