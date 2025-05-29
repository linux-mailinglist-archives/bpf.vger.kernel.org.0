Return-Path: <bpf+bounces-59239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F0AC7626
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3099E2788
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6525228F;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6321CC5D;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488270; cv=none; b=X8geHzEx35Szs3uJ05QTNYeRdWwUc9Owi3DIseK4bF0Suw949nu2ip2cPQ+/qOM+1yoGZx4GUZrremun7p/WsnXUE3JQKjHvbU9KLl5YIQdvW/GkTfB5WnNCC65KATD12CJkV2T4KxoXWwzwhkuCPCeyMC2yOUvlCeO4MPcLzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488270; c=relaxed/simple;
	bh=OE10GPyW7Lv08fY1UaBj6k6KVcrf4lmIInCb6/AApV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fyB78d5AHpolGrIbTfL7gGG4NbUsicc4sHrP0OLwjxICT7gtBe1tcHB71RtWXoyBsn1GcxLoXdfJveQHxUCe/MTAwIT3gWSfRymPBLiRuUTN2qTNEx9VtEovb91jAvEreYq6UL1S1gX7jiPz8+rkaVTV3IZdKLCbXzi/DBRT1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ff-6837d04249c0
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
Subject: [RFC v3 06/18] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Thu, 29 May 2025 12:10:35 +0900
Message-Id: <20250529031047.7587-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+++cnXMcTk9T9GSlNQnByDRMX6TMLuD5OBAEC9SVBzeaFzbv
	EJlOraFTSsx0wczUeYHFvGxe0JyihlJiGMsu6sRLWUYuxUtRTunbD573+T0fXgoTDeE+lDw1
	g1OmShViQoALvrs+O3NlMlwW3LvuBjpjGwGtWznQNGfhg66lC8Gv7Q8kOIZHCaiv28RA90aN
	w4ZxB4PFETsJs41LOPSVmDGwl48RUKbexaDAYuDBZJeWD5U7DRiY8+dIeNujI+Bz218+LFnL
	cHhV04zDrDYKRvResDn+DcGw0cyDzdKnBDya0hOwoJ5FMDVkx6H2nhaBsd/Gh90tHRF1ku1o
	fs9ju2s+kazelMm2GwJZjW0KY00tDwjWtP6QZD++6yPYsepdnO22OHhsWeEawf5cnMHZH/3T
	BGvsmMbZCf0wyTpMvhL6uuBCEqeQZ3HKs5GJAtmSrZpMX/DLGao2o3zU56NBFMXQoUyBJUyD
	XPbxyfYCz8kEHcDYbNuYkz3pEMZhH8U1SEBh9BqfWdTt7h950PGMVv0HdzJOn2Kalucxp1O4
	J9pa9j9w+jGtL17ue1zo80xVe9V+VeTc0gwSTidDb5BMc8UgeVA4wgwabHgFEurRoRYkkqdm
	pUjlitAgWW6qPCfoVlqKCe29tvHO7xsWtD4ZY0U0hcSuwjEULhPxpVmq3BQrYihM7CksuBQm
	EwmTpLl5nDItQZmp4FRWdJTCxd7Cc5vZSSI6WZrB3ea4dE75P+VRLj756LR3dFHs8mXBwIgi
	hv5aOD/+OKVB4s6s9kZs5ZWoyz08BJI2rK4l4v7E8SRJaXYPJflS/Dzh4nzEimHVLe71zQGQ
	z9wdrGivj4y1e/k1+BcnGxwrtbPSY+GHTTvxcScC5q2Vmk6fzvJAQdFodPWaSHtNZHIPDlQl
	Ur7mq24NYlwlk4YEYkqV9B+C4zeh1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnR1Xi9MaerRAWIQxSBMyXzBSgvBQUn6IAkFztJObzjk2
	XbMozGuu1C4iZpNWmpdNmWzmJcxqitNuiqItu8wUtbLUmpmXotTo2w+e9/k9H14SE1bj/qRC
	lcZqVFKlmODj/CPh2bsO9IfJd18+DkZrPQGWRT3UjLZywWhuRjC/9IYHni4nAZV3FjAw9uXg
	8MO6jMFE9xgP3NWTOLTnt2AwVtxDQGHOCgZZrbUc6Kzo5UJ/cxEXSpbvYdCSOcqDwQdGAt7X
	/+HCpKMQh97yOhzcRZHQbfKBhWdfEHRZWziwcKWCgBsDJgLGc9wIBjrHcLh1sQiBtcPFhZVF
	IxEpZprqXnOYtvJ3PMZkS2fstRLG4BrAGJu5gGBs36/zmLfD7QTTU7aCM22tHg5TmD1DMN8m
	RnBmtmOIYCo/znEYa9MQzjw3dfFiNsfy98lYpULHaoL3J/Dlk64ynno8QN9Z1oIyUbu/AXmT
	NLWHvrk0zlljggqkXa4lbI1FVAjtGXPiBsQnMWqGS08YV9aPtlDxdFHOb3yNcWoHXTP1YbVA
	koJV0eLU9n/OANrS+Hjd402F0qX20vWqcG3L8IS4ivgm5GVGIoVKlyJVKEODtMnyDJVCH3Qq
	NcWGVr9Xff7XtVY0PxjlQBSJxBsFPShMLuRKddqMFAeiSUwsEmRF7JULBTJpxllWk3pSk65k
	tQ60lcTFvoJDJ9gEIZUoTWOTWVbNav6nHNLbPxPBnCDpmLpqOnAgT+anbLBvy0gquO96OH3h
	YMxRO2u2NEuCrcLwu7c1JcO+lldVcx6PzM/sc1iRWFzsnGsUbohLsw85z5V5RUeNl+ZeUo9+
	Wu7jxofn1zhEn3U786ITf+Y+bXgRK1EbZ0u/jgS91Dw6HZEeZ9L3nqG6kyKUm9xiXCuXhkgw
	jVb6F8SROee5AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that page_pool_return_page() is for returning netmem, not struct
page, rename it to page_pool_return_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 0e7a336aafdf..633e10196de5 100644
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
@@ -714,7 +714,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
@@ -831,7 +831,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 
 	return 0;
 }
@@ -874,7 +874,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
@@ -917,7 +917,7 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	 * since put_page() with refcnt == 1 can be an expensive operation.
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, bulk[i]);
+		page_pool_return_netmem(pool, bulk[i]);
 }
 
 /**
@@ -1000,7 +1000,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 	return 0;
 }
 
@@ -1014,7 +1014,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1081,7 +1081,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1114,7 +1114,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1254,7 +1254,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
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


