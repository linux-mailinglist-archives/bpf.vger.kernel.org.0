Return-Path: <bpf+bounces-43261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A99B21D2
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A184F1F2140A
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334B155747;
	Mon, 28 Oct 2024 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcEsDuxZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700814D43D;
	Mon, 28 Oct 2024 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077749; cv=none; b=YhNUQ92WVsN5GCuKyMlz6xBxLy8a3uquaByT6pDw4qkP+pOcaYyvLoTuuKEO/7Ab2UlD17bXMGIZMeBo4ZRtHLQHOdbL/jmaRgrO3AJyjx3Ns0sMxtgKzMBpP37rRG91TV+Rzpvpp2bMkhEeVVCLZZbZ5pkQRmK/Ty9mOOTQNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077749; c=relaxed/simple;
	bh=Ribok69L0V+IQIfX1LKAa+j7slCTXJ/a5HygjFWCqNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxsO92yJ4Z8j2ZRVV6mfA0Iy/+6x0Rtvys/L2b21YCewEwIE2aIl6XPewj7oKAgFU+44iDnr8xm3JcDPludSOtzFHRGwpOZpeQmo3S1mgVGBskx9Xa7pA9x1PFuLhj5IMVxghtrXadKd2lE0rYvhEd42ufeJ523+tkZI+MKGWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcEsDuxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65703C4CEE5;
	Mon, 28 Oct 2024 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730077749;
	bh=Ribok69L0V+IQIfX1LKAa+j7slCTXJ/a5HygjFWCqNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcEsDuxZ44cpUaR4KUbORo/ERRrafxKAF05h7Dd+n1ohShoR33iYzss2xVzkX9bZy
	 NUA2c2/P93p+1NY9BMPbz4ZhkGNAColwIYcLIkLlh2xb7UNFCr/2OVBIwND0TfPClO
	 beYu28enquoY3AqAvW6Rn0Hh1VpYSsaOhhkqDSzC3pNPmq+ARjE5S+TFvAdIRba7vC
	 B251sDrDieSzrwoxJpURaYek9EDwPpQG1pvuqNwhl+W23/1EpA/uFDnIxtKnlI9F/A
	 FmYTcm7H7O71F77iLvdRJxipSDNTwtQR1UO+1v/V0OA1iqT0qzRg8WsMBTP86OkiSe
	 E2A9BGrGM6ZnA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	peterz@infradead.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	arnd@arndb.de,
	richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk,
	hca@linux.ibm.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 tip/perf/core 1/4] mm: Convert mm_lock_seq to a proper seqcount
Date: Sun, 27 Oct 2024 18:08:15 -0700
Message-ID: <20241028010818.2487581-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241028010818.2487581-1-andrii@kernel.org>
References: <20241028010818.2487581-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suren Baghdasaryan <surenb@google.com>

Convert mm_lock_seq to be seqcount_t and change all mmap_write_lock
variants to increment it, in-line with the usual seqcount usage pattern.
This lets us check whether the mmap_lock is write-locked by checking
mm_lock_seq.sequence counter (odd=locked, even=unlocked). This will be
used when implementing mmap_lock speculation functions.
As a result vm_lock_seq is also change to be unsigned to match the type
of mm_lock_seq.sequence.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/mm.h               | 12 +++----
 include/linux/mm_types.h         |  7 ++--
 include/linux/mmap_lock.h        | 58 +++++++++++++++++++++-----------
 kernel/fork.c                    |  5 +--
 mm/init-mm.c                     |  2 +-
 tools/testing/vma/vma.c          |  4 +--
 tools/testing/vma/vma_internal.h |  4 +--
 7 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..94b537088142 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -698,7 +698,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
@@ -715,7 +715,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
@@ -730,7 +730,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -738,7 +738,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	*mm_lock_seq = vma->vm_mm->mm_lock_seq;
+	*mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
@@ -749,7 +749,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	unsigned int mm_lock_seq;
 
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
@@ -767,7 +767,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	unsigned int mm_lock_seq;
 
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..76e0cdc0462b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -715,7 +715,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	unsigned int vm_lock_seq;
 	/* Unstable RCU readers are allowed to read this. */
 	struct vma_lock *vm_lock;
 #endif
@@ -887,6 +887,9 @@ struct mm_struct {
 		 * Roughly speaking, incrementing the sequence number is
 		 * equivalent to releasing locks on VMAs; reading the sequence
 		 * number can be part of taking a read lock on a VMA.
+		 * Incremented every time mmap_lock is write-locked/unlocked.
+		 * Initialized to 0, therefore odd values indicate mmap_lock
+		 * is write-locked and even values that it's released.
 		 *
 		 * Can be modified under write mmap_lock using RELEASE
 		 * semantics.
@@ -895,7 +898,7 @@ struct mm_struct {
 		 * Can be read with ACQUIRE semantics if not holding write
 		 * mmap_lock.
 		 */
-		int mm_lock_seq;
+		seqcount_t mm_lock_seq;
 #endif
 
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..6b3272686860 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,39 +71,38 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
-/*
- * Drop all currently-held per-VMA locks.
- * This is called from the mmap_lock implementation directly before releasing
- * a write-locked mmap_lock (or downgrading it to read-locked).
- * This should normally NOT be called manually from other places.
- * If you want to call this manually anyway, keep in mind that this will release
- * *all* VMA write locks, including ones from further up the stack.
- */
-static inline void vma_end_write_all(struct mm_struct *mm)
+static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
-	mmap_assert_write_locked(mm);
-	/*
-	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
-	 * mmap_lock being held.
-	 * We need RELEASE semantics here to ensure that preceding stores into
-	 * the VMA take effect before we unlock it with this store.
-	 * Pairs with ACQUIRE semantics in vma_start_read().
-	 */
-	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
+	seqcount_init(&mm->mm_lock_seq);
+}
+
+static inline void mm_lock_seqcount_begin(struct mm_struct *mm)
+{
+	do_raw_write_seqcount_begin(&mm->mm_lock_seq);
+}
+
+static inline void mm_lock_seqcount_end(struct mm_struct *mm)
+{
+	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
+
 #else
-static inline void vma_end_write_all(struct mm_struct *mm) {}
+static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
+static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
+static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
 #endif
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
+	mm_lock_seqcount_init(mm);
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	mm_lock_seqcount_begin(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -111,6 +110,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	mm_lock_seqcount_begin(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -120,10 +120,30 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret)
+		mm_lock_seqcount_begin(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
 
+/*
+ * Drop all currently-held per-VMA locks.
+ * This is called from the mmap_lock implementation directly before releasing
+ * a write-locked mmap_lock (or downgrading it to read-locked).
+ * This should normally NOT be called manually from other places.
+ * If you want to call this manually anyway, keep in mind that this will release
+ * *all* VMA write locks, including ones from further up the stack.
+ */
+static inline void vma_end_write_all(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+	/*
+	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
+	 * mmap_lock being held.
+	 */
+	mm_lock_seqcount_end(mm);
+}
+
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..55c4088543dc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -448,7 +448,7 @@ static bool vma_lock_alloc(struct vm_area_struct *vma)
 		return false;
 
 	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return true;
 }
@@ -1261,9 +1261,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
-#ifdef CONFIG_PER_VMA_LOCK
-	mm->mm_lock_seq = 0;
-#endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 24c809379274..6af3ad675930 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -40,7 +40,7 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
-	.mm_lock_seq	= 0,
+	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index c53f220eb6cc..bcdf831dfe3e 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -87,7 +87,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 	 * begun. Linking to the tree will have caused this to be incremented,
 	 * which means we will get a false positive otherwise.
 	 */
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return vma;
 }
@@ -212,7 +212,7 @@ static bool vma_write_started(struct vm_area_struct *vma)
 	int seq = vma->vm_lock_seq;
 
 	/* We reset after each check. */
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	/* The vma_start_write() stub simply increments this value. */
 	return seq > -1;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..4007ec580f85 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -231,7 +231,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	unsigned int vm_lock_seq;
 	struct vma_lock *vm_lock;
 #endif
 
@@ -406,7 +406,7 @@ static inline bool vma_lock_alloc(struct vm_area_struct *vma)
 		return false;
 
 	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return true;
 }
-- 
2.43.5


