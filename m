Return-Path: <bpf+bounces-76538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F848CB93FF
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 17:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9221930146CF
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617D26F2AC;
	Fri, 12 Dec 2025 16:18:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576721B918;
	Fri, 12 Dec 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556329; cv=none; b=bNJp2ZrS3De+91LSTtVgGZiHqgeLhNnmcKkmI8cU+zkm/KkpucpkPchMiGrzODSfHgEPGcilE6v6cZkyNHfMUh2J1KVfuH5b3dY+NY49GFYslGq1AcgbvUB9o9OkV1QADScPYnCCcsvAS6MuJx2+BgH7yfoQTN0MuHm4JimX98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556329; c=relaxed/simple;
	bh=Rw/yopypP+v6FMmNiobvuZXEFBWPM7fiVCd72fNmoVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWvReTmRsnLMj8AvDW8F2eDVC7Iw/i2S/Jj/bfXbeuG2+TsWaZIqI5DFiLb84zCrrp2hVlsKzZIWs2G33Y+KfI5xJxTU3FTxn1ZmntiuKGIpz613EabLoRXJfJN36P4RdY2/QzAAV8H0UiUahdc/SAjbQoJgvLeFzrPTmpFCAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EFB11575;
	Fri, 12 Dec 2025 08:18:38 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 585873F762;
	Fri, 12 Dec 2025 08:18:40 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	kevin.brodsky@arm.com,
	dev.jain@arm.com,
	yang@os.amperecomputing.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/2] mm: introduce pagetable_alloc_nolock()
Date: Fri, 12 Dec 2025 16:18:31 +0000
Message-Id: <20251212161832.2067134-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212161832.2067134-1-yeoreum.yun@arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some architectures invoke pagetable_alloc() with preemption disabled
(e.g., arm64’s linear_map_split_to_ptes()).

Under PREEMPT_RT, calling pagetable_alloc() with
preemption disabled is not allowed, because it may acquire
a spin lock that becomes sleepable on RT, potentially
causing a sleep during page allocation.

To address this, introduce a pagetable_alloc_nolock() API and
permit two additional GFP flags for alloc_pages_nolock() — __GFP_HIGH and __GFP_ZERO.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/mm.h   | 18 ++++++++++++++++++
 kernel/bpf/stream.c  |  2 +-
 kernel/bpf/syscall.c |  2 +-
 mm/page_alloc.c      | 10 +++-------
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c79b3369b82..11a27f60838b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2990,6 +2990,24 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 }
 #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
 
+/**
+ * pagetable_alloc_nolock - opportunistic reetentrant pagetables allocation
+ *                          from any context
+ * @gfp:    GFP flags. Only __GFP_ZERO, __GFP_HIGH, __GFP_ACCOUNT allowed.
+ * @order:  desired pagetable order
+ *
+ * opportunistic reetentrant version of pagetable_alloc().
+ *
+ * Return: The ptdesc describing the allocated page tables.
+ */
+static inline struct ptdesc *pagetable_alloc_nolock_noprof(gfp_t gfp, unsigned int order)
+{
+	struct page *page = alloc_pages_nolock_noprof(gfp, NUMA_NO_NODE, order);
+
+	return page_ptdesc(page);
+}
+#define pagetable_alloc_nolock(...)	alloc_hooks(pagetable_alloc_nolock_noprof(__VA_ARGS__))
+
 /**
  * pagetable_free - Free pagetables
  * @pt:	The page table descriptor
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index ff16c631951b..3c80c8007d91 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -83,7 +83,7 @@ static struct bpf_stream_page *bpf_stream_page_replace(void)
 	struct bpf_stream_page *stream_page, *old_stream_page;
 	struct page *page;
 
-	page = alloc_pages_nolock(/* Don't account */ 0, NUMA_NO_NODE, 0);
+	page = alloc_pages_nolock(/* Don't account */ __GFP_ZERO, NUMA_NO_NODE, 0);
 	if (!page)
 		return NULL;
 	stream_page = page_address(page);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..cbc0f8d0c18b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -598,7 +598,7 @@ static bool can_alloc_pages(void)
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
-		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
+		return alloc_pages_nolock(__GFP_ZERO | __GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
 				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ed82ee55e66a..88a920dc1e9a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7542,21 +7542,17 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
 	 * since the running context is unknown.
 	 *
-	 * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
-	 * is safe in any context. Also zeroing the page is mandatory for
-	 * BPF use cases.
-	 *
 	 * Though __GFP_NOMEMALLOC is not checked in the code path below,
 	 * specify it here to highlight that alloc_pages_nolock()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | __GFP_COMP
 			| gfp_flags;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
 
-	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
+	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_HIGH | __GFP_ZERO | __GFP_ACCOUNT));
 	/*
 	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
 	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
@@ -7602,7 +7598,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 }
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
- * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
+ * @gfp_flags: GFP flags. Only __GFP_ZERO, __GFP_HIGH, __GFP_ACCOUNT allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


