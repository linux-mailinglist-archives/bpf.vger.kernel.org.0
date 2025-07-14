Return-Path: <bpf+bounces-63195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B243B04007
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899634A53D9
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4AF24EAB1;
	Mon, 14 Jul 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QaRYtQUT"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3D149C51;
	Mon, 14 Jul 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499799; cv=none; b=nmBYrdYGHAk4XLOezVt+jYG2TpO9VsrC0i04ZGBKslryrYnt1PiMXTtwfRBlPV7jcwdl9bBSYxs/bW8FTQ5QZtIlhgfO6gHUdGsiMJ6frv+6TM7ar96mX9CUw/pItpMMkF38iU2TL3juv82YWwOOHQd7Oz++yEUYKtkMyLkquIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499799; c=relaxed/simple;
	bh=uSDvZ7VTvhMtab969Fj7Ke5hLfJuIyLW2Vi1cGLIv8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGZ0HxKBeIHgFyQpjkSPss6ygE35Ick/2fCxLPuQfydJV6YAx+hbJGQQUT7XbbkWb9kfkT4FP10Xk/PrtaZsoVeHPCpQ1+oXf1HNWOGY+OwNCmhvsHesGFftNN8qXTYLJton8kxF53fPab+iGd4UK+cflst0g6tX/ysLp+rdjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QaRYtQUT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pLHtmwVxblwTxA9MgozfbATAwzmb9kfhVgNP2IA4oMs=; b=QaRYtQUT8DMpCfibdprLAmU2yP
	s6O31SaFATCU/6kXR25bnBKQDVCedhjAlRRXmVan5tWPqWOZcv7tVMfpG9exJ28l6GxzxB+uxYSNj
	wOcJUw7oBaKIFgS6MfzlbfjHEIYJihiwqUJ3J6JbfI/Cytmb9XVIwWgBD3ExsOtvcWVmx+ehLJUeQ
	QCO9FS7+H/RYp/PSOotRq/8iL/xAx9/nqbDNglsbFm6ejOlZAgzgRL47Low1Mkl1cMAKerFC6ZW/5
	nOjzbrrsbBWh5gz5sQghWUoRysrTMWEJ+1w5F0v459MxIn2MDZOWQUF43xb+ATuRG7XS+H3mSAuf1
	CzpLgnJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJFR-00000009llQ-3hx3;
	Mon, 14 Jul 2025 13:29:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC1CA30039A; Mon, 14 Jul 2025 15:29:36 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:29:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250714132936.GB4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012358.831631671@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708012358.831631671@kernel.org>

On Mon, Jul 07, 2025 at 09:22:46PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Make unwind_deferred_request() NMI-safe so tracers in NMI context can
> call it and safely request a user space stacktrace when the task exits.
> 
> Note, this is only allowed for architectures that implement a safe
> cmpxchg. If an architecture requests a deferred stack trace from NMI
> context that does not support a safe NMI cmpxchg, it will get an -EINVAL.
> For those architectures, they would need another method (perhaps an
> irqwork), to request a deferred user space stack trace. That can be dealt
> with later if one of theses architectures require this feature.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

How's this instead?

---
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,40 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
+#define UNWIND_NMI_SAFE 1
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	u32 zero = 0;
+	return try_cmpxchg(&info->id.cnt, &zero, cnt);
+}
+static inline bool test_and_set_pending(struct unwind_task_info *info)
+{
+	return info->pending || cmpxchg_local(&info->pending, 0, 1);
+}
+#else
+#define UNWIND_NMI_SAFE 0
+/* When NMIs are not allowed, this always succeeds */
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	info->id.cnt = cnt;
+	return true;
+}
+static inline bool test_and_set_pending(struct unwind_task_info *info)
+{
+	int pending = info->pending;
+	info->pending = 1;
+	return pending;
+}
+#endif /* CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG */
+
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
@@ -41,21 +75,16 @@ static DEFINE_PER_CPU(u32, unwind_ctx_ct
  */
 static u64 get_cookie(struct unwind_task_info *info)
 {
-	u32 cpu_cnt;
-	u32 cnt;
-	u32 old = 0;
+	u32 cnt = 1;
 
 	if (info->id.cpu)
 		return info->id.id;
 
-	cpu_cnt = __this_cpu_read(unwind_ctx_ctr);
-	cpu_cnt += 2;
-	cnt = cpu_cnt | 1; /* Always make non zero */
-
-	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
-		/* Update the per cpu counter */
-		__this_cpu_write(unwind_ctx_ctr, cpu_cnt);
-	}
+	/* LSB it always set to ensure 0 is an invalid value. */
+	cnt |= __this_cpu_read(unwind_ctx_ctr) + 2;
+	if (try_assign_cnt(info, cnt))
+		__this_cpu_write(unwind_ctx_ctr, cnt);
+
 	/* Interrupts are disabled, the CPU will always be same */
 	info->id.cpu = smp_processor_id() + 1; /* Must be non zero */
 
@@ -174,27 +203,29 @@ int unwind_deferred_request(struct unwin
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	/* NMI requires having safe cmpxchg operations */
+	if (WARN_ON_ONCE(!UNWIND_NMI_SAFE && in_nmi()))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* callback already pending? */
-	if (info->pending)
+	if (test_and_set_pending(info))
 		return 1;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		WRITE_ONCE(info->pending, 0);
 		return ret;
+	}
 
-	info->pending = 1;
 	return 0;
 }
 

