Return-Path: <bpf+bounces-59614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DEACD5E3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AE77A16E1
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3454231828;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B66214A6E;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005590; cv=none; b=J85foH5uMvqELroZNHm6iCu5cZaMFLrtg4PacYbZmrcztygApsa/GdAP7e7bmIM+ZX4L/P3MDnS6RxuSf1jFoCNs5Khf4+4e6Y2hcNI83BJohCifIMaVQWn022xs5rxQZmGp/YAnJxdifN9dnaDEv3u90hVfLQ6RSXBGwTDCZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005590; c=relaxed/simple;
	bh=XBq6AAVvvUF5BWxzTuxlROR1zt98uq/ThjlMhAoG/tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DBD+Mea5rraFUO4SdthRReSnTsC2cI6qkC4AjdLl63cCMFf7vnX7FKSCmjSN/3VC3KCxTw0YP/Q+c5QwJTOoLfDx8B+TTPk7895QJhoabX7CXovcHWjPcFUkPJx8mLwvitY0l/kC1XkD1FMNiQQXsDICrXxBglnU1PnVsY9LgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ec-683fb509f4d7
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [RFC v4 05/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
Date: Wed,  4 Jun 2025 11:52:33 +0900
Message-Id: <20250604025246.61616-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fenZ0NR6cldrJQHEgoZBlqTyUmfai3b5HUhwRt6LENdcq8
	C4rWqBSnVkJeFk5N8waLaTovSZp5ySLRzFneUNQi09IS3cxyit9+/P/P//flYShZN3ZmVOp4
	XqNWRMlpCZb8cCg7Ln5xXnlys8AH9MZ6GurWk+HZtFkI+tomBL83vohgtbuXhoqyNQr0H7QY
	/hitFMz1zIhgqmoeQ/u9Zgpm8vpo0GltFNw2VwtgsClXCAXWSgqaM6ZFMNyqp2Gy/p8Q5rt0
	GPqLazBM5QZCj8EJ1gYWEXQbmwWwlvOEhkdDBhpmtVMIhl7PYCjJzEVg7LAIwbaupwPdSGPN
	mIC0FE+IiMGUQBqqPUm2ZYgiptosmphWHorI+Kd2mvQV2jBpMa8KiO7OEk1+zX3GZLljhCbG
	xhFM3hm6RWTV5HKFvSHxD+ejVIm85kTATYmy9OV3QeyWY3LO3U2cgTIPZCMxw7E+nKljHe3x
	YIlBaGeaPcZZLBuUnR1Zb251phdnIwlDsUtCbk5vE9iLg2wI96CtenvMMJh158rzQ+2xlPXl
	Ot+O4l2nK1f3/NWOR8z6ceNLj3emsu0bnfkjZXdy7IaI68v/JtwdHOY6qy04H0kNaF8tkqnU
	idEKVZSPlzJFrUr2CouJNqHt31albQab0cpgUBdiGSR3kJrHA5QyoSIxLiW6C3EMJXeUunps
	R9JwRUoqr4kJ1SRE8XFd6AiD5Yekp9aSwmXsLUU8H8nzsbxmrxUwYucMJNE4LZZfdW5ub2hd
	2B9m/el5f3g53HvF/axqbErLi7fyU6wVuGFTrI687JeV2jawYbXVah28PN+8vyArKbrYJMkL
	du9LdwmKOG0ZnXX1Plo6WagIifD6268rcCOVE+dantanzc37S6PTI66DJtK3krsWGlCU+tXj
	zKWFpJAGuRzHKRXenpQmTvEfVh/0rdcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF++3+dnddrq666maQNPCRqCVofKMo+yP8pRIWhWCRzry44bPN
	1wJDU8rEWZpQ6KyV5RsWam4+EtPhI4tMM60sRZkUxnpMJZ091Oi/w/mcc/45DOVcjV0ZZVIq
	r0qSJ8hoMRYfP5Dr6/D4sGLvm7ceoDM00FD/MxOqp0xC0NW1IJhfei8Cm7mPhsp7ixToXuZh
	WDAsU2DpnRbBZNUsho6rRgqmr/fToM2zU3DZVCOAnooBIQy1FAmhdPkhBcbsKRGMtOlo+Njw
	Rwiz3VoMA2W1GCaLgqBXvxUWB78gMBuMAlgsrKDh5rCehpm8SQTDPdMYynOKEBg6x4Vg/6mj
	g2SkufatgLSWfRARfWMaaarxJgXjwxRprLtGk8YfJSIy8aaDJv237Zi0mmwCos210uS75R0m
	XztHaVL56ZuAGJpHMXmuN4vCnSLFB2P5BGU6r9pzKFqsuPtkTpDyW5pZeGUFZ6McpwLkwHBs
	ADdUrheuaZr15MbHl6g1LWX9Odt0Hy5AYoZirULOorML1oALe44rbq9BBYhhMOvO3b8RtWZL
	2EDu6bMx/G/Tjat/1LW+48Du4yast9arzqsZrek1dQOJ9WhDHZIqk9IT5cqEQD91vEKTpMz0
	O5+c2IhW76vKWik2ofmR4G7EMkjmKDFNHFI4C+Xpak1iN+IYSiaVuO1etSSxcs1FXpUcpUpL
	4NXdaAeDZdskIRF8tDMbJ0/l43k+hVf9pwLGwTUbGZd9ar33u2RYM9vHROXGpeDSS44lARJN
	01mycdPm8BavlbB88/d8DypE27YlYMH9VYw0tMIpLMf6q+uUo87VUj5T41tryz2R4fP5wi6v
	legzX472OR57UW1PNV+I0AxGxoTSJ7cvZMzkZ3mp4naypyX4iK3ngaWoSXJnai5a6inDaoXc
	35tSqeV/AXgJVq+6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use netmem alloc/put APIs instead of page alloc/put APIs in
__page_pool_alloc_pages_slow().

While at it, improved some comments.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ff3d0d31263c..e80a637f0fa4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -551,7 +551,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	unsigned int pp_order = pool->p.order;
 	bool dma_map = pool->dma_map;
 	netmem_ref netmem;
-	int i, nr_pages;
+	int i, nr_netmems;
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
@@ -561,21 +561,21 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	if (unlikely(pool->alloc.count > 0))
 		return pool->alloc.cache[--pool->alloc.count];
 
-	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
+	/* Mark empty alloc.cache slots "empty" for alloc_netmems_bulk_node() */
 	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
 
-	nr_pages = alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
-					 (struct page **)pool->alloc.cache);
-	if (unlikely(!nr_pages))
+	nr_netmems = alloc_netmems_bulk_node(gfp, pool->p.nid, bulk,
+					     pool->alloc.cache);
+	if (unlikely(!nr_netmems))
 		return 0;
 
-	/* Pages have been filled into alloc.cache array, but count is zero and
-	 * page element have not been (possibly) DMA mapped.
+	/* Netmems have been filled into alloc.cache array, but count is
+	 * zero and elements have not been (possibly) DMA mapped.
 	 */
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_netmems; i++) {
 		netmem = pool->alloc.cache[i];
 		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
-			put_page(netmem_to_page(netmem));
+			put_netmem(netmem);
 			continue;
 		}
 
@@ -587,7 +587,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 					   pool->pages_state_hold_cnt);
 	}
 
-	/* Return last page */
+	/* Return the last netmem */
 	if (likely(pool->alloc.count > 0)) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, slow);
@@ -595,7 +595,9 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 		netmem = 0;
 	}
 
-	/* When page just alloc'ed is should/must have refcnt 1. */
+	/* When a netmem has been just allocated, it should/must have
+	 * refcnt 1.
+	 */
 	return netmem;
 }
 
-- 
2.17.1


