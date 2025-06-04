Return-Path: <bpf+bounces-59612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10EACD5DC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A6E7A6A8F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E47226D10;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330D6FC3;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005590; cv=none; b=OURby/GvDoUsNKsK06DouBnRn4TjpIlYAa4+4ntY2MzoDuhLJrhMVu0aXZNr6OeHvnmmQS1vExtJ2L2NzHX3GL6ARmKhiFWeYFqd6gxUXlbJnxrScJUCBuAM+sW9tM6H88AYx5wRsrYpaSRFAXeEWn2Md9HVIrzW5fx25U22A/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005590; c=relaxed/simple;
	bh=bRBpNS3jYlDXFC8S8KegJ/AlUBeo1bGPS73UG9htamU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Dy/3XXxz9Q/pI7xu6zgNKmP/rIk8sxNj1GJXHHiSW4pbO+6KFJyGTQQsmtuF/sZvvmqV+J/bWdWK/OSPpf4g9BxdPpg5Jw9VGxBXJy+jWtJp3aq+JmlQwJo71pmulPyAzMuJs8getdqRmoOk/oVQSHa30lDnWb+MUKkXrdGERSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f6-683fb509d3f7
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
Subject: [RFC v4 06/18] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Wed,  4 Jun 2025 11:52:34 +0900
Message-Id: <20250604025246.61616-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+++cnXO2XB2W6UkrdRCmoGVovEaYH/xwoD5EWdIF7ZAnt5pT
	NjWNAkvT0rxgN7OFM8u8MlleZpjkXGqoaaY1y1IUhVAnuhRvaM7w24/3eZ7fl5fCpGbchVKo
	4ni1ilPKCDEunnJ46SOqPSY/mGcF0OorCahYSIQ3w0YhaMvrEPxd/EmCzdxGQHHRPAba7lQc
	5vRLGIy1jpAwVDKOQ2N6PQYjOe0EZKUuY3DHWCqAnrpsITxaeo1BffIwCV/faQn4XbkmhHFT
	Fg6fCspwGMoOhladE8x3TCIw6+sFMP/gBQEPe3UEjKYOIehtGcHh+e1sBPomixCWF7REsAdb
	UzYgYBsKfpGszhDPvi31ZjMsvRhrKL9PsIbZPJId/NZIsO35yzjbYLQJ2KwUK8HOjP3A2emm
	foLV1/TjbKfOTLI2w96T9Hnx0UheqUjg1QeCLonlVV1hsaNuidOVpVgyanTJQCKKof2Z1eI/
	xCZnVlVvMEF7MhbLImZnR9qPsY204RlITGG0VciMaZcF9mAHHc7op20bjNP7mIW0RdLOEjqA
	+dJkH9ilbkxF9YcNkYg+zAxan270peudLGMfZpcy9BTJPFvtwv4PdjHNpRY8F0l0aEs5kipU
	CdGcQunvK09SKRJ9L8dEG9D6b0turVwwotme0yZEU0jmIDEOBsmlQi5BkxRtQgyFyRwlbl7r
	J0kkl3SDV8dEqOOVvMaEXClc5iw5NH89UkpHcXH8NZ6P5dWbqYASuSSjyJWrk665YVH57wsV
	1VdCAju1WvIVt3Ws0Nfp7IQ01iuU20ampHuXXDxxJMzkPtx/ZqZ24J68vvBjc7aqyiMkvEIQ
	ILpLqT0DW56c6zN38/u7y3yGzTnbF9Ud3yesO+eUoVUNnyNS92QOOq891iVSGn1jGHeq9nia
	e9HN8d1TuAzXyDk/b0yt4f4BMSaqq9cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0iTYRzGe/cdNlfLryn5pRfSQipDTcj4k6Z25YtBh4sQgtKRX244D2wq
	GgSmy2OumaJhkxbiWZk5c1NUZJ7RyDOamqZMKsxVnl1UTujux3O6eQSEuJp0F8jjkzhlvFQh
	oYWk8EZgpo/TuxDZxW6jN+gMDTTU76ZC9ZKZAl1dK4LNvTk+bPQO0FDxZpsA3Qc1CVuGfQKs
	/ct8WKxaJaEj20TA8vNBGgrUdgIyzDU86CkfomC0VUNB8X4lAab0JT5MtOto+NTwl4JVSwEJ
	Q2W1JCxqQqFffxK2h9cQ9BpMPNh+Vk5D0biehhX1IoLxnmUSXj3RIDB0zVBg39XRoRLcUjvL
	w21lC3ysb07GxhpvnDczTuDmulwaN/96wcfz0x00HnxpJ3GbeYOHCzLXafzT+pHEtq4pGld8
	+cHDhpYpEo/oe/m3TtwVBkVzCnkKp/QLjhLKGt9HJK54ptoaaoh01OGeh5wELHOJzW9soh1M
	M2fZmZk9wsGujD+7sTxA5iGhgGDWKdaqs/MchgtznzXYNg6ZZLzY3aw9voNFTAA71uUoOEY9
	2fqm7sMhJ+YyO79eepgXH2QKzJOEFgn16EgdcpXHp8RJ5YoAX1WsLC1enur7ICGuGR3cV/X4
	d6EZbU6EWRAjQJJjIvN8sExMSVNUaXEWxAoIiavI8/yBJIqWpj3ilAmRymQFp7IgDwEpcROF
	R3BRYiZGmsTFclwip/zv8gRO7ulIWzWy8DbGS1XY1+3pXNoOLbGn/NZKRiRqqsTn5mRfDfU9
	vyjoyPBO59Gp3DFTleb0lXuWDhec53z8T/2cNmfaK8T3de3V26kJ1snwM5/3k23nvt7JCavE
	30btxsaHbpLg62Fij4wE7TVR4E6kS+egMbuYY2afXqhM8cjaatorlJAqmdTfm1CqpP8AigJp
	qroCAAA=
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
index e80a637f0fa4..b7680dcb83e4 100644
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


