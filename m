Return-Path: <bpf+bounces-59611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74BFACD5DB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB80B1899BF7
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E5226D0D;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A61F9F70;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005590; cv=none; b=Qpkak8PUCZmm+2xKdhig3K1c8IIPDOZyP49uABQL7oDw1fPEpCQj4Yye5VNfLFhz47bv1LRQP7dD3Ub3GJjMUZ4DRVcWW7+6sh2bUfJvgrbvmTMlV/BDoasAOsDnYQiG4lqHWsf5dG0KPDj84xDCQEaJGn5mZtAozYiB22kXbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005590; c=relaxed/simple;
	bh=9wfY+yvRgQnruPB/Le46bQg63025QDIHYWA1g7RBE6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j18ny/jhQFQlKGiT5gCEvhH/Cxehp/SIAWfbsa8zI71TZQf5FZZ7zNWdf3je+4CoM9jr0bj81RxtvPhOLMEKKMAARatTTdLHSWuxb2vUC5hPOlMJQHPxtz+NlOwF3j++ozXlK+e/XgDeR3TNQUyxo4+5gY7eTV2iPOYf+5NxCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-14-683fb5093870
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
Subject: [RFC v4 09/18] page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
Date: Wed,  4 Jun 2025 11:52:37 +0900
Message-Id: <20250604025246.61616-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/Z9zds5xOTktqdOCpFFZgpZl8v8QUxDilJVRQZRCLXdywzll
	U9MiMJUycTNKKGzBMjKd1mpeNi9YeY/yks6ad5k4M3KWyzUvYU7x2+99Hp7fl5dE+a2YgJQp
	UlilQiwX4lyMO+NTHMStDpcenO7jQK2hAofl7nT4cty8eulrAPyzMERAZ0s7Dp8/c6FQ252D
	wXnDIgon22wEHCuxY7DhrgmFtoIOHKpzllCYZS5FYE+NhgMLF1+g0JQ5TsC+Oi0ORytWONDe
	pMbgx6IyDI5pImCbbit0ffoJYIvBhEBX/lMcPuzV4XAiZwzA3mYbBp/c1gBoaLRy4JJbi0fs
	YqrKBhCmtmiEYHTGVKayNJDJs/aijFF/D2eMcw8IZvhrA850PF7CmFqzE2HU2Q6c+T05iDGz
	jf04Y6jqx5jPuhaCcRp3nqEucY9KWLksjVUeEF3hSls6C/Bk++b0giETkgnqfPOAN0lToXRh
	VwO6wcZ/o7iHcSqAtloX1nI/KoR22tqxPMAlUcrBoSe1S4in2ELF0j96XxEexqg99F/NBPAw
	jwqjWwtaiXWpP13+5v2ayHs1H3Y8WtvyqSO02mxBPVKaWiDoxrcOzvpgO/2h1IrdBzwd8NID
	vkyRliiWyUODpRkKWXpwXFKiEaw+t+TWcowZzPWcawIUCYQ+PPOwSMrniNNUGYlNgCZRoR/P
	f/9qxJOIM26wyqTLylQ5q2oCO0hMuI13yHVdwqfixSlsAssms8qNFiG9BZkg8MQxdVym6Gz8
	Qsa1SS9HfVzdxMVTtQkXTvsOrtxpjypOcAVlN0ceD+9wu/XTPHzlaiDyrdurNssVNhMtskRL
	Imdz3+W3jkTVL+4VBJw8rN09bon1iVH96rS3T00lfj+Pal7f7BqotiV0bPpiQ3P3SQXL8nqt
	xi6xzDuHKgvDhJhKKg4JRJUq8X8dtS6g2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++c/XfJxXGKnQwxBmZJzoSUXxfN6kOnPliEEGiko53adE7b
	VFQQLU1LcmrZBZs0M81bTKbpFJGad8qKqeEtZzMlulipmZfKnNG3h+flfb+8fEJcSbrzleoE
	VqOWqSRYSApD92f6Cp4cVOy+XREAemMthprFZHg0YeaCvroRwfzSKA/mOroxlJUuEKB/lUXC
	D+MyAVNddh7YKqZJaM1pIsCe34MhL2uFgMvmSg60l/Ry4XWjjgtFy+UENGVM8KC/RY9hvHaV
	C9OWPBJ6i6tIsOlCoMvgBgvPPyPoMDZxYOF6CYabVgOGySwbAmu7nYR7l3QIjG1DXFhZ1OMQ
	CdNQNcxhmovf8hiDKZGpr/RhcoesBGOqvoYZ0+wNHjP2phUzPXdXSKbZPMdh8jJnMPN9aoRk
	vrYNYqbswzcOY2wYJJkXhg7eSedw4QE5q1ImsRq/4CihoqMvH8dPOyfnjzZxMlDLplwk4NPU
	Htr0exw7GFPe9NDQEuFgV8qfnrN3k7lIyCeoGS49pV/hOAIX6gz90fqY52CS8qJ/6iaRg0VU
	IN2Z38n7N+pJ19Q9XR8SrPmxmTvrXTEVQOeZB4gCJDSgDdXIValOipUpVQFSbYwiRa1Mlp6L
	izWhtf8q0n4VmtF8/1ELovhI4iQyjwUrxFxZkjYl1oJoPiFxFXnuXFMiuSwlldXERWoSVazW
	grbySclm0fHTbJSYuiBLYGNYNp7V/E85fIF7Brr6qXxU4abDw4E5GUFVilZr/X1Z2r5ZMvqs
	32zRCemfMI9jV+TbT2miH4gLF7sk0yPW9AKLYUt2auHAl9KI8HK3uslEr9yHiiJxceOhyCOD
	KX3e8o06X8Ph7H5s29uyK/28EUcsODWHvl8NansZ6N5/y+PZoHxbmDThosu7HX5SCalVyPx9
	CI1W9hcRWZbBuwIAAA==
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
 net/core/page_pool.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c31a35621b24..0d6a72a71745 100644
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
@@ -868,8 +868,8 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (!allow_direct)
 		allow_direct = page_pool_napi_local(pool);
 
-	netmem = __page_pool_put_page(pool, netmem, dma_sync_size,
-				      allow_direct);
+	netmem = __page_pool_put_netmem(pool, netmem, dma_sync_size,
+					allow_direct);
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


