Return-Path: <bpf+bounces-59066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A9AC5F73
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046194A8173
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5B2135AD;
	Wed, 28 May 2025 02:29:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0C1D5CD7;
	Wed, 28 May 2025 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399370; cv=none; b=QVDJbqF6UfnUeKWt5hHdQELoUHpAxDiQGOXLczQIBd+iNDWF4cnnHZl2gP6SVmB9lH45GwSK658fplcGrqTj1W6tqWlDqBmeBLZDfaaNfuZ+57JWhVzXnVuun0/OGX8jLyHDQFBWHmlK/wrFdFOvNqaLGIfBH8E81NJguubvJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399370; c=relaxed/simple;
	bh=l8lwlEaDig31EuiYsK+bLyJxb2uyjArQfR2h/hFvszE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TqyC8spKcgGQbulvZgrkxvkdwdevBUlQTkTOBF1hYdUigoTqSbIvPCUB4LmdPvP22H3i8hPm5wnntGttBKf+eT+9nXMXYsmPWKsBZWsN2ajxQCX8VNxh5XZl/5zKtR0vp3kKaIBePn1u+wcfJCIq3ZDdINe7ToL7muZPDlRdFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-7d-68367502b7ed
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
Subject: [PATCH v2 10/16] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Wed, 28 May 2025 11:29:05 +0900
Message-Id: <20250528022911.73453-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH+++cnR2Xo9McdlIoGklheQuVXxTlS/R/FIoeulBLD26o0zZd
	Khhr3jVdWg+hM2aleYPZEp22vMxrWCiKMi+lKdrFGzkd6rp5wbcP3++Xz8uXJsQdpBetUCZw
	KqUsRkoJSeGie5kfLzFUHmjN9gCDqZaCmvUkeD1l4YOhugHB6sa4ABydPRS8LHMSYOhPJ2HN
	tEnAbPe0ACYr5kiwZjUSMK3vpSA/3UWAzlLJg4GGAj483SwnoFE7JYChZgMFX2r/8WHOlk/C
	h+IqEiYLwqDb6AnOvgUEnaZGHjgflVLwZNBIwUz6JILBjmkSSh4WIDC12PngWjdQYcdwfdUo
	DzcVfxZgozkRv630xbn2QQKbq3MobF4pEuCJESuFe5+5SNxkcfBwftoShX/NjpF4uWWYwqb6
	YRJ/NHYKsMN8JJy5LjwfycUoNJwq4MIdoXxsRhKfIUzSz+oJLXpH5yI3mmWC2abyT/w9bi0d
	J7aZYk6wdvvGDkuYINYx3UPmIiFNMEt8dtbg4m0XHoySfW1/s8Mk48PqRvp2RCImlM1+1SLY
	lR5la+ratkQ07baVd01EbMdiJoRdzjOhbSfLrAlY7ZQD7e4Ps+2VdvIxEhnRvmokVig1sTJF
	TLC/PFmpSPKPiIs1o61rK1J/37CglYErNsTQSOouwnUhcjFfplEnx9oQSxNSiUh3MVQuFkXK
	klM4VdxtVWIMp7Yhb5qUHhKdcd6PFDNRsgQumuPiOdVey6PdvLQoxLD4cyK0Oaf1vWlmRXuu
	8OvQ8drMs87owqzKH8P98y96VsfMqyX71QMeVk08eXAuhapISTP6ncrPS01/3nEpbfieo3P+
	clGO7K4EXQtsm+mVJPXIPSeEUfZwn9M1uq6CmqsOk/7bgcmbqLHd1fd3NDPgQemf794+xoiT
	PrcWMqSkWi4L8iVUatl/GdRhsdYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+59zdnaczY5ry8NChGFEQpag9qMiJaj+WERBUNSHXHps8zJ1
	U9NAMjVSS63sg9nM5f1GW0t0lmioeUkjmyjLWQ5tlhRqaeItTI2+Pe/7wPvlZUhJJSVn1JoE
	XqtRRitoESU6fShjL5EYqNr/aFIAemM9DXWLyVDlsKyn2kYE80t2Icx1dtNQ9nSBBP37TAp+
	G5dJcHaNC2GscpKClttNJIzn99CQm7lCQrqlmoCO4l4BDDTmCeDhcgUJTWkOIQy+1NPwuX5N
	AJPtuRT0FtVQMJYXDF2GHbDQ9wNBp7GJgIW7xTQUWA00TGSOIbB2jFPw+GYeAmOrTQAri3o6
	WIEbaj4SuLnokxAbzIn4RbUPzrFZSWyuzaax+dcDIR4dbqFxT+EKhZstcwTOzZim8U/nCIVn
	WodoXPZtlsDGhiEK9xs6hWfcL4oOh/PR6iReu+9IqEg1MiGNuyVKznfmk2noFZODXBiO9efa
	iu3kBtPsbs5mW9pkKevHzY13UzlIxJDstIBz6leIDbGd1XBVtuebTLG7uPThPsEGi9lALqu8
	Vfhv1IurM71eH2IYl/X+zWjYRi1hA7iZO0Z0D4kMaEstkqo1STFKdXSAry5KlaJRJ/uGxcaY
	0fp7lamr9y1ofvBEO2IZpNgqxqYAlUSgTNKlxLQjjiEVUnF6UKBKIg5XplzntbGXtYnRvK4d
	7WQohYc45DwfKmGvKhP4KJ6P47X/LcG4yNNQlP/akwj31VLvqXdn3TulJQNye6Wf89kXibUg
	5KRbdukV2R8iiJVfm4gYtCxLzkW6jrh9/2Ba8t5jdZySV+C46mNHnalrjrcXxK6paV72fnW8
	uqnxq4fes5DuO3i8WSPTHai6lBxfbt82lVXtWiebKe4vuREim833lDl4U1ukgtKplH4+pFan
	/AtkoQYtuQIAAA==
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
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f5fe3007f118..713592614eb8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -543,8 +543,8 @@ static netmem_ref __page_pool_alloc_large_netmem(struct page_pool *pool,
 }
 
 /* slow path */
-static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
-							gfp_t gfp)
+static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
+							  gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
 	unsigned int pp_order = pool->p.order;
@@ -616,7 +616,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
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


