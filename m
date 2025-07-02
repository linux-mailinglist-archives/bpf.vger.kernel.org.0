Return-Path: <bpf+bounces-62073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E70AF0AEE
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A141448013
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEB22331E;
	Wed,  2 Jul 2025 05:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852502063FD;
	Wed,  2 Jul 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435307; cv=none; b=Y/kl78T/EapRw2qkqZMC2nIMCBpd5Xs/4U/fG33nIzuujVfUYevidsu65V439UdmcmvUTUfpeTmc4DweXbN6Xn7mPogUS2GpjTrq1oHYRUbBAvMBYzm2kOwlkoiQivVoK1cIPTK1xQNJVf+lqV5M6v3zf1rd+B4npMPjvoHFIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435307; c=relaxed/simple;
	bh=BpEBqg0Tn6vBpZdUHkN0C1T/n1AoxJGZgoBMWrqDqIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGFhYnqY+votXgfGVV8vRgHHZdVAhi4gpA+u/gqJQy6lVAr3uj8wvR6nrM4enYDoP7OWfuzZPJ9SkUYMRDIzvNQi79V92vYwYvZq3LkdEcKcm34xxf4MWDigVaV91Nuv1ZxjV+PnCBvq+YHpTBB09hpGF6kOoVBmP0lO6ydEX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1e-6864c492e8bd
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
Subject: [PATCH net-next v8 3/5] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Wed,  2 Jul 2025 14:32:54 +0900
Message-Id: <20250702053256.4594-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250702053256.4594-1-byungchul@sk.com>
References: <20250702053256.4594-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRjF+e/e/e91NLstq5sVyaiEKMuyeope9EtdiqIyCHofemmrbcqm
	pr3QKiMTX0ItbFNZZaZTu7bKTSurOXVioGjWSp1iGUhmpCWZUW2K5LfDec75nS8PTchuigNp
	lTaO12kVajmWkJIv024vz3JGK1eWJ6+FPKEMQ+nPRLjXYxdDnqUSwffRDgqGnQ0Y7twaISCv
	OZmEH8IvAvrqeykote6E7qJPJDy9YiOgN9OFIT15jIBno4MUXLQXi6ClMkMMOb/uEmAz9FDQ
	Vp2HwVP2VwyfHOkkNBpLSOjOCId682wYaRpA4BRsIhhJy8eQ3WrG8CG5G0FrbS8JpgsZCIQa
	txjGfnoZpjoPFb6Iqx34SnCPSt6JuCpjF8WZrfHcw+KlXKq7leCslquYsw5lUVznm6eYc+WO
	kVyVfVjEpV8axNy3vvck97WmHXPCo3aSe2V2UrtnHJBsjObVqgRet2LzMYmyqCsgdkiSaC3p
	RwaU75eK/GiWCWMLOzvEk7riso3wacwEs2736LgOYELZ4d4GMhVJaIIpx6yzrIPyHWYy8ey7
	wmrs0ySzmP3TLyCflnpB9lIPnoAuZEsrXoyD/Jg1bE29a9yXeTMfUpx4Ij+Dbbz50TtAeweC
	WaFA5rMJb/XSYxPh22WZcpr1PBPICeZc9mWxm7yGGOOUuvF/3TilbkaEBclU2gSNQqUOC1Em
	aVWJIVExGivyPkzRud8H7WioJdKBGBrJp0ldr6OUMrEiQZ+kcSCWJuQBUv8FXksarUg6zeti
	juri1bzegebRpHyOdNXIqWgZc1wRx5/k+VheN3kV0X6BBqRx6nNMB4n5+2a2PW5et/26De+5
	hntylxljMxfLY5ojHPcPSwb/XHGNnX49yDxvWWLpeZs2XHT3iPjGoaBtT0b3ng+6v2trWMKs
	9r71Bs9+Z8GGz5EVG1ZXhQb1V4kiDWrjlgdBOzbVHdBMl/g3nW3VphS+jau3RAQGBp/Jdglt
	60/ISb1SEbqU0OkV/wBp0bMXLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRjF+++9brV8W5IvZhSLsIzUIOGJ7AJF/rELEVQQUY58acu5YlPR
	ILC0i5pmWmBzllGZbovZUjfLNOfyQkimXWZe0RQlcaZlmt02I/Lb4Zzfc86XhyVkM6Q/q9LE
	CVqNQi2nJaRk76aUdTnOaGXo/dzVYLCYaTBNJcKDXjsFBmMFgi/THQxMOBtouHtnkgDDq1QS
	vlq+EzBQ38eAyboHeooGSai6ZCOg72ojDZmpMwQ8mx5l4Ly9WAR1BU0UtFRkUXD9+30CbMm9
	DLQ9MdDQbf5NwaAjk4QmfQkJPVnboL5wCUy+HEHgtNhEMHmlgIbc1kIa+lN7ELTW9ZGQfy4L
	gaXaRcHMlKcj/0U3s20VrhtxE7ispF2EK/VdDC60xuPHxUE43dVKYKsxjcbW8RwGd76ronFj
	3gyJK+0TIpyZMkrjzwMfSOyufkvju0NjImwpe0vukx2WhEcLalWCoA3ZEiVRFnX5nh6XJFpL
	hlEyKhCnIzHLcxv40gs2wqtpLpB3uaZntS+3np/oayDTkYQluIc07zR3MN5gMRfPt997Qns1
	ya3ifw1bkFdLPUV2Uzf9t3Q5byp9Plsk5sL46vrGWV/mYfovO+m//CK+6eZHzwDrGQjkLbdk
	XpvwnKaU5xPZSKqfQ+n/U/o5VCEijMhXpUmIVajUYcG6GGWSRpUYfPxUrBV5XqLo7I9rdvSl
	LcKBOBbJF0ifNx9XyihFgi4p1oF4lpD7Shcu81jSaEXSGUF76pg2Xi3oHGgpS8r9pJGHhCgZ
	d0IRJ8QIwmlB+y8VsWL/ZETtPPkpYOrp2Kh9yHgg8vJGn4xhXApba0Nsh3QBRwwq9/5Hm7/9
	rMx4r6rNM2LZyk4T0+FHZNZM7a9a0xuwVn1w94qh6DSZbVdLHm8OnF/UE4v2+SfMu0GJA+ed
	GCjXXLxY5bPd6u5yhVKacLVry+s32TvkxpqjtvQIvtl62ywndUrF+iBCq1P8AfVup3kOAwAA
X-CFilter-Loop: Reflected

Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 95ffa48c7c67..05e2e22a8f7c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -544,8 +544,8 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 }
 
 /* slow path */
-static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
-							gfp_t gfp)
+static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
+							  gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
 	unsigned int pp_order = pool->p.order;
@@ -615,7 +615,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
-		netmem = __page_pool_alloc_pages_slow(pool, gfp);
+		netmem = __page_pool_alloc_netmems_slow(pool, gfp);
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_netmems);
-- 
2.17.1


