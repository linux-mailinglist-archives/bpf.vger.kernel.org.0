Return-Path: <bpf+bounces-61149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C560BAE1230
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93EE5A3958
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA921A425;
	Fri, 20 Jun 2025 04:12:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBABF1E25E8;
	Fri, 20 Jun 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392759; cv=none; b=DSM4WvOK3hsDTYmLyFzxBfZ+XNPH4zNDOOZvj/oYFof1XsHtiIGLvRBR2Pk2Nb2fFioUaHtHyYx7I/NBY0yVB9+++R0Z1MCp51Z+lKlJ20i+AEdUzmmWZJWIYAlGfa3pXz4SeF9tjkJsvfDPjADOWlHr0RU+Zk4EtIl3Lo06zNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392759; c=relaxed/simple;
	bh=u0Epei8ZPF+Ot4HQSjUH7Nttos+q9QG8Q4ljT+2pBw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4I/QlOpN+I0OMcl1lna3XUPtoQo9HUi2SMT/Io20TJ8ODEjG5BA1nPprlmvKuvfpIgdeNZECToYT9sJwK14XCZU+JbXkS04/xQw3nMMkojXyWu2o0LGHKLQpmVeGV8IkjEwQOAHda92aD5oimVyvWsgi0sUy+Fc5ATTBsKrZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6a-6854dfb2541b
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
Subject: [PATCH net-next v6 3/9] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Fri, 20 Jun 2025 13:12:18 +0900
Message-Id: <20250620041224.46646-4-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fevec4XJ2W6MkLwTKim2ZpPFCJH4pOQTfsU/dTHtpoXtp0
	aRfwspRG2sWinFYzy8xZi3VxWobp8laRmMXMarHSIpaW2vAS1FZEffvxPL////nyMJTirDSU
	Uaeki9oUQaMkMiz7Eli+wObapFrYfTIOyqw1BCyjmXD1nV0KZdV3EYyM9dIw7GglUFHupaDs
	mQHDd+s4BX0tbhostrXgquzHcL+glgL38TYChYYJChrGBmjItVdJoPNukRROj1+hoDb7HQ3P
	68sIvK35KYX+pkIM7aZrGFxFCdBiDgbvYw8Ch7VWAt5j5wkUd5kJvDe4EHQ1uzGU5hQhsD5w
	SmFi1NdR+ugtnRDJN3sGKf72tR4JX2d6Q/NmWwZ/q2oub3R2Ubyt+ijhbUOnaP71y/uEbzs3
	gfk6+7CEL8wbIPy3vleYH3zwgvDW2y8w/8TsoDdM3SxbliRq1HpRGx2/U6bq8ZagtIHJmXkl
	/TgbtQQaEcNwbCz3oXzOX/zUt9yIAhjCzuaczjHKz0FsDDfsbsVGJGMo9jrhHDW9tN+fxmZw
	jR9T/Q5mZ3EXHxuxn+VsHJc74vnNHDuDs9xs/N0TwC7hvuXeI35W+JzRSwbpH38q117yAfsr
	Kd9d6wWFf0z5onl3Sin/WY61M1zx5x7yp3M697DKiU8g1vRf3PQvbvovbkZUNVKoU/TJgloT
	G6XKSlFnRu1OTbYh37tUHv6xxY6GOhObEMsgZaDcPpKoUkgFvS4ruQlxDKUMkle0rVMp5ElC
	1gFRm7pDm6ERdU0ojMHKEPki7/4kBbtHSBf3imKaqP27lTABodkovnia/syU3g0GyfOv4S3C
	vob16vR5ujtbGwocCSuEybGK45VHInVJLrpvldCZf3A+ypnTcfFyd3dHffBMy7mY6xFke/ik
	8LGI9R4menOFJSiuZ+H7/HHHy5Ara0J3tR6qH0zYFqEP+WqZVLM67AbReDaGB4zULV6SvNKd
	F7L06TajEutUQsxcSqsTfgEbdLEqKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXfenZ2NTU5L6lBQMLBIyDKynshC+tIpUqSESAJbemjDOWNT
	c0Jkm1CNtOuHnDNN826tpuUsJ97yglDDMLZuGystQzTbmpdltRWR3348z+/5P1/+FCFdxGso
	pTqX06jlKhkpwqLk3YbNVneqYusN5wYwW1pIaJ4vgHqPjQ/mpscI/AtvBODrHySh5k6AAPOL
	YgzfLYsEjA94BdBsTQJ33QSGzgvtBHivDJFQUhwkwL4wLQC9rYEHfRXDfHA8LuXDzcVaAtqL
	PAJ4+cRMwvuWX3yY6C3BMGxqxOAuTYSBqlUQGJlC0G9p50HgcgUJN0arSPhQ7EYw2ufFUH6+
	FIGly8mH4Hwoo/zZe0FiNNs3NUOwbY0uHttheidgq6x5bGtDDGt0jhKstekSyVq/XRewb191
	kuzQrSBmO2w+HltimCbZ2fHXmJ3pGiPZms9feaylbQynSNNECZmcSpnPabbsPSFSuAJl6PR0
	ZIGhbAIXoQGxEVEUQ29nPo/vMSIhRdIbGadzgQhzFB3H+LyD2IhEFEHfI5n+ljeCsL+SzmO6
	P+WEHUxHM5UjRhxmCR3P6P1Tf5ih1zPND7r/5AjpHcys/ikZZmnIma8u5v/1VzDDZR9xOJII
	/bXclobHROjU8KicuIokpmWW6b9lWmZVIaIJRSnV+dlypSo+Vpul0KmVBbEZOdlWFGpE3dkf
	12zI/3J/L6IpJBNLbP4jCilfnq/VZfcihiJkUZKaoWSFVJIp1xVympx0TZ6K0/aitRSWrZYc
	PMqdkNKn5LlcFsed5jT/tjxKuKYIFT6fWbTINmUc63CRHnH1/JcPP5NBlJuYuus7WX3GY30Y
	ETe3b53GcfxVWoT9pMq+kJEkzq1VfdW7TtUcELdm1vm2efd1F6p3Lh1cSpiLqtDNYsmL1Rc/
	1j+ovJu+/35DnuPSIV2jzxG5V9l6bbInxXou/nDB5JjB7ukJCvPNJhnWKuRxMYRGK/8NAkkI
	4A0DAAA=
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


