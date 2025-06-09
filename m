Return-Path: <bpf+bounces-60032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E8AD17ED
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AEE168E66
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1D281371;
	Mon,  9 Jun 2025 04:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F5194C75;
	Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443562; cv=none; b=GJaJ78KbGmeob2LqsLALOx+RsbE9cQ6ic7CmRMoIRaUEbSl7UMVy0JhcTUyigyBdWzVSub46ZFZv2PDkThulhFqjr4P3OQtK1eypKOh6gFfJeSz7t7deUzFdlkhgS8RhlENFPmD64mgsKtqdhgKk68ExPvQFZS7aZJ6g58LnQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443562; c=relaxed/simple;
	bh=x1a5UcFV2DjfhqvaRF3PraCM6zAf34sBq2XjhwSKsbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jmd35ima1EunRrmnO0NfAdD84coPPQH8EsGQapYrzRZraTx16snJ8/b5vcxHoWZvfipyFYM5O7wBv8cEeTwZcvHJlaI+n3t8pgSIGm8Zwz1oudrRSSAZeUM5Cb+3x0OAGQyfK9KzMtoiR/lgliPw0mpLjlZ4GDeqYGJRHq4QIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-58-684663e3e970
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
Subject: [PATCH net-next 2/9] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Mon,  9 Jun 2025 13:32:18 +0900
Message-Id: <20250609043225.77229-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHefeec3ZcDU5L6pjRZSGJUWoXeaIoI4yX+hIUEZW4pQc3nMs2
	sxlFpnYbqWXRZS6dlbWptVqZM8JyjVIKMnOxLjabrYjKyNXSlGxLor79+D//y5eHxTIjPYVV
	a/MFnVapkTMSSvJ5fO3cvsxVqqRgXRKY7Y0MNAwa4FKvkwZz/U0E34ZeiiHofsDA+doQBvPj
	Ugq+239iCNz3i8F38R0Ftw82Y/BXtDNQVjqModhpFUHnzXIaTvysw9Bc1CuGp7fMDLxuHKXh
	nauMgg6TjQJfeSrct0yC0MNPCNz2ZhGEjpxl4HiXhYG+Uh+Crnt+Cqr2lSOwt3ppGB40M6kz
	yQ3bcxFpMfWIicWxg1y3JhCjtwsTR/1hhjgGKsXk1bPbDGk/PUyRFmdQRMpK+hnyNfCCIl9a
	PQyx3/BQ5JHFLSZBx7S13CbJ0ixBoy4QdInLFBLVZWeAzuucYai+Wi0qQjWxRhTF8txCvuPJ
	fuYvX7vyEUWY4WbzXu8QjnA0l8wH/Q8oI5KwmOun+YB5WBQ5TOSy+OdnBv+YKC6ObzsQpCMs
	5RbxFQOjeKx0Ot9w9W6YWTaKS+F7vfkRWRa2uLqteMw+ge8485aKWHB4114ti8g4nCxpqsKR
	WZ6rY/m+UDE9VhnDt1m91FHEmf6Lm/7FTf/FLQjXI5laW5CrVGsWzlMVatWGeZnbch0o/CEX
	94xsdqKBznUuxLFIPl6qOJWmktHKAn1hrgvxLJZHSznfSpVMmqUs3CXotmXodmgEvQvFspR8
	snR+aGeWjMtW5gs5gpAn6P5eRWzUlCKUvsa7f2RD36/sEU39rMHUO+54a/SWSvv2+Skle9PX
	X3u9LGeFu8iv8F2Y++NHes/WQ596V+5ufHyy0pPXtNicUzPBOBoft0AxlBaSrzasCAViKq1a
	0Th5yrFaW9WhN90fps45eH22QnlOUWPLkSdG622Gbg9ZL81Y8j7Ks7EkdrlGTulVyuQErNMr
	fwMNMMSzHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHefe+5+y4HB2X1UGDYhCBkWmkPFGaIdVLUBQWRV9y6KENr2xm
	WxRa2sWVdqXLXLqSvNfUTGeY1RQvJGVaMbNStmaB3Wxl5grbiqhvP/7/3/M8Xx4OK96TEE6T
	niVq01WpSlZGZJtW5i1xJa1TR1ztVYLZWstCzaQeKkZsDJirmxB8+T4kBU9HFwtlVyYwmB/l
	E/hqncLg7nRKYbh8lEDr0WYMzpPdLBTmezEcslVKoP1yDwN9TUUMnJu6hqE5d0QKA7fNLLyq
	nWZg1F5IoMdURWC4KA46LXNg4sE7BB3WZglMnLjMwtl+Cwuu/GEE/e1OAsUHixBY2xwMeCfN
	bJySNlYNSmiL6aWUWhr20JuVYdTo6Me0obqApQ2fz0jpi2etLO2+6CW0xeaR0MK8Dywddz8n
	9GPbU5aWvf0kodbGp4T2Wjqkm4N2ylYli6mabFG7NDZRpr5uczOZfQv0JXUlklxUGmpEAZzA
	Lxfqb4whP7P8IsHh+I79HMxHCh5nFzEiGYf5D4zgNnsl/mIWnywMXpr8LRF+oXD/iIfxs5yP
	Ek5+nsZ/ls4Xauru+ZjjAvhoYcSR5Y8VPsX+pBL/0YOEnkuviV/BvrvWEoU/xr7JvFvF+BSS
	m/6zTP8s03+WBeFqFKxJz05TaVKjwnUpakO6Rh+elJHWgHxPUH7gx2kb+jKw3o54DikD5YkX
	1qoVjCpbZ0izI4HDymA5PxyvVsiTVYZ9ojZjl3ZPqqizo1COKOfKN2wXExX8blWWmCKKmaL2
	byvhAkJyEVuyYcfK2Q/DM6qcnLRu25vjOS7lt4gFW11D9Xe9gTn6pHlrThsHMstYeULUhdCt
	xftnRMexxjuHHTHrIhQbt8SMFTSR82Y9bV2x+oqrrPOxcebuXYu9Bvf4+dp9A9tjK5b1keiC
	6Z+xxwzx6p17LyZMlQYeut3Ssa2mpddDjsSvURKdWhUZhrU61S/yyDQ5AAMAAA==
X-CFilter-Loop: Reflected

Now that page_pool_return_page() is for returning netmem, not struct
page, rename it to page_pool_return_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4011eb305cee..460d11a31fbc 100644
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
@@ -829,7 +829,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 
 	return 0;
 }
@@ -872,7 +872,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
@@ -915,7 +915,7 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	 * since put_page() with refcnt == 1 can be an expensive operation.
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, bulk[i]);
+		page_pool_return_netmem(pool, bulk[i]);
 }
 
 /**
@@ -998,7 +998,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 	return 0;
 }
 
@@ -1012,7 +1012,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1079,7 +1079,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1112,7 +1112,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1252,7 +1252,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
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


