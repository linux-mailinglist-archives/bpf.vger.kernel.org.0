Return-Path: <bpf+bounces-59620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E920AACD5F4
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7574F179BFE
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1623F439;
	Wed,  4 Jun 2025 02:53:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B11A316C;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005591; cv=none; b=ivrdNwPUNcOiHzotvkbNRshTu6ORQdipjFQEtrPV75OOPMvqL3KRFduSFICps2twvxkk50rE0K2eYBOKHDjo/UYpSzxAWi0bXHigL1yy5Y6oZi1UoQevX8bexSPCQuN4wXjVOQE1M9HOsb5FFk1hQ6Mep1+gQf1a8GhHWsQ7+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005591; c=relaxed/simple;
	bh=dFDPIlBtZ3CkzrI3IY2wn3h/sH0UOP0yj/34kApkoxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r7I7wQHcaYdXTq9fQAy6xWk9VQRtLbjixgG8MQxICrlfAgETieNiju4lTpaNtDJ7Fp4lBodLhTQ4guMLAGiRFUgw/GGkGlClT6OhKGuXzjgkxo7BiG9hqIWssbrtgnkgOU/0p0NOVUy2rBHG461TyhJUFNtWMDazMuq7aaSAqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0a-683fb5094d1b
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
Subject: [RFC v4 08/18] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Wed,  4 Jun 2025 11:52:36 +0900
Message-Id: <20250604025246.61616-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnTOXk8MSO61SHJgmZGoa7wcxiZDzwcouJCShK09uNKdM
	XSoEXgaVuSnZRWzSRDRvsFhuTlGpeacw8xIzLcVUStTK2fDWZdP89uN9fs/z5eVhQisu4skU
	maxSIZGLCT7OX/KoOso3nZSG9E4g0BmaCGhcy4bn0xYu6BrMCFbXJ0iwd/cRUF3lwED3To3D
	L8MGBnO9MyRM1c7j0H6nBYOZkn4CNOpNDAosdRwYMmu58HCjBoOWvGkSRtp0BHxu+suFeasG
	h4GKehymtNHQq/cGx5tFBN2GFg44iisJKBvWE/BFPYVguGsGh6f5WgSGThsXNtd0RLQf01w/
	zmFaKz6RjN6YxbysC2KKbMMYY2y4RzDGlQckM/mhnWD6yzdxptVi5zCawmWC+Tn3EWe+d44R
	jKF5DGfe6rtJxm70iaOu8COTWblMxSqPRSXxpeUWOt0qyB7ovJCH6vcUIXceTYXTHaYtfJeb
	B02kiwkqgLbZ1jEXe1GhtH2mz+nweRi1zKXndJscV7CXktODA6WEi3HKn6425SMXC6gIuktT
	/X/Ul2588Wp7yJ06QU8uP9nuCp2OxjKK7TjfSNr+6PQO76df19nwUiTQI7cGJJQpVKkSmTw8
	WJqjkGUHX09LNSLnZ2tvbyVY0MrQRSuieEjsIbBMRkmFXIkqIyfVimgeJvYS+B5xngTJkpxc
	VpmWqMySsxlWdICHi/cJwhy3koVUiiSTvcmy6axyN+Xw3EV5KLYo6VJAiNHUnp9rwL3K/A6f
	idcmiMjjCYWz6E/Qe7droW259w8tbKxGFIrGVsd7zD4lV+Wqgv4U7Cw5mSlceDZlTjvltRUz
	HlfzuPLcV1p9N+3ywnk2RuTZc3BE3d3i2V49K/oRWVLovR7gfyMsMjG0IzZ+sRgcAYG/SwJH
	l8R4hlQSGoQpMyT/AFoD/rbVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e+cnZ0tB8c18mCQMDBR0BJc/KRYQqCHoJAMknrIUzu15Zyy
	qWgYeItI2rQSFZ2wkLznYk43Raw2UUc2xUt51yaKD2GXqakTyhm9ffjeXr4kJmnCw0i1NofT
	aVmNjBDhoqvnS2OE3RdVZ1c8cWCydBDQvpsPzSsOPpjaehBs7c0LwDc4TEDjqx0MTGNlOGxb
	9jFYG/IKYLlpHYf+J3YMvBUjBBjK/BiUOFp44Gpw82G8x8iHqv3XGNiLVgQw2WciYKnjDx/W
	nQYc3HWtOCwbE2HIfAJ2Pn5DMGix82DnWQMBLyfMBKyWLSOYcHlxqC82IrAMzPDBv2siEmWM
	rXWWx/TWLQoYszWX6WqJZspnJjDG2vaUYKy/XgiYhc/9BDNS68eZXoePxxhKNwnm59ocznwf
	mCaYxo0fPMZim8aZUfOgICXkpuiCktOo8zjdGUW6SFXroLOd4nz3wLUi1HqsHAlJmoqnbZ5u
	QYAJKpKemdnDAiyl4mifdxgvRyISozb59JrJzwsYxykN7XFXEgHGqQi6sbsYBVhMyWmXoRH/
	NxpOt799fzQkpM7RC5s1R13JYcbgmMIqkciMgtqQVK3Ny2TVGnmsPkNVoFXnx97NyrSiw/ea
	Hh08d6CtyWQnokgkCxY7FhQqCZ/N0xdkOhFNYjKpODzqUBIr2YKHnC7rti5Xw+md6CSJy0LF
	l29w6RLqPpvDZXBcNqf77/JIYVgREldf2X5sUBZ+TVN4540V86duy6/LoywuerTvQ5Rk+l6C
	vfC0pn2DcnZ+iljNSU7lryTdiUyyzUpLLr2ZWuhKqO+pu2WxKavz19klXHsgDFXEYE3xpvEJ
	lc8e3vkltSY6zTgnCJnzjFlSFoOa14P6+vyrs8HKB+92q37XEpEyXK9i46IxnZ79C4Px90K5
	AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dab89bc69f10..c31a35621b24 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
-							 netmem_ref netmem)
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
+							   netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
@@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


