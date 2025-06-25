Return-Path: <bpf+bounces-61490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638CAE75F8
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261A55A2DA4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1D1F5827;
	Wed, 25 Jun 2025 04:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB41991DD;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826047; cv=none; b=JdSO9XMFZlTUTh9HV8ZxxEgXh5/1uD++3tywVC/gbQCxVwN+QgLuGq9Am/UjtoYGppLrBwNmSr+HAZjyoucqniuKG08LAPevr1wHMj6JAnk9vEnF/2FA5hqaShtAYt46BXyii62yoqG4NgbIrWYUB/wGQTqit5ItCpIV5q9p46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826047; c=relaxed/simple;
	bh=BpEBqg0Tn6vBpZdUHkN0C1T/n1AoxJGZgoBMWrqDqIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diiWGmQ5fF0rNIhFuGOmMnp1i/vmZOd+sKWqWIMfMRvEaonHx/iuHeHG7c4ExGSZfBRARykkXR5POatA9mg8mgZ+iJDo9b5OrXUEp2/dmqVuvS5GoxcX6lJsinrUNZy5c/ZS5V5KOSIweQ0y8M7PD3cquvj2GH8yY8h064QTMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-08-685b7c38f6bb
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
Subject: [PATCH net-next v7 4/7] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Wed, 25 Jun 2025 13:33:47 +0900
Message-Id: <20250625043350.7939-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9/ds7ZcnS2JE9GBCNLLLsMo9eQ6OOfYlD0KSVy5MGN1GRe
	0jKy1C6amtp1mzmx1DljsZYuMylvaUWFpUzNlGmSkIqXTGdRmxL57eF5n+f3fHlZrLgtDmR1
	CcmCPkETp6SllHTcrzw0PCNKu7PPKAGTrZYG63waVA05xWCqqUMwu9DPwEzrKxoqyucwmN5n
	U/DD5sHwtd3NgNWuhsHKUQoaL9djcBd20JCfvYjh+cIEAxed1SL4UFcghhueBxjqM4cY+Nhg
	ouFL7R8xjDbnU9BpsFAwWLAf2s1rYe7NdwSttnoRzF0rpaGky0zDcPYggq4WNwXGCwUIbE0u
	MSzOexnGti/M/k2k5fskJg5Lr4g8NQwwxGxPIY+rQ0iuqwsTe81VmtinixnyuaeRJh13Finy
	1DkjIvlZEzSZ+tpHkcmmbprYHN0UeWtuZQ7JI6URMUKcLlXQ79gXLdVWDvgnTkvT7JYxlIlK
	JbmIZXkujC+voHKRZEnefvYT+TTNbeFdrgXs0/7cLn7G/cqbkbKYe0jzrbX9jO+whkvhRzqr
	RD5NcUF87/A35GPKvKD7xcHLzI289dGLJY6E282b3FlLWwpvJKfnwpIv4+R8590RylfF3l3b
	PYXPxt5q1hMj9s3ynIPl8147mGXmOv5ltYu6jjjDirrhf92wom5GuAYpdAmp8RpdXNh2bXqC
	Lm37iVPxduR9l8pzv6KcaPrDkWbEsUjpJ9uZE6lViDWpSenxzYhnsdJfdmuP15LFaNLPCPpT
	x/UpcUJSM1rPUsoAmWrudIyCi9UkCycFIVHQ/7uKWElgJio5+lpfnBG8d9RztkHVy9SFt4Wp
	5d+Sx60thfLVVwIreE9EpCVotiwicaM8XPfieOgxo+Pg7wcPNzy7FK+6n+IsU2991PDp3c22
	bTs6Vx3uPpAXSobao/tUG1qKLI1aVVNf3sJ5x+TLmg51kaegdMyIJfOblbFgLVOfbxibyg5Q
	Uklaza4QrE/S/AWk6D61KgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0hTcRzH+Z9zdnY2Wp3WqIM9lENLjEyhy48Uk146FEUvVthDDj204XSy
	qWgXvEwR72Z2cZux0rzNsVjlppXIvBdUaJrlfakZSKVzXoPajMi3L9/L5/fyo3DxGuFDKRKS
	OHWCTCklhYTwXKj2INy4LA+eNAMYLI0kmFZSoXbCzgNDQxOCxdVhPrg6ukmoeriEg+FdNgFu
	yxoO011OPpisZ2G8ZoaAl7k2HJwlPSQUZa/j8Gr1Ox+y7HUYtFf28uB9UzEPytce42DLmOBD
	f4uBhLHG3zyYcRQR0KurJ2C8OAK6jDth6c0cgg6LDYOlwkoSbvcZSfiSPY6gr91JgD6zGIGl
	dYgH6ysehr5zjB/hz7bP/cDZZ/WfMLZZN8pnjdZk9mldIJs/1Iez1oY8krUulPHZkcGXJNtz
	f51gm+0ujC3SfifZ+enPBPujdYBkq2Z/Yqzl2QBxXhwlDIvllIoUTn0oPFoorxmVJC4IU631
	31AGqhTkIwHF0IeZey+WkVeT9H5maGgV92oJHcK4nN1EPhJSOG0mmY7GYb432EEnM1O9tZhX
	E7Q/8+nLrGdMUSIPqLos4C9zD2N60rbBEdBHGINTS3i12FPJGczc8EX0dqa3YorwTnHPXcsD
	sdfGPVPtcz1eikS6TS3d/5ZuU8uI8AYkUSSkxMsUyiNBmjh5WoIiNShGFW9Fno+oufnrlh0t
	9p9yIJpC0i2i4JwouZgnS9GkxTsQQ+FSiejuMY8lipWlXePUqivqZCWncaDdFCHdJTp9kYsW
	01dlSVwcxyVy6n8pRgl8MlBzoe8jSzim76varws/MK60+aa7LkSmnnFUqE7QiYrqlr39z6+P
	MD4R6+KfhyP95kvN1Td63LVfLbPha0fzdi3bs+JLYjsVr8wxH3IjT752hRZMYXGTbQOCwUtB
	d0rcW/Uj6X7lH1Xdtm7T5bddhQU2c546qHjbu7CAVvdxv30aKaGRy0ICcbVG9gcRAeLYDQMA
	AA==
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


