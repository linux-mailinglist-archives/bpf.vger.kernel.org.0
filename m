Return-Path: <bpf+bounces-39100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40F96E902
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 07:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2D11C22340
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B0130AF6;
	Fri,  6 Sep 2024 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm0jdEna"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AF54FB5;
	Fri,  6 Sep 2024 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599539; cv=none; b=XN0DUKbVGOk6mGo26dM+M++1+dVgemaAbhDJRaZEUaV01GyM9msEDbLzCLeY3WI6CCiNd68IW2TSitc3tAX/SEaORRTzyG6C3UxaLvZYPUP9qFnwlNjiLf52uojsvZC24Tf1lvTiMI2FmE7MNY+P/v46yQZNmLFSEzksk1x5kDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599539; c=relaxed/simple;
	bh=QeJaV7NxUMr6y7gsUb56bD7q6rDPJGAUdKl0q2s8gUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhQ4U5cqN+n0ZZse0r3iEr89Nomv04bWA1IpfI23zJ6yH1vLI4K9RKmtr9+d1SWxFerj/QF1eBynWm1hQ5H8nZh1hAbIHO9lQ8zzJPfw3tpc7+ZcW6Gx19MMXSahX+h63tyIPP0G5fbuKOadVu0g1WHH6tCmtPiReo30bKZi5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm0jdEna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0516C4CEC8;
	Fri,  6 Sep 2024 05:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725599538;
	bh=QeJaV7NxUMr6y7gsUb56bD7q6rDPJGAUdKl0q2s8gUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rm0jdEnaH3gzrt/ZrzjYJggbJMRhkZ7pVttHT3Y+qQm8rP4KhY2QvSm9MAX8Eu2SE
	 YsrL50oF9CAIz7Br9LxTh4dZT2uhC5roEACDiBZCrIoYMIk+yu7hwLc7AMIH6tFJar
	 GRZ5BwFmqxuwpF6m6qRASY8wfKRHZWJ34QrPHK9cXo3OaHBwJ0urPXPHV4kJACdIBk
	 Nz4szuc7WQA06iXoQBWbbcDWFJm9KnewfJ9cZ1gjWlI0NI+Pif3ioOEsAYa6s1uUy8
	 nUY5EWljCzZOS9t4CHvTPUDuvvpwtC30A8kEFcc5R3xvBR5SQ3jEUbBfkJYGlwt+MN
	 fwoGEE4m1GKIQ==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
Date: Thu,  5 Sep 2024 22:12:04 -0700
Message-ID: <20240906051205.530219-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240906051205.530219-1-andrii@kernel.org>
References: <20240906051205.530219-1-andrii@kernel.org>
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

A few will-it-scale ([0]) bechmarks were run with and without the
changes in this patch on a beefy server. The test script below was used.
Most of background activity on the server was stopped, but there could
still be some sporadic sources of noise. And frankly, will-it-scale
benchmarks themselves aren't 100% noise-free and do fluctuate somewhat.
Also malloc1 benchmark was getting stuck for some reason, so it was
skipped from benchmarks. But I think it was still useful as a bit of
sanity check, but take all of them with a grain of salt.

Benchmark script:

  # cat will_it_scale.sh
  #!/bin/bash

  set -eufo pipefail

  for b in page_fault1 page_fault2 page_fault3 malloc2; do
          for p in 40; do
                  echo BENCH $b CPU$p $(will-it-scale/${b}_threads -m -t$p -s60 | grep average)
          done;
  done;

Before (w/o this patch)
=======================
BENCH page_fault1 CPU40 average:5403940
BENCH page_fault2 CPU40 average:5019159
BENCH page_fault3 CPU40 average:971057
BENCH malloc2 CPU40 average:1364730680

After (w/ this patch)
=====================
BENCH page_fault1 CPU40 average:5485892
BENCH page_fault2 CPU40 average:5047923
BENCH page_fault3 CPU40 average:982953
BENCH malloc2 CPU40 average:1361339890

Results seem to be within the noise of measurements, but perhaps mm
folks might have better benchmarks to try.

  [0] https://github.com/antonblanchard/will-it-scale

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
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


