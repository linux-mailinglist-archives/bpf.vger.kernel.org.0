Return-Path: <bpf+bounces-40720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD898C863
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AB228576A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39271CF2B2;
	Tue,  1 Oct 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfDuVI4A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFB1CEEA7;
	Tue,  1 Oct 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823139; cv=none; b=SBr1IF2vn8JA46ctX3RFnw+/Vrk6D3rh16pcEjPxbg59LgnjBFU7yXidaKSGxUQrPxdNZh4fnbQFnBlo/w/9ZJLcB5NZpTAvjkwio1J2iPu8M6n7JVHoSCel/qEKtHHMfgaqxP7+7rWFqdmCq8V6FB3uvkt+Zmj6I+2jJQYvNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823139; c=relaxed/simple;
	bh=5eizI5x+ShSEQgV2sFgQYF+jiwqy/RpZnCYPy8CWlCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxVhcg84QHBQisXaY/nfF+rXUU6+cqouoBCeECilKqL2yvbpX1+OHiNsvJ2MaFKFAQLX5YHP9S6HzJPFRtrOuKOzt6iwGEtG67R9+/8nnvoyP0EMVQKzTbuMLCa/k0XXIi781y/jvZUQJRZ30Wpc56dlrTds+gss/bSdUQ4GD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfDuVI4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73A1C4CEC6;
	Tue,  1 Oct 2024 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823139;
	bh=5eizI5x+ShSEQgV2sFgQYF+jiwqy/RpZnCYPy8CWlCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfDuVI4A1C9B6XefEXXmRXfyt7/s7dX48eXgg1McB+htkj6q+gilGOE4d61u22XCh
	 UfxULXP1HekgDrUTsX2+Ln5wBjCakxnoD/gFrptDXm5zUyoSqPWUf30SbjqdXEbzQX
	 1Y7WBvvnXnURdWM7kDKwCuD1ZyLjVha0EIEcEHAPgeIvQbAIYIl3uMOjNn4Psmap5M
	 QFFj8DAP9dAq9Mj7rOjscOJ9UFzHxizXyyksvbX1ftosYFrQe6GyfemxxqilV6KEBX
	 bQr4Hj1fllwJKPcEpXl2xOQYQECHviW+3pSvnf592Nq2IwBGBWXnrjNhPa2grRrgbA
	 zgC9Q7nB+8MNQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	mingo@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 tip/perf/core 1/5] mm: introduce mmap_lock_speculation_{start|end}
Date: Tue,  1 Oct 2024 15:52:03 -0700
Message-ID: <20241001225207.2215639-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001225207.2215639-1-andrii@kernel.org>
References: <20241001225207.2215639-1-andrii@kernel.org>
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
index 485424979254..d5e3f907eea4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -876,6 +876,9 @@ struct mm_struct {
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
index 18bdc87209d0..c44b71d354ee 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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


