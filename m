Return-Path: <bpf+bounces-58798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5AAAC1A66
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954791C00CE3
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D1221F02;
	Fri, 23 May 2025 03:26:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B422154F;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970786; cv=none; b=heiywxgJpvEBzHVhmtGoFmDxg8eK78WiY4Jxop5sQ4P8H+lZGUqFPFpMIImTcpnEsglZBzkIR49enq5pI1p53HFr8u99J0rUqlfrnDoaBe9QMXbU3/xMme7JRVT4lO6lmEH44WjFnODzo9GsOmHTpyzUBmCm1cUkhioCbrwe5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970786; c=relaxed/simple;
	bh=Nlu+Ye/l2MvdjyqvtqV9kAfumkCJ+PGw/5U4NmeTbnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JxITAFQYUcB3pms/aobcDOncSKi3Orn3PPG2220jQuVv/m/5tdta225KzvZfiQ2iJzFhpjzjGO1cYmRkqW/s8q6z/18uLOOmUXS5M5DHAO1NnFIaUdKLlWhSEDT/602j4m12jA+Pn2oVNWTpJKCc/BQUXrXdGfNivJ5kYXuvweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-93-682feadc559e
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
Subject: [PATCH 04/18] page_pool: rename __page_pool_alloc_page_order() to __page_pool_alloc_large_netmem()
Date: Fri, 23 May 2025 12:25:55 +0900
Message-Id: <20250523032609.16334-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG++9cN1wcpubRqHQQhpE3NN5IQoLgCBFRfVLBRh7dck7ZdM0i
	cCWUokvKMGzSJO9KR5bpNDFbXivIvMQ0rxP9YKnkmnkLc1bffjzvj4cHXhqTdeMBtEqTxWs1
	CrWclOCSJa+KExOLYcpws5EBs9BIQsO6AWpmbASY61sQ/Nz4SoGru4+E5xVrGJg/5eHgFjYx
	mO91UjBdvYBDx71WDJwP+kkoytvC4I6tVgSDLSYCSjarMGjNnaFguN1MwlTjDgEL9iIcBsrq
	cJg2xUKv5QCsffiOoFtoFcFaYTkJj4YsJMzlTSMYeufE4anRhEDodBCwtW4mY4O45roxEddW
	NklxFms297I2hCtwDGGctT6f5KyrDylu4ksHyfU/2cK5NptLxBXdXSa5H/PjOLfSOUpyQvMo
	zn20dFOcy3r4IhMviUnm1So9rw07c1Wi7Bx/Rma+EhtWBAHLRatUARLTLBPFln7eJv6za6NK
	5GGSCWYdjg3Mwz5MBOty9uEFSEJjzDLBzpu3diWa9mbS2PrK4x4HZ46yPaaxPV/KRLNC4RT5
	t/MI29DUtZeLmZNs8ZR7L5ftOq9HxilPJ8u4Kba068W/Qf7s21oHXoykFrSvHslUGn26QqWO
	ClXmaFSG0GsZ6Va0+9vq29sJNrQ6eNmOGBrJvaQ2SZhSRij0upx0O2JpTO4j7VkIVcqkyYqc
	m7w2I0mbreZ1dnSQxuV+0si1G8kyJlWRxafxfCav/X8V0eKAXFSumlopOyX+3Ra0Ebjfe8d2
	ATk7kyszBphFd5whvillRnXOWDLpXfKtpFmTEnx6ueHXfaMk+lhmzxUUsmR357YyhedTNX3q
	REVkSKR/WbTemDp7KDwBgn3fP666lTh7fdyvP+aNSZgLbF/otyb5xAXF6ehhp29N/mjppZGz
	hBzXKRURIZhWp/gD/TS9x9cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnZ0NB6cldtDoMqhMUTNTfqKUfaj+BGUQFQiiI09tqVM3
	tZmEmnYTNW+h2KSZ9ykd867ZEO+WYGiWmqkslLDS8pa6rNTo28vzPrxfXpqQlZK2tEodyWnU
	ihA5JSEl57wSncZmXJSHvz1DoOcrKahY0UHpZKMQ9MZ6BIurH0Sw0NFNQWHBMgH6/iQSlvg1
	Aqa6zCKYKJkmoeVeAwHmhz0UpCZZCLjdWCaA9vxeIbypTxNC9loxAQ3xkyIYbNZTMF75RwjT
	bakk9OaVkzCR5gNdBhtYfv0VQQffIIDllHwKsgYMFHxKmkAw0G4m4XFCGgLeNCwEy4qe8pHj
	2vIRAW7K+yjChuooXFPmgJOHBwhcbXxA4er5TBEee9dC4Z5cC4mbGhcEODVxlsI/pkZJPGca
	onDh5+8CzNcOkbjP0CE6v91P4h3EhaiiOY3LsUCJ0jT6hAqvE+vmeJ6IR/OiZCSmWeYou7Ba
	LNjMFHOQHR5eJTazNePKLpi7yWQkoQlmVshO6S0bEk3vYIJZY5HjpkMy+9nOtJEtX8q4s3zK
	OPVvcw9bUdW6xcWMB5s+vrTFZRvOi7ejonQkMaBtRmStUkeHKlQh7s7aYGWMWqVzvhIWWo02
	7iu59SujES0Onm5DDI3kVlL7UBelTKiI1saEtiGWJuTW0s5pZ6VMGqSIuclpwgI0USGctg3Z
	0aR8p/TMZS5QxlxTRHLBHBfOaf63AlpsG48cDQ1xLd6De8ubs+5eai+wmuHKogyPiu08j/ih
	Kt99z0+0Zth0vUzw6L7jdP/3RXXsyVdefWfdHL/g6c6U9at1Hq0a46Fd2X76WNON3f3+ONne
	VJNz4fhg3E/fsH4sXgrgn/p71p6yqKYUmW4RprCciHFH9ZjOfP2Abf779Vz/IjmpVSpcHQiN
	VvEXrVITMboCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
page alloc/put APIs, rename it to __page_pool_alloc_large_netmem() to
reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2680d38d3daf..147cefe7a031 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,7 +518,7 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
+static netmem_ref __page_pool_alloc_large_netmem(struct page_pool *pool,
 						 gfp_t gfp)
 {
 	netmem_ref netmem;
@@ -555,7 +555,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return __page_pool_alloc_page_order(pool, gfp);
+		return __page_pool_alloc_large_netmem(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


