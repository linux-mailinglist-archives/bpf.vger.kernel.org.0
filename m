Return-Path: <bpf+bounces-41856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FC599C7F4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3392862C5
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9E1AA786;
	Mon, 14 Oct 2024 11:00:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91819E980;
	Mon, 14 Oct 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903611; cv=none; b=moFymIW3eKfyccOp8bp3aEXtR74XaqkqdWQh86Y3zrlER5z1Rx8aPz90YnO20aLgzxMtD6Iwew5ph8TXlomcOU9oomswlTM5GZCd5pjg2LPswD/PykaXQCxLyhsPB3y/M/lECQpgpMUFOhsnuWgSAaUMkb0C+ABLYBH3EeYuBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903611; c=relaxed/simple;
	bh=MYo2eVE04Uihxjd9OjHw5pgp2GZSp/xiYux4/Csipuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGrM5muwU31ngAfddeJcLekWiFfCagPD44g9keKwfyMJ/ztHUM/QlmaaCcRbn+Vqhf7qznlGMf58T/4rZRYgwLiEQlF2a7CFztZADka0WwDEoQB4f8IZbrMlc/eHsbwaKyUxfVnXGjRYJ5g0hWlmZ7HuWbJLlFMgnmJat9NzHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 478EC1688;
	Mon, 14 Oct 2024 04:00:38 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8813F51B;
	Mon, 14 Oct 2024 04:00:05 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 13/57] bpf: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:20 +0100
Message-ID: <20241014105912.3207374-13-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Refactor "struct bpf_ringbuf" so that consumer_pos, producer_pos,
pending_pos and data are no longer embedded at (static) page offsets
within the struct. This can't work for boot-time page size because the
page size isn't known at compile-time. Instead, only define the meta
data in the struct, along with pointers to those values. At "struct
bpf_ringbuf" allocation time, the extra pages are allocated at the end
and the pointers are initialized to point to the correct locations.

Additionally, only expose the __PAGE_SIZE enum to BTF for compile-time
page size builds. We don't know the page size at compile-time for
boot-time builds. NOTE: This may need some extra thought; perhaps
__PAGE_SIZE should be exposed as 0 in this case? And/or perhaps
__PAGE_SIZE_MIN/__PAGE_SIZE_MAX should be exposed? And there would need
to be a runtime mechanism for querying the page size (e.g.
getpagesize()).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 kernel/bpf/core.c    |  9 ++++++--
 kernel/bpf/ringbuf.c | 54 ++++++++++++++++++++++++--------------------
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ee62e38faf0e..485875aa78e63 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -89,10 +89,15 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 	return NULL;
 }
 
-/* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
+/*
+ * tell bpf programs that include vmlinux.h kernel's PAGE_SIZE. We can only do
+ * this for compile-time PAGE_SIZE builds.
+ */
+#if PAGE_SIZE_MIN == PAGE_SIZE_MAX
 enum page_size_enum {
 	__PAGE_SIZE = PAGE_SIZE
 };
+#endif
 
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
@@ -100,7 +105,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
 
-	size = round_up(size, __PAGE_SIZE);
+	size = round_up(size, PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
 	if (fp == NULL)
 		return NULL;
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e20b90c361316..8e4093ddbc638 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -14,9 +14,9 @@
 
 #define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
 
-/* non-mmap()'able part of bpf_ringbuf (everything up to consumer page) */
+/* non-mmap()'able part of bpf_ringbuf (everything defined in struct) */
 #define RINGBUF_PGOFF \
-	(offsetof(struct bpf_ringbuf, consumer_pos) >> PAGE_SHIFT)
+	(PAGE_ALIGN(sizeof(struct bpf_ringbuf)) >> PAGE_SHIFT)
 /* consumer page and producer page */
 #define RINGBUF_POS_PAGES 2
 #define RINGBUF_NR_META_PAGES (RINGBUF_PGOFF + RINGBUF_POS_PAGES)
@@ -69,10 +69,10 @@ struct bpf_ringbuf {
 	 * validate each sample to ensure that they're correctly formatted, and
 	 * fully contained within the ring buffer.
 	 */
-	unsigned long consumer_pos __aligned(PAGE_SIZE);
-	unsigned long producer_pos __aligned(PAGE_SIZE);
-	unsigned long pending_pos;
-	char data[] __aligned(PAGE_SIZE);
+	unsigned long *consumer_pos;
+	unsigned long *producer_pos;
+	unsigned long *pending_pos;
+	char *data;
 };
 
 struct bpf_ringbuf_map {
@@ -134,9 +134,15 @@ static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 	rb = vmap(pages, nr_meta_pages + 2 * nr_data_pages,
 		  VM_MAP | VM_USERMAP, PAGE_KERNEL);
 	if (rb) {
+		void *base = rb;
+
 		kmemleak_not_leak(pages);
 		rb->pages = pages;
 		rb->nr_pages = nr_pages;
+		rb->consumer_pos = (unsigned long *)(base + PAGE_SIZE * RINGBUF_PGOFF);
+		rb->producer_pos = (unsigned long *)(base + PAGE_SIZE * (RINGBUF_PGOFF + 1));
+		rb->pending_pos = rb->producer_pos + 1;
+		rb->data = base + PAGE_SIZE * nr_meta_pages;
 		return rb;
 	}
 
@@ -179,9 +185,9 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
 
 	rb->mask = data_sz - 1;
-	rb->consumer_pos = 0;
-	rb->producer_pos = 0;
-	rb->pending_pos = 0;
+	*rb->consumer_pos = 0;
+	*rb->producer_pos = 0;
+	*rb->pending_pos = 0;
 
 	return rb;
 }
@@ -300,8 +306,8 @@ static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 {
 	unsigned long cons_pos, prod_pos;
 
-	cons_pos = smp_load_acquire(&rb->consumer_pos);
-	prod_pos = smp_load_acquire(&rb->producer_pos);
+	cons_pos = smp_load_acquire(rb->consumer_pos);
+	prod_pos = smp_load_acquire(rb->producer_pos);
 	return prod_pos - cons_pos;
 }
 
@@ -418,7 +424,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	if (len > ringbuf_total_data_sz(rb))
 		return NULL;
 
-	cons_pos = smp_load_acquire(&rb->consumer_pos);
+	cons_pos = smp_load_acquire(rb->consumer_pos);
 
 	if (in_nmi()) {
 		if (!spin_trylock_irqsave(&rb->spinlock, flags))
@@ -427,8 +433,8 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		spin_lock_irqsave(&rb->spinlock, flags);
 	}
 
-	pend_pos = rb->pending_pos;
-	prod_pos = rb->producer_pos;
+	pend_pos = *rb->pending_pos;
+	prod_pos = *rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
 	while (pend_pos < prod_pos) {
@@ -440,7 +446,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		tmp_size = round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
 		pend_pos += tmp_size;
 	}
-	rb->pending_pos = pend_pos;
+	*rb->pending_pos = pend_pos;
 
 	/* check for out of ringbuf space:
 	 * - by ensuring producer position doesn't advance more than
@@ -460,7 +466,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	hdr->pg_off = pg_off;
 
 	/* pairs with consumer's smp_load_acquire() */
-	smp_store_release(&rb->producer_pos, new_prod_pos);
+	smp_store_release(rb->producer_pos, new_prod_pos);
 
 	spin_unlock_irqrestore(&rb->spinlock, flags);
 
@@ -506,7 +512,7 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
 	 * new data availability
 	 */
 	rec_pos = (void *)hdr - (void *)rb->data;
-	cons_pos = smp_load_acquire(&rb->consumer_pos) & rb->mask;
+	cons_pos = smp_load_acquire(rb->consumer_pos) & rb->mask;
 
 	if (flags & BPF_RB_FORCE_WAKEUP)
 		irq_work_queue(&rb->work);
@@ -580,9 +586,9 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 	case BPF_RB_RING_SIZE:
 		return ringbuf_total_data_sz(rb);
 	case BPF_RB_CONS_POS:
-		return smp_load_acquire(&rb->consumer_pos);
+		return smp_load_acquire(rb->consumer_pos);
 	case BPF_RB_PROD_POS:
-		return smp_load_acquire(&rb->producer_pos);
+		return smp_load_acquire(rb->producer_pos);
 	default:
 		return 0;
 	}
@@ -680,12 +686,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 	u64 cons_pos, prod_pos;
 
 	/* Synchronizes with smp_store_release() in user-space producer. */
-	prod_pos = smp_load_acquire(&rb->producer_pos);
+	prod_pos = smp_load_acquire(rb->producer_pos);
 	if (prod_pos % 8)
 		return -EINVAL;
 
 	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
-	cons_pos = smp_load_acquire(&rb->consumer_pos);
+	cons_pos = smp_load_acquire(rb->consumer_pos);
 	if (cons_pos >= prod_pos)
 		return -ENODATA;
 
@@ -715,7 +721,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 		 * Update the consumer pos, and return -EAGAIN so the caller
 		 * knows to skip this sample and try to read the next one.
 		 */
-		smp_store_release(&rb->consumer_pos, cons_pos + total_len);
+		smp_store_release(rb->consumer_pos, cons_pos + total_len);
 		return -EAGAIN;
 	}
 
@@ -737,9 +743,9 @@ static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t siz
 	 * prevents another task from writing to consumer_pos after it was read
 	 * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
 	 */
-	consumer_pos = rb->consumer_pos;
+	consumer_pos = *rb->consumer_pos;
 	 /* Synchronizes with smp_load_acquire() in user-space producer. */
-	smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
+	smp_store_release(rb->consumer_pos, consumer_pos + rounded_size);
 }
 
 BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
-- 
2.43.0


