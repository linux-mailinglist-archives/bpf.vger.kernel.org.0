Return-Path: <bpf+bounces-38805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FD96A5BE
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D632BB2231D
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BACD192D92;
	Tue,  3 Sep 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+gUUnua"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B2192B99;
	Tue,  3 Sep 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385578; cv=none; b=h0hEBnxGRnXFUtV1Hz+nUgm94xPwy/MOHvtef7lGeYoyrYlHrva1IXGdsa/mjyqV+gucyVqGmP+PAQCQ6w61018aUSef2X77FKjJ5t2oGBH28RM41LkxCQt3IdPmcB/MbrlbmdYKtuLnCnbjff7lMiiHe4gd2XwbUxNslq2deP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385578; c=relaxed/simple;
	bh=N5+oyD36t1Y3uV0QDaXdkNDQIadUdSARy7H0PZ8GrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FP/SosmPqUDzF2OuhHsZn7FEcB65QXnH/9KLNr4UBsXPZawbEOo2Z0jLxoS4lWvCx1NjpySpmEsadEHtL5oELOxkwxc0f7qj5Dx0knbxiZC83yIKUlAplvatsa533DtuiYnwuharpdTVx64rhS//l3JajJhtJS3I01g62ehz71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+gUUnua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5688C4CEC9;
	Tue,  3 Sep 2024 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725385577;
	bh=N5+oyD36t1Y3uV0QDaXdkNDQIadUdSARy7H0PZ8GrZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+gUUnuasOBgH12BDlSefX51CiByLaX7P6euE1PZPq1aZGeB6vcaM3sc9UbSboX9x
	 oP48UCrq4njBF7u0GklrP3Q7+F+wnuYG1WEd2Q00a+j31EbwdMfMFRaNRbZBVn14a/
	 c3E/xaBKcD3WgV5kuNEfr2lJYi3ziXSHCtYK10D3RZHPRCtAZWJFH0W/KShzQKEvv9
	 HDVmAxHhMAc4z1UKeFeKgc0fh+l5LSVEEW3xksY4HWJsePbRLTO1QFls/psiMDsdlO
	 KWKgudcy3RhL3APUtIJ/WnLHjT60YzazSUo9/mOSoJgdzdKNLx7kJDSSWpWxfgVdoO
	 McX/FLF4C/q+Q==
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
Subject: [PATCH v5 3/8] uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
Date: Tue,  3 Sep 2024 10:45:58 -0700
Message-ID: <20240903174603.3554182-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903174603.3554182-1-andrii@kernel.org>
References: <20240903174603.3554182-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It serves no purpose beyond adding unnecessray argument passed to the
filter callback. Just get rid of it, no one is actually using it.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
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


