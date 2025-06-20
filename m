Return-Path: <bpf+bounces-61148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5BAE122E
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF045A3199
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD018212D8A;
	Fri, 20 Jun 2025 04:12:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF361E5207;
	Fri, 20 Jun 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392759; cv=none; b=XBsmqwHYGsdo5rxX4C7k6icFOcWXhZKRJ5ddi3wk0n/Cf1z4qxiSHST+GV7IAEw7Y219oijB/XDPjE0YOaUGV7baJ//CrRC0D6E1IXCV0EVBwRfGwxznZscNcsEILA5as7uKZCCyAth5b7edI5tyXiqZ/ZFPqdFZLJ1wCTRty4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392759; c=relaxed/simple;
	bh=lOki3YqzQcqtkTJ9eJR3BxnlQIiozzo5ussGGYz6FQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqySFM3bmm/Fh4Ej3It3MZ92gGP5dzER1Oz1dHGMQQjjY+TThaCdxPJUIMBBi2lJGa6WAvl+cdjI4+Eeu8cnQM7npd5K42/jm+CYPaaX8Uq4ULfG+FuPj/aPdztUhSYeEFrU3WSljGNCrjw66qtF+5e11qs+b+nsR+pNWa+xUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5e-6854dfb2dd29
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v6 2/9] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Fri, 20 Jun 2025 13:12:17 +0900
Message-Id: <20250620041224.46646-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250620041224.46646-1-byungchul@sk.com>
References: <20250620041224.46646-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++/8d85xtDguqWMXwqGYdjW03qBEkOiElKF9KaMaenCjeWHe
	g8JSuoxcV0jnrFnkbcpieZmmlmuZouElqtlFZakQeCG1NZ1Q2yTy28Pzvr/neT+8NCEpEW6g
	FamZvCpVppSSIiyaWl2+wzRyQr77rjkMdMZaEgzOXKgcNQtBV9OIYH7hCwVz1rckPCl3EKDr
	K8Twy7hIwHinnQKD6SiMVExgaL3WRID9VhcJRYUuAtoWpim4Yq4SQH+jRgj3F58S0JQ/SsH7
	Fh0Jw7V/hDBhKcLQra3GMKKJgk79OnD0TCKwGpsE4LhZRsK9QT0J3wtHEAy+tmMovaxBYGy3
	CcHldGeUvhmmogK515MzBFdfPSTgmrXfKE5vyuKeV4VyatsgwZlqbpCcafYuxX392EpyXcUu
	zDWb5wRcUcE0yf0c/4y5mfYPJGes/4C5Xr2VOu57SnQgiVcqsnnVrshzIvlS85QwvSggV6P/
	iPLRp41qRNMsE87ONgSpkY9X/r7TSXo0yQSzNtsC4dF+TBg7Z3+L1UhEE0wdyVprv1CewVom
	mS3t7fZqzASxlqt9XkDMRLBVdWVoOXQLa3j2yuv7MHvZn1deeAsk7h3n40Lh8r4v210yhj33
	EO5i40OJxybcaEFDKeHpZRkzzfZ0tlHLmf5sR5UN30aMdgWu/Y9rV+B6RNQgiSI1O0WmUIbv
	lOelKnJ3JqalmJD7YSouLiWY0Wx/vAUxNJKuFpvn4+USoSw7Iy/FgliakPqJn3Qdk0vESbK8
	C7wq7awqS8lnWNBGGkvXi/c4cpIkTLIskz/P8+m86t9UQPtsyEcPeweq1/QpDbUnBbHRCQMB
	U8HvouWfi+Mibmt2xe1/sJgWsv3UEWl0WuPLodnTkYaBvLmA7X1+cUtT1fMdO1Ydztm2LzbX
	5Yq5lOPc3DWjDupQ+o89s5LHUPwP/4JNjrYzj3wHDxYHJmTqWuxhlTjx0NbkyLGQ5MUYJ35c
	cn3iK5biDLksLJRQZcj+AhK/HpAsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9cdhwtjkvcwT5Iq4gGmkLGSxfpQ9ShKIJuFFgOPbbhvLCp
	aJC3LUtr60rUdDGVSqe2WqazzHTzmoahaStLbaUUeEmny8uiphH17eF5f8/zfHkpTOTFgyhF
	YgqnSpQpJaQAFxzYpgmxDh2Wh42/lECRpZKEirl0uD9sI6DIXINgZn6AD+7mNhJKiz0YFHVr
	cZi1LGAw0uriQ4V1PwzdG8Wh/nwtBq7L7STotIsYPJ+f4EOurYwHDmMHAa9r9ATcWLiLQW32
	MB96nxaRMFj5i4BRuw6HDkM5DkP6ndBqCgRP5xiCZkstDzyXjCRc7zGR8Fk7hKDH4cKhMEeP
	wNLgJGBxztdR2DLI37medYxNYmx1+TseW2f4yGdN1lT2cZmULXD2YKzVnE+y1ulrfPZDfz3J
	tt9axNk6m5vH6jQTJDs18h5nJxv6SLb063cea6nuww+KTgi2x3JKRRqn2hQZLZB768aJZN2a
	dL2pH2Wjt6sLkB/F0JuZH1dbySVN0hsYp3MeW9IBdDjjdrXhBUhAYXQVyTRXDvCXDqvo00xh
	V8eyxun1jD2vezkgpCOYsioj+lMazFQ8bFz2/egtzFTus+UBkY+ZK9ESf3h/puP2F98A5RvY
	wFjuiJZszBfVPCnEriCh4T/K8I8y/EeZEGZGAYrEtASZQhkRqo6XZyQq0kNjkhKsyPcT9856
	r9rQTO8eO6IpJFkhtM0ckosIWZo6I8GOGAqTBAhL2w/IRcJYWcYZTpV0SpWq5NR2tJrCJWLh
	3mNctIg+LUvh4jkumVP9vfIov6BsJBa/ChgNjtNkeRc8Yn1r5ixms3dpzZmRxpT6FMHPrNC4
	BP/yK0djzubeXFng+lZ33FMM0mrdudqSvkf5ngdRfXhT594LA1ubsletM6W9iJ6O8suT7zu8
	1jsluzixEBf4hijZ0S2lPrUYzD/duTnzIbMbd+12G8P8NZ0n1x5pdEhwtVwWLsVUatlvTOCk
	IA8DAAA=
X-CFilter-Loop: Reflected

Now that page_pool_return_page() is for returning netmem, not struct
page, rename it to page_pool_return_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/core/page_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ba7cf3e3c32f..3bf25e554f96 100644
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
@@ -712,7 +712,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
@@ -826,7 +826,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 
 	return 0;
 }
@@ -869,7 +869,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
@@ -912,7 +912,7 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	 * since put_page() with refcnt == 1 can be an expensive operation.
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, bulk[i]);
+		page_pool_return_netmem(pool, bulk[i]);
 }
 
 /**
@@ -995,7 +995,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 	return 0;
 }
 
@@ -1009,7 +1009,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1076,7 +1076,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1109,7 +1109,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
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


