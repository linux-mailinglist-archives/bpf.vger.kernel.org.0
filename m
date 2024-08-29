Return-Path: <bpf+bounces-38443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BD964DD1
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552772835A4
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7C1B8E82;
	Thu, 29 Aug 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0C32/Hx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3A1B9B4B;
	Thu, 29 Aug 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956676; cv=none; b=YnUOV4eDHUg/kBkW5QNUKsxP1pVei6ONMnbU5roREIshVlT11/KzgYnJwqwH8c0HxjkCZPD58OwSeZmoo3gY6lyyw0STtiDeInQ6KW6ysKfZlDTssrQtqvoEnz3tfORCFc4cez/WoVm/MfZJ7g3GSg/soVfz2wYfzNg9cdc6Nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956676; c=relaxed/simple;
	bh=uB9+IvJHW7QHyKw3tlvcdrmTqmlaEh8Wb6qWvDMkeqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt43ZIaLuGZpYedgsDK0wW+vke0ADGoN4n3aYBfjEqC5dBZnkNLxGPGC2zLwZ4lVLHLraGewYx5gWxo6wv8RHq01LeH/0wCmfJo0DiLqv9uCtjSXBIquqYOC+QokqMsuSXr7XLMwFdE5prI+pYNmJxJVU3CzxRa/sWAAR7imhpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0C32/Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C858C4CEC1;
	Thu, 29 Aug 2024 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956676;
	bh=uB9+IvJHW7QHyKw3tlvcdrmTqmlaEh8Wb6qWvDMkeqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0C32/HxcnullYmYODfLBOAm95ENZ77LpyOSqhrTR5282TU19iHVfGCtTERRKl4Xd
	 gEoceEOvrXWiPR5WvCbPIecsj2plew3ivwlj3WwOiAqxtwwECBThdxn+Mml3qBA7j7
	 RLikOuen3wU/dRuBorVMIGts13xMDZhNtC+ScbQHhOTSUgZgSpZENOzdXljKuGXaFz
	 YeSw7eef693DWz+loTFI1HdJQofxGf/eI6YuLHudlkEPyXtX49LpuPxfuZb0xUEQ2N
	 3fNV9bCTWMO+3XFKlfnJzuS7l4KTglLvSyd9817qOMzE0nGaBC3Lsy+GfsR3F2RXDv
	 ZFYHpe9IhIO1w==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 3/8] uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
Date: Thu, 29 Aug 2024 11:37:36 -0700
Message-ID: <20240829183741.3331213-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829183741.3331213-1-andrii@kernel.org>
References: <20240829183741.3331213-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It serves no purpose beyond adding unnecessray argument passed to the
filter callback. Just get rid of it, no one is actually using it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h     | 10 +---------
 kernel/events/uprobes.c     | 18 +++++++-----------
 kernel/trace/bpf_trace.c    |  3 +--
 kernel/trace/trace_uprobe.c |  9 +++------
 4 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 6332c111036e..9cf0dce62e4c 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -28,20 +28,12 @@ struct page;
 
 #define MAX_URETPROBE_DEPTH		64
 
-enum uprobe_filter_ctx {
-	UPROBE_FILTER_REGISTER,
-	UPROBE_FILTER_UNREGISTER,
-	UPROBE_FILTER_MMAP,
-};
-
 struct uprobe_consumer {
 	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
 				struct pt_regs *regs);
-	bool (*filter)(struct uprobe_consumer *self,
-				enum uprobe_filter_ctx ctx,
-				struct mm_struct *mm);
+	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 	struct uprobe_consumer *next;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3e3595753e2c..8bdcdc6901b2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -918,21 +918,19 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	return ret;
 }
 
-static inline bool consumer_filter(struct uprobe_consumer *uc,
-				   enum uprobe_filter_ctx ctx, struct mm_struct *mm)
+static inline bool consumer_filter(struct uprobe_consumer *uc, struct mm_struct *mm)
 {
-	return !uc->filter || uc->filter(uc, ctx, mm);
+	return !uc->filter || uc->filter(uc, mm);
 }
 
-static bool filter_chain(struct uprobe *uprobe,
-			 enum uprobe_filter_ctx ctx, struct mm_struct *mm)
+static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	struct uprobe_consumer *uc;
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
-		ret = consumer_filter(uc, ctx, mm);
+		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
 	}
@@ -1099,12 +1097,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
-			if (consumer_filter(new,
-					UPROBE_FILTER_REGISTER, mm))
+			if (consumer_filter(new, mm))
 				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
-			if (!filter_chain(uprobe,
-					UPROBE_FILTER_UNREGISTER, mm))
+			if (!filter_chain(uprobe, mm))
 				err |= remove_breakpoint(uprobe, mm, info->vaddr);
 		}
 
@@ -1387,7 +1383,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	 */
 	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
 		if (!fatal_signal_pending(current) &&
-		    filter_chain(uprobe, UPROBE_FILTER_MMAP, vma->vm_mm)) {
+		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
 			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
 		}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e391daafa64..73c570b5988b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3320,8 +3320,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 }
 
 static bool
-uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx,
-			 struct mm_struct *mm)
+uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 52e76a73fa7c..7eb79e0a5352 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1078,9 +1078,7 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	return trace_handle_return(s);
 }
 
-typedef bool (*filter_func_t)(struct uprobe_consumer *self,
-				enum uprobe_filter_ctx ctx,
-				struct mm_struct *mm);
+typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
 
 static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
@@ -1339,8 +1337,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 	return err;
 }
 
-static bool uprobe_perf_filter(struct uprobe_consumer *uc,
-				enum uprobe_filter_ctx ctx, struct mm_struct *mm)
+static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm)
 {
 	struct trace_uprobe_filter *filter;
 	struct trace_uprobe *tu;
@@ -1426,7 +1423,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 static int uprobe_perf_func(struct trace_uprobe *tu, struct pt_regs *regs,
 			    struct uprobe_cpu_buffer **ucbp)
 {
-	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
+	if (!uprobe_perf_filter(&tu->consumer, current->mm))
 		return UPROBE_HANDLER_REMOVE;
 
 	if (!is_ret_probe(tu))
-- 
2.43.5


