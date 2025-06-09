Return-Path: <bpf+bounces-60031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49EAAD17F2
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E97A5B24
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A31280CFC;
	Mon,  9 Jun 2025 04:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D92459CF;
	Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443562; cv=none; b=EIyXVC27ZklYgqqAgodvadr50v1gLZXK5SZmeGev5TULtzXm8bPVjLazIi8LyKP9xxqmN9YNtpqg/H7p7g9SVFxHjdGZSPH0FDP+U67SbaBX2P0pM0unvZ4tPtWtPeGwCqv7Rfgcput0cjUBi04eUw4nPcxiWF+DDNl9JF5qHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443562; c=relaxed/simple;
	bh=JiunAmghWfLF1JvmLdqj2YRT/ONAJMGiW3tMys3xPhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5h/6iRYK4YF2YMK74Z2u278L2sTrkfcMJzNDpoY2VkDpQN7RX4RjyyMtXB7F1T+J1QztF7FNIOBAPHbQlP92vjt+KBmhbCvHbKg6Ag2Ec8widnSy2KCK8/A1DcqAroREjXeGYqIYV0EmbJr4DiXka9DJjF1YAAKmNGDGqfi/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6e-684663e342a4
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
Subject: [PATCH net-next 4/9] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Mon,  9 Jun 2025 13:32:20 +0900
Message-Id: <20250609043225.77229-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRjF++9/793danCbojeLwlEUQmpl9ZgRViSXoAj6EvVBR17baJpu
	vkaJpVCNZpGVOWdMRJsvtFyWq2zWHE7pTSx1Wb6wZVHUzK2GNqlcEvXtcJ7zO+fLQ2PpOTKK
	Vmbl8uosuUpGiQnxl0W1az2HUxTxXmciGMwtFDRPF8KNcSsJhqa7CL7NvBGC3+GkoK42gMHw
	ooyA7+YfGCa63UIYa3hPQMeZdgzuCz0U6MqCGE5bTQLou1tOwuUf9RjaS8aF8PK+gYLRll8k
	vLfrCOjVNxIwVp4M3cYICDz5jMBhbhdA4HwNBRX9Rgo8ZWMI+rvcBFSfKkdgtrlICE4bqORo
	rq3xtYC7px8RckZLHnfbFMNpXf2YszSdoziL75KQezvYQXE914IEd8/qF3C6Ui/FTU0ME9yk
	bYDizG0DBPfU6BByfsvyfcxB8dZ0XqXM59Vx29LEiq6PU8Jsn7jQ6faSJahGpEUimmUS2Cun
	BwR/deuQmQxpilnNulwzOKTDmXWs3+0ktEhMY8ZLshOG4B8gjFGzQ91fKC2iaYJZxdrORoRs
	CbOR/fS8k5zvXME233qEQxERs4kdd+WGbOlcxP7KhOfji9neqndEKILnZs3XpSEbz5Gld6px
	aJVl6mnW0XMVzVcuYR+bXMRFxOj/w/X/cP1/uBHhJiRVZuVnypWqhFhFUZayMPbwsUwLmnuQ
	hpOzh6zI17ffjhgayRZJ0ip3KaSkPF9TlGlHLI1l4RJmbKdCKkmXFx3n1cdS1XkqXmNHS2lC
	FilZHyhIlzJH5Ln8UZ7P5tV/rwJaFFWC9iz0+c88SDTlMIOjcQW3Lj6fQifsJarqYkfBnaSv
	G3QXMiq3TEbO5u1w/0werNy85lnAQx2ILL3S2bdxV8p2UuT7LOo9IU1dmR4/wlZMFbd4TymH
	d/szaha0Fjc7Tz7Mn9j79kNVWEZC5vmZ4rZfSRW2D8+u1hUm2XKIm4c8y6JpGaFRyNfFYLVG
	/httt+AqHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe/bce3cdDm5T6lpQeSsEKZuScaBIKdKbHyL6EkUvDru10bZs
	U1MrshS0kfaiUK5Zi8h3ubmszRKzKZpkb760ldVkpWSkZdOhLiiHRH378/v/zjlfDo0V34gl
	tEafIRj0Ki1HyQjZjo35az+lJamVY5VrwCLWU1A3nQ1VQw4SLLUPEEzODErB19FFwe1bfgyW
	lwUETImzGIY7vVLwVI4Q0FJox+C9+JSC4oIAhnOOagm0V3ST8OpBCQlls3cw2POGpND30ELB
	x/rfJIw4iwnoNtcQ4ClJhE7rIvA/+4agQ7RLwH+hgoLSXisFnwo8CHrbvQRcP1uCQGx1kxCY
	tlCJHN9U81bCN5s/SHmrLZO/Vx3Nm9y9mLfVnqd4288rUv79mxaKf3otQPDNDp+EL84fp/iJ
	4XcE/711gOJvf/kh4cWmAYLvsXZIdy7cK9t0SNBqsgTDus2pMnX76IQ0/acsu8s7TuahihAT
	CqFZZj3b6BLJYKaYKNbtnsHBHM7Esj5vF2FCMhoz4yQ7bAlIgkUYY2BdnWOUCdE0waxmW4sW
	BbGciWe/vnhMzu9cztbdbcNBJYTZwA65M4JYMac4+6vxvL6Q7S7/TAQVPHdWvKEIYjw3mX//
	Or6E5Ob/LPM/y/yfZUW4FoVr9Fk6lUYbH2M8qs7Ra7Jj0o7pbGjuBypP/7rsQJN9yU7E0IgL
	lade3aZWkKosY47OiVgac+FyxrNVrZAfUuXkCoZjBw2ZWsHoREtpglssT9ktpCqYI6oM4agg
	pAuGv62EDlmSh+yuqT2RB/oFT155g+9mf1rCzv6TM6umcneZ/LvGRnO5w4X7I5QxjyaiQo8n
	l0WktBmkLa/FQVqhPZGomxqNqLaUntlxqrG5cdReHGZMjluxtuH5loTnI7oqy3flSu3QsvdR
	fVzR9sh9CZETLq0xLvCFSFq5wFam9P7oaSPrnpRyhFGtio3GBqPqD0ndHOv/AgAA
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
index 8d44d1abfaef..a9189ad1044b 100644
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


