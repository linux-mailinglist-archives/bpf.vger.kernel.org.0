Return-Path: <bpf+bounces-58802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD46AC1A79
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752D21C0444D
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1307221F0E;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A538217A31E;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=fWtnu2R5Q82WD5LInI+KaK01BjKx6sXuUu1ANlycPzV+/gJ2X/2PtfNxSJxxdamXqVJQP53oO9Jqy0hSmT5dZ7xzNepFhZBkWlmmCA5re7/RTn5rEr7q47QvW2qNQUxUHSNkr64Q3bVlzMcUPolGoosHLS/Lb8HmcAO619ri+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=Gi6KTuSH5vQAjkQ6UtpKBJxOWz2N8Ui11sOKVlAzsUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=frYr2dD/+uPH+k0RT6IZ/oNWhQioLu/rFCeP0LTCoH/LPEFOzTZryWkzmg37wYS7TCSndceZPBzpv0eiINWe9x5iBCapU0SyUPGTyOsJF7QGh1qzworf06tr7mhzC2eNk7c5+LYIHoQV/W4bH9lYEmEM3yJDlwSLG2jFTTIoPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a7-682feadc47f5
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
Subject: [PATCH 06/18] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Fri, 23 May 2025 12:25:57 +0900
Message-Id: <20250523032609.16334-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGOzvv3jOHi8PycjTKWkSwSjNU/laWQdEJ/BD5LTNdevAM55RN
	zUuRlWCZ2rKgsFmz0HRasyk6L0gur6QlmrnM1BaKhBo5FW9hXvDbw3P5fXlEpLQVeYqU6kRO
	o1aoZFiMxFPOLw8P/fbhj0x0uoLeVIGhfCEFXo9ahKA31hAwu/idAkdLO4ZXRfMk6D9nIpgz
	LZEw1manYKRkHEFjVi0J9gcdGHIzl0m4bSkVQE9NnhAeLxWTUJsxSkFfvR7DcMWqEMatuQg6
	C8oQjOQFQ5vBDeY/ThLQYqoVwHxOIYZHvQYMvzJHCOj9YEfw7FYeAaYmmxCWF/Q4eC9bXfZN
	wNYV/KBYgzmJrSqVs9m2XpI1G+9h1jyTT7FDXxsx2/F0GbF1FoeAzb0zjdm/Y4OI/dPUj1lT
	dT9iuwwtFOsw775AXxKfiOZUymRO43MyUszrpitRwhuvlNnVbGEGcd8zm3ASMbQf019UgLb0
	3W4HXteYPsDYbIvkunahfRmHvX2tIxaR9LSQGdMvC9aDHXQ4k7dUvTFG9H5mKmdpw5fQ/kzX
	5Du8CfViyivfb4Cc6ABGNzy34UvXOg1fBql1KEMvUky9uYHaHHgwzaU2pCMkBmKbkZAq1clx
	CqXKz5tPVStTvKPi48zE2rklN1bCLMRMT6iVoEWEzFliEfvwUqEiWZsaZyUYESlzkbSOe/NS
	SbQiNY3TxEdoklSc1krsFCGZu+To/LVoKR2jSORiOS6B02ylApGTZwahjUq/UtGCQ3y9VvJP
	VRW/pZ+7+06QEllhLJMREPQPx/A3IxGsXnYz8BFB3d2R9sx921W6bBLVy9VndOYXbRfHDlme
	IHXgngEd53G+pqwmS15XF9IcjnbR8qhzlddDz6a5Xi2xLvgHpofl8kzswdM98X0uicafxwY+
	Paw/LkNaXuErJzVaxX+2gf9z2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGe3fO3h1Ho+OyPCokraRS0gy1P5kiRfQSJfYhohs59OCWOmVT
	0SjQFDSda5kfSmcsRPPKbIqXFLNpXkipvDHN1DStTK284Q1Mjb79+D0Pz5eHoaRFtCOjVMXw
	apU8QobFtDjQN/no0JSH4liGmQGDqQxD6XI8vBitFYKhpBrBwsonEcy3tGHIf75EgeF9Cg2L
	plUKJlrHRDBSOElDQ2oNBWMP2zFkpqxRcL+2SADNeR1C+FCtE0L2agEFNYmjIuh5ZcAwXLYh
	hElLJg0dOcU0jOgCoNW4F5beTSNoMdUIYEmbh+FxtxHDeMoIgu7mMRpyk3QITI1WIawtG3CA
	jFQVDwhIXc5nETGaY0llkStJt3ZTxFzyABPzXJaIDPU3YNL+ZI0mdbXzApKZPIvJn4lBmvxq
	7MMk//tvATFV9dGk09giCrK9Jj4Vykco43i1h3+wWKGfraCjy53jFzbShYkowzEd2TAc68Wl
	dc3jLcbsIc5qXaG22I715ObH2uh0JGYodlbITRjWBFvBbvYmp1utoreYZl24Ge3qtpew3lzn
	9Ev8b9SZK61o2h6yYX04/fDitpdudup7B0V6JDaiHSXITqmKi5QrI7zdNeGKBJUy3j0kKtKM
	Nv8rvLf+qBYt9JyzIJZBsp2Sw5EeCqlQHqdJiLQgjqFkdpK3k+4KqSRUnnCHV0fdUsdG8BoL
	cmJomb3k/BU+WMqGyWP4cJ6P5tX/UwFj45iIum5/7a/061OJZrRah/xxPVadmZveVX9jqaah
	7sLJidP25cXfYq0Sn6R9nsct/UG+HQEHFCfKrxdoRtUuLZemDpQe/NjppcwObHNrknz5Md61
	xzP17DqO2/8mRe/n8FOykp92xK1fmnu3Ku1p2NVeMml/+bWTf1an7cVnjuKBkDCLjNYo5J6u
	lFoj/wvFk5rouwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that page_pool_return_page() is for returning netmem, not struct
page, rename it to page_pool_return_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index cec126e85eff..1106d4759fc6 100644
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
@@ -713,7 +713,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
@@ -830,7 +830,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 
 	return 0;
 }
@@ -873,7 +873,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
@@ -916,7 +916,7 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	 * since put_page() with refcnt == 1 can be an expensive operation.
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, bulk[i]);
+		page_pool_return_netmem(pool, bulk[i]);
 }
 
 /**
@@ -999,7 +999,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 	return 0;
 }
 
@@ -1013,7 +1013,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1080,7 +1080,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1113,7 +1113,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
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


