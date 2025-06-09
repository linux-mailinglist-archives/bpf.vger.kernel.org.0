Return-Path: <bpf+bounces-60030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5BAD17E9
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1443ABA0C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF328033C;
	Mon,  9 Jun 2025 04:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3335248F65;
	Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443561; cv=none; b=a5GPMpQXhN2Qd3i+aHfxAYZ0gHttHfk9OLA4hcjFuEGB78HbO9X4mPdj7TdxXteNd/+0UATGwofHFH4PezdezWY5XqShhGM84iQ2D8dxIU78LITihBVgyf9tN1O6e4cDXCjE53OE8TXPZFUN3Cq1g2VmYl2srutEN0QiUNK5iVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443561; c=relaxed/simple;
	bh=ZflgS0K6ShKnO9nFxZAsfAkWsyflfsEmT4GLmM53QkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJxKlw14GUlqWT43ymTFhcdzL5KbmdvOEDjXnLMzo6cuSCkSF8eUA70tUb7nPzh31uLouyALC3T+yT9HlHcC+zacEYPYYq5DdCxjNaKiAm9ITxStyliT3jUlp0+eIjUXe9gJhwhJSN8BTIbHWQjTDY4FJW31YZ2riRJtm1DOD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-63-684663e3785b
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
Subject: [PATCH net-next 3/9] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Mon,  9 Jun 2025 13:32:19 +0900
Message-Id: <20250609043225.77229-4-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRTG+7/3ja3eltWbgdEoKi27WZ0PGUK3l76UFAb6QUe+ttU02cVU
	ENSs0HRFSdZcMZGZN1jOvFZiS5yWkpjKum6YCuGtmom6bpsm9e3hPM/vPOfDYXBZLhnIqJJ0
	giZJoZZTYkI8LinZ9unMEeWOpsthYLJWU1A1kwoP3I0kmCrrEUzNvqPB0+agoLRkGgfTqxwC
	vlvncBhuH6TBVTZCwJOrDTgMXu+goCDHi0N2YzkGPfUGEgrnLDg0ZLppeN1souBj9W8SRuwF
	BHQaKwhwGSKg3bwKpl+OIWizNmAwnX+Pglu9Zgo+5bgQ9D4fJKA4y4DA2uIkwTtjoiLW848q
	3mB8k/EDzZtter62PJjPc/bivK0yl+Jt327S/PuBJxTfccdL8E2NHowvuDRB8V+H3xL8ZEs/
	xVsf9RN8l7mN5j22oBNstHh/vKBWpQia7QfixEqHXZtcszS13lBEZiKDJA+JGI4N4z4bLNSi
	fnqtZl5T7CbO6ZzF/TqA3cl5Bh1EHhIzODtBcsMmL+Y3VrAazjA6N68JdiM37qydh6XsHm6o
	Z4ReWLqOq3rY6lvEMCJ2L+d26vxjmS9i7yvHF+LLuc67Q4Q/gvt6rfdl/jHuIy/VFeP+Wo61
	MNzTnO6/d67hnpU7iRuINf6HG//hxv9wM8IrkUyVlJKoUKnDQpVpSarU0DMXEm3I9yBlGT9i
	GtG3npN2xDJILpHGFR1WykhFijYt0Y44BpcHSFnXQaVMGq9ISxc0F2I1erWgtaO1DCFfLd01
	fTFexp5V6ITzgpAsaBZdjBEFZqKK/sJg7RerhTrmbs4/hGGucJ2o+Su578HWmqmNc9kxua2n
	9J2joByHKsuyqC0bhkrroetKxmf3T7LoRkCWYTb69koiqLlLN/FibElk2GSCPiG1INwR8zta
	cpQMPX2wLl3t2F3b1308FlhjVmHU5pBNIVsi23seD9C/ziXHrpETWqViZzCu0Sr+ALHqoQkc
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRzF+e0+dh1OrnPYzchw0EvUMlK+lIUQ1aUwLOllhI68tKGbsqnM
	IFlpSJazMrXmlJU9fMVy6lxREnNMpSKxByuzzakjyOyhDV9RWxL13+Gczznff74UJprEIyi5
	Mp9TKaU5ElKAC/ZtLYkdO7FLtlHbtgYMpjYSWmc1cNdtJcDQYkEwMzfMh2l7HwmNN3wYGF6U
	4vDDNI/BhMPDB9cdLw6Pyrox8FT2k1BRuoDBWWsTD3rrBwgYtOgIuDp/G4NurZsPLx8aSPjQ
	9osAr60ChwF9Mw4uXTI4jOHgezqJwG7q5oHvYj0JVUNGEsZKXQiGej041J3RITD1OAlYmDWQ
	yRK2s/ktj32gH+GzRnMB29EUzZY7hzDW3HKeZM3fr/DZ928ekWz/tQWcfWCd5rEVJVMk+23i
	Hc5+6XlNso0fv/JYU+drnH1mtPNTQ9MFSVlcjryQU23YnimQ9dnUee0hGouultAiXXA5CqIY
	ejPz+EI7GdAkvZZxOuewgBbT8cy0pw8vRwIKo6cIZsKwwAsEYbSK0X2a/6NxejXz2dnxpyyk
	E5jxQS9/aXQV03r/iX+IooLoRMbtzA/YIj9ie9WELeGhzMD1cTyAYP67pgZRwMb8zZKuOuwS
	Eur/o/T/KP1/lBFhLUgsVxYqpPKchDh1tqxIKdfEnchVmJH/B+6cXrxsRTMvd9sQTSFJsDCz
	dqdMREgL1UUKG2IoTCIW0q4dMpEwS1p0ilPlZqgKcji1Da2gcMky4Z7DXKaIPinN57I5Lo9T
	/U15VFCEFhUvf95prr2iOyp+uiltZGX1zoPFs/19UfMa163pQ+MpW6qE7puLeHJNntLysC4y
	xmh3esoa0qtC74UnWbyjo0mXNh4YzqgguvbP7U2Lrs4KYcpjI4fVelVMQ80Rl/WcI0F8O+V6
	PN8zGWk/nlqjF25rTnRURv1cF3bMpfCtb6+W4GqZND4aU6mlvwH5on6O/wIAAA==
X-CFilter-Loop: Reflected

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 460d11a31fbc..8d44d1abfaef 100644
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
@@ -1139,7 +1139,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


