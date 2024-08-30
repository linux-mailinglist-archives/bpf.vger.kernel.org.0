Return-Path: <bpf+bounces-38574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D619666CF
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F56D283E04
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE21BC9FF;
	Fri, 30 Aug 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3foGkK9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2E1BC08B;
	Fri, 30 Aug 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035162; cv=none; b=KEK6Btr0b/mxhXHiUIwEhpnZRuMQeigginrhn4kQhCn+mJSfpPqtR3zzs18j1RXh6KtC7Pby0Jstkqh2QmCAoitIYOvHD7FIG1RHcKNPsKas4ivTDTuQjHX4fAfw72jbEm/+yNScUX3h7wmYMQCA7i3gCcTg2NYYNdDZGJ8T4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035162; c=relaxed/simple;
	bh=P2rqqspjoJ+gwn37T9gSKXeAKPP9RlbcPxrJ572nRgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoDDkrNRUaYkX6eKX9cpC7eTPmYpjZLQB+7z4zs9PBmH8o5KS+FSHQ/SL1xOpmYfDEyQw72C/rFJUoj3MyHnhKJ/4q4Qm1uqTY5P52/+OWXVXog6I3QeByuDvXihTc0CimQa49cJCfkYZmYaVxmNOkaerp9LwoOWYDx0O34zqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3foGkK9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035162; x=1756571162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2rqqspjoJ+gwn37T9gSKXeAKPP9RlbcPxrJ572nRgs=;
  b=D3foGkK99SH8Sj+nQ5oRvvAgLpVdqzF2qgmb6Qawpku/K0rlwPajXKSX
   V9P3cwV4CGGCWh2wZ5ypcFlA7qob3chCQ0jTidDqxb4N/nz2j9Xmx/KU6
   MBjhaJh/NAXu1v6N/244YJ8s+Rtw5LBiUHn9/+rCRXSqIDzSWcGtocoHx
   COjAJR8QHzYk+ErqXgmx1AvWerekMYygUZiSh5Ofe58FHVQFGFYjQDUv6
   ZxzlBqdUgQ/huXKK9+7ZKXV0Cv7dQZzbqq6/ykMHDxmr9bnzgxklP+NpK
   uDlYsLtZiaAYGaz8oy5m3HzT9NszGpukxxnfyKufGfXiymkYmL2M52NyW
   g==;
X-CSE-ConnectionGUID: ziUKf/s+Q2ey+FLCLhfDEw==
X-CSE-MsgGUID: X/ZcWqufSlG97CsMg5iWfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068955"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:26:01 -0700
X-CSE-ConnectionGUID: ksPEpP6JQWeh19P0W3ROGw==
X-CSE-MsgGUID: Gq3ljsB1SYa0zjGC//t7aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996468"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:57 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 6/9] net: skbuff: introduce napi_skb_cache_get_bulk()
Date: Fri, 30 Aug 2024 18:25:05 +0200
Message-ID: <20240830162508.1009458-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
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
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..2bc3ca79bc6e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1304,6 +1304,7 @@ struct sk_buff *build_skb_around(struct sk_buff *skb,
 				 void *data, unsigned int frag_size);
 void skb_attempt_defer_free(struct sk_buff *skb);
 
+u32 napi_skb_cache_get_bulk(void **skbs, u32 n);
 struct sk_buff *napi_build_skb(void *data, unsigned int frag_size);
 struct sk_buff *slab_build_skb(void *data);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a52638363ea5..0a34f3aa00d1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -366,6 +366,68 @@ static struct sk_buff *napi_skb_cache_get(void)
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
2.46.0


