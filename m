Return-Path: <bpf+bounces-59241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56111AC7627
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8559E29E9
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E3252297;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C24245025;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488270; cv=none; b=iZ60Uj9MfNEzL7K8OSQw4cEQiIw1a8D2jpGqNqa6qjkFNkqp+BfWdHdgctHAd39t0yzti2736PifUMni66ylXBALnvGmUCCpdyCrVzcKwAdcK7NawZaOwUrucAMn/LiTFVMOmCVpEX8Om/n8ZYac6fue4GUwtXfpSRqwKOdbhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488270; c=relaxed/simple;
	bh=cAMBnw/KqIY7IkwPsz8uO0RVHwA8RRgl4y98aXttjVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ArmjatcxjIzfG64kStO5G5cGIJSVrJu8hGPFMxd50Q54ROWXbJUpUe/1DZper10Jg4NGpuX7TFdQbGqRjcEoROig199Xva6YywyZUOpgVYXxX3S5VV1H4nXiGL53thmjFcTOCXMBl41dvbpdcRsYImQyXTWwaeR/jMds8f83fno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1e-6837d042d920
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
Subject: [RFC v3 09/18] page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
Date: Thu, 29 May 2025 12:10:38 +0900
Message-Id: <20250529031047.7587-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH/e+cnXMcrk5L9GhoOYwiyDIs30wq+9JBDIKg6EI52qmzdBqb
	mibBUlOUZjcx02Uzr5k1XeW2kspLzi6aeYmZlbJQiJyh5lJXmUv69vD+3t/zfngpTPIC96cU
	CUmcKkEWLyVEuMjhdXv9ru5wfuOVHD/QGeoIuDuTCtXDZiHoahsR/JgdJGGqzUpAeZkTA93b
	LBymDXMYjLTbSRiqGsWhKceEgf1SBwHaLBcGGeYaAXQ35guhYK4SA5NmmITexzoCPtfNC2G0
	RYvDy+I7OAzl74R2vQ84X48haDOYBOC8eJOAaz16Ar5kDSHoabXjUHI+H4HhqU0IrhkdsTOI
	fXhnQMBaij+RrN6YzD6oWcfm2Xow1libS7DGyask+/F9E8F2FLlw1mKeErDazHGCnRj5gLPf
	n/YTrOFhP86+0beR7JQxcC99SBQp5+IVKZxqw/ZYEe8YHBCeNi1Lve+oJDWodEke8qQYOoz5
	U1OE/+e2TqvQzQS9hrHZZjE3e9OhzJTdurAjojB6XMiM6FwCd7CcPsI4pr8Rbsbp1UxpXyty
	s5jezDTNZJOL0pXM3frn/0SeC/PCB4X/upKFYzfymgm3lKFnSSazfxgtFvyY5hobfhmJ9cij
	FkkUCSlKmSI+LIRPS1CkhhxPVBrRwnOrzv06bEaT3ftaEE0hqZe4A4XzEqEsRZ2mbEEMhUm9
	xRk7tvASsVyWdpZTJR5TJcdz6ha0gsKlvuJNzjNyCX1SlsTFcdxpTvU/FVCe/hoUsao6OPCy
	oih5bF6tjK48WC+d6a+oMFmIvi77rZ+Wut9HY7Tp93o1a+Ose0wnxp/UNvgGFTtzHVszgg9H
	TxzoXIpndm0reBQzvZuPWBtFB+zwSa/PlTRZvwZfiECR3s9KyvlnAQ37zdmnIMrDEqiRvysr
	tr3iu66XyrnjjdpYKa7mZaHrMJVa9hdmHlfX2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF++0+Xa2uS/JqRHTDJCNLsPxSsiyibkWRPQgiylEXt9ymbUtU
	CpZK4mj2xFKXLGSm87GY4maJ5By6UVHYg5mZslKitCwfTBeVK/rvwzmcc/44NCatw2NppUYv
	aDVyFUeKcfGBrUXrd7xIUWwMfVwIZnsjCQ3BPLg/7CLAbGtDMDU7QMGkp5eEmnszGJifF+Mw
	bZ/DYKQnQMFQ7SgOHSVODAJXvSSYikMYFLrqRNB910fAi7YyAm7NWTFwGoYpePnQTML7xt8E
	jLpNOPgq63EYKkuDHssymHkyhsBjd4pg5spdEm72WUj4UDyEoK87gEPVpTIE9k4/AaGgmUzj
	+Nb6fhHfXjlI8RbHeb6lLoE3+vsw3mErJXnHjxsU/+5NB8l774Rwvt01KeJNRV9J/vvIW5z/
	1vma5Gs+TYh4e+trnH9q8VAHI4+LU88IKmWuoN0gyxArxgf6iRxnZF7zuJUyoOrFRhRBs0wy
	63nWS4SZZOJZv38WC3MUk8ROBnpxIxLTGPOVYEfMIVHYWMqcYMenv5Bhxpk4tvpVNwqzhNnE
	dgQvU/9KV7INDx7/LYqY18tbyv9mpfNjFcYu8hoSW9ACG4pSanLVcqVqU6IuS5GvUeYlns5W
	O9D8f7UXf153oamXu92IoRG3SOJFKQopIc/V5avdiKUxLkpSuG2zQio5I88vELTZp7TnVYLO
	jZbTOBct2XtMyJAymXK9kCUIOYL2vyuiI2INaN/qrvi5BHXMFs2TNatka4cXmPYfyiw9qW9L
	OhvNSm/vbPywrWmwRP/Z+33JhlR8o6Yq3ZUu+KrVtVxBxYqJCyrr+z1B1zuJL+7oLtuRkrTR
	p7LZ9Ef7D5ef67qzs/dKw/rWvB8NzVwWtc7qlfX88ln1HgO9PTkw0U/FNI1VLtrB4TqFPCkB
	0+rkfwDA/DWMuwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_put_page() puts netmem, not struct page, rename it
to __page_pool_put_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 0a5e008df744..9eae57e47112 100644
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


