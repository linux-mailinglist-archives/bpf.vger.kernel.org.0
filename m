Return-Path: <bpf+bounces-59060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F64AC5F68
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67097A74B1
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2301F3BA9;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3F1C860C;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=TR1VRC+3uvgavP3qZsyfLgG6PNmVuX+o5rCfQ9eIIRX9RVVvQsxijGJncD7AJhy9RpsE+7gGduJ4mNp1Y7nK1WsORXxjlcrUk97MFYk0xC7u3Cy2wxPRVPkpHiFPGVb1eUXV60Qd622edn7fj1YmStEwqLRdjmAN+VBT/rEnmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=peGMgh/7phOJLL87zd6HtqYt1TTFa/Q5ehEOSQLlW18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WSb9j5bfWPtJQPtYkAc0JxCvSEk+4WtiP5Zx7J3uTAwjLvqhS7693jkO/NKCRtaL+sFJ/FX02A/2RZVko5D7jiL60IVLf5Oqh3WRY1Su3A4WRKiK2txB9HNOpozrtwmqI0FUWhqHyUzUr/bUXo/wV3niYAd8Nyrsa1wvoETj/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-41-6836750121c7
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
Subject: [PATCH v2 04/16] page_pool: rename __page_pool_alloc_page_order() to __page_pool_alloc_large_netmem()
Date: Wed, 28 May 2025 11:28:59 +0900
Message-Id: <20250528022911.73453-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcRyG+++cnZ0Nh4cleTIwGlkhaVlqvzTSLoJ/QhJ4V5QtPbXVPOqm
	plLgF5RLrawobMEqMnXWZInONKlpaihmijq/ZaFQOSWXS51kTuvu5XlfnpuXJmQtpB+t4tM4
	Da9QyykJKXF4PQtC6eHK/WZ3JOhN1RQYFzPh5aRFCPqqOgS/lkZE4Gxtp+D5UxcB+s8FJCyY
	lgmYarOLYKJ8moSmG/UE2G93UFBc4CYgz1IhgJ66EiHcX35BQH3OpAj63uopGK9eFcK0tZiE
	T2WVJEyUREObYQu4OmcQtJrqBeAqekLBvV4DBV8LJhD0tthJeJxbgsDUbBOCe1FPRe/AtZVD
	AtxQNibCBnM6flMRiHW2XgKbqwopbJ4vFeHRgSYKdzxyk7jB4hTg4vxZCv+cGibxXHM/hU21
	/STuMrSKsNPsf4o5LTmSyKlVGZxm39HzEmVd84wgpU+c2V05QuSgVZEOiWmWCWW/zNYTOkSv
	Z+MPXw+mmN2szbZEeLIPE8I67e2kDklogpkVslN6t8BTbGZ41rF6c91DMgFs2+AGlzJhbJe9
	Dm34t7PGmvfrfjETzn4cTfBg2dpk7pYJeZwssyBiS4sa/+23sh8qbOQdJDWgTVVIpuIzkhQq
	dWiwMotXZQYnJCeZ0dq15ddXzljQfE+cFTE0kntJcU2YUiZUZGizkqyIpQm5jzQvKlwpkyYq
	srI5TXK8Jl3Naa1oG03KfaUHXFcTZcwlRRp3heNSOM3/VkCL/XJQRKIq5rA2xTuBzz6RGhuV
	Hz6gd/iczNzZGMMfapkOihQMBrwapoxqqd/e7mdYK+QJy4OBs5q44eBvRd7iFe/C+UHHHp+w
	3N9DOWOlCdbGONP48bsRDekHL19MZUqM/p3+F2LtUudD+etduj9B/se+v+OLyXPJXH6B3B7v
	uDYqJ7VKRUggodEq/gKjMjzG1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnR2Xq+MSPWklDCMz0gSVX5plfelPH0IoMirJpQc31Cmb
	mhbW8kI2L1lNEpuxEC9TcbJkzhAJNS8kKZq11FQWkyJvpYluxXJE3x6e9+X98tKEuIH0o+WK
	LE6pkKZJKCEpPB9deBRlR8qOrdYeBp2xlYKWzVxonLfwQddsRrC+NS2Atf5BCupebBCgGy0i
	4ZfRQYB9wCaAuYYFErrvdxJgezhEQXmRk4ACSxMP+mqH+TBmruCD1lFPQKd6XgATr3QUzLa6
	+LDQW07CcI2BhLmKWBjQ+8DG20UE/cZOHmyU1VLwZFxPwZeiOQTjfTYSnt2rQGDssfLBuamj
	YiW4w/CJh7tqPguw3pSNXzYFY411nMCm5gcUNv18LMAzH7opPFTtJHGXZY2HywuXKfzDPkXi
	lZ5JCtd9XeVhY8ckiUf0/YI4ryvCE8lcmjyHU4aeTBTKzD2LvMwJj9x3hmlCjVwCDaJplgln
	W777apAHTTGHWKt1i3CzNxPGrtkGSQ0S0gSzzGftOifPHexhFOySq0TgZpI5yA58/OdFTAQ7
	YjMjN7NMANvS/ppw73swkeybmSS3Fm9XVkqNqBIJ9WhHM/KWK3LSpfK0iBBVqixPIc8NScpI
	N6Ht9xryfz+yoPWJs72IoZHEU4TbI2RivjRHlZfei1iakHiLCk5FysSiZGneLU6ZcV2Zncap
	epE/TUp8RefiuUQxkyLN4lI5LpNT/k95tIefGp3xEQUWu/wpbU7bkfwLNwL9rjqqK0sC2+xV
	5av1HSMxd4tDvdTPb4fHmVzkvksToxdZm3XMc9DLsCuh+aZzt+vpRsCUVmJ7P6BNbWKz9g7J
	HKLS0dOWO9rZ4f0Ll78lpoQdnzX8WeqPEccryqJKohK4gqDGXGNQtPnA9LWqnZ4SUiWThgUT
	SpX0L1PEFV65AgAA
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
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e101c39d65c7..147cefe7a031 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,8 +518,8 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
-					       gfp_t gfp)
+static netmem_ref __page_pool_alloc_large_netmem(struct page_pool *pool,
+						 gfp_t gfp)
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


