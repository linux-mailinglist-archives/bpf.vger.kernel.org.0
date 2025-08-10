Return-Path: <bpf+bounces-65306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05125B1F836
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 05:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7544E046E
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4731A0BE1;
	Sun, 10 Aug 2025 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8hUDadd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486917333F;
	Sun, 10 Aug 2025 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754795134; cv=none; b=iJdAeYdOdcSmbXPJpucCTBNgBH5I9NFALRvQEF9/thQ5fF3LljcIwirL0OUU2DI6X0dPyHEr8zDCBfnK+4Gk8de6sfBFq7HvxzvAlkillBTj2BUbOHiONIfUDeeDptGYxRGe6TWQ7iArvGUtBee7+rB1NeoRO1s0tGRntGZdcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754795134; c=relaxed/simple;
	bh=UW0pJQMcISAu1g75T7Lt8itEdsV5EjcUI+raQ8mCRCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQG/tpQjvTR5ppw2EMVofSptt2/r06EN96GO9IFMrBldtWqAmPnpLGwEHKT4BkuZcx6cXPmd10DDjoxGZI8vaI2CLU2SzxH6MLZISnVb9KgsZUctB0F+XNk03WSfQa46eIEr6s9dlQIP76Zhmo/4xInQw5FCFUwL5EQYwE6g3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8hUDadd; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso2929124b3a.1;
        Sat, 09 Aug 2025 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754795132; x=1755399932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfHV9bIyt5rbICyogwuiVIfKAoUEiKQorPCAB/q2Xeg=;
        b=W8hUDaddKxhHXGSOH2Rn/aBmNLLYiobZrSSXwhRygxiRsbLZIKkmHDdklFAseoi1f/
         t4t+8ZbU6MkD19F8EjY61Tbuho5FsFOExUxGHJrhrylkd5jNvVN+MCfFLemaZbDTjuSw
         IW80zk8VBUampwiEI6/v/uLRD+kIoiSpxTvE42qrEZhEJ63a655jgqamWl8YfJ2D3wW/
         35j2N+uO6HMSf9hmHX6yEcr6qeYVmqlk8eNkshn8pk9TzIVzDWS3UbWuQ9/YKLdKtXq9
         0maPhfgzrzfEQWb0EuflZW2f9pg0nVELme2HGq+movHUP9om5EOjKtPgNJVqbntJM0+R
         E3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754795132; x=1755399932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfHV9bIyt5rbICyogwuiVIfKAoUEiKQorPCAB/q2Xeg=;
        b=MM8L5E+/XsJnI9LGca2JgWPgt+r21PrcvH1JaVFDR823JV58ksEHZl+laHCp9l749A
         9OHKu9Y7NasKRSRifVLvXrPj2hj4RPuPd0lEjQeVfiHLTki8Wjv/ducwsmNEl9xEfoS6
         hJGXlV/B7ppsHjx+Qvlmvyd0Eu7d3mLgbGkLbpPNTQhOpM2h9cC9tVwoxcUBKj0q1rWT
         Yizqxs7hwC2pWPt24NaoY4L6R9mCbBs6tb5TqhiDHgH9hT4UU2gJREa73LXzME319Dzb
         3L/Pn1iCnYg2H68O696Sr098ZdkvCSnigWn3WyA0QyXpQ5fMyLS/gfzDLNz+jjcyzu6M
         AEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBkpc9jWSFapIK9cAwiQs/RCWZpz/30wnywzz7dADiDgLXVtT7gPSM3QZ6bUAKezcKg/o=@vger.kernel.org, AJvYcCUifltZZmb5fgWRUZ2PJA8wU7zQhMT7YZbas9KePdUuBPx7OqOMN0E6xTTVs5/6vbnujtt5qiWRiluwiCDf@vger.kernel.org
X-Gm-Message-State: AOJu0YynBI/PYs/mvJmcKDFtbxhwdXALzNcGMDxGkvISxnwmwAWsUdhw
	b4pA6VMdqxangyVQbj8hMVfC+D9x29v4+5QVcdNAvJOUws1xDeZnyuNu
X-Gm-Gg: ASbGncvoo2UJ9cSAKUm25uJT81edX1gCgMhvLhsGi3aL62k7ftffHjN6q4uEJa111rk
	ZT2Xc2pHDzMR4050fDZ1Jn4jwarbKDFtXaKex2oULlyGqM+H5YBuTtwJ7pOTvaCif/AJylF5EfZ
	I2G70Iga8VaRytVIyye2nnDvm8pv5aPwEx+tZS9wN8WnRdIbUVAdE7MjQOtsBtEUhOXY15pnI0i
	z2Txb1DAvp9yFqBwof7obdAqeWGmPNrs7MP1w5cQvzYlaGbJYJ7Ggllizj8StieCFxJ7RkORBJi
	Kt+81I9K70/rEnHmFrKby+iBw7kepxLuiJmEW8nDUS3EHR9GkmtM8moXn3+olbD9Yv5Ol+8CcK3
	LWoyuEsHWEnpLRs2YRrkbInCITdwrvQ==
X-Google-Smtp-Source: AGHT+IF/XcaE8O/9dKzl5xPGfM7QV9bCDTJ5B7gD98tSc3MtNIZ3uwdw6StoAwey553JB7sC+sV72g==
X-Received: by 2002:a05:6a00:10cf:b0:76b:cdce:484f with SMTP id d2e1a72fcca58-76c4603d30dmr14080885b3a.3.1754795132101;
        Sat, 09 Aug 2025 20:05:32 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm21276265b3a.6.2025.08.09.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 20:05:31 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	alexei.starovoitov@gmail.com
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
	jani.nikula@intel.com,
	simona.vetter@ffwll.ch,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH tip 2/3] sched: make migrate_enable/migrate_disable inline
Date: Sun, 10 Aug 2025 11:04:41 +0800
Message-ID: <20250810030442.246974-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810030442.246974-1-dongml2@chinatelecom.cn>
References: <20250810030442.246974-1-dongml2@chinatelecom.cn>
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
calling to __set_cpus_allowed_ptr() is leaved in __migrate_enable().

The "struct rq" is not available in include/linux/sched.h, so we can't
access the "runqueues" with this_cpu_ptr(), as the compilation will fail
in this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
  typeof((ptr) + 0)

So we introduce the this_rq_raw() and access the runqueues with
arch_raw_cpu_ptr() directly.

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
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 Kbuild                    | 13 ++++++-
 include/linux/preempt.h   |  3 --
 include/linux/sched.h     | 72 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c     |  3 +-
 kernel/sched/core.c       | 56 +++---------------------------
 kernel/sched/rq-offsets.c | 12 +++++++
 6 files changed, 101 insertions(+), 58 deletions(-)
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
index 2b272382673d..be489558207f 100644
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
@@ -2307,4 +2310,73 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#if defined(CONFIG_SMP) && !defined(COMPILE_OFFSETS)
+
+extern void __migrate_enable(void);
+
+struct rq;
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
+
+static inline void migrate_enable(void)
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
+		__migrate_enable();
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
+	barrier();
+	p->migration_disabled = 0;
+	(*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))--;
+}
+
+static inline void migrate_disable(void)
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
+	(*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))++;
+	p->migration_disabled = 1;
+}
+#else
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void) { }
+#endif
+
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0806295945e4..bfba29a4fb10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23853,8 +23853,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
 #ifdef CONFIG_SMP
-BTF_ID(func, migrate_disable)
-BTF_ID(func, migrate_enable)
+BTF_ID(func, __migrate_enable)
 #endif
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..00383fed9f63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+EXPORT_SYMBOL_GPL(runqueues);
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
@@ -2381,28 +2382,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
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
+void __migrate_enable(void)
 {
 	struct task_struct *p = current;
 	struct affinity_context ac = {
@@ -2410,37 +2390,9 @@ void migrate_enable(void)
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
-
-	if (p->migration_disabled > 1) {
-		p->migration_disabled--;
-		return;
-	}
-
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
+	__set_cpus_allowed_ptr(p, &ac);
 }
-EXPORT_SYMBOL_GPL(migrate_enable);
+EXPORT_SYMBOL_GPL(__migrate_enable);
 
 static inline bool rq_has_pinned_tasks(struct rq *rq)
 {
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


