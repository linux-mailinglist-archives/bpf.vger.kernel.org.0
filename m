Return-Path: <bpf+bounces-62071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4790EAF0AE6
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D2D1883987
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F721C187;
	Wed,  2 Jul 2025 05:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851861EFF9B;
	Wed,  2 Jul 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435306; cv=none; b=Y5IlaXwGWhTjVfNMtr3HcjnR3qZL5dJ/suW7M1dFoYVoa+OnRKs4Up7qTD7dBoIPu1IH+rUmg/3DATbIBgE5212jU53Bl+hjj+Rblk1kjwqQwOaclmp2frVdgBPSycVy0NhHzYt/6CPZl0ljL4S+1MeI1DCsp18UWV7FbaRlEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435306; c=relaxed/simple;
	bh=lOki3YqzQcqtkTJ9eJR3BxnlQIiozzo5ussGGYz6FQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpDr02blt2DGJpeRGIrc53idTvufjsF94F4x6zqYyzhh+5mftZpf6PchAEXqX4cx4L1dX0ts2r3eBGwtsH06y/cie6ZrzP7rxkGXrWurR0ZUcYGHrqHlKmlcLTNJVjPOwGwUwGRCWcf3V5CMKghbbfajlcsLYCn3HLZo80URbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-08-6864c4926c6e
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v8 1/5] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Wed,  2 Jul 2025 14:32:52 +0900
Message-Id: <20250702053256.4594-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250702053256.4594-1-byungchul@sk.com>
References: <20250702053256.4594-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRTG+++9brl4XVGvWpSjlCI1xeoElX4oeL8ERRHddbgXN9JZm9cg
	8gaWpJYF1Vy5isx0uZg6Zxcrm3Nikcy0maUym2B4Ia2hrqjNkvr24znneZ7z4dCYREsE00pV
	Oq9WyVKkpAgXjQfciSi3yhWbHI0bQWc0kFA7kw33hywE6GrMCL7N9lMwbW0n4e5tDwa6t4U4
	fDfOYeC2uSioNe2BwaoRHJ4WNWHgKrOTUFLoxeDZ7AQF+ZZqAXSZSwm4OncPg6bcIQq6H+tI
	GDD8ImCktQSHDu0DHAZL48GmXw6ezjEEVmOTADwXb5JwxaEnYbhwEIHjlQuHirxSBMYWJwHe
	GV9GRdsAFb+WezU2iXEND/oEXLP2E8XpTRlcffUGrtjpwDhTzQWSM02VU9zH3qckZ7/uxblm
	y7SAKymYILmv7g84N9nSQ3LGhh6ce623UnsDj4i2y/kUZSavjtqZKFL8aB4nTpWEZpfqe1Eu
	eh9SjIQ0y8SyeZ6fggW+Pukl/Uwy4azTOYv5eRkTzU672vFiJKIx5iHJWg39lH+wlElmGwyd
	hJ9xZh1rK/8+HyT2BTnrurA/oavZ2kcv5lnIbGZbbPb5AolvZ/i8lfyzH8h23PjsK6B9BeGs
	8ZbEL2M+a0FjBebvZRkLzTZc+fL30CD2ZbUTv4QY7X927T+79j+7HmE1SKJUZabKlCmxkYoc
	lTI7Mikt1YR8H1N19sdRC5rq2t+KGBpJA8T2d0kKCSHL1OSktiKWxqTLxEtW+SSxXJZzhlen
	JagzUnhNKwqhcekKcYwnSy5hkmXp/EmeP8WrF6YCWhici47nm/MSdgXHv9ctfnPonCZma1Ia
	UVR4TFzZV9l/cYf5smyf2zsaeNt9d/c1Ob4uL250xvnkQHXWUFOouSZ1QBhambilrm7v6RO3
	3MlofcGug1U9YUsjIg6XTdTXrjFkrkQvVfnPty26vDGuTejeXx7btViQG9Qd9kacENX5LrFi
	bk6KaxSy6A2YWiP7DeiIuiAtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bv7r2OZrclddGkGogkpUkZB4rykz5ESR8KI4Ic8+aWbsqW
	okbgW1mWlhZm86WV5etsskynmIkudZoYC2tlpc2SCNN8TZ1QmxL57cc5v/P/fzkMIVkmvRml
	+gKvUcvipJSIFEUcyNxdYIlW7Gl/4QslRgMFtQvJUDliFkJJTSOC2cUhGmYs3RSUP5gnoGQg
	i4Q54xIB37ocNNSajsFwxRgJrdlNBDhu9lCQm+Uk4PniBA0Z5ioBdJZahfC6MU8Id5YeE9CU
	NkLDm5YSCj4b/ghhrCOXBKuumoThvFDo0m+G+b5xBBZjkwDmb5RScNump2A0axiBrdNBQnF6
	HgJjm10IzgVXRvHLz3SoH+4cnyRwQ/V7AW7WfaKx3pSIn1YF4By7jcCmmmsUNk0X0Pjj21YK
	9xQ5SdxsnhHg3MwJCk99+0DiybZBCpd//yXAxoZB8rjktOhgNB+nTOI1QYeiRIrl5p/ChNwd
	yXn6tygNvfPJQR4Mx+7jiiadlJsp1p+z2xcJN3uxwdyMo5vMQSKGYOsozmIYot2LTWwM12Do
	E7qZZP24roI5gZvFriD7k9fEaug2rra+fYU92BCuratnpUDickavWqhVfyNnvffVVcC4Cvw5
	Y5nEPSZcp5nPiolbSKxbY+n+W7o1lh4RNchLqU5SyZRxIYHaWEWKWpkcKI9XmZDrJyouLeeb
	0eyb8A7EMki6XtzeL1dIhLIkbYqqA3EMIfUSe/q6RuJoWUoqr4k/q0mM47UdyIchpVvERyL5
	KAkbI7vAx/J8Aq/5txUwHt5piDRsdwQl2ixXYg9f3xCOf1Ruqcuo2nxOlBxz/NGzu3vtLQm2
	+rDLuxaGxwoj8fh9iQ/9KuCSfH+gtjgp/sHO1Lkvy5pTS71bwzZuzz6hijjZNF/pYy3znZ3u
	JS+ekcseho+kn/ce7C+ccFr37hiI9gRV26h8yjPVfPR3/jrPwAWLlNQqZMEBhEYr+wu8Ulhd
	DwMAAA==
X-CFilter-Loop: Reflected

Now that page_pool_return_page() is for returning netmem, not struct
page, rename it to page_pool_return_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/core/page_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ba7cf3e3c32f..3bf25e554f96 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -371,7 +371,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 }
 EXPORT_SYMBOL(page_pool_create);
 
-static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem);
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
@@ -409,7 +409,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			 * (2) break out to fallthrough to alloc_pages_node.
 			 * This limit stress on page buddy alloactor.
 			 */
-			page_pool_return_page(pool, netmem);
+			page_pool_return_netmem(pool, netmem);
 			alloc_stat_inc(pool, waive);
 			netmem = 0;
 			break;
@@ -712,7 +712,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
@@ -826,7 +826,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 
 	return 0;
 }
@@ -869,7 +869,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
@@ -912,7 +912,7 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	 * since put_page() with refcnt == 1 can be an expensive operation.
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, bulk[i]);
+		page_pool_return_netmem(pool, bulk[i]);
 }
 
 /**
@@ -995,7 +995,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 	return 0;
 }
 
@@ -1009,7 +1009,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1076,7 +1076,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1109,7 +1109,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1253,7 +1253,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
-- 
2.17.1


