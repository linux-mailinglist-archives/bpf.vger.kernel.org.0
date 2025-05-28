Return-Path: <bpf+bounces-59065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DAFAC5F75
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C72C3A247E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB1020E328;
	Wed, 28 May 2025 02:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DEA1C8604;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399369; cv=none; b=ZzgUPTdYHUZlcQIZwe8cSDKCZ3aZwmEPrU1nDCegeqSw7H8EQ7rmZxD8S4gak0naVRJJb7/TLkPaRIwB8fHYL7EjnRpCw6wKQGg1k+xNnmLV69E7XqgkWTuf6fki/fp3IotH+rZCQg0BcBuPF1iMfQ5R0TlCFYgh/FSQig7ZF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399369; c=relaxed/simple;
	bh=7AJlMGhcPhsmLwkXKQkMj21lpg7UMZiM/xVdovsSez4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T+TrhnT30OYcoCGVJC9Reje8necrJz5naLw3B5jBgoMwD+79jwi37p/pJMhHzNGWHTqW08v1FynnywNhBcCeoHzEzN75+ybkjC0XM2vF0bmLgGWuXLnwj+YHVt4bX4AgL/faRw1UKGs6wmV3qkqRc9X7fjeL2zCX3PRdCJFrpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-4b-683675013d47
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
Subject: [PATCH v2 05/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
Date: Wed, 28 May 2025 11:29:00 +0900
Message-Id: <20250528022911.73453-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH+++cnR2Hg9MSOxokrYtgpXlbLxUp4Yc/QVD4oagPbenBjea0
	zWsSqQnRzAuWZbpqGuYVJsvLlBG1Vl4xmxgrr2kTDNN0auoMc0nfHn7vw/PlpQmxlfSnleoU
	TqOWqySUkBT+9K48ilKlimPv606A3thIQcNqBtRMmPmgr29FsLQ2LACXrZOCF5UrBOg/5pGw
	bFwnwPlhUgDjL6dJsNxtI2CyqIuCgjw3AbnmWh4MtBby4eF6NQFt2RMCGOzQUzDWuMmHaWsB
	Cd3ldSSMF0bDB4MvrPTOIrAZ23iwcv8pBQ/sBgqm8sYR2N9NklCRU4jA+NrBB/eqnoreh5vr
	vvBwe/moABtMqfhVbRDWOewENtXfo7BpsUSARz5bKNxV5iZxu9nFwwV35ii84PxK4vnXQxQ2
	Ng+RuM9gE2CXae955rLwVDynUqZxmpDTMqGifliHknt8MsqWA7ORndEhL5plItgG9w/0n5vH
	fvE8TDGBrMOxRnjYhwllXZOdpA4JaYKZ47NOvfuftIuRscVLawIPk8xBtvpTz1aIpkVMJDtr
	37ndDGAbmt4QntmLkbLvR+I8s3jLmM83Ik+SZZYF7Ea1hdz2/di3tQ6yGIkMaEc9EivVaYly
	pSoiWJGpVmYExyUlmtDWZ1/e2rhiRosDsVbE0EjiLcJNkQoxX56mzUy0IpYmJD6i3CipQiyK
	l2fe5DRJVzWpKk5rRXtoUrJbFLaSHi9mEuQp3HWOS+Y0/6882ss/G1U9m5E6u2MGn/sf8FvX
	dmQp2h+H31Bf6hh90aS0FDVdqphOPxk+tbmw0dJXMh/j+6xf96bjcH9ppD3km7Tl0JOC0bGa
	35R1MSElasAiS1uwzWYdmRnIuSAqdeWbM85e+348dS3gjDG/nNfbGFnkFftIeE5/O+zivOzP
	/kR/qkoWLCG1CnloEKHRyv8CrALHmdUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnZ0NV8c165hFtExJ0hKc/qKLQmR/QkoIDCLQpYc2nBc2
	NRUkU6NazuxCiM5Y2MxbzMx0hlnMu91s4qXUKQstwlt5QV1hrujbw/s+vF9empCYyG20KjGF
	0yQq1DJKRIpOHcr1R6nBygPLvfvAYK6hoHo5HR6PW/hgqGpAsLAyLID5tk4Kyh4uEWD4kEfC
	onmVgIkOhwDGyidJaL7WSIDjVhcF+jwnATmWCh60lnbzobehgA/3Vk0ENGaPC6DvhYECe80a
	HyatehK6iytJGCsIgw7jFlh6M4WgzdzIg6X8Ugru2owUfMkbQ2BrdZBQcqUAgblliA/OZQMV
	JsP1lZ94uKl4VICNdan4WYUf1g3ZCFxXdYPCdT/vCPDIQDOFu4qcJG6yzPOwPneGwj8mPpN4
	tqWfwmXf5njYXN9P4rfGNkGk+znR4ThOrUrjNPuPxoiUVcM6lNwjTS9a9M1GNkaHhDTLBLH1
	9jmeiynGlx0aWiFcLGUC2XlHJ6lDIppgZvjshMH5V9rMxLCFCysCF5PMHtb0sQfpEE2LGTk7
	ZXP/t7mTra59TbhiIRPMto/EumLJujF704wKkciINlQhqSoxLUGhUssDtPHKjERVekBsUkId
	Wj+vPOvXbQta6DthRQyNZG5iXCtXSviKNG1GghWxNCGTinNCg5UScZwiI5PTJEVrUtWc1oq8
	aFK2VXzyLBcjYS4qUrh4jkvmNP9bHi3clo08vXbZv2Y5NpbMho8SZ6KF/ivbW9uvvhozRZyO
	3TsY/t7h01O6Zn4e4njiZnp0RF853VkiD9oU2jJwuck64D0niqIHsz2iVuO7FtGDg/dtPubd
	L586w4qqKzuj3nleF1zI7D0/H7JDHyGdDrrk54ePB3l0TXp/z833Xf1trz+2ECkjtUpFoB+h
	0Sr+ALs1jfC4AgAA
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
---
 net/core/page_pool.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 147cefe7a031..0313609abc53 100644
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


