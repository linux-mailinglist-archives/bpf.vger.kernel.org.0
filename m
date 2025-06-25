Return-Path: <bpf+bounces-61489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9CCAE75F9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7711BC3F7A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB01F5851;
	Wed, 25 Jun 2025 04:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6D189F5C;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826047; cv=none; b=UyRxzboe06lv6oIz6ah2CFNGNQTpr7pB+yu6zviNzQ21yKWwsL5wjNysyHjcYugJGO+hyooJJE1ej3hKzk10ddLRijxbLM6tOS2Tn83mvFCXoOwNo4+eLFaQWTB0lbeERHWP5814LqxoZeBCkJBmxd8HeszSYWgrLLpfIKQPtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826047; c=relaxed/simple;
	bh=lOki3YqzQcqtkTJ9eJR3BxnlQIiozzo5ussGGYz6FQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFVYhhynoz3l4rqr7eFcshlDmnP9m42velUvsmf+n2Fza90yDPfGNyzDUMh+LjqVsoI9lBGri+Q3zRxxRRoOTfAW33c/G1IgbD6V8Pq1IxMEXIg37ulkpCkZbVycczO6GB7LjpfWURQ06pWFDa+9yyLooM7c3EtTb9yZs8w3Udk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-f4-685b7c382e8c
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
Subject: [PATCH net-next v7 2/7] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Wed, 25 Jun 2025 13:33:45 +0900
Message-Id: <20250625043350.7939-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+++cnXMczc6m1KnotgwrqDS6vEGZYNT5YJAVfVCklh7cSJdt
	ulQKNLcuoitcF51rrETd1Jgsc1PWxbUuZiw1spWlstIPUUZaQ9MumyL17eF5n9/zfHkpTGzg
	L6LkihxOqZBmSggBLvgy9+Y6OJUii7nbtx2MtkYCGsbzoG7QyQdjfQuC7xN9JIx5nhBQfSOA
	gfGFBocftp8YDD32k9Bg3wsDtcM4uM45MPBffEpAmWYSg7sTIySccVp40NWi48PlnzUYOAoH
	SXjZZiSgv/EPH4bdZTh0GKw4DOji4bF5PgQ6PyPw2Bw8CJReJ0DfYybgg2YAQc9DPw5VRToE
	tns+PkyOBzuqHvWT8VHsw89fMbbZ+obHthrek6zZnsvetqxlS3w9GGuvv0Cw9tFykn3X6yLY
	pxWTONvqHOOxZcUjBPtt6C3Ofr33imBtza9w9rnZQ+4TJQu2p3OZcjWn3BB3RCCbav3Czy5b
	kacz96JC9HpxCQqjGHoTU1f+BJ/V95usKKQJOprx+SawkI6kY5kxfygjoDD6FsF4GvvI0CGC
	zmAqvF3TAE6vYtpNlbyQFgaLPrYVoZnSZUxD04PpojB6M2P0F0+PiYMZbW8RNpMXMR2VH4M+
	FRyIZmwmccjGgmjxnSostMvQLorpHtHyZzoXMu0WH34J0Yb/cMM/3PAfbkZYPRLLFeosqTxz
	03pZvkKetz7teJYdBT+m9vRUihONdh1wI5pCkrnCGG2yTMyXqlX5WW7EUJgkUnh1a9ASpkvz
	Czjl8cPK3ExO5UaLKVyyQLgxcDJdTGdIc7hjHJfNKWevPCpsUSGyHG3/lRrzRxiuic9ovaZe
	ef7ZeE7inoio6m1RIpP3fmd40v63qvdxouW2ku5DQ7GJnR27vfOGU593M46kiC26XWk79Amu
	tPpRfZxk58iV1W5raQ2ljyw49buKW5Nw0GFcgurQgG7H0vLN1Jwpb5vm6NmCT4MvOW22qTLm
	UbfxhARXyaSxazGlSvoX5oAG8S0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9/ztlxNDguy9MFqmFJN7vQ5Y3KCor+SVYfguhCturkVnPJ
	pqJdwCuVtHWlck6Z2MV5YbJMnZnlpVS0C5q6tLSWikFmpY10om1K1LeH5/k9z/vlZbFslJrJ
	qjRRglajUMsZCSXZtT5pKZw7qFz+IzkITNZ8BvJ+x8KDj6U0mHKLEQwNd4hhsKaWgewsFwbT
	62QKfllHMPS8cIohzxYKXfd7KSi/UILBeaWOAX2yG8OT4W9iSCzNEUF1Rj0Nb4oNNNwcuYeh
	JP6jGJrLTAx05o/T0Fulp6DeaKGgy7AZXping6vhK4Iaa4kIXJczGLjRZGbgc3IXgqZqJwXp
	CQYE1goHDe7fno30553izfNJ9dcBTIos70TEbvwgJmZbNHmYs4ikOpowseVeYojt53Uxed9a
	zpC6O26K2EsHRUSf9I0hP3raKTJQ0cKQ7L7vImItaqH2yA5INhwX1KoYQbss+IhEOWrvpyP1
	82IN5lYUj9pmpSIfludW8U8LLcirGS6QdziGsVf7cSv4QWctlYokLOYKGL4mv0PsDaZy4fyd
	V28mChQ3n6/MTBN5tdQz1F2WgCZH5/B5hc8mhny41bzJmUR5tczDpLQm4Enel69P6/b4rOdA
	IG/NlHlt7KkmPUrHV5HU+B9l/EcZ/6PMCOciP5UmJkKhUq8O0p1SxmlUsUHHTkfYkOcn7p8f
	vVaKhpq3VyGORfIp0uUpB5QyWhGji4uoQjyL5X7SW2s9lvS4Iu6MoD0dpo1WC7oqNIul5P7S
	kH3CERkXrogSTglCpKD9m4pYn5nx6Kz/gt0Fs+9+at+onbajpX9s/FDAnMZM6ZfQGek5xpd0
	ZVZdZ8i2LfT+tqP7T5RvfCu3L0xzpQzOTbBwvf4rfW98X1jRsHfuusQ+jd057teypHDctfji
	AGlcEzZ2WBa1qVi9OCBYUmZoLNla8Lg/qHenJSvjmPvl0VbHydv6mDHsFuSUTqlYsQhrdYo/
	tDwbxA8DAAA=
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


