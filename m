Return-Path: <bpf+bounces-41642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8739993FE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926DF1F23F6B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD21E3DF5;
	Thu, 10 Oct 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/xpkIms"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BC1CF5C5;
	Thu, 10 Oct 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593811; cv=none; b=O6viZ3zeckc3bzb+dL0EPzsjg8ux/wIMc0SilcWHpQCD3wNDqg/7lEwcSD7vnzdmKFzdbGGAFs+6Z2Ub60d4ua+HF45CEYEueR516y0iXCR4x707ZFW52eweGyHsMTSvn47mgFeGycX4u6G2KZe3+BFKh9zCHLLwubQmxMHjM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593811; c=relaxed/simple;
	bh=wgt1aG7beo2Dv30obPLfAmhHU07l2a/OUlPnAMEzc64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guA6JHlRJ+SWD7cWJAHStbymfMLunwdRoKKntP5hLFZruFil5AjBrX9A3EsAG7tfEw0NoRhEPkmW+FopssyhatAYW5Gc/ta0tKcc+m4X7QyxZPcCRg9xhUZIUZ1qUFl5UyE9w1PlH6f9yjQ6OAzwT3B7nc1zL1EJdQCW0CUs7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/xpkIms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D916C4CECD;
	Thu, 10 Oct 2024 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728593810;
	bh=wgt1aG7beo2Dv30obPLfAmhHU07l2a/OUlPnAMEzc64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/xpkIms4/XteSjXOaghmqaQVxUthT47UHNM+oFCsckR7E3/ssFpC2mX6GbNYFNua
	 c7GYJ/tay3Y31AM2Jrz+78QGi+BakcO2VBszuXhoE4TXE59jNBFRf5HbCii/XHY6Ju
	 ZBJ7hzr4rp3ZbFkl0pAnhZKpDLNb5QPBiJXoCdgnt25FPcKDuiv9Fhn0on1J0/mcKc
	 8q6+B1AGFdV5jmva2MTrzj+PC0PcCptrwoFcIbfCWr43dCbkFE6F2qiAV3X8kN6SiB
	 ht+oDb8FkkNv9pFXMfH8vUswVFgouEPlDaH6zjpszRYATw0AjV+4axBpdKG7KNpCoY
	 Z16vjigxFwOfg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
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
	akpm@linux-foundation.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
Date: Thu, 10 Oct 2024 13:56:41 -0700
Message-ID: <20241010205644.3831427-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010205644.3831427-1-andrii@kernel.org>
References: <20241010205644.3831427-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suren Baghdasaryan <surenb@google.com>

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@google.com
---
 include/linux/mm_types.h  |  3 ++
 include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
 kernel/fork.c             |  3 --
 3 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..5d8cdebd42bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
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
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..9d23635bc701 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,39 +71,84 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+static inline void init_mm_lock_seq(struct mm_struct *mm)
+{
+	mm->mm_lock_seq = 0;
+}
+
 /*
- * Drop all currently-held per-VMA locks.
- * This is called from the mmap_lock implementation directly before releasing
- * a write-locked mmap_lock (or downgrading it to read-locked).
- * This should normally NOT be called manually from other places.
- * If you want to call this manually anyway, keep in mind that this will release
- * *all* VMA write locks, including ones from further up the stack.
+ * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE semantics)
+ * or write-unlocked (RELEASE semantics).
  */
-static inline void vma_end_write_all(struct mm_struct *mm)
+static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
 {
 	mmap_assert_write_locked(mm);
 	/*
 	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
 	 * mmap_lock being held.
-	 * We need RELEASE semantics here to ensure that preceding stores into
-	 * the VMA take effect before we unlock it with this store.
-	 * Pairs with ACQUIRE semantics in vma_start_read().
 	 */
-	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
+
+	if (acquire) {
+		WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+		/*
+		 * For ACQUIRE semantics we should ensure no following stores are
+		 * reordered to appear before the mm->mm_lock_seq modification.
+		 */
+		smp_wmb();
+	} else {
+		/*
+		 * We need RELEASE semantics here to ensure that preceding stores
+		 * into the VMA take effect before we unlock it with this store.
+		 * Pairs with ACQUIRE semantics in vma_start_read().
+		 */
+		smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
+	}
+}
+
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq)
+{
+	/* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
+	*seq = smp_load_acquire(&mm->mm_lock_seq);
+	/* Allow speculation if mmap_lock is not write-locked */
+	return (*seq & 1) == 0;
+}
+
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq)
+{
+	/* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
+	smp_rmb();
+	return seq == READ_ONCE(mm->mm_lock_seq);
 }
+
 #else
-static inline void vma_end_write_all(struct mm_struct *mm) {}
+static inline void init_mm_lock_seq(struct mm_struct *mm) {}
+static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire) {}
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq) { return false; }
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq) { return false; }
 #endif
 
+/*
+ * Drop all currently-held per-VMA locks.
+ * This is called from the mmap_lock implementation directly before releasing
+ * a write-locked mmap_lock (or downgrading it to read-locked).
+ * This should NOT be called manually from other places.
+ */
+static inline void vma_end_write_all(struct mm_struct *mm)
+{
+	inc_mm_lock_seq(mm, false);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
+	init_mm_lock_seq(mm);
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	inc_mm_lock_seq(mm, true);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -111,6 +156,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	inc_mm_lock_seq(mm, true);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -120,6 +166,8 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret)
+		inc_mm_lock_seq(mm, true);
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..dd1bded0294d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
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
-- 
2.43.5


