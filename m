Return-Path: <bpf+bounces-66169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFB4B2F436
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912103AF177
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B02F3C2F;
	Thu, 21 Aug 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgPGgx7N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE62F28FD;
	Thu, 21 Aug 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769110; cv=none; b=hlz9Ug1aiHwsJkaFzwB4whkxUraXlGHfyfElFHVh3WPNagslCohkRDmgxm7g6uP2j0gqrtEHEag4k5Ft0wQi4WcZ+Pv3kRT54LR/Xp25EmiuVs8ARU8NTOHtmM+89MjIg+7qRuKuf4Tkxpx4k472qTe/B4ngPJmppPWWvURZkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769110; c=relaxed/simple;
	bh=jK5dymyj55hiHpvgBZZ8z0X/9RjUBkzOLYoPvDIC2w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbXwqrSgEK6RIuRWuO2Eg8ZAOUp8HSEvIA7iyYlUntk/HHH/6w8mmbhhCxosWgrO9T4cXwl2DWt5ynrtghAqCCvgVfAeLnfWljPzPHbmzNqtkxbTEoqEonhBzpQMG+l+EQNvE78Iu8JMbd5DBXtdxW0uA9LgXutDySbZA4kQYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgPGgx7N; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24457f5b692so8298635ad.0;
        Thu, 21 Aug 2025 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755769108; x=1756373908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmGrkGg7Imifx3s5HIBsV5ipuLOW5PNOIFjJsbhXigw=;
        b=PgPGgx7Nm7Oe1ZArLX1ojF5Vqx3py0I46rad65rc6dGRSoVsCER0Gp6C2wvs11XvNi
         1FU8ght2TO1BhY9piz2bM5l96DmEapec6X+Pv/zs+nPvB4mw6KHGgaFiDnfS40N/gEKG
         kYbjUHQkAj5YsCM2uHes3d81boxJ7C1ra5aRJHIObai7RLy+8yjL1wymaHolapuEHu2t
         prG51Me180FuBnhcA4Q5LfgBW1CGa2yFbdWEALLxEyrftVSWB5oX728fnSoBHX7wSlP6
         Q2fPBfZ0v2f8cD+DY/h+G1NY0yu1biJ5K5gwTteVD8ISIgryi8QIFPMQ2/53+DjEC/sN
         gSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769108; x=1756373908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmGrkGg7Imifx3s5HIBsV5ipuLOW5PNOIFjJsbhXigw=;
        b=P8nuacxtpa2pHgGWkfvxzM2B6c/J7Q5R5uLpLBEbWs6dYpZPvc3Q6lHsNsQsU+x606
         /aFxGivkGXyCxzIyUgee9TbbHgEVLWyrKLGHBlpVr1gJnxMo/4m7ekB1CnOE6tP5wLlV
         z8aURAcPCXvzLle+rJed5dj7qlqdpC4JfxBmMbmffSqvjt8Hfu0FWKi8l2qx8MTAVSSX
         mWyJZY+AAfd0v2fL14iXUv5eqUGDbUFssv6ce2v0F5yr+MJVNGprQMdMcq4kwSYYkihM
         h7Vnj7bsWjgJeatT7BV0UEd/akfg61IcXDIic3VnLMC8OfZAvmmdgWCGqlRUeIYsNECS
         Vx0w==
X-Forwarded-Encrypted: i=1; AJvYcCVAEZ4yfX0ROi8nd39HVq3UGncAG+jxjn0odA+Rbs0dy5H/w4EKw2qAOKeuIJwHXQP8uHm/1B5ax/iA0sHr@vger.kernel.org, AJvYcCVyW7MxFNoxkQgqrZMZLMSNwv4lbHUgaKjGugqn6AMRcSwMxZpMTGGY+x3On3mmRpdkfpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5E52OKYCRX7U/rzih9imdPz/hFCqN9HePq5e0Q8981+RUe6B
	JNYmOVcZShFMOMGMxuyz9Y/FcvWpXgT6IBO+nnSAs0RJHBhFhmrPiNZo
X-Gm-Gg: ASbGncs+fjTtn936JpVX6bpM8PL7rmhpBiRzsgY32sHpXU8gnaVJqGPYQSg34iUUN0g
	CDj3cRMA/1sbrqvAtic2k4R/9HF7x3uHJkSZJPE45Y4SYa4JzJuBweptKO4zhC43s0T0ko6Y6p/
	vJ0WB8W7fW4p6BwHgRquRtBhXv2M7yUaAOwGbBJrB7JDWDkWTD1FAEvLOBkYQkh86jpC4bI0NZw
	nju6Nn3pCLpIf1DSsh6YNSgTbCW0Ihqk6oQlSCsdmYfDydrz//4FM0AcRp4BvZydi3lN330iFa1
	EIRNzTC6M2JRlWauK3fI/WO9Iw0ie5OlbZAas6yBdJ9U+BHee6QpKODBlSM+XdqTkFpL0IkGJf1
	GpuJRd2sxzKYEMGvY4UzCuAY=
X-Google-Smtp-Source: AGHT+IGjFqc8W/vRwu7zAeJb+hA0JH7xTTFSX/hIvMlRCDxMstvxsEvJsnggV0TobfPzMcZnc3Gxng==
X-Received: by 2002:a17:903:f90:b0:240:5c38:7544 with SMTP id d9443c01a7336-245fedbb9dfmr25709975ad.50.1755769107857;
        Thu, 21 Aug 2025 02:38:27 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed540040sm49652085ad.163.2025.08.21.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:38:27 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 2/3] sched: make migrate_enable/migrate_disable inline
Date: Thu, 21 Aug 2025 17:38:06 +0800
Message-ID: <20250821093807.49750-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821093807.49750-1-dongml2@chinatelecom.cn>
References: <20250821093807.49750-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, migrate_enable and migrate_disable are global, which makes them
become hotspots in some case. Take BPF for example, the function calling
to migrate_enable and migrate_disable in BPF trampoline can introduce
significant overhead, and following is the 'perf top' of FENTRY's
benchmark (./tools/testing/selftests/bpf/bench trig-fentry):

  54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k]
                 bpf_prog_2dcccf652aac1793_bench_trigger_fentry
  10.43% [kernel] [k] migrate_enable
  10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
  8.06% [kernel] [k] __bpf_prog_exit_recur
  4.11% libc.so.6 [.] syscall
  2.15% [kernel] [k] entry_SYSCALL_64
  1.48% [kernel] [k] memchr_inv
  1.32% [kernel] [k] fput
  1.16% [kernel] [k] _copy_to_user
  0.73% [kernel] [k] bpf_prog_test_run_raw_tp

So in this commit, we make migrate_enable/migrate_disable inline to obtain
better performance. The struct rq is defined internally in
kernel/sched/sched.h, and the field "nr_pinned" is accessed in
migrate_enable/migrate_disable, which makes it hard to make them inline.

Alexei Starovoitov suggests to generate the offset of "nr_pinned" in [1],
so we can define the migrate_enable/migrate_disable in
include/linux/sched.h and access "this_rq()->nr_pinned" with
"(void *)this_rq() + RQ_nr_pinned".

The offset of "nr_pinned" is generated in include/generated/rq-offsets.h
by kernel/sched/rq-offsets.c.

Generally speaking, we move the definition of migrate_enable and
migrate_disable to include/linux/sched.h from kernel/sched/core.c. The
calling to __set_cpus_allowed_ptr() is leaved in ___migrate_enable().

The "struct rq" is not available in include/linux/sched.h, so we can't
access the "runqueues" with this_cpu_ptr(), as the compilation will fail
in this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
  typeof((ptr) + 0)

So we introduce the this_rq_raw() and access the runqueues with
arch_raw_cpu_ptr/PERCPU_PTR directly.

The variable "runqueues" is not visible in the kernel modules, and export
it is not a good idea. As Peter Zijlstra advised in [2], we define and
export migrate_enable/migrate_disable in kernel/sched/core.c too, and use
them for the modules.

Before this patch, the performance of BPF FENTRY is:

  fentry         :  113.030 ± 0.149M/s
  fentry         :  112.501 ± 0.187M/s
  fentry         :  112.828 ± 0.267M/s
  fentry         :  115.287 ± 0.241M/s

After this patch, the performance of BPF FENTRY increases to:

  fentry         :  143.644 ± 0.670M/s
  fentry         :  149.764 ± 0.362M/s
  fentry         :  149.642 ± 0.156M/s
  fentry         :  145.263 ± 0.221M/s

Link: https://lore.kernel.org/bpf/CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250819123214.GH4067720@noisy.programming.kicks-ass.net/ [2]
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- don't export runqueues, define migrate_enable and migrate_disable in
  kernel/sched/core.c and use them for kernel modules instead
- define the macro this_rq_pinned()
- add some comment for this_rq_raw()

v2:
- use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP
---
 Kbuild                    |  13 ++++-
 include/linux/preempt.h   |   3 --
 include/linux/sched.h     | 106 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c     |   1 +
 kernel/sched/core.c       |  63 +++++-----------------
 kernel/sched/rq-offsets.c |  12 +++++
 6 files changed, 145 insertions(+), 53 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

diff --git a/Kbuild b/Kbuild
index f327ca86990c..13324b4bbe23 100644
--- a/Kbuild
+++ b/Kbuild
@@ -34,13 +34,24 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
+# Generate rq-offsets.h
+
+rq-offsets-file := include/generated/rq-offsets.h
+
+targets += kernel/sched/rq-offsets.s
+
+kernel/sched/rq-offsets.s: $(offsets-file)
+
+$(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
+	$(call filechk,offsets,__RQ_OFFSETS_H__)
+
 # Check for missing system calls
 
 quiet_cmd_syscalls = CALL    $<
       cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
 
 PHONY += missing-syscalls
-missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
+missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
 	$(call cmd,syscalls)
 
 # Check the manual modification of atomic headers
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1fad1c8a4c76..92237c319035 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -424,8 +424,6 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  *       work-conserving schedulers.
  *
  */
-extern void migrate_disable(void);
-extern void migrate_enable(void);
 
 /**
  * preempt_disable_nested - Disable preemption inside a normally preempt disabled section
@@ -471,7 +469,6 @@ static __always_inline void preempt_enable_nested(void)
 
 DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
-DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..ae73fb70cc05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -49,6 +49,9 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
+#ifndef COMPILE_OFFSETS
+#include <generated/rq-offsets.h>
+#endif
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -2312,4 +2315,107 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#ifndef MODULE
+#ifndef COMPILE_OFFSETS
+
+extern void ___migrate_enable(void);
+
+struct rq;
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+
+/* The "struct rq" is not available here, so we can't access the
+ * "runqueues" with this_cpu_ptr(), as the compilation will fail in
+ * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
+ *   typeof((ptr) + 0)
+ *
+ * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
+ */
+#ifdef CONFIG_SMP
+#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
+#else
+#define this_rq_raw() PERCPU_PTR(&runqueues)
+#endif
+#define this_rq_pinned() (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))
+
+static inline void __migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Check both overflow from migrate_disable() and superfluous
+	 * migrate_enable().
+	 */
+	if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
+		return;
+#endif
+
+	if (p->migration_disabled > 1) {
+		p->migration_disabled--;
+		return;
+	}
+
+	/*
+	 * Ensure stop_task runs either before or after this, and that
+	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+	 */
+	guard(preempt)();
+	if (unlikely(p->cpus_ptr != &p->cpus_mask))
+		___migrate_enable();
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
+	barrier();
+	p->migration_disabled = 0;
+	this_rq_pinned()--;
+}
+
+static inline void __migrate_disable(void)
+{
+	struct task_struct *p = current;
+
+	if (p->migration_disabled) {
+#ifdef CONFIG_DEBUG_PREEMPT
+		/*
+		 *Warn about overflow half-way through the range.
+		 */
+		WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
+		p->migration_disabled++;
+		return;
+	}
+
+	guard(preempt)();
+	this_rq_pinned()++;
+	p->migration_disabled = 1;
+}
+#else /* !COMPILE_OFFSETS */
+static inline void __migrate_disable(void) { }
+static inline void __migrate_enable(void) { }
+#endif /* !COMPILE_OFFSETS */
+
+#ifndef CREATE_MIGRATE_DISABLE
+static inline void migrate_disable(void)
+{
+	__migrate_disable();
+}
+
+static inline void migrate_enable(void)
+{
+	__migrate_enable();
+}
+#else /* CREATE_MIGRATE_DISABLE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* CREATE_MIGRATE_DISABLE */
+
+#else /* MODULE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* MODULE */
+
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..de9078a9df3a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23855,6 +23855,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
 #ifdef CONFIG_SMP
+BTF_ID(func, ___migrate_enable)
 BTF_ID(func, migrate_disable)
 BTF_ID(func, migrate_enable)
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..58164a69449d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,6 +7,8 @@
  *  Copyright (C) 1991-2002  Linus Torvalds
  *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
  */
+#define CREATE_MIGRATE_DISABLE
+#include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/hrtimer_api.h>
 #include <linux/ktime_api.h>
@@ -2381,28 +2383,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 	__do_set_cpus_allowed(p, &ac);
 }
 
-void migrate_disable(void)
-{
-	struct task_struct *p = current;
-
-	if (p->migration_disabled) {
-#ifdef CONFIG_DEBUG_PREEMPT
-		/*
-		 *Warn about overflow half-way through the range.
-		 */
-		WARN_ON_ONCE((s16)p->migration_disabled < 0);
-#endif
-		p->migration_disabled++;
-		return;
-	}
-
-	guard(preempt)();
-	this_rq()->nr_pinned++;
-	p->migration_disabled = 1;
-}
-EXPORT_SYMBOL_GPL(migrate_disable);
-
-void migrate_enable(void)
+void ___migrate_enable(void)
 {
 	struct task_struct *p = current;
 	struct affinity_context ac = {
@@ -2410,35 +2391,19 @@ void migrate_enable(void)
 		.flags     = SCA_MIGRATE_ENABLE,
 	};
 
-#ifdef CONFIG_DEBUG_PREEMPT
-	/*
-	 * Check both overflow from migrate_disable() and superfluous
-	 * migrate_enable().
-	 */
-	if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
-		return;
-#endif
+	__set_cpus_allowed_ptr(p, &ac);
+}
+EXPORT_SYMBOL_GPL(___migrate_enable);
 
-	if (p->migration_disabled > 1) {
-		p->migration_disabled--;
-		return;
-	}
+void migrate_disable(void)
+{
+	__migrate_disable();
+}
+EXPORT_SYMBOL_GPL(migrate_disable);
 
-	/*
-	 * Ensure stop_task runs either before or after this, and that
-	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
-	 */
-	guard(preempt)();
-	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &ac);
-	/*
-	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
-	 * regular cpus_mask, otherwise things that race (eg.
-	 * select_fallback_rq) get confused.
-	 */
-	barrier();
-	p->migration_disabled = 0;
-	this_rq()->nr_pinned--;
+void migrate_enable(void)
+{
+	__migrate_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
diff --git a/kernel/sched/rq-offsets.c b/kernel/sched/rq-offsets.c
new file mode 100644
index 000000000000..a23747bbe25b
--- /dev/null
+++ b/kernel/sched/rq-offsets.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+#include <linux/kbuild.h>
+#include <linux/types.h>
+#include "sched.h"
+
+int main(void)
+{
+	DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
+
+	return 0;
+}
-- 
2.50.1


