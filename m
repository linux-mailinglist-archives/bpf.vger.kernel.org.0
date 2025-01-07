Return-Path: <bpf+bounces-48132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42456A0449B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BE4161E8D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E01F63CC;
	Tue,  7 Jan 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsfE5XgS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182D01F63F9;
	Tue,  7 Jan 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263908; cv=none; b=RrVAxUzLWFNU9SfVhuF85H8RYexm/ukoIBeCPbTkELc0B1YvMw+6Oa2Y5m/mGx6MwRL7S7CQMKbBpHxriPY+kxC/61RSlkIqYyJJhXL6gWeLXhPNhU5GNkQ8TSI1Uhw9XVI3rq/5pAzSbtu3lFw1WoLCbXjw3EdDVYPk9AgEDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263908; c=relaxed/simple;
	bh=DK+b4+WcHq9Zk5fVFh25MBWsSHb7zRQ6cqFgHos74Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV+Ro/CJeNnbVxtj1G49Wv4p5YgUPFkc/uYVdI3Mauwof7eetMd7PM9Zgu0iooxc6uoypNzNOryuhOQUa03Iim7pBSfNJlw6AE5yElo3co4dghwNbAxo+NNuKVjRRn70QTk4qO/8QANBpGkxu25mpMIh6yagYJTTBJRDZPXVBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsfE5XgS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263905; x=1767799905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DK+b4+WcHq9Zk5fVFh25MBWsSHb7zRQ6cqFgHos74Xg=;
  b=WsfE5XgS4kGFL1kb7QIOIDk6gVNP8As4WwSj81ASIm7jlbvuKjkP9pM2
   N0kOdmh0V4ucU5m21EKw9gJ2hke2Otm/P1owuUFFM6yfyK433eWd5fkLc
   uKDjUY88nwp1XvJ2m+mjHXgd74QF46HEg4VNZsiFr6Pt4AfZDypewc8Ks
   Y/9MfOyVpYuDtym4Bz2oZni0y0wwVMebMxObFfUyAMwhoDn8UzA70ZBSu
   NFUDVkk3PxNaYf5362nhWMQNG+MAUYM7xOSSEB9IPSswZEEuClPoLpkfX
   m5AiUJPClvBx7LUexj/qh1soNd+1Ai+fn8x1KuR3Bl8B766+oina3vryP
   w==;
X-CSE-ConnectionGUID: bWBCmL9aQmWutVmLvwaIMg==
X-CSE-MsgGUID: JtUQ34FfTD++iNPgY/8fag==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685863"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685863"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:26 -0800
X-CSE-ConnectionGUID: 77qiPURsS6qyuGqMQJdAAw==
X-CSE-MsgGUID: 8B/JCauwSUKWJSgYH/gFdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646966"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:22 -0800
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
Subject: [PATCH net-next v2 5/8] net: skbuff: introduce napi_skb_cache_get_bulk()
Date: Tue,  7 Jan 2025 16:29:37 +0100
Message-ID: <20250107152940.26530-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
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
2.47.1


