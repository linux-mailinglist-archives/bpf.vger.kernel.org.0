Return-Path: <bpf+bounces-66002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8BB2C3CF
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DED188E0B6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B633CE9D;
	Tue, 19 Aug 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hYe++qOC"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EE3043BD;
	Tue, 19 Aug 2025 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606753; cv=none; b=NrQSfSzpKMOizV64ZcZO/HixR0sIf4xqQlJVhYUwCLoJOkYmSukAYB8buvCchUBSUArvzJCyKDhF8gflnlpKDBNLhUOmx1z0zlHq3DAxpJAb/ATn0ke9cS2RHhh67iT72YLfpco9Yl6qQwSgRFOFZgNo/80UXzAo36aoykHGx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606753; c=relaxed/simple;
	bh=UfjgA3IAcFiZGVMggjC3pZmukJrsoIJSLjL4mh7uIGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXup0QwnZmp1hIoW+1+fJiCcbiaX08R3aJIXsCI6BKqkd1upCrA36nWLrBuGdz80YQ92kASL1GPYuJ3483ZOkhoUyD+lXgMZjjh4eKNHf8Iz7zsdE6fpr5RXnTqAyh7EmWkWIoJt31HO/7OBKJyCtAtNVzgEcnuV+bnaTT2+Zfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hYe++qOC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qRXOWTnqCwu5OR7JWEvk9coM3l6zsXKqglM2duNSOxU=; b=hYe++qOCqjGN5b/OJJNt5KbA7N
	Hdq9mxFrZIGs2tdbLCdw1ggouzJYVsTzVnLZPeYsavQ6Zj/QQj1A8vq0YURfZg7pO6fyWfxyVPEE1
	7yyYdJHFOqivIFqLZuy1tXEo9TlVx7Ly5jXIMck6flKykLsoq9LaQx7SiVakwDvIaeg1utM3/l5gl
	pLswRlLjP1AnZZZQv4nDiEm+vYxVeiiWDnQxNhITnLyc+CwU4Oqnhc9D9hTGFsvWJ5fyoJZbWd//X
	dFJdKzdi6HQodR69HeEpJqNXECJ0/Jm+cnx5BRpKXdz/3PLG6ohhpRImKO5T8gqf1R6P02FJG+ONB
	6JKDVi+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoLVe-000000058SO-35z3;
	Tue, 19 Aug 2025 12:32:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E82BF30036F; Tue, 19 Aug 2025 14:32:14 +0200 (CEST)
Date: Tue, 19 Aug 2025 14:32:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, simona.vetter@ffwll.ch,
	tzimmermann@suse.de, jani.nikula@intel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819015832.11435-3-dongml2@chinatelecom.cn>

On Tue, Aug 19, 2025 at 09:58:31AM +0800, Menglong Dong wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..00383fed9f63 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +EXPORT_SYMBOL_GPL(runqueues);

Oh no, absolutely not.

You never, ever, export a variable, and certainly not this one.

How about something like so?

I tried 'clever' things with export inline, but the compiler hates me,
so the below is the best I could make work.

---
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2315,6 +2315,7 @@ static __always_inline void alloc_tag_re
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#ifndef MODULE
 #ifndef COMPILE_OFFSETS
 
 extern void __migrate_enable(void);
@@ -2328,7 +2329,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq
 #define this_rq_raw() PERCPU_PTR(&runqueues)
 #endif
 
-static inline void migrate_enable(void)
+static inline void _migrate_enable(void)
 {
 	struct task_struct *p = current;
 
@@ -2363,7 +2364,7 @@ static inline void migrate_enable(void)
 	(*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))--;
 }
 
-static inline void migrate_disable(void)
+static inline void _migrate_disable(void)
 {
 	struct task_struct *p = current;
 
@@ -2382,10 +2383,30 @@ static inline void migrate_disable(void)
 	(*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))++;
 	p->migration_disabled = 1;
 }
-#else
-static inline void migrate_disable(void) { }
-static inline void migrate_enable(void) { }
-#endif
+#else /* !COMPILE_OFFSETS */
+static inline void _migrate_disable(void) { }
+static inline void _migrate_enable(void) { }
+#endif /* !COMPILE_OFFSETS */
+
+#ifndef CREATE_MIGRATE_DISABLE
+static inline void migrate_disable(void)
+{
+	_migrate_disable();
+}
+
+static inline void migrate_enable(void)
+{
+	_migrate_enable();
+}
+#else /* CREATE_MIGRATE_DISABLE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* CREATE_MIGRATE_DISABLE */
+
+#else /* !MODULE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* !MODULE */
 
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,6 +7,9 @@
  *  Copyright (C) 1991-2002  Linus Torvalds
  *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
  */
+#define CREATE_MIGRATE_DISABLE
+#include <linux/sched.h>
+
 #include <linux/highmem.h>
 #include <linux/hrtimer_api.h>
 #include <linux/ktime_api.h>
@@ -119,7 +122,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_updat
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
-EXPORT_SYMBOL_GPL(runqueues);
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
@@ -2382,6 +2384,11 @@ static void migrate_disable_switch(struc
 	__do_set_cpus_allowed(p, &ac);
 }
 
+void migrate_disable(void)
+{
+	_migrate_disable();
+}
+
 void __migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -2392,7 +2399,11 @@ void __migrate_enable(void)
 
 	__set_cpus_allowed_ptr(p, &ac);
 }
-EXPORT_SYMBOL_GPL(__migrate_enable);
+
+void migrate_enable(void)
+{
+	_migrate_enable();
+}
 
 static inline bool rq_has_pinned_tasks(struct rq *rq)
 {

