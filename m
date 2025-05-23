Return-Path: <bpf+bounces-58806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A72AC1A83
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E425507F48
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266425DD07;
	Fri, 23 May 2025 03:26:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5568221571;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=LhBDxnnGnCOZfXNM+kmbkRlX459nlC+caGRiKy06jhuD3l9jdcO1yQdvoo5dDGhYt4fvhCzJ29E/IlXHR5eUAjCZ7qr3R3aI105gk1GIBE6K9yp0h17hTOYtEHkHr1k6PEQMa+4zQd50i/AEz6K1+2RH/pMtKIAokuRybr3ZVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=iFnfTWEc7pxfQokROsd8KJwiJS8bB+kZS180YvaOd6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Evc4yHjpGj5jTk/+hL3dKu9HWFVfNaa1Mu9dqQppC6ctu33ZF5uG9lPh62JTpr8oGwIngpMGxt89I9ll5rS5ALIwdTECON65XDhus9/03oFOd5v2ymjTM2Zfl3IX20Q6SwpJ27r3E44uz1ZgEjZsD/WmXqT3d56NvLho/CGsxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-9d-682feadca2ba
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
Subject: [PATCH 05/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
Date: Fri, 23 May 2025 12:25:56 +0900
Message-Id: <20250523032609.16334-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXReUiTcRgHcN+917YcvkypV4OO0SmkGRbPHyJCgT8qI7H+6bKVL240jzZd
	GgSaRngmTUV00SQ0L5gsc7NEdM6LwpalTTOPeSSmRi6XTsuc5X8fnuPLAw8fF3cQfnx5fBKn
	jJcqJJSQEM57lh8Zng2UHXXZxKDV11FQu5wCz8dMJGhrGjH4ufKZBoeli4Jn5U4ctO8yCVjS
	u3CY6rTTMFo5TUDzQyMO9kfdFORlruJw31TFA2tjPgmFrgocjGljNHx4paVgpG6dhGlzHgE9
	pdUEjOaHQaduOzjfzGFg0Rt54Mx9QoGmT0fBROYoBn3tdgLK0vMx0LfYSFhd1lJhe1FD9SAP
	NZV+oZHOkIxeVPmjbFsfjgw1WRQyLD6m0fBAM4W6S1YJ1GRy8FBexgKFfkwNEeh7Sz+F9A39
	BHqrs9DIYdh1nrkkDInhFHI1pwwMvS6UTY7n4ontPinFJRoyDbMy2ZiAzzLB7ODLr7wt52ic
	hNsUc5C12VZwt32YINZh79qoC/k4s0CyU9rVzQVv5irb21JOuk0w+1nNQC/ttog5zq51NJL/
	QneztfWtm0EC5gRbMLJEuS3emHn9cYh2h7LMEs326H/9v8KXbauyEQWYSId51GBiebw6TipX
	BAfIUuPlKQE3E+IM2MZzK++tXTZhi9YoM8bwMYmnyCQMlIlJqVqVGmfGWD4u8RF1TAfIxKIY
	aepdTpkQrUxWcCoztpNPSHaIjjnvxIiZWGkSd4vjEjnlVpfHF/ilYb6nVkxP1YetKVnR/dfU
	9kIRUzSdNtn5zXDD1Nv2qWi2k4zMKptPn2EKvcLX1vflj6nWw8/pvcpvP/CpO7NnpvXKYvSB
	YovAQxlU1mylfxtiu4Nc2i7e6YzqUO3JudDUiQsV27wPhZgvRqGQmYz695LcP5HLEeM2gcYY
	kZM5eFZCqGTSIH9cqZL+BUzjIB7YAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRgG8P47l83R4LSsTgpFg9BJbmmaL2QlSHkoij4EhuBl6aEt56XN
	ayRoDiyvs0WITZxIOqewmPcStTlvaGaaYmreFYkwr8sblCv69uN9Hp4vLw8TGnEXniI2gVXF
	ypQiko/zb1/K9Jz8LpWfH/+Mg95cQ0L1dgpUzjQRoDc1INjcmeDChq2bhPIyOwb6Txoctsy7
	GCx2zXFhumIJh5asRgzmCnpIyNPsYfC0yciBjpJeAgYb8gl4ufsGg8b0GS4Mv9OTMFXzm4Al
	ax4OvcVVOEznB0CX4TjY+34gsJkbOWDPLSFBN2QgYV4zjWCoYw6H1xn5CMytYwTsbevJABFT
	V/WVwzQXf+MyBksiU2v0YLLHhjDGYnpOMpb1F1xmcrSFZHqK9nCmuWmDw+RlrpDM2uI4zvxs
	HSGZ8uVVDmOuG8GZfoONe+dICN8/ilUqkliV9EoEX74wm4vFdzinvCrSEelokMpGTjya8qFz
	dHbcYZJyo8fGdjCHnSkvemOu++DO52HUCkEv6vc4juAoFUoPtJYRDuPUWVo3OsB1WED50vud
	DcS/0dN09dv2v0NO1EVaO7VFOiw86Lz/Ms7VIr4BHTIhZ0VsUoxMofSVqKPlqbGKFElkXIwF
	HfyvIm2/sAltDgdZEcVDosMC9xipXEjIktSpMVZE8zCRs6BzSSIXCqJkqY9ZVVy4KlHJqq3I
	lYeLTghuBLMRQuqBLIGNZtl4VvU/5fCcXNKR37p3V+DlIrF9Xd2eNVw7v3LqZPDN4g/iqYX7
	feGeIXZX6a17q5XJNTMXUszoWFvykx5/iWb/Y477w5XmRwHaNBt71XTGDynzw8TSfg9tqHSt
	9PpsWGnWL2NorUX8rL4vw++cj0ZSP7tc6qOvrQ8rKJzwDnLxawt0K7i77Rl5TYSr5TIvD0yl
	lv0BG79mfbsCAAA=
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
 net/core/page_pool.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 147cefe7a031..cec126e85eff 100644
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
+					   pool->alloc.cache);
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
@@ -595,7 +595,8 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 		netmem = 0;
 	}
 
-	/* When page just alloc'ed is should/must have refcnt 1. */
+	/* When a netmem has been just allocated, it should/must have
+	 * refcnt 1. */
 	return netmem;
 }
 
-- 
2.17.1


