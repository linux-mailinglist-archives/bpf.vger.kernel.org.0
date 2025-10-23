Return-Path: <bpf+bounces-71952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D0C02640
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FED25676D0
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C512BDC09;
	Thu, 23 Oct 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug274Z6E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A40259CB9
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236103; cv=none; b=hqVgLRmR7cD77Y4HZS2RzrK699BcuNTLeh55UYkhTCDR9LEXFotjaZGpc/np7bV2E0MMUYDLrXuGAs20ClKnb0kWPCXV9R4F+XJQJwe+OtjtjebPPuT1aKep0xMIgt34pU9HwoIz+tdyLMyqlm1r7s1hBxHzG4KgjuPFxy8kBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236103; c=relaxed/simple;
	bh=qwKrw7kl+VeM7QrOZeXqtXAdzN6g7Ex6ji9qaOHcy84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mfyz82LI2g9AiqySn3OQhchjtKCqaEcvSviV+lPOpvZAGgG/dIxpRZLqw8dLtsZg4mKv93FsJuI34gSYOZTRqkQJ0xY3cNbgf6VCMblkji1DTk8C7UmNYjfXl/sgzJPHCrgy49CFRHtKVFmJUK8PUAplbVASOcMe5XszT0h1cSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug274Z6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E067C113D0;
	Thu, 23 Oct 2025 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761236102;
	bh=qwKrw7kl+VeM7QrOZeXqtXAdzN6g7Ex6ji9qaOHcy84=;
	h=From:To:Cc:Subject:Date:From;
	b=ug274Z6EKyWfHsbexUOEhJvid3RQID5vF30687t1fQHp1l2fpF02dLuUSrG3XcJfY
	 Wo1U3Hogn1Y9tzqI2OlpaRlVTI5IjJ2Vt4I3+2xzbe16YcGIS6D6Y6PlFS08P/t6i6
	 6neHTpifUsaT6uITVMcLmxUWyLCc+L+TujEDHFTaxx2ZogrRrsVlkLXissCilBRwQm
	 Alz/7ih8Rcuw2jddu9dG1Z8b/b+uOZjeBgxhsVrDxbaYEKhZiQFd+qMSYLbY1BhMw+
	 t0fbZBtJE/ePK5pMXaJ03hpdmjB+1Sj+i+WVeyev8Ws6AoNaT8v86mGpGdrOL4hnuC
	 0yv+AQ4uihGGA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: stream: start using kmalloc_nolock()
Date: Thu, 23 Oct 2025 16:14:44 +0000
Message-ID: <20251023161448.4263-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF stream kfuncs need to be non-sleeping as they can be called from
programs running in any context, this requires a way to allocate memory
from any context. Currently, this is done by a custom per-CPU NMI-safe
bump allocation mechanism, backed by try_alloc_pages() and
free_pages_nolock() primitives.

As kmalloc_nolock() and kfree_nolock() primitives are available now, the
custom allocator can be removed in favor of these.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/stream.c | 159 +++-----------------------------------------
 1 file changed, 8 insertions(+), 151 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index eb6c5a21c2ef..593976a5d6c8 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -4,111 +4,10 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
-#include <linux/percpu.h>
-#include <linux/refcount.h>
 #include <linux/gfp.h>
 #include <linux/memory.h>
-#include <linux/local_lock.h>
 #include <linux/mutex.h>
 
-/*
- * Simple per-CPU NMI-safe bump allocation mechanism, backed by the NMI-safe
- * try_alloc_pages()/free_pages_nolock() primitives. We allocate a page and
- * stash it in a local per-CPU variable, and bump allocate from the page
- * whenever items need to be printed to a stream. Each page holds a global
- * atomic refcount in its first 4 bytes, and then records of variable length
- * that describe the printed messages. Once the global refcount has dropped to
- * zero, it is a signal to free the page back to the kernel's page allocator,
- * given all the individual records in it have been consumed.
- *
- * It is possible the same page is used to serve allocations across different
- * programs, which may be consumed at different times individually, hence
- * maintaining a reference count per-page is critical for correct lifetime
- * tracking.
- *
- * The bpf_stream_page code will be replaced to use kmalloc_nolock() once it
- * lands.
- */
-struct bpf_stream_page {
-	refcount_t ref;
-	u32 consumed;
-	char buf[];
-};
-
-/* Available room to add data to a refcounted page. */
-#define BPF_STREAM_PAGE_SZ (PAGE_SIZE - offsetofend(struct bpf_stream_page, consumed))
-
-static DEFINE_PER_CPU(local_trylock_t, stream_local_lock) = INIT_LOCAL_TRYLOCK(stream_local_lock);
-static DEFINE_PER_CPU(struct bpf_stream_page *, stream_pcpu_page);
-
-static bool bpf_stream_page_local_lock(unsigned long *flags)
-{
-	return local_trylock_irqsave(&stream_local_lock, *flags);
-}
-
-static void bpf_stream_page_local_unlock(unsigned long *flags)
-{
-	local_unlock_irqrestore(&stream_local_lock, *flags);
-}
-
-static void bpf_stream_page_free(struct bpf_stream_page *stream_page)
-{
-	struct page *p;
-
-	if (!stream_page)
-		return;
-	p = virt_to_page(stream_page);
-	free_pages_nolock(p, 0);
-}
-
-static void bpf_stream_page_get(struct bpf_stream_page *stream_page)
-{
-	refcount_inc(&stream_page->ref);
-}
-
-static void bpf_stream_page_put(struct bpf_stream_page *stream_page)
-{
-	if (refcount_dec_and_test(&stream_page->ref))
-		bpf_stream_page_free(stream_page);
-}
-
-static void bpf_stream_page_init(struct bpf_stream_page *stream_page)
-{
-	refcount_set(&stream_page->ref, 1);
-	stream_page->consumed = 0;
-}
-
-static struct bpf_stream_page *bpf_stream_page_replace(void)
-{
-	struct bpf_stream_page *stream_page, *old_stream_page;
-	struct page *page;
-
-	page = alloc_pages_nolock(/* Don't account */ 0, NUMA_NO_NODE, 0);
-	if (!page)
-		return NULL;
-	stream_page = page_address(page);
-	bpf_stream_page_init(stream_page);
-
-	old_stream_page = this_cpu_read(stream_pcpu_page);
-	if (old_stream_page)
-		bpf_stream_page_put(old_stream_page);
-	this_cpu_write(stream_pcpu_page, stream_page);
-	return stream_page;
-}
-
-static int bpf_stream_page_check_room(struct bpf_stream_page *stream_page, int len)
-{
-	int min = offsetof(struct bpf_stream_elem, str[0]);
-	int consumed = stream_page->consumed;
-	int total = BPF_STREAM_PAGE_SZ;
-	int rem = max(0, total - consumed - min);
-
-	/* Let's give room of at least 8 bytes. */
-	WARN_ON_ONCE(rem % 8 != 0);
-	rem = rem < 8 ? 0 : rem;
-	return min(len, rem);
-}
-
 static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
 {
 	init_llist_node(&elem->node);
@@ -116,54 +15,12 @@ static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
 	elem->consumed_len = 0;
 }
 
-static struct bpf_stream_page *bpf_stream_page_from_elem(struct bpf_stream_elem *elem)
-{
-	unsigned long addr = (unsigned long)elem;
-
-	return (struct bpf_stream_page *)PAGE_ALIGN_DOWN(addr);
-}
-
-static struct bpf_stream_elem *bpf_stream_page_push_elem(struct bpf_stream_page *stream_page, int len)
-{
-	u32 consumed = stream_page->consumed;
-
-	stream_page->consumed += round_up(offsetof(struct bpf_stream_elem, str[len]), 8);
-	return (struct bpf_stream_elem *)&stream_page->buf[consumed];
-}
-
-static struct bpf_stream_elem *bpf_stream_page_reserve_elem(int len)
-{
-	struct bpf_stream_elem *elem = NULL;
-	struct bpf_stream_page *page;
-	int room = 0;
-
-	page = this_cpu_read(stream_pcpu_page);
-	if (!page)
-		page = bpf_stream_page_replace();
-	if (!page)
-		return NULL;
-
-	room = bpf_stream_page_check_room(page, len);
-	if (room != len)
-		page = bpf_stream_page_replace();
-	if (!page)
-		return NULL;
-	bpf_stream_page_get(page);
-	room = bpf_stream_page_check_room(page, len);
-	WARN_ON_ONCE(room != len);
-
-	elem = bpf_stream_page_push_elem(page, room);
-	bpf_stream_elem_init(elem, room);
-	return elem;
-}
-
 static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 {
 	const int max_len = ARRAY_SIZE((struct bpf_bprintf_buffers){}.buf);
 	struct bpf_stream_elem *elem;
-	unsigned long flags;
+	size_t alloc_size;
 
-	BUILD_BUG_ON(max_len > BPF_STREAM_PAGE_SZ);
 	/*
 	 * Length denotes the amount of data to be written as part of stream element,
 	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
@@ -172,10 +29,13 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 	if (len < 0 || len > max_len)
 		return NULL;
 
-	if (!bpf_stream_page_local_lock(&flags))
+	alloc_size = round_up(offsetof(struct bpf_stream_elem, str[len]), 8);
+	elem = kmalloc_nolock(alloc_size, __GFP_ZERO, -1);
+	if (!elem)
 		return NULL;
-	elem = bpf_stream_page_reserve_elem(len);
-	bpf_stream_page_local_unlock(&flags);
+
+	bpf_stream_elem_init(elem, len);
+
 	return elem;
 }
 
@@ -231,10 +91,7 @@ static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bp
 
 static void bpf_stream_free_elem(struct bpf_stream_elem *elem)
 {
-	struct bpf_stream_page *p;
-
-	p = bpf_stream_page_from_elem(elem);
-	bpf_stream_page_put(p);
+	kfree_nolock(elem);
 }
 
 static void bpf_stream_free_list(struct llist_node *list)
-- 
2.47.3


