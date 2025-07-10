Return-Path: <bpf+bounces-62895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25EAFFC49
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0FF5A7067
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EE28FFE2;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9128C5BC;
	Thu, 10 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136110; cv=none; b=nmTCrgpYHoyff2MwhSzvcU9w6EF2oF+Ww6GUmSSg7sYA2SSl3kK2v3Rs3Wumo60N9yxFOGEATlPd8v/Psctu3zWvxMSAIPs5JNbm7v8mUU239nk7H4XjTTIapmAxfdfeaLB3WemRrL3tGsD8LSQpYb4cBQV1e/ga+8BtQnZaTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136110; c=relaxed/simple;
	bh=75DXtV497MdWlzDLLKGHpJQSJXoFYHQUOB4/IwnVbes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwZSPb+6KwrK+YPrG8XHvuUVuUbEZVV3rCdMpdJtDR+YKJ5e3bHa/35MOq/ufZyjNFuCTVtkBYiLm0guA0sRewwr1hhZMGPM89FZy4HPCFGO52ED+/1ovNbVwtsLdeZHv/i0IKv5xrQzj1VFtq1kFMbsEth+52SgQ6nuCDhGjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-eb-686f79a12a98
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
Subject: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through struct netmem_desc in page_pool_page_is_pp()
Date: Thu, 10 Jul 2025 17:28:02 +0900
Message-Id: <20250710082807.27402-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLYRjGff2+nnPWrHFWw9kQScMkwhgj7x/CCPIJC4nMbYKyE210HWcX
	m0sMS8RsUyZC10kXzG6UGqu5hCqbIKZMamNXK2EbNmZbZdNuEf775Xmf53nfP14Oq87IQzmd
	IUmUDBq9mlEQRUdgwfSCtATtzIbbkWC2ljFQ2psKl5rscjCX3ETwo6+ehW5nFQPnC3owmF9k
	EPhp7cfQ9riFhVJbNDQWegjcOVKBoeV4NQPZGV4Md/s6WThkL5JBzc0cOZzqv4ihIr2JhVeV
	ZgYaygbl4HFkE3hiKibQmBMFjy1joOdpOwKntUIGPVn5DOS6LAy0ZjQicD1sIZB3MAeB9Z5b
	Dt5eX0feowY2ahJ92P4V0/LitzJ6y/SepRZbMr1eNJVmul2Y2kqOMtTWdZKl797cYWj1GS+h
	t+zdMpp9uJOh39vqCP16r5ah1vJaQp9ZnOyqoA2KeXGiXpciSjPmb1Fo65q37uwYnfrL/Aml
	oyuqTBTACXykMPjtJPnL7mtFQ8zwUwS3uw/7OZiPELpbqny6gsP8ZUZwltWz/sEoXhJa7Z0y
	PxN+spBfZRzSlfwc4epnGx4unSiUXr3vY44L4OcK9ta9flnls3hrM8mwPUh4cvYD8Vuwb6/1
	3NBp2Jc8fCMP+9cKfDknnMi1yYcrQ4QHRW5iRLzpv7jpX9z0X9yCcAlS6Qwp8RqdPjJcm2bQ
	pYZvS4i3Id+/FO7/HWtHXTWrHYjnkDpQWbPdoFXJNSmJafEOJHBYHazsXafXqpRxmrQ9opSw
	WUrWi4kONI4j6rHKWT2741T8dk2SuEMUd4rS36mMCwhNR9ELBp6neGbnNUXk7ouVwg+MN4yI
	aV72hYyRlt6VUp+HBL3+6Kn7bgx9tjKhPLv/mLdemZXudBgXHIw3XphDpsmWbFocc2lt2Iqq
	l2smRJesrKZZpwdGKtrK3ro8671dW0ZXZgU3Vzb/CAyLWvF+4aJdscs/bTw2rb4yakRS/m7X
	2eJMNUnUaiKmYilR8wd9KT3mKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+5//2dlxNTgty4NdrIEUQpqU8kIRQoUnofJTRR/KpQfPck7Z
	lroiWF6QJO1imM4tFMnUmdNluoVJTfNCHwrLWutiaYqEaZvXaVCbEvnt4Xl+7/O+H14ayxbJ
	UFqp1vEatUIlpySk5Pj+vN3V+gxhj3cqHEzWRgosCznw4KtdBKaGNgQzvo9imO7upaCmeg6D
	6VU+CbPWRQyjPcNisNiOwVDtGAkdhe0Yhm/0UVCcv4ThqW9SDLn2OgK6zP0ieN1WIoI7i/cx
	tBu+iuHNExMFXxr/iGDMWUxCv7GehKGSOOip2gRzLycQdFvbCZi7bqagdKCKgpH8IQQDXcMk
	VF4tQWDtdIlgacHfUfniizgunOuamMJca/0HgnMYP4u5KttF7lFdBFfkGsCcreEaxdm8t8Xc
	p3cdFNdXvkRyDvs0wRXnTVKcZ9RNclOdgxRXM/6L4Kytg2Si7IzkQAqvUmbxmqiDSRLB/e18
	5s+NOfOmcWRATbIiFESzzD7W1VJHBjTF7GRdLh8O6GAmmp0e7vX7EhozDym2u/GjOBBsYDTs
	iH2SCGiSCWfNvTeXfSkTwzb/sOGV0jDW0vzMr2k6iIll7SOXA7bMjywNFpEr+Hq2v+I7GUCw
	f6/13vI52D+Z97gS30RS4yrK+J8yrqKqEG5AwUp1VrpCqYqJ1KYJerUyJzI5I92G/B9Re+X3
	LTuaeRPvRAyN5Oukr1PVgkykyNLq052IpbE8WLpwWiXIpCkK/SVek3FOc1HFa51oM03KQ6QJ
	p/gkGZOq0PFpPJ/Ja/6lBB0UakD2+bGSkwkt28ZVyZbCsyPZEFJblml+nx8VkplWsEPweLaH
	m2/kGtzuibvJxKzXTPQ4juhpSdyB+vLctJZBr3Bi6y+drcKTFzvjeFtmmy5a2yWEeJ5/kIZt
	id94eDF0jXXoQozZu0WTHaqLduzZVdDdVHio1KIz7v10K9F3NFZOagVFdATWaBV/Ac0HVvIN
	AwAA
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
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/mm.h   | 12 ------------
 include/net/netmem.h | 17 +++++++++++++++++
 mm/page_alloc.c      |  1 +
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..0b7f7f998085 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
index ad9444be229a..11e9de45efcb 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -355,6 +355,23 @@ static inline void *nmdesc_address(struct netmem_desc *nmdesc)
 	return page_address(nmdesc_to_page(nmdesc));
 }
 
+#ifdef CONFIG_PAGE_POOL
+/* XXX: This would better be moved to mm, once mm gets its way to
+ * identify the type of page for page pool.
+ */
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	struct netmem_desc *desc = page_to_nmdesc(page);
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
 /**
  * __netmem_address - unsafely get pointer to the memory backing @netmem
  * @netmem: netmem reference to get the pointer for
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ef3c07266b3..cc1d169853e8 100644
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


