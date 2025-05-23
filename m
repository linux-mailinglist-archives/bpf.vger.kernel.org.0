Return-Path: <bpf+bounces-58812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8BDAC1AA2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BEDA46E14
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D192777EA;
	Fri, 23 May 2025 03:26:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ACA223706;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970791; cv=none; b=rPr4ufASrHFXOK7ltcKhNlmtKfivqABNGVGr/aiRTzKUzE0dDypwL8edtg3e6eO0ZMrmvGvmj4FVfLINjzX14b6D0P+CmumshugM1dpg7/ofN5hHXl4CUJ1bpZl2BriTO1+tpoWmYuc01LYR5BiXakS2j8SJVdB8r81XlhRl1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970791; c=relaxed/simple;
	bh=Q25QQvMCVB4ttatlEs0Z7kGrOH8zr4XA0WKeasesxB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LkUwg25hmCshNWfqbSiGeZdEE6ndgRPXz2eI9Tr9hjlgWNTqTxANd1ac4CuXXxYiseasGeEFy04UMDScGVz8AgU5sP5MIV3cFbv8LKR6uvP+JE2sqdcYtyAUxlzOZBzviwnOkFMJCZcJtGcip5KUwmufT2D+0xVGOL9Rk+TxCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-cf-682feadcff71
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
Subject: [PATCH 10/18] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Fri, 23 May 2025 12:26:01 +0900
Message-Id: <20250523032609.16334-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRaUiTcRzH++959jzPhqOHKfWokDSQUnAemf2gA9+Ef3oVZJZZ1MinNtQp
	m5qKkpkRDV3ildYTTCJvWMxrHnTMeZGmadY0U/EKpBRPPMJySu8+fK83X4aQ20kPRqNN5HVa
	VayCkpLS3y5lfmPz/uqAn6XeIJhrKajZSIGKSasYhOpGBKub32lYsXdR8KpsnQChP5uENfMW
	AbOdUzRMlM+R0Pa4iYCpp90U5GZvE5BlrRTBQKNRDIVbrwloypykYahFoGC89q8Y5my5JPQ8
	ryJhwhgKnaZDsP7xFwK7uUkE6zkvKSgYNFEwnT2BYLB9ioQXD4wIzG8dYtjeEKjQo7i+akSE
	m5//oLHJkoTrKn2xwTFIYEv1EwpblvNpPPa1jcLdJdskbrauiHDuwwUKL82Oknjx7TCFzfXD
	JO412Wm8Yjlykb0mPRPNx2qSeZ3/uVtSdZZ5R5TQLkkRSjtQJsphDEjCcGwwN20vFhsQs8eG
	zAtOmWKPcQ7HJuFkNzaQW5nqIg1IyhDsgpibFbZFTsOVjeF6hmx7IZL15j58KqedLGNDuGc1
	A8T+vhdX8+b9Hkt29bzxNcrJcvYk1/pllHaOcuwSzU13FFP7BXfuQ6WDzEMyEzpQjeQabXKc
	ShMbrFSnajUpytvxcRa0+215xp8oK1oeuGRDLIMULjKr1F8tF6uS9alxNsQxhMJN1jGnVMtl
	0arUNF4Xf1OXFMvrbciTIRWHZUHr96Ll7F1VIh/D8wm87r8rYiQemaiitDLrkZEK53eiGu73
	ep4KuKZMt3tH5EeG4NM+J5r60y5rS94tPgtvjOjz62wos86X2M6uBn4rmJgJc9dPHvZZGNpJ
	V5+UQsWd5chsr5aiwuNXfxklQsaYq/IGU3E6NOaK6+J5YTOjdSZopPx63+cuc9hB34Qifbhn
	HZ9SJ5lVkHq1KtCX0OlV/wANXJze1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH+59zds7ZcnGclid9CBaiCGlixg8KkV48GmVvRUQ58uCGm8qm
	MqvBUilazrwUeZm2Eu/WdIrOslWbV7ISzUumThaaRJjmBXXdVOjtw+fzffvSuKSW8KcVKem8
	OkWmlJIiQnT2RM6RqW9h8qOtG35gsjSR0LihhdpZmwBMDe0IVjc/U7DS3UdC1eN1HEwfcglY
	s2zhMNfrpsBVM09A1+0OHNz3+kkw5npwyLbVYeCsGBDAUHu+AO5vVePQoZ+lYOS5iYSZpr8C
	mHcYCRgoqyfAlR8NveYDsP72O4JuSwcG63kVJBQPm0n4kutCMOx0E1B+Mx+BxT4hAM+GiYyW
	cm31nzCus2ya4szWDK61LoQzTAzjnLXhDslZfxZR3NRYF8n1l3gIrtO2gnHGnEWSW56bJLgf
	9lGSq1pYwjhL2yjBDZq7qXPeF0UnE3mlIpNXh0UliOTZlj9YmlOoNZX2ID3Kow2IplnmGGvQ
	xxmQkCaZIHZiYhPfYV8mnF1x9xEGJKJxZlHAzpk82E7wYZLZgRHH7ohgAtk372uoHRYzx9mH
	jUO7nmUOsY3Nr3dZuO0LZtbIHZYwkeyLj5NUARKZ0Z4G5KtIyVTJFMrIUE2yPCtFoQ29mqqy
	ou37anS/Cm1odSTGgRgaSb3EwaowuUQgy9RkqRyIpXGpr7hnPlQuESfKsq7x6tQr6gwlr3Gg
	AJqQ+onjzvMJEiZJls4n83war/5fMVror0eSWHZzgdJ0UfuKO/jDyuKWCPupIt10zP6y+pen
	27xb2u9+bQ7qGbNGl2ivXwpOb71sjp0ZT1r3zC1oHmHezZM2qjokwn6QDLgQlesTZFwO1Jea
	XNklo2cqkqt+6zqXnC2FKKo08ZaX8F35A61ufNBdWfnqmSH+SfyNiqeNe1elhEYuCw/B1RrZ
	P3u36Dq6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 01b5f6e65216..1071cb3d63e5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -543,7 +543,7 @@ static netmem_ref __page_pool_alloc_large_netmem(struct page_pool *pool,
 }
 
 /* slow path */
-static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
+static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
 							gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
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


