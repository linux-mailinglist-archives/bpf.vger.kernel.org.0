Return-Path: <bpf+bounces-59243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8AEAC7630
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A0A40BE8
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325F255222;
	Thu, 29 May 2025 03:11:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16221CC5F;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488271; cv=none; b=hPBVny3pZVJkgAk8JtazcHWiuUazDkLcBbjbhAKoYSezJ4q1qPhIBojzLeQ8GmTjjFHzBb6mB6u3KQGh581rwfgWFc/UQh7Y4jiskPaNDprEYEwXzkHjQpuDhbiIHDeavify2F9HuCZnxVjBT70KwZxJC+6ON6Oa05D+ODSeuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488271; c=relaxed/simple;
	bh=v0E1DcRq11eqrPyrfJLt14Y0cOjn9oDEymLeuq2EWi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bxVtnNSqmPAoSdvOJGdbN9D/NO7lCZAoRIBaMIHhGRLiMIjS176lIbj2TIv8m3Z/USMwSjc0PkXe/lw/1Xk/yctrYVux6h/i4AgE6m+q1n9PsZbaCVhgnCvVwcz6kVtNA2xL+34l7o7SpD0/bR+Ii/YoznuXP3YZMiilE9H8aUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f5-6837d0416fcd
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
Subject: [RFC v3 05/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
Date: Thu, 29 May 2025 12:10:34 +0900
Message-Id: <20250529031047.7587-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH+++cnc3l4jTFTiZlg7CsNMXyjUSlD3XCPgQihIq69NhGOnVT
	08ial9IktYuX0hUTybzBYoqbKZJz6SohcxnLSm2mhqTipeFcWbry2wPv83u+vFxMYMDduRJp
	OiOTipKEBA/nzTrXHj45GCg+Mr/MA6W6hYDmlSx4Oq5jg7KpHcGy7RMHlgz9BNTVWjFQvi3A
	4ad6FYPJPgsHxuqncOgq1GJgKTMSUFJgxyBP18CCwfZSNpSvPsFAqxjngOm5koDRlj9smNKX
	4PCquhGHsdJQ6FO5gfXNDwQGtZYF1tuPCLg/pCJgomAMwVCvBYea3FIE6m4zG+wrSiJ0L93W
	+JFFd1R/4dAqTQbd2uBNF5uHMFrTdIugNYv3OPTnD10EbXxgx+kO3RKLLsmfI+iFyRGcnu8e
	Jmh12zBOD6gMHHpJs/scGckLSmCSJJmMzDc4jifuHfFPXXPN+nq3i6VAuduLkROXIgOozrpK
	9ibPVNlYG0yQXpTZbMM22JX0o5Ys/Xgx4nExco5NTSrtDsmFjKHeTdxwME7uo4wVMw7mb0S/
	2/9H91DNz144Qk7kUaqytdLhCNadh8U9xEaUIhc4VGFfM/o32En1NJjxO4ivQluakEAizUwW
	SZICfMTZUkmWT3xKsgat/7Y+51eUDi0OhusRyUVCZ74RBYoFbFGmPDtZjyguJnTl54UcEwv4
	CaLsK4wsJVaWkcTI9WgXFxfu4PtbLycIyIuidOYSw6Qyss0ri+vkrkBpRS/JovqzYSuntuaF
	tnhUTXd01pW7nNDFTEcLPdo6pxuu9s3eHI2MFnn/Pm9ZMW3rL5sxvg5yO66wRXiZ/IJCVvfH
	Y8qDrG8T7xMf5+cMaE1h+cLF8ti4poooaYT4unt4gdeM55mYgDXfQyPi09IDrtcuBNekqNLS
	yzMT3eQhnkJcLhb5eWMyuegvVL19ntcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnc3h4Li0ThYJAzFGWUbmT4y0PuihG33ohlA59OTmZcqm
	NsNs6iIcapnNyiZMxLuwUNNppjWHzhRa3jBL5wVFTK3cEnVl6aJvD7wPz5eXiwmqcG+uVJbC
	yGXiBCHBw3kXQnIOnbIGSY783gwGnaGegLo1JVRNGtmgq21G4Fj/zAG7uYeA8rJVDHQf1Dj8
	NGxgMNs9zQFb5RwO7Q9aMJh+aCEgX+3EINtYzYKu0l42WJsL2PBkowKDFtUkBwbbdARM1P9h
	w5wpH4fekhocbAVh0K3fBat9iwjMhhYWrOaVElA0oCdgRm1DMNA1jcOLrAIEho5RNjjXdESY
	kG6q+cSiW0vGObS+IZVurBbRmtEBjG6ozSXohpXHHPrLSDtBW545cbrVaGfR+TnLBP1jdgyn
	v3UME3T5/HcWbWgaxul+vZlz0SOSdyKGSZCmMfLDJ6N4kq6xo8mbnsqpwnaWCmV5aJAblyKP
	UQtP11nbTJB+1OjoOrbNnmQAZZ/uwTWIx8XIZTY1q3O6pJ3kDerjzH0X46QvZdEuuJi/FXo9
	72T/i/pQdS/fukJuZCBV3FjscgRbznPNO+IR4unRjlrkKZWlJYqlCYH+inhJukyq9I9OSmxA
	W/dV3v1VaESOwQgTIrlI6M63oCCJgC1OU6QnmhDFxYSe/OzQ4xIBP0acfoeRJ92UpyYwChPa
	y8WFu/lnrjJRAjJWnMLEM0wyI/+/srhu3io07HU2bj3DeEU5sSgUag9oQ7UONRl5UJVZ/L5q
	pZOy7HO8GmuOqwixNqLlNtGgbejauRhCmhh9e+i6X//l6tCykdOxU74mmdJrtrOkveh881K4
	l2P/m2BTWfEYliKKyLDOfy1KsUbe8vDpM95by5VN7bFnhmvC3PvH88aXLpmFuEIiDhBhcoX4
	L5NhrTe6AgAA
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
index a44acdb16a9a..0e7a336aafdf 100644
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


