Return-Path: <bpf+bounces-40721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926198C865
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 00:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43891F24DAF
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E631CF281;
	Tue,  1 Oct 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heHmzfSm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E721CF5D1;
	Tue,  1 Oct 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823142; cv=none; b=J8Tx2s8vzTw6+FV37fePMlf/KJBlOs5dN43d0qRUjVR4s3elTexWVoFiXwAnRIE0y/VhayJlNa4ytl9hOjDtiLDXW0a6Gd2GETdq5u2rfDThhlTBVC0a8u/EurPDC6ksAuNK6ekmZLxgup10fJx6vRrb1rpA+8b1B+jE1EmZqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823142; c=relaxed/simple;
	bh=Q4lsQ3VDioDbBQhpNH028nIzfuY7M4lO4nHV2LRxuL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cic6QzfYFVXNlUWfA+29s3cMa6KcxS0SerYvzOL8rXZyuctL8jJY3HgUOerXFERmTNqEyhGc6Qeri4MzRcxlwHKtZfq6r6QXb7kj9YYOHFAOVnnzG6Nv4bCtxKKwbvHwB1b9q/gp04TB5lJZw1vTMUvS2xf409AxUhlkgC98g2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heHmzfSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09495C4CECD;
	Tue,  1 Oct 2024 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823142;
	bh=Q4lsQ3VDioDbBQhpNH028nIzfuY7M4lO4nHV2LRxuL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heHmzfSm2yzI1iI9a6pWLMysWPAc4UEw5I9P9k+LCuudPU3BDHrwWOqPAvRSOEqTP
	 Ld0jpPXOtCuEWw1kQnr1yJxZdwUK1sroXcx6QboO6bkoM27/YJj51x4ArDOxWR7e+N
	 6TroV0+9NlEv+Gi6hpXaHDl9AgN4jyT3NE6il/bVevt/+NknSG3iX/M2eRxc8xAc4x
	 DmsnJVCgep1LiyQEN3aTVQ3r3ZIG1B2qky5sxKLak2lGcIuCEBKb7s+4J8x771Ipfs
	 Y7l+2n+hzxF9xCO4R2/LEb/EF/kjGm7gDDPXvnpTHGN5iCRHxN/cwUM+nhZ1rDPCOl
	 4im8A0phpKNdQ==
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
Subject: [PATCH v2 tip/perf/core 2/5] mm: switch to 64-bit mm_lock_seq/vm_lock_seq on 64-bit architectures
Date: Tue,  1 Oct 2024 15:52:04 -0700
Message-ID: <20241001225207.2215639-3-andrii@kernel.org>
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
 include/linux/mmap_lock.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6549d0979b28..f8e75d0642a8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -716,7 +716,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, long *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -735,7 +735,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	long mm_lock_seq;
 
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
@@ -753,7 +753,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	long mm_lock_seq;
 
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d5e3f907eea4..c045543f43d9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -705,7 +705,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	long vm_lock_seq;
 	struct vma_lock *vm_lock;
 #endif
 
@@ -887,7 +887,7 @@ struct mm_struct {
 		 * Can be read with ACQUIRE semantics if not holding write
 		 * mmap_lock.
 		 */
-		int mm_lock_seq;
+		long mm_lock_seq;
 #endif
 
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9d23635bc701..fca527dece63 100644
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
-- 
2.43.5


