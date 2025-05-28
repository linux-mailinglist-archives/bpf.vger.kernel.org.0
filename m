Return-Path: <bpf+bounces-59059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28971AC5F5E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5658C9E1EBD
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699811E9919;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CFFC0E;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=r4Y9ELfoB55lQadNrKijYSL5XLX3PIx0ZS9vstCsycSI86bbpyMb+aVzhU1eIr6wxPVS7AuPJK5sWazivf9lIsdngslNBsOidKdTUoRjvD5gG87ZtoEQjiSNkseoQ/8yKYQXmxwbAJLy9SvhRL1NLUty98QZoJTUOCknSsQWKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=DCYoi6bM4o8LyOO6369/o6CJ3l42lAvqjlZ5kAUWyqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=En1e53Vs5Zvz5ni4TXqgC3N74F3V/x2Sjc6yuklGURJNwexqYyhzr7ycfc/5PpazJG6yDmw1Y+BePJ1iugmv3ewrYOHe52KAcvSDmNybjHcvgi8XDlVE9zJFixt1A2P0fHz1BVBaX4HBsPaB2GxpW3cFQiWlOjfolIYMsVKHg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-36-683675010d40
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
Subject: [PATCH v2 03/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
Date: Wed, 28 May 2025 11:28:58 +0900
Message-Id: <20250528022911.73453-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnXO2Wp2m1clCadGFLuaixht0A4P+HwqC6ktROfTUhnPK
	5mUTglmLaDVb6oe0FbPrUmOyzBsmNbdKFLNFsspUVorIVHS5tHWd1bcfz/u8z/vAyxDSdjKR
	UWvzeJ1WqZFRYlI8Nr9qE8pXqFJv3koFu6uWgpoZA9wfbBKCvboBwZfZDzSEvS8ouF0VIcD+
	ykzCtOsbAUPPgzQM3BsmofVCIwHBKy8psJqjBJxtcgqgp6FECOXf7hLQaBqk4U2LnYL+2l9C
	GPZYSeiofEDCQMkeeO5YApHOEAKvq1EAkcs3KCjzOyj4ZB5A4G8PknC9uASBqy0ghOiMndqz
	Etc/eCfAzZUfaexw5+NHzvXYEvAT2F19kcLuqVIa9/W2UvjltSiJm5vCAmw9N07hyaH3JJ5o
	e0thV/1bEnc5vDQOu5MOskfFOzJ5jbqA123elS5W9c+0olzzIkO9s5QyIdsCC2IYjt3KmXoF
	FiSaw6j3qzDGFLuWCwRmiRgnsHIuHHxBWpCYIdhxITdkj84txLPpXO9A95yJZFdzY3e8ZIwl
	7DbOVvmE+BuazNXUPSVit0SsgvP1ZcRk6R/LxCUXimVy7CzNdYyV/SuxjHvmDJA2JHGguGok
	VWsLspVqzdYUlVGrNqRk5GS70Z/X3jvz/VgTmuo55EEsg2TzJbhum0oqVBbojdkexDGELEFy
	drdCJZVkKo1FvC7npC5fw+s9aDlDypZKtkQKM6XsaWUen8Xzubzu/1TAiBJNaFUowb4vLZDc
	dyCkX9xvW+e7GPQt3F3TIi4+8ZmaPCL7fmK4dIW13f3lzWjSVfrg8f4KH60UPVa/ztr4bsHD
	W6w8Ma4s73BF8/55l+/q5Ybk01NLO0Pn0wp/dEz4R47tXHSq4eea0vjuikPde4tGwhsG5dkK
	Y7khaXu8f2Yadd0ZlZF6lVK+ntDplb8Bdc03PNYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG++9cdjy0Ok7Jg0HS7AKVVtjWD7p+yn9W0odIiC4uPbTlnLFN
	0SIwG0Sr2dIUsQmrWV6yJnO5WVaiywtFheFatbJmVkQXTV3WKnNF3x7e9+H98jKEtI6MZ9Ra
	g6DTKjUymiXZ9DXHk1C+QrWitSIRrI4mGq5MFkLdKw8F1sZWBOPfn4thzNtDg/1CiADrQyMJ
	E44fBAx3B8UwePktCe0n3AQEz/TSYDaGCSjx1Iugq6aPgketpRSc+3GJAHfxKzE8vmGl4WXT
	FAVvO80k9FU3kDBYuhG6bXMgdO8jAq/DLYLQ6RoayvttNAwZBxH0dwVJOH+sFIHjtp+C8KSV
	3ijDroanItxW/UKMbc583FK/BJv8/QR2Np6ksfNrmRgHfO007q0Kk7jNMybC5uOfaTw6/IzE
	X24P0Nj+fkSEHa4BEt+3ecXbo3exa7MFjbpA0C1fn8mqXk62o0PG6EJXfRldjCyzTCiK4blV
	fNj7jYowzS3m/f7vRIRjuZX8WLCHNCGWIbjPFD9sDYsiRQyXyfsGH/yVSG4h/6nWS0ZYwsl5
	S/Ut4t9oAn+luWOaGSaKU/B3A1mRWDqtfDnlQBbE2tCMRhSr1hbkKtUaebI+R1WkVRcmZ+Xl
	OtH0fZeP/jzrQeOPUzsRxyDZTAlulquklLJAX5TbiXiGkMVKSjYoVFJJtrLosKDL26fL1wj6
	TjSXIWVxkrQMIVPKHVAahBxBOCTo/rciJiq+GNkpRduC+fJ815qKI1UpVw+axE9kfkulL/Hd
	hpu/7IvWza5aqlu9tbcww61d67SPxEff0XxoKd+EdqTM6zLGbN61bWdor3nVlv0f0hPuRwX5
	/aMPfhvi9vzKQKbKuU2XAjlHpmb6UpO2vekIGLIqVtQOLVu2m70ombj2WpvOpuXZr8tIvUq5
	cgmh0yv/ACjZQm66AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use netmem alloc/put APIs instead of page alloc/put APIs and make it
return netmem_ref instead of struct page * in
__page_pool_alloc_page_order().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 974f3eef2efa..e101c39d65c7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,29 +518,29 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
-						 gfp_t gfp)
+static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
+					       gfp_t gfp)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	gfp |= __GFP_COMP;
-	page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
-	if (unlikely(!page))
-		return NULL;
+	netmem = alloc_netmems_node(pool->p.nid, gfp, pool->p.order);
+	if (unlikely(!netmem))
+		return 0;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
-		put_page(page);
-		return NULL;
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
+		put_netmem(netmem);
+		return 0;
 	}
 
 	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page_to_netmem(page));
+	page_pool_set_pp_info(pool, netmem);
 
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, page_to_netmem(page),
+	trace_page_pool_state_hold(pool, netmem,
 				   pool->pages_state_hold_cnt);
-	return page;
+	return netmem;
 }
 
 /* slow path */
@@ -555,7 +555,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
+		return __page_pool_alloc_page_order(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


