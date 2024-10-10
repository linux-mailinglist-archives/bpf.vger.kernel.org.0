Return-Path: <bpf+bounces-41643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284E999400
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF521283CD5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C691E47C9;
	Thu, 10 Oct 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIJtnOw3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6561E2029;
	Thu, 10 Oct 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593814; cv=none; b=Dmd11ZMwl9Ei1ghJeKs1I/LiO04z1dPaVvtca2RveJFdjfRTONfut3Bl7TA6sEgXFIk9C2YZv4OLCQ3Ta9lTSjedXXb6kgQBfoz9cEfUy4szXjHh1C+KhtdQHkH+uXej/bznpVsa3Y4X2BxkfBsUSqQgfLBeJ8NmJ9pXcXqu1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593814; c=relaxed/simple;
	bh=Fclxig+1EAtAWEBIe+FzYZRXWMXhfE7OvVxsNaE1DGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4a1w6q+OddA/uUe5cgCGrt7iap6c6gioGGHT4YJG03C3o2+lQ2iouP7fBLMP5tlMlYrjoYHWq0AoucReRq0bkn6MsD6ti5EidEvShzP7l4zFD0AXskZf3n15vN9N2JG+3csiHFj1iK0Qlx+VZKHf0rHhSd6o6nwGYiqkjqBb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIJtnOw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2A2C4CECD;
	Thu, 10 Oct 2024 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728593814;
	bh=Fclxig+1EAtAWEBIe+FzYZRXWMXhfE7OvVxsNaE1DGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIJtnOw3slAN3+Rawp25Ab7zwSbPGytnf251F+P9dJp6mu+wi/4bvnkUAD61lBZ+/
	 WiAu/Sv6kxIzrTRke67spN6D/KVkdsbex8Ahhuy9n+F4/ehSWhLtH+BytOQANs7lrb
	 aONXzNWSCTZnJqFgqCP2i/b98GyBTchxH27Zw2pzlsoAgiRRdUty410qoKQcz+Xgn0
	 hR6S9fDgI4MghcYQ6mWM2w1TocGDnVZEg+S0ok1Wz7LhFGV3nzu3/SGSj6eoncF57G
	 n9m1cte7bZ3wjUSFSd8j6GY78XZnXoaezm3DCmAjB6uJkKA7R6z0X3iGMac6OnqpgQ
	 fl7T/DexrVneg==
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
Subject: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit mm_lock_seq/vm_lock_seq on 64-bit architectures
Date: Thu, 10 Oct 2024 13:56:42 -0700
Message-ID: <20241010205644.3831427-3-andrii@kernel.org>
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

To increase mm->mm_lock_seq robustness, switch it from int to long, so
that it's a 64-bit counter on 64-bit systems and we can stop worrying
about it wrapping around in just ~4 billion iterations. Same goes for
VMA's matching vm_lock_seq, which is derived from mm_lock_seq.

I didn't use __u64 outright to keep 32-bit architectures unaffected, but
if it seems important enough, I have nothing against using __u64.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/mm.h        | 6 +++---
 include/linux/mm_types.h  | 4 ++--
 include/linux/mmap_lock.h | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..97819437832e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -730,7 +730,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, long *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -749,7 +749,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	long mm_lock_seq;
 
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
@@ -767,7 +767,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	long mm_lock_seq;
 
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5d8cdebd42bc..0dc57d6cfe38 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -715,7 +715,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	long vm_lock_seq;
 	/* Unstable RCU readers are allowed to read this. */
 	struct vma_lock *vm_lock;
 #endif
@@ -898,7 +898,7 @@ struct mm_struct {
 		 * Can be read with ACQUIRE semantics if not holding write
 		 * mmap_lock.
 		 */
-		int mm_lock_seq;
+		long mm_lock_seq;
 #endif
 
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9d23635bc701..f8fd6d879aa9 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -105,7 +105,7 @@ static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
 	}
 }
 
-static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq)
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, long *seq)
 {
 	/* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
 	*seq = smp_load_acquire(&mm->mm_lock_seq);
@@ -113,7 +113,7 @@ static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq)
 	return (*seq & 1) == 0;
 }
 
-static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq)
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, long seq)
 {
 	/* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
 	smp_rmb();
@@ -123,8 +123,8 @@ static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq)
 #else
 static inline void init_mm_lock_seq(struct mm_struct *mm) {}
 static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire) {}
-static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq) { return false; }
-static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq) { return false; }
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, long *seq) { return false; }
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, long seq) { return false; }
 #endif
 
 /*
-- 
2.43.5


