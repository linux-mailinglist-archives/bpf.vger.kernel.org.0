Return-Path: <bpf+bounces-59064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB0AC5F70
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C51BC0410
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EB200110;
	Wed, 28 May 2025 02:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC171C9DC6;
	Wed, 28 May 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=b2vA5es2xlB5CeOQVeeYxw4TJi5dU1hXi++HXBLlDFxUQwtSi8DmnqPXlKJloq4R2ENnRAVUHg9GEmG6mrIusbVhGMLLwXYzsY1qH7iWNaEcTyu7BntUeOFZcN740/6XoVJNWtGkATv3UwBThpuLKPny2COEuXS0LvVHJ0MLjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=zrNGKnbSxXrbqDwxy2zSBF4Zq1u8zpRiWQM30ZvnayA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fWasVwLeNqfdu32n8fmQyEuO2xZjBBtYhw/gEUXQy7uUAQwGIZaKscI9G6ZyItW/nMbVAcXtR/iGg2+924tilkufI9k1ypZVQ6waQpRWmmEAMBTNaRHXk0Y1B2fTdZx5tbuh5HlUYzHMiHuwCL17LONeqGLI1zsFFNS5XfVAvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-73-683675027897
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
Subject: [PATCH v2 09/16] page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
Date: Wed, 28 May 2025 11:29:04 +0900
Message-Id: <20250528022911.73453-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e/8d3Ycro4nqVNB0aCM7jftjaL8kPGnT0FFUFENd2irOWVL
	ncHIvFBZ2pUUnbUoTc2arHBzSc25vNBFMYtpF23pPoS6dDbNheaSvv14nvd9ng8PQ3FNeBGj
	1p4RdFqFRk5LsXQo6t5aUVq8akNRrwxMlhoaHk0Y4GGfXQym6joEY78/SSDgbqHh/r0gBab2
	XAy/LJMUDDR7JdBb4cPQcMFGgfdqKw0FuSEKsu2VIuioKxTDrclyCmxZfRJ47zDR8LVmWgw+
	VwGGtpIqDL2FCdBsng/B14MI3BabCIJXymi42Wmm4XtuL4LOJi+G0vOFCCwvPGIITZjohGXk
	WVW3iNSXfJEQszWNPK1cRfI9nRSxVl+iiXX0hoR8/thAk9biECb19oCIFOQM02RkoAcT/4sP
	NLE8+4DJG7NbQgLWJfvYw9IdSkGjThd063eekKrGQxdRak604f21YioL+WX5iGF4dgs/2aDM
	R5H/MOh8Lg4zzcbyHs9vKswx7EY+4G3B+UjKUOywmB8whURhYx57jB+vLP33gNnlfNVEGQqz
	jI3nx8ra0GzoUv5RrZMKd0XO6K8+J4Vljo3j/ZctKJzJs78kvNnpp2bvF/KNlR58DcnMKKIa
	cWpterJCrdmyTpWpVRvWJaUkW9HMtBXGP0fsaLRjvwuxDJJHyUhtnIoTK9L1mckuxDOUPEaW
	vStexcmUisyzgi7luC5NI+hdaDGD5Qtkm4IZSo49qTgjnBaEVEH33xUxkYuyEC4/1b8acbHl
	5wZvG+Mquqbquc6h6Frb1Lu57p7F3pfx2ulDR6/eLZzjKuo5TjaHfqYc5DLq8IpNY4bUJ299
	2/V5D9ptjrwRx2rn4OE/Nb4fjaci/Ae+JR5Kbd0dqE+6Y6x+vvL64+6y/U5VX7TxwEvR1m1d
	wdhEx97Qnu39u9d8lWO9SrFxFaXTK/4CjDAo/tYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcRyG/e+cnR1Hq+OyOtmFOdDISjNUfqSU0de/LjLoIigwlx7dclPZ
	VFxR+QV+5UcZITphIZpOYbLMTTOTzc8SlYmlpimGYmBazaZuQrmiu4fn5X1vXpoQ15M+tDw5
	jVMlSxUSSkgKr0TkHuOlh8uO5/uB1tBMQdNGJryYM/NBq29DsLb5SQD2nn4Kap87CNCO5JHw
	y+AkYKFvXgCz9YskdOabCJgvG6CgJM9FQI65gQfWmkE+jLaV8uGps44AU9acAMY6tBR8bv7N
	h0VLCQmDVY0kzJZGQZ9uLzjeLyPoMZh44HhUQ0GFTUfBl7xZBDbrPAnV2aUIDF0TfHBtaKko
	CW5tnOTh9qoZAdYZ0/HLhkBcNGEjsFFfSGHjzycCPP2hk8IDlS4St5vtPFySu0LhHwtTJF7t
	Gqdw7dJ3Hja0jpN4SNcjuOp1QxgZzynkGZwq+FSsULbuKkCpuV6ZY+WVRBZaFRUhT5plQllH
	92u+mynmEDsxsUm42ZsJYe3z/WQREtIEs8JnF7QunjvYzcSw6w3Vfwsk4882btQgN4uYcHat
	ZhD9G/Vlm1q6t4do2nPb907HubWYCWNXiw2oHAl1yEOPvOXJGUqpXBEWpE6SaZLlmUFxKUoj
	2n6v/v7WYzNaG7toQQyNJDtEuCVMJuZLM9QapQWxNCHxFuWcDpeJRfFSzV1OlXJLla7g1BZ0
	gCYl+0SXr3OxYiZRmsYlcVwqp/qf8mhPnyykTvX3C6r4dDvR3HbiSOPRhIhlW/S5PI0xetl5
	/t7DmJUA55lnkRxrIqy9ryrj37xVNoWqCwsSBt5RJ3ctjUa3t36MfZDxTbd1aca3bvYmt7NJ
	m82K7EnD3cXiZSParw+ovmabijioPJtg3ezz6/b4WtRxeM/QZEzwnQuqsoGRYQmplklDAgmV
	WvoHFS70lrkCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_put_page() puts netmem, not struct page, rename it
to __page_pool_put_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index af889671df23..f5fe3007f118 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -790,8 +790,8 @@ static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
  * subsystem.
  */
 static __always_inline netmem_ref
-__page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
-		     unsigned int dma_sync_size, bool allow_direct)
+__page_pool_put_netmem(struct page_pool *pool, netmem_ref netmem,
+		       unsigned int dma_sync_size, bool allow_direct)
 {
 	lockdep_assert_no_hardirq();
 
@@ -850,7 +850,7 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 	/* Allow direct recycle if we have reasons to believe that we are
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
-	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * __page_pool_put_netmem() makes sure we're not in hardirq context
 	 * and interrupts are enabled prior to accessing the cache.
 	 */
 	cpuid = smp_processor_id();
@@ -869,7 +869,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 		allow_direct = page_pool_napi_local(pool);
 
 	netmem =
-		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
+		__page_pool_put_netmem(pool, netmem, dma_sync_size, allow_direct);
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
@@ -970,8 +970,8 @@ void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 				continue;
 			}
 
-			netmem = __page_pool_put_page(pool, netmem, -1,
-						      allow_direct);
+			netmem = __page_pool_put_netmem(pool, netmem, -1,
+							allow_direct);
 			/* Approved for bulk recycling in ptr_ring cache */
 			if (netmem)
 				bulk[bulk_len++] = netmem;
-- 
2.17.1


