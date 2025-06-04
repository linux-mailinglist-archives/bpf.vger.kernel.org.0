Return-Path: <bpf+bounces-59616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44419ACD5EC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1083A36A8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA92367BA;
	Wed,  4 Jun 2025 02:53:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43529213E99;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005591; cv=none; b=YRmHYyQv9PH1EMTHygq/GEnrDY4YzpkR0K+axwXT8b+WzIdO6+BhfTU7HJwPa45CSVRDIIKyllAMyotJX11J3/+YX5Cb/AdPUSFmOj5ASVJumFnpGkTsCSKp8BPBcl0gnaFU7PzEiQgSZojVeYL3Fc1MoUyff3Bey7xmxx/VJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005591; c=relaxed/simple;
	bh=bDBHZjOpbvhy8/zaXp1kYTGzbPYY5yxDct9yZpIItP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HzDc9LHkPWwTl6vHNwuUZvUoWDSf6hWBvc5Hkzx9SHQPKy6NXsdItOe8he9XOYBeDI+2/X2z4RBjKE20ZNV/plEYFpgJaRcGWpQdo5g8OhL5uFw/BsQFRqWQFvfHipKWUCCVNX/RM7xX9LJt4V7seMyx3xY2HqjrUCVck0LoU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d8-683fb509aa61
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
Subject: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
Date: Wed,  4 Jun 2025 11:52:31 +0900
Message-Id: <20250604025246.61616-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRe0hTcRQH8H67d/fO4eK2tG4KWgPJDDVD60hmSwl+SaLUP1FQjby4kU6b
	jzQQVgmV5hKfZRMmPtJpzKa5GaJpvrIwtcyZ84HiiEpDzeEjMGf534fzPedw4AgIcRfpJlAo
	kzmVUhYnoYSkcM65zNfp1Sn5kZflh0FrqKOgdiUNnk+Z+aDVNyH4vTpGw1JnDwXlZXYCtB8z
	SVg2rBEw2z1Nw2SVjYSW+yYCph/3UpCTuU7AXXM1DwaaNHwoWKskwKSeouHTay0FE3UbfLB1
	5JDwrqSGhEmNFLp1e8D+/ieCToOJB/ZHpRTkD+komMmcRDD0dpqEZ3c0CAytFj6sr2gp6QHc
	WDPKw80l4zTWGVNwQ7UPzrIMEdiof0hh42Ieja1fWijc+2SdxM3mJR7OuTdP4YXZryT+1TpM
	YUPjMIk/6DppvGT0iGYuCUNiuDhFKqfyD70mlGePmehE8660yeJ8pEZtO7OQk4BlAtkHLyrQ
	tkea7JTDFHOQtVhWCYddmAB2abqHzEJCAcHM89lZ7TrPEexmrrCVDcV8h0nGi83SVNMOi5gg
	ti57gvi31JOtrX+zZSfmGGudL96aFW/25Jg/E46lLLNMs0Ultv9X7GPbqy1kLhLp0A49EiuU
	qfEyRVygnzxdqUjzu54Qb0Sbz63K+HPZjBYHLnQgRoAkziKzNVQu5stSk9LjOxArICQuIs9D
	myVRjCz9NqdKuKpKieOSOpC7gJTsFR2134oRM7GyZO4GxyVyqu2UJ3ByU6PI5JnzHmVRZwc3
	lH1zUmlgRuyq637f4HBWWoeLrHx1RXRp/E00qOkKyz1DF/BaT7Z7nXMNNfRH6oNcv4XrJ0YV
	3wv8o3wKawsLRtrGK7tPeyqnuDxthNDdVBblcfxEf+Rwn1BMX7T5tXMRT8MSvQ2rCy31CZaQ
	OW8xE/xDLSGT5LIAH0KVJPsLqlZ3Q9gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRe0hTcRQH8H733t3dLRfXJXWxQFpIKGQZKkcKk4L6EZFBQSiUDr254aa2
	qagR+IpI3fKZYRMWos0HLOZrPlCZ4qOCSrM0HzNLSTStpktdUc7ovw/n+z3nn8OQUhPlzSgT
	U3hNolwlo8WU+NLJ3KOiltOK4+tbB8FgbqShYSMdns5aBWCob0WwtjkpBEf/IA3VT5wkGF7l
	UbBu3iJhfmBOCPbaBQq67rWRMPdgiAZdnouEHKuJgL6qYQG8btULoGyrhoS2rFkhjHYYaJhp
	/COABZuOguHKOgrs+nAYMO4D54tlBP3mNgKchVU0lI4YafiUZ0cw0jdHweNsPQJz97gAXBsG
	OlyGm+smCNxeOS3ERksqbjL54/zxERJb6u/T2PKjRIin3nXReOiRi8LtVgeBdbkrNP4+/4HC
	q91jNK7+8o3A5uYxCr809gsve0aJT8XxKmUarzkWFiNWFEy2CZOtnun2ilKUhXr25CMRw7FB
	3PtWJ+02zR7hxsc3Sbe92EDOMTdI5SMxQ7IrAm7e4CLcwV72BlfTVCFwm2J9uXy9Sei2hA3m
	GgtmyH9HfbiGZ707FrEh3NRKxc6udLujs74li5DYiHbVIy9lYpparlQFB2gTFBmJyvSA2CS1
	BW3/r/bOr2IrWhs9b0Msg2QeEutUmEIqkKdpM9Q2xDGkzEvi47c9ksTJMzJ5TVK0JlXFa23o
	AEPJ9ksuXONjpGy8PIVP4PlkXvM/JRiRdxYyZ8dEFpR3Xik8sVawaJqOWHWWMXjzuZ5AdYdC
	ou3Or6nR17M646KkZzNLWpKXc36nFfmKrsZPeN2WpcSO+N0q1C3mXvR4qK4N7QiaGVtS33U0
	WCKJ0MO9H32JnHLTmZvV5Yo3lY6WSjYuOyJ4qbn4826WG/o5FnMusrvHb9Ulo7QKeaA/qdHK
	/wIbDSeIuwIAAA==
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
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4011eb305cee..523354f2db1c 100644
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


