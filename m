Return-Path: <bpf+bounces-68629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A810CB7CA11
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D542326E18
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F97284883;
	Wed, 17 Sep 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ccu4yq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96A2773C7
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089386; cv=none; b=GeJmT6674lqZe4Ynl2SQzWeHfQss6YFWxHahmH/BfX55gZ502LaNIzbvEO3eWmZP3BmRtvQBHu8XRQaXcFlBV7KlYZa24MxZNT2cWlLSlZON2NK0KqAfbddoeC3xbmZ00thKjqF63efgmlt79ou9YstBNCup5D5sPnQCaQD9Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089386; c=relaxed/simple;
	bh=evqnwkFd3LTqlwrs4DhMUVQPKhCtMd5/kMVbKkmcOmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbhFtbp4L0S1rrsk8rzjLzjJdDuxLIV/Uzb68Jw7JCZ+5+WKWdywOa13j59B8rWxrNMW3y0a7anHQJlgN/Wii9O1IfznPzQlKy98+CMcdze0D1JJV4f6RuxUi4m3VqeH4VASHOAfRCGBqr4nFUASly/lpgAgxBUk1NeZz3Rb1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1ccu4yq; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso4026434b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089383; x=1758694183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysQz8N+qO7HZkfEGJ21cxgykX/0mRcVvREriQqdyxME=;
        b=I1ccu4yqlLOEtRYM3MA1E01AVjOjgPdVf+AYEL8SjO8fpauhBhBMQiFliltrvSem1K
         DolfjWBiT4d9mwXqG1OH0145FAGO8AwN4mu57Py32SI/KXoyxf18uOydcp7JoftIDXs9
         cXMNIBp4ZVQbNnyeRzKsfCLXXdHEj44ArUy+zvVdl5D45y7v0Akuivu4VK8R8T+wpOPO
         7YfDvruPvDm7QnmY47FKn4wrnUkGBuH6V3qpsskbtHO4iKf4CbbiPbYk8NgUhP0lloks
         rZBfHY0pZxkXEkgo8ZGBfGf0WhBjwHyllaMUGsnT7RGIp+U4e0PgUK85KesIM36pPJgP
         n8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089383; x=1758694183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysQz8N+qO7HZkfEGJ21cxgykX/0mRcVvREriQqdyxME=;
        b=QaKR3iCA7WZIdhblBGtn1re6m3es20suVhAGz7ZsY535JIDlekU7TppVgDelOoaNrp
         mVbmqJLAOxUGt7xcY+gTIw0soBpaHO5sJSiErH7D6WHv7tlxO1qwC7PJbrOsQS4zLBdF
         A7RUsExtIACWTt11cEK7bwUzxzqaNe8/akAM7wxfdPGw7Alm/PczyOSjXE640koVx7fO
         M9J4xQmfs1fnBzEDAvOYtYEL+DVIf0w/oBuvvO7nqwGqJNT87IH56OuWuqI0NjXynzxu
         2HTvGWoxWQ8j6Zij8qOz0vOVh7S/LUw495z40B2BXZmckc8qvU9qEOz4pc1xeH7IOmI9
         ICAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3due6Q8dPRhLgvMGzGHcOK6Ly9M4YBA2f3k4YOZcpQW3cTESIflwg182XweroB1O2Yao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRXk+LKgR0rxBTJHJGulYGtusHDJ52EQadIytQqaRa+/pm28o
	zY7Nri1p+yXnMgf0PSU05mwQGPwUpJq5dYatIuztmuQOgtDylDAQolxL
X-Gm-Gg: ASbGncuW4+wzvyvx4GOh5dH/JDuii6VpGCdTfORec2n73AIUyfg/2RSbXUDTVQzO+3r
	deYHegjk1RkGtMiXoOhq2huZSZ573RddtFd+QXSF9Z9e0SejzR3En3mAAfMDLdPKecCKImNc8wB
	d8/UmLuSuZt8hMiJ1bC6RsM615Uy1DCdYBmcf8u/TokkGkCaxMCGGRMV7LLel3jlDXKwKNxe6W1
	TB8FgSHiqRtjBjRP55BpBWvVscK66pCnc8HNvX/Z58LjnzhU3QwwyQLJygN99rJoTSM9KeIe4d/
	Lp+oRaK43k41wwPBED6si3UXk6IZnX9B9DC98Aif6nc+tjF9DAv0GwSduLGiL7PrBSbq/SvUrs0
	3kZrLoN9TFQFwzi2UdI0=
X-Google-Smtp-Source: AGHT+IFrt44m9s9yu7Fn/1C+Zc08IdcJ1DeyVWPDnzSI/ATbbKkoTUJAiDdnkVVR38BouC3uQQedPg==
X-Received: by 2002:a05:6a20:3d05:b0:24c:c33e:8df0 with SMTP id adf61e73a8af0-27aac9934e3mr1210366637.45.1758089383231;
        Tue, 16 Sep 2025 23:09:43 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:42 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
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
Subject: [PATCH v5 3/4] sched: make migrate_enable/migrate_disable inline
Date: Wed, 17 Sep 2025 14:09:15 +0800
Message-ID: <20250917060916.462278-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917060916.462278-1-dongml2@chinatelecom.cn>
References: <20250917060916.462278-1-dongml2@chinatelecom.cn>
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
v5:
- fix the comment style problem in include/linux/sched.h

v4:
- rename CREATE_MIGRATE_DISABLE to INSTANTIATE_EXPORTED_MIGRATE_DISABLE
- add document for INSTANTIATE_EXPORTED_MIGRATE_DISABLE

v3:
- don't export runqueues, define migrate_enable and migrate_disable in
  kernel/sched/core.c and use them for kernel modules instead
- define the macro this_rq_pinned()
- add some comment for this_rq_raw()

v2:
- use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP
---
 Kbuild                    |  13 ++++-
 include/linux/preempt.h   |   3 -
 include/linux/sched.h     | 114 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c     |   1 +
 kernel/sched/core.c       |  63 +++++----------------
 kernel/sched/rq-offsets.c |  12 ++++
 6 files changed, 153 insertions(+), 53 deletions(-)
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
index 644a01bdae70..2a1efccda2e2 100644
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
@@ -2317,4 +2320,115 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
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
+/*
+ * The "struct rq" is not available here, so we can't access the
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
+/*
+ * The variable "runqueues" is not visible in the kernel modules, and export
+ * it is not a good idea. As Peter Zijlstra advised, define and export
+ * migrate_enable/migrate_disable in kernel/sched/core.c too, and use
+ * them for the modules. The macro "INSTANTIATE_EXPORTED_MIGRATE_DISABLE"
+ * will be defined in kernel/sched/core.c.
+ */
+#ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
+static inline void migrate_disable(void)
+{
+	__migrate_disable();
+}
+
+static inline void migrate_enable(void)
+{
+	__migrate_enable();
+}
+#else /* INSTANTIATE_EXPORTED_MIGRATE_DISABLE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* INSTANTIATE_EXPORTED_MIGRATE_DISABLE */
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
index 9fb1f957a093..8340cecd1b35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23859,6 +23859,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
 #ifdef CONFIG_SMP
+BTF_ID(func, ___migrate_enable)
 BTF_ID(func, migrate_disable)
 BTF_ID(func, migrate_enable)
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da2062de97a2..fa437bedf8a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,6 +7,8 @@
  *  Copyright (C) 1991-2002  Linus Torvalds
  *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
  */
+#define INSTANTIATE_EXPORTED_MIGRATE_DISABLE
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
2.51.0


