Return-Path: <bpf+bounces-62072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BF0AF0AEF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C51447F9E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B9C223337;
	Wed,  2 Jul 2025 05:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33D1E7C2E;
	Wed,  2 Jul 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435307; cv=none; b=PBrokbclePB82loakerG+dNEppi01j11V71beR+ZVrTIOiRCCTo31pArP8rPB0TXdTrMY95nxfTxzLMQ8ubq8RYuKsek7Cv1iEJL8AsH52aqx2atocMYfFdCgyQ2RAdKLd0FtQxtThJ1yfouNniCtPhdBBfpDgdbTSPHkUu/F+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435307; c=relaxed/simple;
	bh=u0Epei8ZPF+Ot4HQSjUH7Nttos+q9QG8Q4ljT+2pBw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCAA0BmRa5G6l1wcGTDd0jJikhuki8GUHJA9Ej8190ZDc8Otc4vGlNuKsVj4YEsZW1s7jMYjwqev9xLF67tiAqNyTRrWXNDkvfkQ+c8PS/4dttymZ/MzyH5fB2dOeMou17YxfUCBwJBMUq7x9LW1VSmLsYYRHz5Vxr6yIKZWdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-13-6864c492f1b3
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
Subject: [PATCH net-next v8 2/5] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Wed,  2 Jul 2025 14:32:53 +0900
Message-Id: <20250702053256.4594-3-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e+cnXMcWxyX5NGQaBVClqYUvWGl1If+EKEoEeQHne7glpdk
	U9Og0LQybVoZlNuSZWjecrHMS5nYXGp0E82aWV7TTzZL2/JGtSmR3x6e93l+z5eXIaQ6oS+j
	Sk3n1anyZBklIkXfxBU7b1gVyl3O9l1gMNVTUDefBfdHW4RgqG1C8HNhiIY5azcF9+46CTC8
	yyfBYVokYLJrnIY68zEYqZoioe1yMwHjJT0UaPOXCHi2YKfhQku1AHqbioVwc7GSgOacURr6
	nxgoGK7/I4Qpi5aEl7oaEkaKw6HLuAGcr6YRWE3NAnBevUNBaZ+Rgon8EQR9neMk6HOLEZja
	bUJYmncx9C+G6fCtuHN6hsCNNYMC3Kr7QmOjOQM/qt6OC219BDbXXqGwefYGjT9/aKNwz+0l
	Ere2zAmwNs9O4R+Tn0g80z5AYVPjAIlfG610pOdJ0X4Fn6zK5NVBB+NEykFnGUqzr8vKK5si
	c1CXuBB5MBy7m9PqJ4X/9K+PdsKtKdafs9kWVrQXG8zNjXeThUjEEOwDirPWD9Huw3o2g1se
	baDcmmS3cdcbbgncWuICzdmNglXoJq7uYccKyIPdw7V39azkpa7MRIGVWs17ci/LvroGGNeA
	P2cql7ptwlXNe6wn3Lsc28hwFdoiepXpwz2vtpHXEKtbU9f9r+vW1I2IqEVSVWpmilyVvDtQ
	mZ2qygpMOJ1iRq6PqTq3HNOCZnujLYhlkEws6XmfoJQK5Zma7BQL4hhC5iVZ5+eyJAp59lle
	fTpWnZHMayxoI0PKvCUhzjMKKZsoT+eTeD6NV/+7ChgP3xzENkcZ+gOkjphMy4XhxmhG8fR3
	fE1sSHr13ll5WPYRs26L9+x8QWlM5f4DFzvOfH9gu7TnfF/U2/rhUEdJWHmtTOPlW3Di86FI
	j7HNSQMd08cDdKp4i8OeqJ1MigudEfuJr80Hjb0Nzz21XOrAgxF6S3rEoVzP2MP7wrqP7ijy
	eSMjNUp58HZCrZH/BVJz70wtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e+cnZ0tJ8dpeTAiGt0YtBJK3koi+lD/lG70QQgqhx7aSGdt
	ai4KNIVqeEkNcpdiYRdvuZjWZpnXtZQKQ8lmlspMiZRpzda8lG1G1LeH5/m9z/PlpQnJAhlD
	q9SZnEatSJNSIlJ0cGf+pjJnqnJLsW8NmK11FNQGcuD+iIMP5prHCGZmBwXgc76goPK2nwBz
	TwEJ361zBIy5PAKotR2A4XvjJDRfthPgKemioKhgnoBns14BXHJU8aDzZjcf3jwu5sP1ubsE
	2HNHBND3xEzBUN0iH8Y7ikjoNlaTMFy8G1yWFeB/OYnAabXzwF94k4LyXgsFowXDCHo7PSSY
	8ooRWFvcfJgPBDtMz4cEu9fhzskpAjdWD/Bwk/GjAFtsWbihSob17l4C22quUtj2rUyAP/Q3
	U7irYp7ETQ4fDxfleyn8dew9iada3lK48vM0D1sb35KHJcdE8alcmiqb02zelSxSDvgN6Iw3
	PCffME7mIleYHglpltnK/njnJUKaYjawbvfsko5iYlmf5wWpRyKaYB5QrLNuUBAKIpksdmGk
	ngppklnHltbf4IW0OFjk81p4f0pXs7UP25aKhMw2tsXVtcRLgszoFSf1h49guw2fggN0cGAD
	a70lCdlE8DT/kYm4hsTG/yjjP8r4H2VBRA2KUqmz0xWqtG1y7WmlTq3KkadkpNtQ8CfuXVwo
	daCZvn0diKGRNEzc9jpFKeErsrW69A7E0oQ0Shy+KmiJUxW685wm46QmK43TdqCVNCmNFick
	cckS5pQikzvNcWc4zd+URwtjclF/+5jxjnxxo3qHTG5f3n5J91NYsqdCvnbS5hEfuoAjtvQn
	reAf7cvskRWpKve2j7adXR9zJK8cjY3au+MCxxMTo1v3S50NrxtVWi0T5TYkWgOBE48MeSUJ
	E4dmfxX6WuOflp9bdZX/c3rYTzsnfPHLvsyZtm/MGECvIpsy4vRSUqtUxMoIjVbxG0nOZXIP
	AwAA
X-CFilter-Loop: Reflected

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3bf25e554f96..95ffa48c7c67 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -673,8 +673,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
-							 netmem_ref netmem)
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
+							   netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
@@ -721,7 +721,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -1136,7 +1136,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


