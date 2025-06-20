Return-Path: <bpf+bounces-61146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C9AE1226
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554A8174556
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BEE2036F3;
	Fri, 20 Jun 2025 04:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4C1DED5C;
	Fri, 20 Jun 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392758; cv=none; b=QvEpWUXVPKELoHJP8SQPdvq8z4HpCorB7WwxDhoyH6apGvP2Ys67YAHvuaaeWz5Lnu/P0ei699x4x53Qcc/rIYi3djl5zLx1pORPptC2uQg26n8jFW2marooO+7MDRwyIsedJ/Skp31GysvlVnkCxGiPZeMMD6S2D08XTlebKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392758; c=relaxed/simple;
	bh=BpEBqg0Tn6vBpZdUHkN0C1T/n1AoxJGZgoBMWrqDqIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9JV1U09pZSNz5IelJ6TLy7oFNeF/uwSV2Jj5C+8GirpWJeN4tFkI4IjTWxGxQ93ZcE37JErJdQXElKKLON9yhtX4ROqODRDktq4IEMlOxhtOtXFHu89MQ2csdUQ787raIhHRK0ndvvpPJWBzqG4fnkObFS6Ag+fgajWLEE8EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-75-6854dfb227fc
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
Subject: [PATCH net-next v6 4/9] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Fri, 20 Jun 2025 13:12:19 +0900
Message-Id: <20250620041224.46646-5-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUhUcRSH+c9dHZy63ga9aQtNhiRoGi6nrPChh9tDEdSDlVSDXprBLcYl
	FSrTAUnSIhNs1BoV17FGxm1cklJzDVLLmHIZGVNaXHBNncpmlKi3j3N+3++8HBpjcwlXWhkd
	J6ii5ZEyUoyLZxwLvWrM5xU+E1LI11eRoFtNhLJxIwH5lfUIltaGKVjs6CKhuHAFg/y3ahyW
	9esYTHZaKNAZToO5dAqHlvQGDCz3u0nIVFsxeLE2S0GqsVwE/fVZBDxaL8GgIWWcgndN+SSM
	VW0QMNWWiUOPpgIHc1YwdGqdYaVvGkGHvkEEK/cKSMge1JIwoTYjGGy34JB3JwuBvtVEgHXV
	1pH3eowKdufbp+cwvrbio4hv1IxSvNYQz9eUe/IZpkGMN1TeJXnDwkOKH/nQQvLduVacbzQu
	ivjMtFmSn5/8hPNzrUMkr68dwvk32g7qrNNF8bFwIVKZIKgOnbgqVpSOSq8viBMNFV9RCipw
	yEAONMf4cZMlWvSXey2TuJ1JxoMzmdYwO0sZX27R0mWbi2mMeUZyHVXDlH2xg4nnlp/qCTvj
	zAEu7XHqpixh/LnBohJ8q3Qvp6t+uVnkwARw86nNpJ1ZW2a1SE1s5Z24nsefbXnadsCD0z9h
	7WPMpqbV5WH2uxxTS3MD+lZqq3Mn96rchD9AjOY/XfNP1/ynaxFWiVhldEKUXBnp561IilYm
	eofFRBmQ7V9Kb/68ZEQL/efaEEMjmaPEuHROwRLyhNikqDbE0ZhMKinuPqNgJeHypGRBFXNF
	FR8pxLYhNxqXuUgOr9wIZ5lr8jghQhCuC6q/WxHt4JqCdDmWLz/2KRqbUqSX91sriI2DTE0o
	jIUEbrhbPCMczaMX3u8+Wp1dInGt673VWbDBotKQHGcdgYp+W4WnbnXvRtJ/uSwXh30rC5B5
	dSVrb/sXHnHekxhj+H7gitK1OQuCZmB72Ul2Kk7Wpw4UD/iMa4lTPmOhQebj29jnuzpleKxC
	7uuJqWLlfwBO5gJLKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRjF+e+9bjl4W1IvCVkDKQK7QMZDSRh0+SfM7AJBH6pRL201Z21e
	phSZG4SS2g2sOctLW3mJ2TKdZlFzLS0oWyRL08nKlaFmaaIuqk2J+nY453fO8+VhCVmIXMyq
	tRmCTqvUyGkJKUnZaIx3+Peq1vivxoPFXk9D3ZQBbg04KbDUNiGYmO5lYNz9jIbqykkCLK9M
	JPywzxAw6AkwUOdQgN8WJKHtXDMBgZIOGopMIQIeTo8ykO+8LYL28k4KupqKKbgyYyWgOW+A
	gTetFhr6639TEHQVkdBpriHBX5wEnoqFMPliGIHb3iyCyfPlNFz2VtDwweRH4G0PkFB2thiB
	/ZGPgtBUeKPsaT+TFIfbh78SuLHmnQi3mPsYXOHIxPdur8SFPi+BHbUFNHZ8v8Tg991tNO64
	GiJxi3NchIuMozT+NthD4q+P3tK4+vOYCNsb35Kpsv2SxCOCRp0l6FZvOiRR2fqiT3yXGBw1
	QygPlYsLkZjluXX888AgGdE0t5z3+aaJiI7m1vLjgWdhX8IS3B2ad9f3MpFgAZfJ/7hhpyKa
	5OJ447X82bKUS+C9VVZybjSWr2t4PDsk5tbz3/If0BEtCzNTVSZqjp/Pd177GObZ8IHlvP26
	LGIT4arxfhlxAUnN/1Hmf5T5P6oCEbUoWq3NSlOqNQmr9MdVOVq1YdXh9DQHCr+E7fTPi040
	8Wa7C3EskkdJnRN7VDJKmaXPSXMhniXk0dLqjhSVTHpEmZMr6NIP6jI1gt6FYlhSvkiavE84
	JOOOKjOE44JwQtD9TUWseHEeSm30FPg/WZ6OWVdk4C29doVvj2XbgcT4HdWbN4hf9/CK0gHr
	sn03+jiPGavl7iiF4Xx2ws2uuzFnSpYYRlJaD9t6tC9jT9XZSphjtcyuIasl6F+q+dIQrGza
	qTLnssmfTjrSNTmlI4k1S4xn+7J3z9t6M900097d8KTl5C8qKCf1KuXalYROr/wDnSYNGg4D
	AAA=
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


