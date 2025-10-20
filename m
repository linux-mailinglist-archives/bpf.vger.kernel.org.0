Return-Path: <bpf+bounces-71598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D004BF7DE6
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15943353759
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B0351FBF;
	Tue, 21 Oct 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LB9bd8MD"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968C34F25E;
	Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067151; cv=none; b=GEt707LA3PjJgAygTi0n82FuTgehiIeEad6yYBFUKCYnsPcpHx72LMPMy7VTz2KyofzmuAEHupZq8ofqIrkrMkDdMXRryCsinvXQnpPDquK5o97HQ/nbmeFozQMq2jE5DM3vgV9/V3apUnBroJszJP8ziLhgg7/tSD2pDLaKi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067151; c=relaxed/simple;
	bh=QsHFvi//g4HRcWfugd+JY1chiMBqOhI9UXQyr1+ljSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZHPZsBJDtb3fVU229n2x3qBTfm8d7vsCT+RTtG55dKJ7PSxX09SwtEigO31E4VhUD7mZKMlJN2ROOGrzYpL/lqyTDv6kfMHavGIZ9y4ny1XNRnXHodp8wE9n/1LPkzrR3576TQnUJQV2ZwKmbwQFM2SEyD5CabY5i8MAfAWxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LB9bd8MD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RSjTgo/UGZZgGAoRYbVD0IljFiwy3i9IhIYBJ8qHaDM=; b=LB9bd8MDfmb03oYRhY77QkhDtG
	f+DqEN5CUg6EZW9udx1ma8UHKwqLH/FP4meJrfBKiilWzdAuTrg8DqqzsC6Kcg7xja0JZmAi0WwIE
	P1wl25DaZJ4fUgiC4cUoaxS7gtqAjvAQCagWPmqeVgBACRQR4hvf9TxrguTCQZbYcQGjxJ1LbCjuA
	vyJ706fFka2qoCsPObKQ1MMffgoYfccGV9H6wHVOyek6eWlZthIMlp3e4zA3x6VABved+oN2YXMd4
	vT9DOobxQH5tpdBrxzLk1xTkFWN7rWEycLRJeXwoI0l2cQM9zOfTLgxX438j5jA2DcBXMoSS94J48
	PxLVA66Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0f-0000000DsZX-012g;
	Tue, 21 Oct 2025 17:18:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 39E093030D8; Mon, 20 Oct 2025 13:40:40 +0200 (CEST)
Date: Mon, 20 Oct 2025 13:40:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] perf: Use extern perf_callchain_entry
 for get_perf_callchain
Message-ID: <20251020114040.GT3419281@noisy.programming.kicks-ass.net>
References: <20251019170118.2955346-1-chen.dylane@linux.dev>
 <20251019170118.2955346-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019170118.2955346-2-chen.dylane@linux.dev>

On Mon, Oct 20, 2025 at 01:01:17AM +0800, Tao Chen wrote:
> From bpf stack map, we want to use our own buffers to avoid unnecessary
> copy, so let us pass it directly. BPF will use this in the next patch.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---

> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 808c0d7a31f..851e8f9d026 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -217,8 +217,8 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
>  }
>  
>  struct perf_callchain_entry *
> -get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark)
> +get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
> +		   bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark)
>  {
>  	struct perf_callchain_entry *entry;
>  	struct perf_callchain_entry_ctx ctx;
> @@ -228,7 +228,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>  	if (crosstask && user && !kernel)
>  		return NULL;
>  
> -	entry = get_callchain_entry(&rctx);
> +	if (external_entry)
> +		entry = external_entry;
> +	else
> +		entry = get_callchain_entry(&rctx);
> +
>  	if (!entry)
>  		return NULL;
>  
> @@ -260,7 +264,8 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>  	}
>  
>  exit_put:
> -	put_callchain_entry(rctx);
> +	if (!external_entry)
> +		put_callchain_entry(rctx);
>  
>  	return entry;
>  }

Urgh.. How about something like the below, and then you fix up
__bpf_get_stack() a little like this:


diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4d53cdd1374c..8b85b49cecf7 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -303,8 +303,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	u32 max_depth = map->value_size / stack_map_data_size(map);
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
+	struct perf_callchain_entry_ctx ctx;
 	struct perf_callchain_entry *trace;
-	bool kernel = !user;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -314,8 +314,13 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+	trace = your-stuff;
+
+	__init_perf_callchain_ctx(&ctx, trace, max_depth, false);
+	if (!user)
+		__get_perf_callchain_kernel(&ctx, regs);
+	else
+		__get_perf_callchain_user(&ctx, regs);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */



---
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..14a382cad1dd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
 	u32				nr;
 	short				contexts;
 	bool				contexts_maxed;
+	bool				add_mark;
 };
 
 typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
@@ -1718,9 +1719,17 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+
+extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+				      struct perf_callchain_entry *entry,
+				      u32 max_stack, bool add_mark);
+
+extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7a31fa..edd76e3bb139 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -216,50 +216,70 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
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
+		perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
+	perf_callchain_kernel(ctx, regs);
+}
+
+void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
+{
+	int start_entry_idx;
+
+	if (!user_mode(regs)) {
+		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			return;
+		regs = task_pt_regs(current);
+	}
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
+
+	start_entry_idx = entry->nr;
+	perf_callchain_user(ctx, regs);
+	fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
+}
+
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask)
 {
-	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
-	int rctx, start_entry_idx;
+	struct perf_callchain_entry *entry;
+	int rctx;
 
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
 		return NULL;
 
-	entry = get_callchain_entry(&rctx);
+	entry = get_callchain_entry(&rctx, regs);
 	if (!entry)
 		return NULL;
 
-	ctx.entry		= entry;
-	ctx.max_stack		= max_stack;
-	ctx.nr			= entry->nr = 0;
-	ctx.contexts		= 0;
-	ctx.contexts_maxed	= false;
+	__init_perf_callchain_ctx(&ctx, entry, max_stack, true);
 
-	if (kernel && !user_mode(regs)) {
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-		perf_callchain_kernel(&ctx, regs);
-	}
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);
+	if (user && !crosstask)
+		__get_perf_callchain_user(&ctx, regs);
 
-	if (user && !crosstask) {
-		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				goto exit_put;
-			regs = task_pt_regs(current);
-		}
-
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
-
-		start_entry_idx = entry->nr;
-		perf_callchain_user(&ctx, regs);
-		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-	}
-
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c1a362..cbe073d761a8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 		return &__empty_callchain;
 
 	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+				       max_stack, crosstask);
 	return callchain ?: &__empty_callchain;
 }
 

