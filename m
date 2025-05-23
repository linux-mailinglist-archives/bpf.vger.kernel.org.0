Return-Path: <bpf+bounces-58807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E2AC1A96
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC177B1C47
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54467270ECB;
	Fri, 23 May 2025 03:26:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174DF222578;
	Fri, 23 May 2025 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970789; cv=none; b=VR1efZmlT6ERmfYnTDey6Sc3NYOOY7ydtSz/cHOZsHNQ1dPoRVI4VkP4sriBl7EbC8OWeyS+Wfej7URr2xqZrlA3GYvQ2skis2caZ2oT/IQqzYiRWIEL3HcCg0RsR0jtwg04P4pi9Sl9Nc9smDW4coEhcQddH4D/CPL6JnsyDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970789; c=relaxed/simple;
	bh=JwC5FopaTIpoUXDYp0ofYPsRLafHFGG+4lEMajJog5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Uu09TpAK6hI7aRf6AxOh7qBrl+wuNsX911mLbUZ/wmE3SEy+iBBlhFnp3zLomiY1LkqNbWYFCi4LyyevH5Nq7msanoOgf5Dy+7zYRKOXQz/1Lf5vZ7Jmsg8V2bkrnOawwNZqmD3Yqz+spi7PwJ5D/Apy4yyJdovZ/k57dFC4dJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c5-682feadc1c29
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
Subject: [PATCH 09/18] page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
Date: Fri, 23 May 2025 12:26:00 +0900
Message-Id: <20250523032609.16334-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRWUwTYRSF/TvTmaFhwqQSHdGIVo2BIIsBvQ/E8OZIfJCIslTABkbbsFoW
	wahBwShIgQBBgZIUkcrSpKQiFK1ECrJERWSzIlsw8OACEWhlEZVCfPty7jnfy6UwcQfuQikS
	UnhlgixOQohw0Q/HR0fGvnrJvYd1rqDW6whoWE6HJ1NGIajrmxEsrXwmYbGzm4DqKhsG6vfZ
	OFj1qxjMdE2TMKmdxcF0twWD6YIeAlTZaxjcNtYKoL85XwglqzUYtGROkTD4XE3AhO6vEGbN
	Khx6y+twmMwPgC7NDrC9+Y6gU98iAFteJQHFAxoCvmRPIhjomMah4lY+An2bRQhry2oiYD/X
	VPdJwLWWj5OcxpDKPa1153ItAxhnqM8hOMNCEcmNjZgIrufhGs61GhcFnCprjuB+zozi3Hzb
	MMHpm4Zx7q2mk+QWDXvPMOEi/xg+TpHGK71OXBTJB4ztWNI9Jn2uIIvMRKV0LqIolvFlVb+O
	5yKHTcxp/iCwM8EcZi2WFczOzowPuzjdjeciEYUxc0J2Rr22WdrOSNmy+m+4nXHmEGvSagm7
	k2aOsapa/y2nK9vQ+GrT47ARF05YCTuLGT/2xdAoaXeyjJVkVSoL2hrsYttrLXghojVoWz0S
	KxLS4mWKOF9PeUaCIt0zOjHegDZeq73xW2pEC/1nzYihkMSRNoq85GKhLC05I96MWAqTONOv
	Zz3lYjpGlnGNVyZGKVPj+GQz2k3hkp30UdvVGDFzWZbCx/J8Eq/8fxVQDi6ZiLgQVXnnpcm7
	75QgJ881dj2oO8DjpDZw1BAxWFR16eP6yuy+6hU+mHEqPB/Nu+neHXQqGaug9lD9PaPWyOD7
	S36BYdKom5EHHCbC50/HYGNZsREhbeOWELqo2Jox99jJQ/rMjVyq6R3pe/CHHiq9EnruelDo
	jCmsqgwl2hq9oiV4slzm444pk2X/ABimipjWAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnR1Hg+McdrAPxkpMoZmQ9cus/BD0rygkSEE/5MhDG17Z
	1DQwLA0v5SUtKZu2FOe8MVuySw6taV5Q0Waad8XQpMLKG+q6qdG3h/d9eb68NCGuJj1oZVwi
	p4qTx0gpISm8dCLj0MRnP8Vha6sYNIZ6CurWU6B6xsIHTa0JwcrGuACW2zspqHy+RoCmP5OE
	VcMmAXMdswKY1s2TYMsyEzBb0EVBXqaTgDsWPQ/ayrr5MGDK58PDzSoCzOkzAhh8paFgqv4P
	H+bteSR0l9aQMJ0fDB1ad1jr+Yqg3WDmwdr9MgqKHVoKPmZOI3C0zZLw9HY+AkPLCB+c6xoq
	WIqbakZ52Fo6KcBaYxJ+qffFuSMOAhtrcyhsXCoS4IlhG4W7HjtJbLUs83BexiKFf8yNkfhb
	yxCFKxe+87ChaYjEvdp2QYhruDAoiotRJnMqv1ORQoXD8oZIyGZSFgsyBOmoRJSLXGiWOcLm
	mN7xtplivNmRkQ1imyWMP7s820nmIiFNMIt8dk7j3Bm5MRHsk9ov5DaTjBdr0+moXETTIuYo
	m6cP+uf0ZOsaX+94XLbiwqlVapvFTADb/H5MUIiEWrSrFkmUccmxcmVMgEwdrUiNU6bIrsXH
	GtHWfbq0nw8saGXwrB0xNJLuFh2M9VOI+fJkdWqsHbE0IZWI3s7LFGJRlDz1JqeKv6pKiuHU
	drSXJqV7ROfDuEgxc12eyEVzXAKn+t/yaBePdJR2uevWL+J4xMmJewkGu2fYjXN9IQ19tgXj
	PltUyQsTtoZzPYFX7jYOV7v+rno0GrBQbyat4pLQSc8wRUOfW4Xe3TunXxgm82jZnzZgS6nU
	Nj/zadVV+Jwpaq1LcnhdMEefXqfGl5IkF/XKwOZjzvIPrlmh2YO9nw6UF0vqpnqkpFoh9/cl
	VGr5X7RkK5u6AgAA
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
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fd71198afd8b..01b5f6e65216 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -789,7 +789,7 @@ static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
  * subsystem.
  */
 static __always_inline netmem_ref
-__page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
+__page_pool_put_netmem(struct page_pool *pool, netmem_ref netmem,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
 	lockdep_assert_no_hardirq();
@@ -849,7 +849,7 @@ static bool page_pool_napi_local(const struct page_pool *pool)
 	/* Allow direct recycle if we have reasons to believe that we are
 	 * in the same context as the consumer would run, so there's
 	 * no possible race.
-	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * __page_pool_put_netmem() makes sure we're not in hardirq context
 	 * and interrupts are enabled prior to accessing the cache.
 	 */
 	cpuid = smp_processor_id();
@@ -868,7 +868,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 		allow_direct = page_pool_napi_local(pool);
 
 	netmem =
-		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
+		__page_pool_put_netmem(pool, netmem, dma_sync_size, allow_direct);
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
@@ -969,7 +969,7 @@ void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 				continue;
 			}
 
-			netmem = __page_pool_put_page(pool, netmem, -1,
+			netmem = __page_pool_put_netmem(pool, netmem, -1,
 						      allow_direct);
 			/* Approved for bulk recycling in ptr_ring cache */
 			if (netmem)
-- 
2.17.1


