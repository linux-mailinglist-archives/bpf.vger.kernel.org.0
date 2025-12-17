Return-Path: <bpf+bounces-76842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A363ACC6D7A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25FA9300502A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1033DEF7;
	Wed, 17 Dec 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gpPlvs9E"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A833D4FC
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964050; cv=none; b=OV4j6fh0afXIxoBJQc3LPHvI0xq69Hd9AOdcpZ6pTr/Gy00qHXU8vC63oHqiQjxaFaglkuwk/juLUa1RXpXH8uSniRXEynDDAPVWce/Y/LrU7jHkZBEfwYl8F3FxkK2PHxPpl+S9LkJUT7Gv8E5rg6xN9lkDI7sD//5YcqSmx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964050; c=relaxed/simple;
	bh=5ioWaFO4+Kq2uYQ1+qXzbSfQIUd5d5RjdjcsFE9VmwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7UOyA/Q0Jbe0SUUZUZWX4+i94CLqApex04p9lX9qzFw3fNkBy2+uoCh4snAq0NK2bCuG+080RxkC6b/R1UNZhsHLAnyDdswySHGY0yVDnTkxOFDcM5LEmtKpEHjr+VH6JoQA5HKs8WmGNxlWFfShQcjbSppEGL7sMiZI+n2c1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gpPlvs9E; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5JftX5nCvedv6EPifDZq2yTQY8oH6ldLTNQvOsNazM=;
	b=gpPlvs9EF3E+BjN/UKj2uuOdGttjJ6OcoaisTq0p30pv7cL0GvbEnCV/Fm3XWak5hQ6eal
	BsXupAzo6f7DjAf3mIQOCVgLihC+PeP1EFgwnD8EaJI6CfjL9ssp3WEWXWsqF35Dq5DJ4D
	ytU4ULmMMi7THbfMnBvQokbBViQP/XQ=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v7 1/2] perf: Refactor get_perf_callchain
Date: Wed, 17 Dec 2025 17:33:25 +0800
Message-ID: <20251217093326.1745307-2-chen.dylane@linux.dev>
In-Reply-To: <20251217093326.1745307-1-chen.dylane@linux.dev>
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From BPF stack map, we want to ensure that the callchain buffer
will not be overwritten by other preemptive tasks. Peter
suggested provide more flexible stack-sampling APIs, which
can be used in BPF, and we can still use the perf callchain
entry with the help of these APIs. The next patch will modify
the BPF part.

In the future, these APIs will also make it convenient for us to
add stack-sampling kfuncs in the eBPF subsystem, just as Andrii and
Alexei discussed earlier.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h | 10 ++++
 kernel/events/callchain.c  | 99 +++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9870d768db4..e727ff7fa0c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
 	u32				nr;
 	short				contexts;
 	bool				contexts_maxed;
+	bool				add_mark;
 };
 
 typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
@@ -1718,6 +1719,15 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+
+extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+				      struct perf_callchain_entry *entry,
+				      u32 max_stack, bool add_mark);
+
+extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs,
+				      u64 defer_cookie);
+
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b9c7e00725d..17030c22175 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -216,13 +216,67 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 #endif
 }
 
+void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+			       struct perf_callchain_entry *entry,
+			       u32 max_stack, bool add_mark)
+
+{
+	ctx->entry		= entry;
+	ctx->max_stack		= max_stack;
+	ctx->nr			= entry->nr = 0;
+	ctx->contexts		= 0;
+	ctx->contexts_maxed	= false;
+	ctx->add_mark		= add_mark;
+}
+
+void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return;
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_KERNEL);
+	perf_callchain_kernel(ctx, regs);
+}
+
+void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs,
+			       u64 defer_cookie)
+{
+	int start_entry_idx;
+
+	if (!user_mode(regs)) {
+		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			return;
+		regs = task_pt_regs(current);
+	}
+
+	if (defer_cookie) {
+		/*
+		 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
+		 * which can be stitched to this one, and add
+		 * the cookie after it (it will be cut off when the
+		 * user stack is copied to the callchain).
+		 */
+		perf_callchain_store_context(ctx, PERF_CONTEXT_USER_DEFERRED);
+		perf_callchain_store_context(ctx, defer_cookie);
+		return;
+	}
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
+
+	start_entry_idx = ctx->entry->nr;
+	perf_callchain_user(ctx, regs);
+	fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
+}
+
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
-	int rctx, start_entry_idx;
+	int rctx;
 
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
@@ -232,46 +286,13 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry		= entry;
-	ctx.max_stack		= max_stack;
-	ctx.nr			= entry->nr = 0;
-	ctx.contexts		= 0;
-	ctx.contexts_maxed	= false;
-
-	if (kernel && !user_mode(regs)) {
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-		perf_callchain_kernel(&ctx, regs);
-	}
+	__init_perf_callchain_ctx(&ctx, entry, max_stack, add_mark);
 
-	if (user && !crosstask) {
-		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				goto exit_put;
-			regs = task_pt_regs(current);
-		}
-
-		if (defer_cookie) {
-			/*
-			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
-			 * which can be stitched to this one, and add
-			 * the cookie after it (it will be cut off when the
-			 * user stack is copied to the callchain).
-			 */
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
-			perf_callchain_store_context(&ctx, defer_cookie);
-			goto exit_put;
-		}
-
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
-
-		start_entry_idx = entry->nr;
-		perf_callchain_user(&ctx, regs);
-		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-	}
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);
 
-exit_put:
+	if (user && !crosstask)
+		__get_perf_callchain_user(&ctx, regs, defer_cookie);
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.48.1


