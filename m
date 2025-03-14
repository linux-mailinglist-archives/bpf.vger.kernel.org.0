Return-Path: <bpf+bounces-54041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78494A60E6C
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 11:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA784622F6
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD241EF09A;
	Fri, 14 Mar 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx9T+aoz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C31F3BAE
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947144; cv=none; b=TIa8FRYyQQKduvasr5SRl+ubeW923uaRBTAklhst87mVl7DgRq14fSUpX1vpm7UUv1FXbSM8FKyWoEMAzOM7LlZOt4w97RgLiuRtRQ3UbdhCdfDfAAg9SY0z5fuUDxQC7mQ+78pAhn584DXIVcpfZPNDuJz7esCXjkddo8NXLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947144; c=relaxed/simple;
	bh=HwWk2I3OdQJPTfT3Cl0K+4+N5uv5GmbCTPwYpoP+U5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDCZRXgNwYvH6RtWTASYvo7GNCBZdFFQ8wz2fgHCH4Hlyxld1Xd2EcGLeqt3Wy+GcikGKTFaMo/D5HDeKF2ameQ9wajgafEg1MMLySruwu4DYERnTEN5zK77sVY7Ilz0IUk5C41qgNLzA/NLj0f7BVFtXqbDmRe3w2v8YQO811w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nx9T+aoz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741947140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+DimXfUHWFE+Vsqjj1iCGyhBq1kmkWNtKkNWDSpM9o=;
	b=Nx9T+aozWfe7ydcY+F94+h1kyaB8tXzc6hzUMIAgubz+FSZqG62Cy2vd/PX57w6twv5bvt
	pIw1bIwWEUVNY4AbdvN/zx6kq3FezIGZBxW/rydyBz4A1BOKhjnV52IYv7vaGJGRMTnzZz
	6BFTdFt72sVmXSOh1hmvKfdL5gq9Itw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-a1Qx4fSSN4SmO-C1y055pg-1; Fri, 14 Mar 2025 06:12:19 -0400
X-MC-Unique: a1Qx4fSSN4SmO-C1y055pg-1
X-Mimecast-MFC-AGG-ID: a1Qx4fSSN4SmO-C1y055pg_1741947138
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30b860e140dso8732101fa.1
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 03:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947137; x=1742551937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+DimXfUHWFE+Vsqjj1iCGyhBq1kmkWNtKkNWDSpM9o=;
        b=TaBHxdbLviUOyh6b4mTJKS1g3KEZcXOv9Om4XeQUVEcjvnwn7x98dVkHnd4+/lzcwb
         Gyjl2zq8pjgPntWrEWca4bI/fEnYQURQtyGF+39mt0SUb6dku0OaMzur145Cs7ziLyv7
         kBxLa6rYbR4tE5W+CHxnnkReAf/1GrqPRGJJE5ydNoRQZtiWEHyexyWtqTqWI8EwAdLb
         Qz9U3ugqgJ79Gty5AjNhugpKRvAzQz+oaH3kwVkHHp3/2HTHXevUXCUoWcf5M/3Tw11J
         E21mKpVKsz8dLK2x7WH7flwouUPRf1Zq4IPKjxrHC5b1qcKlPeI3fyOjNsJI1tQL6zIE
         hWnA==
X-Forwarded-Encrypted: i=1; AJvYcCVvx4CX0WDzAkBRUPI3GQPMMPZooYU5+DjF2bQMJQYqzMOBTeCDwyBhCOCeIC4bOC568B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOocRppgCkk7rcl/EXxRZekbzA3wNRjIhGOq34EaR49vbuZ1w3
	vcziA9/mWGTyAnmAFdrpymfDvP1IEVmn/BRUVGhPGzzqN1rxPV3frv1tNRoGMYesVdJtAkCpEMh
	EOqZT0XxsZTNC2kizJaP3eb/9yz0KV5aFS1NJXN2TlzQA18IUug==
X-Gm-Gg: ASbGncsnr4ejX3gm41IKg+Xhqum+B+3H7jMZfns3NGPH1PXkZ9rNYkY7yUQr4Es7NaG
	lTYvXgMNp/48YThWrtsBh3OmSAgZK7Uf+f/35jqk+c+5EGZifMzFP9WG+2e1+9egPCZIjKNzJPa
	OVqVanlyinHQYTtoXWCVVpI4ikolEhyPh3XewWK50UWySa2zWlectuG2zyHhi8VT+rBFWGhAZZj
	GDDXM1ZfXjP0g8iiipKe6RwBhAHWv5IaA10Ve6plyaNOGZhOU5Y7+fnsKaR84YYS3DEjWY+6159
	g6hIGKTVw/hz
X-Received: by 2002:a2e:8902:0:b0:30c:4be7:1d42 with SMTP id 38308e7fff4ca-30c4be720c0mr4692591fa.12.1741947137275;
        Fri, 14 Mar 2025 03:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUBB+wtWsQxl8uXrZ431QyFroWOXaMppHSjgaRgNrqxZyQrpKDNG0hx3B3XyzCMTPkytOKww==
X-Received: by 2002:a2e:8902:0:b0:30c:4be7:1d42 with SMTP id 38308e7fff4ca-30c4be720c0mr4692291fa.12.1741947136730;
        Fri, 14 Mar 2025 03:12:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c4012af5dsm5146841fa.15.2025.03.14.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:12:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0F5FC18FA932; Fri, 14 Mar 2025 11:12:13 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 14 Mar 2025 11:10:21 +0100
Subject: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
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

- 24 bits on 32-bit architectures
- 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
- 32 bits on other 64-bit architectures

Since all the tracking is performed on DMA map/unmap, no additional code
is needed in the fast path, meaning the performance overhead of this
tracking is negligible. A micro-benchmark shows that the total overhead
of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
map and unmap, it seems like an acceptable cost to fix the late unmap
issue. Further optimisation can narrow the cases where this cost is
paid (for instance by eliding the tracking when DMA map/unmap is a
no-op).

The extra memory needed to track the pages is neatly encapsulated inside
xarray, which uses the 'struct xa_node' structure to track items. This
structure is 576 bytes long, with slots for 64 items, meaning that a
full node occurs only 9 bytes of overhead per slot it tracks (in
practice, it probably won't be this efficient, but in any case it should
be an acceptable overhead).

[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
[1] https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com

Reported-by: Yonglong Liu <liuyonglong@huawei.com>
Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Suggested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Qiuling Ren <qren@redhat.com>
Tested-by: Yuying Ma <yuma@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/types.h | 36 +++++++++++++++++++---
 net/core/netmem_priv.h        | 28 ++++++++++++++++-
 net/core/page_pool.c          | 72 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 121 insertions(+), 15 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index fbe34024b20061e8bcd1d4474f6ebfc70992f1eb..1e187489d392757c8dd2960870b0d875c1dde01b 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <net/netmem.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
@@ -58,13 +59,38 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+/*
+ * DMA mapping IDs
+ *
+ * When DMA-mapping a page, we allocate an ID (from an xarray) and stash this in
+ * the upper bits of page->pp_magic. The number of bits available here is
+ * constrained by the size of an unsigned long, and the definition of
+ * PP_SIGNATURE.
+ */
+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
+#define _PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 1)
+
+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
+ * index to not overlap with that if set
+ */
+#if POISON_POINTER_DELTA > 0
+#define PP_DMA_INDEX_BITS MIN(_PP_DMA_INDEX_BITS, \
+			      __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
+#else
+#define PP_DMA_INDEX_BITS _PP_DMA_INDEX_BITS
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
@@ -233,6 +259,8 @@ struct page_pool {
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
index d51ca4389dd62d8bc266a9a2b792838257173535..5612d72d483cad8c24d2f703bb48aad185cfe59a 100644
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
@@ -471,9 +470,11 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
+	int err;
+	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -487,15 +488,28 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
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
@@ -512,7 +526,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
 		put_page(page);
 		return NULL;
 	}
@@ -558,7 +572,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
-		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
@@ -660,6 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -668,6 +684,17 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
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
@@ -675,6 +702,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
+	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -1084,8 +1112,32 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
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


