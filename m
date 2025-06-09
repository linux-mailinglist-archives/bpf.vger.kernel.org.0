Return-Path: <bpf+bounces-60035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70CAD17FA
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ABD16B049
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79484283FF0;
	Mon,  9 Jun 2025 04:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AF280334;
	Mon,  9 Jun 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443565; cv=none; b=RyaN+Z1ZmmpOysE4noM77YKG/JS4LZa5hMe6U1eGwHJnrbqJXh9WDA8WXCPe2SAPJOqPeMwFFW8L1dxbHgQJB/fyAJOUl4NBhbLuuuZYq62rBjom7PpkjpEfnGvmxC/SJ+0pGHWz+5l5Z5RwYtR1AHK/3NkgJwTwxEZzpq0WOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443565; c=relaxed/simple;
	bh=Lmy+RFwqYXPu6N1bxf4/Xzdmx3q5DYPNxpm9jG4/57A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9wm0zTthy+Jj9AlVa8gldBINJv95FTeaLEhwgMdgu2rm+F5iBk5l2eDzZXWJdYNF+w7Hxw+U1X2Vfg6Qb/cAOfsnTVwouLaalf6KlE51eer4yHbxvjn+DNp2amOV/VvJUCPG2D4Is9IPoVDQ4Qt+l0X36lP4s2S0/C//EqJP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a3-684663e4a09b
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
Subject: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct netmem_desc in page_pool_page_is_pp()
Date: Mon,  9 Jun 2025 13:32:25 +0900
Message-Id: <20250609043225.77229-10-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRjHefe+5+y4XJ1m1MmyaBTVUMuweC5KhDDerpLsoi/IMQ9tNT+Y
	H2mUaC6qpRalqHPaxLKpxWLlXCFRU3KipGnF+tQ0vSojV2NqUZ4k6u7H//l/3DwcVl1gIjlD
	Ro5oytAa1ayCKD6HN8R81O3Sbw7cjgSb8xYLraF8uDniYcDW4kbwbfqNHAJd3Sw0NgQx2PrN
	BL47ZzCMPxmVw3DTBIGOc+0YRi/5WCgzz2I443HIYMBdzkDFzA0M7UUjchh6YGPh/a1fDEx4
	ywj0WJsJDJcnwhP7Ugj2fkLQ5WyXQbC0joWrg3YWxszDCAY7RwnUFpcjcD70MzAbsrGJa+i9
	5lcyet/6Tk7trlx616GhFv8gpq6WCyx1TV2R07cvO1jqq54l9L4nIKNlJZMs/Tr+mtAvD1+w
	1HnvBaF99i45DbhWJfMHFdvTRKMhTzRtSkhV6Mdaf8qzyiLyK3zl8iJ0mbegME7g44XQ+Q5k
	Qdwfnr64UJJZfr3g909jiZfwcUJgtJtYkILD/CQjjNtmZdIhgs8UJp5V/GHCrxMaq32MxEp+
	m9BWOYnm+1cLrXceYak/bE4f8edIsorfKnifO/C8fbHQU/ORSBY8t+usV0kynkuWtNViaVbg
	mznBe+0pma9cLjx2+MllxFv/i1v/xa3/xe0ItyCVISMvXWswxsfqCzIM+bG6zHQXmnuQptM/
	DnnQ1ECKF/EcUocrU6uS9CpGm5ddkO5FAofVS5T88E69SpmmLTgpmjKPmHKNYrYXreCIeply
	S/BEmoo/qs0Rj4tilmj6e5VxYZFF6Fibp7/CJla+2xh8rNvXtHL3RJU5qy96ES7cMBT5cqiR
	FkcpNHFRnWtjDpRsSFiZYExJrA3jY2Xvx0KdDaVLDx/ScSl1bG54YZJhf4zPvMOgi6mewXtZ
	Nxa6a5M1jhBx2w52LqhxX7fsMd+erDGm1g98iH6jOdXeezY1V8OoSbZeG6fBpmztb/NMs34c
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHefeenR1Xi+O0PNSHYlCBpSmkPFCUdH0TunyIAgly2KkNr2w6
	NJGsSZG6lWlYa9rSNG+0mDO1MmKazgpWmrGu2qbrgpe8ZM0ltRVR3378/7/neb48DJaOUksZ
	ZVomr0qTp8hoMSXes0EbMZy0QxF1s1cMRnMTDY3fs+HGUJsQjA23Ecx4X4tguquHhuprsxiM
	jgIKvprnMIx0u0QwWOuh4N6ZVgyuc3YadAU+DKfa6gTQWdErhKe39UIom6vB0Jo/JIL+O0Ya
	3jX9FILHpqOg11BPwaA+DrpNS2D28SiCLnOrAGaLK2go7TPR4C4YRNDX6aLgykk9AvN9pxB8
	3410nIxY618KSLvhrYiYLFmkuS6cFDr7MLE0nKWJZeqCiLx5cY8m9ks+irS3TQuITjtOk8mR
	VxSZuD9Ak+qPXwTEbB2gyBNTl2hfcIJ44xE+RanhVes2JYoV7sZ5UYYuJLvMrhflo/NsIWIY
	jl3PeYsWFaIghmZXc06nFwc4lI3mpl09VCESM5gdF3IjRp8gUISw6ZznWdlvptiVXPUluzDA
	EjaWa7k4jgLMscu5xlsPcGB/kD8fcmYGYikbw9me1+E/ejDXe3mYCijYf9dcKQ3E2D+pbbmC
	zyOJ4T/L8M8y/GeZEG5Aoco0TapcmRITqU5W5KQpsyOT0lMtyP8DtXk/StrQTP9OG2IZJFso
	SSzfrpAK5Rp1TqoNcQyWhUrYwa0KqeSIPOc4r0o/rMpK4dU2tIyhZGGS+IN8opQ9Js/kk3k+
	g1f9bQVM0NJ8VJqbm7BmNq7809ptSf1lVbn1u+5q5n/OPD26IiJ8xUzF1eLTGZ74kqH18Q7b
	xIGQbwtqwuaryFRJkSc42xS1/3py8+6zxoef3avmqysjHMWTH/IiMmtyo7Zv3rJ3rMOreueY
	cy8+4bt+yKrhvR3WIqPuUWls3cgGV8f7sWXFl7Vz5TJKrZBHh2OVWv4LhMCT+P8CAAA=
X-CFilter-Loop: Reflected

To simplify struct page, the effort to separate its own descriptor from
struct page is required and the work for page pool is on going.

To achieve that, all the code should avoid directly accessing page pool
members of struct page.

Access ->pp_magic through struct netmem_desc instead of directly
accessing it through struct page in page_pool_page_is_pp().  Plus, move
page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
without header dependency issue.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/mm.h   | 12 ------------
 include/net/netmem.h | 14 ++++++++++++++
 mm/page_alloc.c      |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e51dba8398f7..f23560853447 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  */
 #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
-#ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
-#else
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return false;
-}
-#endif
-
 #endif /* _LINUX_MM_H */
diff --git a/include/net/netmem.h b/include/net/netmem.h
index d84ab624b489..8f354ae7d5c3 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
  */
 static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
 
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	struct netmem_desc *desc = (struct netmem_desc *)page;
+
+	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+#else
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
+#endif
+
 /* net_iov */
 
 DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4f29e393f6af..be0752c0ac92 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/netmem.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
-- 
2.17.1


