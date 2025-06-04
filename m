Return-Path: <bpf+bounces-59615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B438ACD5F8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673B7189B4FC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B35235C01;
	Wed,  4 Jun 2025 02:53:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336213C9D4;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005591; cv=none; b=Y2CYp97a4OjrZRFjzRjh0RmnYc0YGUvp6bNqCiPfx64YqOYsVfITDUIT5KD+QAFbG9kLpPKE1ef1e4kYsOf/x6BwEXzRxMI7y+UtkTQcgntUY+vbX3MOzA3oaVqtuja4E3lawWTrQ5fzOIWj2BSyMKXaC2dLOir6lIQRHu+0EjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005591; c=relaxed/simple;
	bh=ENO441/wuyIcnrFDoULWDbyOEXwgOq63mWHdv0EWhi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g2W5h+UD9wRQoWkaFltrDpNmMjhyvDgjQ07+L1f1RcroKvKnPddTQmifo+VpjDLQQpQBVqhL+ekwKF0j8rF7GZxtXigfJguSXxt2rrUcW071OYNvMGQZN4rlaVerP/Kcz1Re6aT0Ysu9+YPZAa9SLNnf6hO8pexswAbfbVI8ODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e2-683fb5092bbc
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
Subject: [RFC v4 04/18] page_pool: rename __page_pool_alloc_page_order() to __page_pool_alloc_netmem_order()
Date: Wed,  4 Jun 2025 11:52:32 +0900
Message-Id: <20250604025246.61616-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e/8d3Y2HJ2W2EkjcRWi4TWtFxLzQx8OSBfoW4W59NBGc8rm
	bVE0LyENb5RU2IKJ5b22lukUkVzDC2qapaxcKYoW4SWvUyeYs/z243ne5/flpQiJHftRClUG
	p1bJlFJShEVz3pWhwndn5RETmxFgMDWS0LCeAzUTVj4Y6psRrGyMCWDZ3k1CVeUaAYbBAgyr
	pk0CprsmBTBePYOhvbCFgMnSHhKKC9wE5FlreTDUXMKH8s2XBLToJgTwuc1Awo/GbT7M2Iox
	9FbUYRgviYcuoy+s9c0isJtaeLBW9JyER8NGEqYKxhEMf5jE8Cy3BIGpw8EH97qBjA9km+q+
	8tjWiu8C1mjJZN/WhrB6xzDBWuofkKxl6aGAdY62k2zPUzdmW63LPLY4f55kF6e/YXahY4Rk
	TU0jmO032gXssuXIJfqKKDaFUyqyOHV4XJJI3l2j56cXinJcfYM8HXpN6ZGQYuhopn9jmL/H
	r7b1Ag+TdBDjcGwQHvahI5nlyW6sRyKKoOf5zLTBzfMUB2glU/bbRuoRRWH6OOPqPO2JxXQM
	s/XC9d8ZwDSY3+96hPQpxjn/ZHcq2bkptn4hPE6G3hAwU7oK4t/gENNZ68BlSGxEXvVIolBl
	pcoUyugwuValyAlLTku1oJ3fVt/dumpFS0OXbYimkNRbbHXGySV8WZZGm2pDDEVIfcQBwTuR
	OEWmvc2p066rM5Wcxob8KSw9KI5ay06R0DdlGdwtjkvn1HstjxL66dCJhI/Yd/akq1NGqM5E
	3YhJbozzz19Isoj04c6YhQsJo4ENo1ivyBXOmpMi95e2XUsMWurNNf/qzz82NHD/55Jd5J4I
	FZt7PzXum3k8FuI1t5h4rtK38E6hNrY0r7zt8JDrnqsobyX76GpCVQPtlF+MHXij+aM53xps
	Nuqo0RYp1shlkSGEWiP7C9rpciTXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF++0+dl1NriZ5sUBahGlkiZlfMFQq6JalFUHkP7ry2pbztamo
	EfgKcTRzWRk6a2a6+aiVmU4Rqzl8YLTSNPPRbKL0wizN1wRzRv8dzuec88+hMFcd7kFJE1I4
	eYJYJiIFuCA8KHeP0/MQyb459Q7QGOpJqFtMB924kQBNbROCuaURPsyau0iorJjHQGPJw+GP
	YRmDyU4bH6zVUzi05TdjYLvRTYIqz45BjlHPg47yHgLeNhUScGu5CoPmrHE+9LdqSPhUv0rA
	lEmFQ09pDQ7WwlDo1G6B+d4fCMyGZh7MXy8nobhPS8JEnhVBX4cNh7LsQgSG9iEC7IsaMlTE
	NtZ85LEtpWN8VtuQyj7T+7DKoT6MbagtINmG3zf57OhgG8l237XjbItxlseqcqdJ9tfkMM7+
	bB8g2covMzzW0DiAs6+1Zv4pl0jBwRhOJk3j5HuDowWSLp2SSMoXpC/0WnhZ6DGlRE4UQ+9n
	Hq0q+Q5N0l7M0NAS5tButB8za+vClUhAYfQ0wUxq7DwH2EzLmKJvJlKJKAqndzILrwIdtpAO
	YFYeLhD/Nj2Zuicv13ec6APM6HTJetV1LaMyvseKkECLNtQiN2lCWrxYKgvwVcRJMhKk6b4X
	E+Mb0Np91VdX1EY013/UhGgKiTYJjaPBEldCnKbIiDchhsJEbkJP7zVLGCPOyOTkiVHyVBmn
	MKGtFC5yFx4/x0W70pfEKVwcxyVx8v+URzl5ZKEr56Xh5pqZyBHfMFlnum7wqelEUJst9s2D
	iqrWaJU+9toR5++nb7tcyDXZc7+GuQ9nF5AVSG2JuOysnOiI2viu59iuF/cttnvZxf5eyfON
	irn2HKNibHt1yAfNofA+/8z6OKuenlGfLQmlx5LPmCJGlB6HA71b3ct233EO/7ztpAhXSMR+
	PphcIf4LUY6+C7oCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
page alloc/put APIs, rename it to __page_pool_alloc_netmem_order() to
reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 523354f2db1c..ff3d0d31263c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,8 +518,8 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
-					       gfp_t gfp)
+static netmem_ref __page_pool_alloc_netmem_order(struct page_pool *pool,
+						 gfp_t gfp)
 {
 	netmem_ref netmem;
 
@@ -555,7 +555,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return __page_pool_alloc_page_order(pool, gfp);
+		return __page_pool_alloc_netmem_order(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


