Return-Path: <bpf+bounces-54737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12092A71279
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 09:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53003175ABF
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5491A5B8E;
	Wed, 26 Mar 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkIHxxZQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDB2A1B2
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977148; cv=none; b=CWktzW1n0+7fQhL0cZIv+meDwBLfMLob1dl8xhjhUt1XsMKvQfiPuy3GD8hWE2nle2m7qPUcbeBJN8NhPsRiJg7PhE3oZ+dIW+jBJluQ3KuQ5aVbZru3agp185v10Qj8qYKxEO0qKd2NfKSl68gVXH2UYFWmX48GgPpFBv2h1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977148; c=relaxed/simple;
	bh=up5gMaS9V877R6Epg37O2+rGYGQsnTu4+UNiG9MgPwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoeUw1YPHA56i762oMSio6/Iu9nUnROdi341wOBRsuJcOAJKYg3kCKoeNOKikevaTcUx79mJYV7H+11kxIaAMfQV9FNdbstyAgSuJEv68lth207WGI5Sp11sHlyF+uGM4d6mRk1NgKH9i4HNINeRfnCaAKyGqy34HNBBrHvpdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkIHxxZQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742977145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3o8kOx0A3a9gpCq5fYDk6BqU9uXGkmyjhzH6v4re0o=;
	b=OkIHxxZQPnYeyDa0nzn/26GeKbBgvLRVs5yo4uNwk5JSTluIN6tU0lFpI/FUC/yl6z/EBw
	H8N2mnpjQQiBWIe299qZwVZ8KvNeUY3tICu83R7B9Rvy/EU3h2ale3YHLOoQk3E5LzLlsm
	wcHfKhoXjm8/fsGjz14vYs2scdNo3rI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-D6E5M4aqMRiCqL7-HJK10Q-1; Wed, 26 Mar 2025 04:19:04 -0400
X-MC-Unique: D6E5M4aqMRiCqL7-HJK10Q-1
X-Mimecast-MFC-AGG-ID: D6E5M4aqMRiCqL7-HJK10Q_1742977143
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so767714566b.2
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 01:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977143; x=1743581943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3o8kOx0A3a9gpCq5fYDk6BqU9uXGkmyjhzH6v4re0o=;
        b=K0HqHCLoc+UL2J44NfETFIo+zPjwkJtoFMkCjSDl9Qn0ikk4QsLlpSZXX1hmwZZqaF
         MrkWz9/wJUenI/Ud9TxILNy4qY3Igf9QtWIIavWzSfvhbPzfgyUiU/noSRO4C2hp3zyl
         9uUcYn47jUWy9Wd8WjbE5g5vdIjtfv4ulzTbxBrPTkKZbo63xz0PlniRfSE+Hv4JeCkV
         NZtgTmijE57SHVo8gdzCGB+g+84a6MAwetJ2fA+0Y6HtWIqaTlm3dK6B1sSQ6HidWCzC
         ZndrkxpyfJH6OUUj581uZs1ndpG3Ookp0kDKrRzFmmOjZ65GaWEIsjzwr7dudU5E9S+t
         bzzg==
X-Forwarded-Encrypted: i=1; AJvYcCVmxIy5vX5DfZjsIHDHKMYlGiWUrNv8xBRWtF1FP0YUbwAzleLJ3OkdHPLrzBcXqsIiG3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9R79i62f9GPWj/7xr58bXXDfcfsTw3CtyRyvCkriagG3LAfn
	tn4tJL+4dRZ2kGv2Hgj8JkPcriDmxSKjeIlOjZo8yD3b8Y7H46PbmsUiYuAZEdkwV2I0+YyArHg
	jX3pZaXrL+dbiYqGKO89PfaF+DzSjnMF+AaX91HPGaDVI6wBveg==
X-Gm-Gg: ASbGncv4JQGxw+4mpEVZmmm+P12/0SdrFOEGW3jfnykTROND4EV7ddrCVbiKK62FmKx
	Xq/i41O09HCY2Qv19N7KQFy8yuuU3DKI/rv2YrtTR5cPjAndx0BcJGkQSVSLgfJRcsCXj6gurkn
	OsqbMbBvl1oCS/Lo0/K/PbQcThWG5c8t7a8Hr1L1kHDorhY8Hx49FSwVns0rk1H86aTAop4lqqu
	mtrtK3EfG+19HVNvZuaxsHKc5ag/wzsKaFnrISnrrzKawxrKEel/Ku3eP6GY9cqTP9VtmILxTXs
	95RmjO5S7m1/W2O3iSwDv2bWJYHW/7YXQUdKxgAC
X-Received: by 2002:a17:906:d7cb:b0:ac4:5fd:6e29 with SMTP id a640c23a62f3a-ac405fd6eaamr1484669166b.26.1742977142698;
        Wed, 26 Mar 2025 01:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKE+mfhhLv2lQjs/xlsgXqislY1jyDT4Dp3H+d9g7vxrFzqat7h23i/Fa4g4X1nbBbVSrbqA==
X-Received: by 2002:a17:906:d7cb:b0:ac4:5fd:6e29 with SMTP id a640c23a62f3a-ac405fd6eaamr1484664166b.26.1742977142073;
        Wed, 26 Mar 2025 01:19:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbd3d3esm983376066b.130.2025.03.26.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:19:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 54C1F18FC9D0; Wed, 26 Mar 2025 09:18:54 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 26 Mar 2025 09:18:40 +0100
Subject: [PATCH net-next v3 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-page-pool-track-dma-v3-3-8e464016e0ac@redhat.com>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
In-Reply-To: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
X-Mailer: b4 0.14.2

When enabling DMA mapping in page_pool, pages are kept DMA mapped until
they are released from the pool, to avoid the overhead of re-mapping the
pages every time they are used. This causes resource leaks and/or
crashes when there are pages still outstanding while the device is torn
down, because page_pool will attempt an unmap through a non-existent DMA
device on the subsequent page return.

To fix this, implement a simple tracking of outstanding DMA-mapped pages
in page pool using an xarray. This was first suggested by Mina[0], and
turns out to be fairly straight forward: We simply store pointers to
pages directly in the xarray with xa_alloc() when they are first DMA
mapped, and remove them from the array on unmap. Then, when a page pool
is torn down, it can simply walk the xarray and unmap all pages still
present there before returning, which also allows us to get rid of the
get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
synchronisation is needed, as a page will only ever be unmapped once.

To avoid having to walk the entire xarray on unmap to find the page
reference, we stash the ID assigned by xa_alloc() into the page
structure itself, using the upper bits of the pp_magic field. This
requires a couple of defines to avoid conflicting with the
POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
so does not affect run-time performance. The bitmap calculations in this
patch gives the following number of bits for different architectures:

- 23 bits on 32-bit architectures
- 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
- 32 bits on other 64-bit architectures

Stashing a value into the unused bits of pp_magic does have the effect
that it can make the value stored there lie outside the unmappable
range (as governed by the mmap_min_addr sysctl), for architectures that
don't define ILLEGAL_POINTER_VALUE. This means that if one of the
pointers that is aliased to the pp_magic field (such as page->lru.next)
is dereferenced while the page is owned by page_pool, that could lead to
a dereference into userspace, which is a security concern. The risk of
this is mitigated by the fact that (a) we always clear pp_magic before
releasing a page from page_pool, and (b) this would need a
use-after-free bug for struct page, which can have many other risks
since page->lru.next is used as a generic list pointer in multiple
places in the kernel. As such, with this patch we take the position that
this risk is negligible in practice. For more discussion, see[1].

Since all the tracking added in this patch is performed on DMA
map/unmap, no additional code is needed in the fast path, meaning the
performance overhead of this tracking is negligible there. A
micro-benchmark shows that the total overhead of the tracking itself is
about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]).
Since this cost is only paid on DMA map and unmap, it seems like an
acceptable cost to fix the late unmap issue. Further optimisation can
narrow the cases where this cost is paid (for instance by eliding the
tracking when DMA map/unmap is a no-op).

The extra memory needed to track the pages is neatly encapsulated inside
xarray, which uses the 'struct xa_node' structure to track items. This
structure is 576 bytes long, with slots for 64 items, meaning that a
full node occurs only 9 bytes of overhead per slot it tracks (in
practice, it probably won't be this efficient, but in any case it should
be an acceptable overhead).

[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
[1] https://lore.kernel.org/r/20250320023202.GA25514@openwall.com
[2] https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com

Reported-by: Yonglong Liu <liuyonglong@huawei.com>
Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Suggested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Qiuling Ren <qren@redhat.com>
Tested-by: Yuying Ma <yuma@redhat.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/poison.h        |  4 +++
 include/net/page_pool/types.h | 49 +++++++++++++++++++++++---
 net/core/netmem_priv.h        | 28 ++++++++++++++-
 net/core/page_pool.c          | 81 ++++++++++++++++++++++++++++++++++++-------
 4 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 331a9a996fa8746626afa63ea462b85ca3e5938b..5351efd710d5e21cc341f7bb533b1aeea4a0808a 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -70,6 +70,10 @@
 #define KEY_DESTROY		0xbd
 
 /********** net/core/page_pool.c **********/
+/*
+ * page_pool uses additional free bits within this value to store data, see the
+ * definition of PP_DMA_INDEX_MASK in include/net/page_pool/types.h
+ */
 #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
 
 /********** net/core/skbuff.c **********/
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index d6c93150384fbc4579bb0d0afb357ebb26c564a3..cdc06fb67642c104b071998920bd88125fbefd43 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <net/netmem.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
@@ -54,13 +55,51 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+/*
+ * DMA mapping IDs
+ *
+ * When DMA-mapping a page, we allocate an ID (from an xarray) and stash this in
+ * the upper bits of page->pp_magic. We always want to be able to unambiguously
+ * identify page pool pages (using page_pool_page_is_pp()). Non-PP pages can
+ * have arbitrary kernel pointers stored in the same field as pp_magic (since it
+ * overlaps with page->lru.next), so we must ensure that we cannot mistake a
+ * valid kernel pointer with any of the values we write into this field.
+ *
+ * On architectures that set POISON_POINTER_DELTA, this is already ensured,
+ * since this value becomes part of PP_SIGNATURE; meaning we can just use the
+ * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
+ * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
+ * 0, we make sure that we leave the two topmost bits empty, as that guarantees
+ * we won't mistake a valid kernel pointer for a value we set, regardless of the
+ * VMSPLIT setting.
+ *
+ * Altogether, this means that the number of bits available is constrained by
+ * the size of an unsigned long (at the upper end, subtracting two bits per the
+ * above), and the definition of PP_SIGNATURE (with or without
+ * POISON_POINTER_DELTA).
+ */
+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
+#if POISON_POINTER_DELTA > 0
+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
+ * index to not overlap with that if set
+ */
+#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
+#else
+/* Always leave out the topmost two; see above. */
+#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+#endif
+
+#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
+				  PP_DMA_INDEX_SHIFT)
+#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
+
 /* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
  * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
- * the head page of compound page and bit 1 for pfmemalloc page.
- * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
- * the pfmemalloc page.
+ * the head page of compound page and bit 1 for pfmemalloc page, as well as the
+ * bits used for the DMA index. page_is_pfmemalloc() is checked in
+ * __page_pool_put_page() to avoid recycling the pfmemalloc page.
  */
-#define PP_MAGIC_MASK ~0x3UL
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
 /**
  * struct page_pool_params - page pool parameters
@@ -229,6 +268,8 @@ struct page_pool {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
 
+	struct xarray dma_mapped;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index f33162fd281c23e109273ba09950c5d0a2829bc9..cd95394399b40c3604934ba7898eeeeacb8aee99 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -5,7 +5,7 @@
 
 static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp_magic;
+	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
 static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
@@ -15,6 +15,8 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
 
 static inline void netmem_clear_pp_magic(netmem_ref netmem)
 {
+	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
+
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
@@ -33,4 +35,28 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
 {
 	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
 }
+
+static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return 0;
+
+	magic = __netmem_clear_lsb(netmem)->pp_magic;
+
+	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
+}
+
+static inline void netmem_set_dma_index(netmem_ref netmem,
+					unsigned long id)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return;
+
+	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
+	__netmem_clear_lsb(netmem)->pp_magic = magic;
+}
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fb32768a97765aacc7f1103bfee38000c988b0de..5eb132f7f2193bda76121cc10a24dac4993b2c21 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -226,6 +226,8 @@ static int page_pool_init(struct page_pool *pool,
 			return -EINVAL;
 
 		pool->dma_map = true;
+
+		xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
 	}
 
 	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
@@ -275,9 +277,6 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -325,7 +324,7 @@ static void page_pool_uninit(struct page_pool *pool)
 	ptr_ring_cleanup(&pool->ring, NULL);
 
 	if (pool->dma_map)
-		put_device(pool->p.dev);
+		xa_destroy(&pool->dma_mapped);
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
@@ -466,13 +465,20 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+	if (dma_dev_need_sync(pool->p.dev)) {
+		rcu_read_lock();
+		if (READ_ONCE(pool->dma_sync))
+			__page_pool_dma_sync_for_device(pool, netmem,
+							dma_sync_size);
+		rcu_read_unlock();
+	}
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
+	int err;
+	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -486,15 +492,28 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	if (page_pool_set_dma_addr_netmem(netmem, dma))
+	if (in_softirq())
+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
+			       PP_DMA_INDEX_LIMIT, gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  PP_DMA_INDEX_LIMIT, gfp);
+	if (err) {
+		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
 		goto unmap_failed;
+	}
 
+	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
+		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
+		goto unmap_failed;
+	}
+
+	netmem_set_dma_index(netmem, id);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
 
 unmap_failed:
-	WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
@@ -511,7 +530,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
 		put_page(page);
 		return NULL;
 	}
@@ -557,7 +576,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
-		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
@@ -659,6 +678,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -667,6 +688,17 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 		 */
 		return;
 
+	id = netmem_get_dma_index(netmem);
+	if (!id)
+		return;
+
+	if (in_softirq())
+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
+	else
+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
+	if (old != page)
+		return;
+
 	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	/* When page is unmapped, it cannot be returned to our pool */
@@ -674,6 +706,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
+	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -1083,8 +1116,32 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
 static void page_pool_scrub(struct page_pool *pool)
 {
+	unsigned long id;
+	void *ptr;
+
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	if (!pool->destroy_cnt++ && pool->dma_map) {
+		if (pool->dma_sync) {
+			/* paired with READ_ONCE in
+			 * page_pool_dma_sync_for_device() and
+			 * __page_pool_dma_sync_for_cpu()
+			 */
+			WRITE_ONCE(pool->dma_sync, false);
+
+			/* Make sure all concurrent returns that may see the old
+			 * value of dma_sync (and thus perform a sync) have
+			 * finished before doing the unmapping below. Skip the
+			 * wait if the device doesn't actually need syncing, or
+			 * if there are no outstanding mapped pages.
+			 */
+			if (dma_dev_need_sync(pool->p.dev) &&
+			    !xa_empty(&pool->dma_mapped))
+				synchronize_net();
+		}
+
+		xa_for_each(&pool->dma_mapped, id, ptr)
+			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+	}
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.

-- 
2.48.1


