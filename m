Return-Path: <bpf+bounces-59244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9744AC762F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FE817005E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F632566D7;
	Thu, 29 May 2025 03:11:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7D24469E;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488271; cv=none; b=LRLDurr2rYzsCB73Bro9mcixy9e49twJSlVdpqf2I6tW7PBbZms+CmkoHQeY3ujWzvWGEYJusX7FsEMMPDmJ8zREMp3zj7xB7spRKdpj4kYR5gaoDJ9JGBLuw0SA+JeNVmoArh8NcN2KGDnr+TzmYU0btEpleu67cEZ0o6JjYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488271; c=relaxed/simple;
	bh=us/ep2twu4oD+HDNTFDt0qYJmmC2fND/7bX8UIm19M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ojgKZEaN/Rl4l4BPavgRsYQtqBjvJ3F0paGFAZAOtSscj2JHkq6pTyh2R6s57hk3bTUUgrhWCYdSLQ/3M/uL8xBJCrbglWrPvnlRcjK0kjIidUv8/ULq6hfWWUVS/EvMYEZWvxuzufjcw7it6alZDBPKvbFq6eeOTYlaegXzo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0a-6837d042f86d
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
Subject: [RFC v3 07/18] page_pool: use netmem put API in page_pool_return_netmem()
Date: Thu, 29 May 2025 12:10:36 +0900
Message-Id: <20250529031047.7587-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnXNcDk5L9GRQNLpIWKmZvlCUBMK/C6T5IbAPuvLQRnPK
	LHXVxNSyrKl0o3TiNDI1bTFvM0VzLi/YZVnWUktTNMS0UhNtkW2K3368z/P8vrwMIWkjfRiF
	6iyvVsmUUkpEiiY9ircfsIXI/XV9EtAbKyl4PJ8Cj4bMQtBX1CGYXeinYcbaQcGD4jkC9G8y
	Sfht/EPAaPswDYOlYyQ0ZdUTMJzbSYEu00FAurlMALa6HCHc/vOQgPq0IRrePdNT8KVyUQhj
	Fh0JXfnlJAzmhEK7wQvmur8jsBrrBTB3o5CCWz0GCkYyBxH0tA2TUHApB4Gx2S4Ex7yeCt2I
	a8o/CXBD/mcaG0zncHXZNpxt7yGwqeIahU3TN2k88KGJwp33HCRuMM8IsC5jisK/RvtI/KO5
	l8LGml4SvzRYaTxjWh/ORon2xvJKRRKv3rkvRiS/89ZGJ6SJU369Tk5DE6Js5M5wbBDXMW4T
	rvD42HXSxRS7lbPbFwgXe7IB3Mxwh/MuYgh2SsiN6h0CV7CGPcZNtKXTLibZzVx5bquzxDBi
	pygrW7ns3MA9fvp8yePO7ubuVt9dmkqclfvZrZTLybELNPeqtppeHqzlWsvsZB4SG5BbBZIo
	VElxMoUyaIdco1Kk7DgVH2dCzteWav+eMKNpW6QFsQySeog7UYhcIpQlJWriLIhjCKmnOH1/
	sFwijpVpzvPq+Gj1OSWfaEHrGFLqLQ6cS46VsKdlZ/kzPJ/Aq1dSAePuk4YCV7s9dXN0e1/x
	/Yq2RF+MW/hR8e1wdIvgfXirj1dqYUb4Ef1ko/ZoZETqomrPyPYkOtNS5Wf7eHJdekng5Rc/
	B8IWrzbOrmrB1l19ef9KrLUjB8OQ5kIbW1qkVfr7DUVoirqiGjeVmw8lFGhti1pZcH9BzRNf
	naKKbroTIzpxXEomymUB2wh1ouw/V9ha8tYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnXOcDY5r6EGhaCCF4C00X1DUbnT0Q0h0kQp05LEN55RN
	zVmRqWBZal6SsgkTzTst1JymSM67iXlBsUxni43KvKWJl7Km0bcf7/M8vy8vhYkqcRdKrkzk
	VEqpQkIIcMHZgAyPEyP+Mm+9AQetvp6Auo0UqJpr4YO2thnB2uY0CavdfQSUl61joH2XicNP
	/RYGll4zCaZKKw7tWQYMzHn9BORkbmOQ3lLNg67SAT6MNOfyoWjrOQaGtDkSxl9rCZit/8MH
	qzEHh4GSGhxMuSHQq3OC9bffEXTrDTxYf1hKQOGYjoDPmSYEY11mHJ7dzUWg75jiw/aGlgiR
	sE0173lsa8kMyeoaktjGanc2e2oMYxtq7xNsw48Ckv042U6w/U+2cba1ZZXH5mQsEuyK5QPO
	LnVMEGz5l2Ueq2+awNkhXTcZ7nhZEBjNKeTJnMorKEogezw6QiakCVNWhm+koXlBNrKnGNqX
	+Wp9gO8yQR9mpqY2sV0W0z7MqrnPdhdQGL3IZyzabd5usJ8+x8x3pZO7jNNuTE1ep61EUUKb
	KCtb8c95kKl7+WbPY0/7McWNxXtTka3yNLuTeIQEOmRXi8RyZXKcVK7w81THyjRKeYrntfi4
	BmT7XuXtX/ktaG38jBHRFJLsE/Yjf5mIL01Wa+KMiKEwiViYHnxMJhJGSzWpnCo+UpWk4NRG
	5ErhEmdh2CUuSkRflyZysRyXwKn+pzzK3iUNtfZEOlzxCBcHqT6ttNkluBeQXrLZ8lGnst/G
	aeeFo9alQN9Ca0SYY9zw6bZWrTkiXLPgoDwfPFEUJQ7pXg48lLpz9WZAaN+LilOd33bunTT1
	DFVsxXhnBXCWebdbk7GDB+5UNR+/YC3x72sfNV10XcspcjNu5s+EDsa8mnQ+shYuwdUyqY87
	plJL/wIYqxOguQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use netmem put API, put_netmem(), instead of put_page() in
page_pool_return_netmem().

While at it, delete #include <linux/mm.h> since the last put_page() in
page_pool.c has been just removed with this patch.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 633e10196de5..4368beda1e08 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -20,7 +20,6 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
-#include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
@@ -712,7 +711,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 /* Disconnects a page (from a page_pool).  API users can have a need
  * to disconnect a page (from a page_pool), to allow it to be used as
  * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
+ * page-allocator via put_netmem()).
  */
 static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
@@ -733,7 +732,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 
 	if (put) {
 		page_pool_clear_pp_info(netmem);
-		put_page(netmem_to_page(netmem));
+		put_netmem(netmem);
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
-- 
2.17.1


