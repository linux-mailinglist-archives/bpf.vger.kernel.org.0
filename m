Return-Path: <bpf+bounces-59063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35FAC5F6F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466A1188D26B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BCE1FECB1;
	Wed, 28 May 2025 02:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF51C8610;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=BS0GxFV8t+G8ssT/TRiO85mFgaPv5DEBceKHESed1XLW+1UCzJWX6OIszUvaAxqWcgRsUXXQFzSpMJj75HyCnx3WPy6jws7gP/j7X+iEXtIJrrUNs7hjEJpL1bIDpdtOY16rlh0IbcOCFLp/VdwMju+qZsqYOSbmJoVI6LBV0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=i27tFTY0lH/hxDO4wmBD49b1/x+j/A0fSvF5088tNAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mYr12h92fAWlrK/OsmlChmrpvqdz9gJjDKx1REdVmD9ac55aIobVFe3fO50dGw85OlAmJNXnbxpkVKdRQKL5we1uaUHnce8a+dIkqxyHK3nmiJPciEHGKO8kMD6qxgwTagHpvoGXAyw4U4RcmyZjjVtBt0fStdXnKOVIS3b8jpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-55-683675014831
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
Subject: [PATCH v2 06/16] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Wed, 28 May 2025 11:29:01 +0900
Message-Id: <20250528022911.73453-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGfXfOzjkOR6cleVqQtAhD8n7pBc38Ur4f+iBEEYbo0EMb6ZRN
	lwaFNwrNmVmk2aqJl+ZUji3zhojN5aULyrywzBuL2QdNzcu8rDKn+O3H//n9ny8PhYl6cTEl
	V2SwSoU0RUIIcMEvjyo/Xma4LHB0HYNarpGADZtZ8M1sOx9qDa0Arm19J+GquZ+A1VWOXWOo
	AIfr3DYG7X02Es7UzeGw60EbBm2PBgioKXBiMK9dz4PDrSV8+HS7FoNtObMkHOnUEnC6cYcP
	50waHA5W1uNwpiQa9umOQsfnBQDNXBsPOopfEvCJRUfAHwUzAFp6bTh8kVsCINdt5UPnppaI
	Pola6r/xUEflFIl0xkz0Tu+LiqwWDBkNhQQyrpSRaHK8i0ADFU4cdbSv8pAmf5FAv+0TOFrq
	HiMQ1zKGoy86M4lWjSdi6ThBZDKbIlezyoCoRIGsvHaTTOe8s+xfl/EcoBEXAXeKoUOZocn7
	vAOuKRwhXUzQPozVuoW52JMOYlZt/XgREFAYvchn7Frn3sMROpH5pP/HLwIUhdOnmYmFJNdZ
	SIcxY6N1xH6nN9PQ3IO5FHc6nPk4uaeIdpWlhxxwVTL0FsmYG/Oxff8Y80FvxUuBUAfcDEAk
	V6hTpfKUUH9ZtkKe5Z+UlmoEu9PW3f1zox2sDF8xAZoCEg8hag6TifhStSo71QQYCpN4CvMu
	hMtEwmRp9h1WmZagzExhVSZwnMIlXsJgx+1kEX1TmsHeYtl0VnmQ8ih3cQ5IdHZ4Udb3Y2Aw
	SlthPlcYea9JsGDz97pODkvN8x3i5hDV9ERxdabeMbGR3zo+bCn/6ZgnDfbchOz4uuXL7EV1
	+aXYpZC/a89ONXUm9jdNjdpqvF41GntAvqMsUHO1JXjnbUSA+5lrr89GzKb5yUo3fLj4uPOH
	fWPcHnMxzw9JcJVMGuSLKVXS/23RqJbWAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfSzUcRzH+97v4X6ujl/XrX6x2G61NiulxT4mZavNd2VWMlmPbvzmLufY
	HfKwNmEVouiB6WwnD3mqkwxXpoYcyRRpR0IatTIPkR2nB1frv/fer9fe/7wZQlJOOjJKdSyv
	UctVMlpEigK803aiOE/F7oJve0BnqKGh2pIA98eaKNBVNSBYWHovhPl2Ew0lxYsE6HrTSfhh
	WCZgomNcCKPlkyQ0X2kkYPx6Jw3Z6VYCUpsqBNBW1EXB64YcCm4tlxHQmDImhP4nOhpGan5T
	MNmaTUJXYSUJozm+0KHfCIvdUwjaDY0CWLxWRMPNPj0Nn9JHEfS1jZNw91IOAkOLmQKrRUf7
	ynB95aAAGws/CLG+Lg4/rnDFmeY+AtdVZdC47nueEA+/a6ZxZ4GVxMameQHOTpum8dzEEIln
	WgZoXPJlVoAN9QMkfqVvFx5df1K0L5xXKeN5za79oSJFfplFGGNwSZjomSVTULZjJrJjOHYv
	V5rRL7Rlmt3Omc1LhC1LWXduftxEZiIRQ7DTFDehswpsYAMbyr2s+EVlIoYh2W3c0FSYrRaz
	HtzA23L636YLV137nLApdqwn92L4ryJZVWayDOgGEunRmiokVarjo+RKlYebNlKRqFYmuIVF
	R9Wh1ffKL67kNqGFfr9WxDJItk6Maz0UEkoer02MakUcQ8ik4tQDngqJOFyemMRros9p4lS8
	thU5MaRsk/jwCT5UwkbIY/lIno/hNf+pgLFzTEGXgzh/p5KnZ0/JPrZvmesNfGS+N2gfUhuo
	Ng57mUSlEQ6HrMF0Q7dXnjnDRZp89XZyFuXTf+T4V2eTQ5S4KP6CV3DpWjdzj2nE2/ym/tmK
	Jcunu1j7OWjH75IzcfYBFXe4kEbn3N5jW5tTxJvPh0s1D/1MP42Uyv9gUldg/oP00zJSq5C7
	uxIarfwP9D+8QbkCAAA=
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
index 0313609abc53..8d52363f37cc 100644
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


