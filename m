Return-Path: <bpf+bounces-37000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8E94FCBF
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049D51F22C8A
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49713AA2D;
	Tue, 13 Aug 2024 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3xvOnoW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06379139D1B;
	Tue, 13 Aug 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523417; cv=none; b=gocx8czl2QnwZ1R95uzRr2uRlKm/JdCro79n9it7jBbR8xMAqMJYZ7QTEjqyV86BAqVmVpWeRiQ1q03TWkaWs2bmRl4NHwRSV+mmfkfhRj3Rrxmvd0VTh7kYnMKCGrpIGAS1PMY9pCCfxvrUNXo2V4gn6t7ks2mGrg4pVcAweno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523417; c=relaxed/simple;
	bh=mYH0n7OY/tN+k3UF1Q0GJPFr/FSKIMdZcbGxNJ52OfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHwJwEzOXgCAd0uOep8N5UkFS9KH5Gu2Q50p3beotu3C0+jJoJlfafByGlxEXvRQwJtKNDLRuz7/iiQ6i5Rg70krwglNIhJkUjt5dqbRyCcpX9YPLTeAKuoDVOHMEvnoippvU2uzHBJ+JzQ9f+fOV6cBuMbT/2w7i+5ScIzG6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3xvOnoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ED0C4AF09;
	Tue, 13 Aug 2024 04:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523416;
	bh=mYH0n7OY/tN+k3UF1Q0GJPFr/FSKIMdZcbGxNJ52OfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3xvOnoWnvTsLIvKz6kdYhpy/06faosDWyzX4GZE9mZKKYnCrHQmeagOkf3NtLtlt
	 NmKjplsABxkVNsQSzHzR8kIYehx8Ka4H96mrEHnJ5/uB7BhSRa1rrkIs78nr9DL8OX
	 d0o7kSdAgrgCbCLvkIE1Yf3v6860bzYy5EHLqGfN3vA5Uf52rC1YG3mlA5IVW1p45F
	 CesQXLMDDMVAWyAl87VczubWu4gJ2hIJmxwGMuY/FGsANI2pjOCkGX9V64pu3GyB/7
	 gDvHzjkVyPcdTMh3VRASUdbc3SLZs8dxl/4Yoydf+uy7do87L6tUk4/+wWn3AHSVTG
	 38rfKjpvmatrw==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH RFC v3 11/13] mm: introduce mmap_lock_speculation_{start|end}
Date: Mon, 12 Aug 2024 21:29:15 -0700
Message-ID: <20240813042917.506057-12-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
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

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 include/linux/mm_types.h  |  3 +++
 include/linux/mmap_lock.h | 53 +++++++++++++++++++++++++++++++--------
 kernel/fork.c             |  3 ---
 3 files changed, 46 insertions(+), 13 deletions(-)

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
index de9dc20b01ba..5410ce741d75 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,15 +71,12 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
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
+static inline void init_mm_lock_seq(struct mm_struct *mm)
+{
+	mm->mm_lock_seq = 0;
+}
+
+static inline void inc_mm_lock_seq(struct mm_struct *mm)
 {
 	mmap_assert_write_locked(mm);
 	/*
@@ -91,19 +88,52 @@ static inline void vma_end_write_all(struct mm_struct *mm)
 	 */
 	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
 }
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
+	/* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
+	return seq == smp_load_acquire(&mm->mm_lock_seq);
+}
+
 #else
-static inline void vma_end_write_all(struct mm_struct *mm) {}
+static inline void init_mm_lock_seq(struct mm_struct *mm) {}
+static inline void inc_mm_lock_seq(struct mm_struct *mm) {}
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq) { return false; }
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq) { return false; }
 #endif
 
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
+	inc_mm_lock_seq(mm);
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
+	inc_mm_lock_seq(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -111,6 +141,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	inc_mm_lock_seq(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -120,6 +151,8 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret)
+		inc_mm_lock_seq(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..76ebafb956a6 100644
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


