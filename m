Return-Path: <bpf+bounces-65954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9597B2B68A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A38625A1C
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014C28727C;
	Tue, 19 Aug 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX7n0adm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6728724E;
	Tue, 19 Aug 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568735; cv=none; b=MeiMjR0U+EV1vGg0f7L4psdz+LzrNv9roGpy6WAZa6981kURr4IqVdOfgOeUK7pbDhEVJycb1uOfN3hVu+04UdHkBZaaPNWsMlPhOie5VJlW0OEk20XdWORYzpPtfRwrwtZxosDFbGXW8jdkZWckqbn0lp/zjIWSYeEoXQ4NyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568735; c=relaxed/simple;
	bh=Y5SPX1vvn846jYR10WlqQO/trR88j8vNgTUttu8GXNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjX7BZWM7eXjoysi8cZTzUfGnP//sPRF9LI9k6VT1KgpBuNJ5YURcTQP2kx4S5kN+art4bLddAYztc3YHFiVt64ILyZ+0H9L9iwGk646ft14N6oel8uWDAMuvggq9DvMmFDJeEEdFYaVCZGREg9dlkT5JgnPuXMHNikCsobcfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX7n0adm; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so1176766b3a.0;
        Mon, 18 Aug 2025 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568733; x=1756173533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf1ADsAevvIgMEqQb8gukFVemRiQosBpLNzrx7L+xIQ=;
        b=XX7n0admjfkZ2haE9QO+lPtITppbb2/yRmRveKAkUTGe2eLO3NTq+/gqA9lzBtvkqj
         oBbCM62YlNqxTGoW/BQvTBddbDDjTicFv/xXbmlqamy4vY9UVk9C2/aQYkN+8sikY7CX
         0zPLPclG4ieNXLX/whxVR2/GXtfnXrN7TE+CH8cDjTj0wn2hWlHqne3gXJfjcIiBReq1
         wTuYP3jS3UXu6fIFfEyO6RgbpMbkQWGF8QfZ/6hLk6O0ooBMvcCnqROnWqq7HldFQHJd
         41o1/gZ8ir2WStCsdrN5cZegv3cuKTtwV5D7bN490/i4u8Wqe9T4FWbKmBaVzTYktnF1
         4NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568733; x=1756173533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf1ADsAevvIgMEqQb8gukFVemRiQosBpLNzrx7L+xIQ=;
        b=qp9G1TBYkpotgDD8m06LzAo0bptDYL0RqQetQGDXhaw3vPEaKctvkzhxttogjCAEpq
         H/2SX579rBgh2oipvHalJmNaM4rbpGJT12V/5dpuXGiYG97tnD7Ilr0BeEAgZ1PcXpbF
         GzhpgKVzxhzjJIDqCj5TFVfIvqH030l0cjicEMD0ePqn8YwihM+v5j8ZocYNy6fe67lN
         qKeJNZD8oV7A3sdZdlh+P+ciTw/1hI/sohl2//Q+sMQgQX2ZAAgVTZ/NIA1jc6g4i+kj
         43eYaLgUziVnmViO6WBkEP6VGvjG0DAVrA/Qm9M543Zb7npzeSq1Yj1/p1xiqjN2j181
         AjWw==
X-Forwarded-Encrypted: i=1; AJvYcCU9TBm92D1TCpdy48MbTUJZPBcWGiO+p4pXD6lYCkVNTAXrlpfyJw01KSUVVPxajw1HEvY=@vger.kernel.org, AJvYcCW9Fn+TSC9+x6HJ4iQLp9gZu6sj2/V6cxH+F7G/fSFPpjEdMv93pFQkJNMGDxj5QMf60k73lae5kHs1ew6p@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3G7B5NA4cSgGRROw37yrTDgtHLmsvwVM4t++S9M+oEJ5d9r4
	VaWISo4eASIO/5oJ1Qu+dxlpVbBEIEwDJJ+TpwSHtUBiUMMQYvL5G0ja
X-Gm-Gg: ASbGncs3CJ5c4/Z8CYshaC1Wbw4Pr5TdnI4HygWrh3ecL4h+ZKNJtXVf16dy6xBHE1o
	wZD6WwpxkHyiVx4q2KaKTivqt57bQaQQPc/hKUqhVKWOqDL5DEp+dtL1KHqe45t9LZtdHmds3sg
	ik0Q0xH5rqRM92n38BlLbLCZlZePc9INpJy3ZoEPcqtXvn5Q7JTrCcg7ouScVslXZ7RngXb0hs2
	X4+2kqd2gLl/MLV1sKsI8wrh5XQImToEJ45R8eHvbjLmi6tlwfYT5jjBbPoU7F4XnZCR6eso+y3
	/8zbU3CmzHd2LR43AgTI88a90Lgm8VBZpnw7aKq8c4js87cRKsrbvkleqCOaB2pfwbC/Ri/lFL3
	Ckn5+ouvnMxLjTi0IyRc=
X-Google-Smtp-Source: AGHT+IGSXnG0AZIbaCPjv8iJQ6KTzm2XbbFU/f+FJi4iTGjk3AHcsTi1n+kXCEDiKNT9+nFye6BUIw==
X-Received: by 2002:a05:6a21:3383:b0:240:1d9a:4ca7 with SMTP id adf61e73a8af0-2430d30cf87mr1081522637.5.1755568732807;
        Mon, 18 Aug 2025 18:58:52 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b474f22665bsm1952013a12.20.2025.08.18.18.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:58:52 -0700 (PDT)
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
	simona.vetter@ffwll.ch,
	tzimmermann@suse.de,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
Date: Tue, 19 Aug 2025 09:58:31 +0800
Message-ID: <20250819015832.11435-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819015832.11435-1-dongml2@chinatelecom.cn>
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
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
v2:
- use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP
---
 Kbuild                    | 13 ++++++-
 include/linux/preempt.h   |  3 --
 include/linux/sched.h     | 77 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c     |  3 +-
 kernel/sched/core.c       | 56 ++--------------------------
 kernel/sched/rq-offsets.c | 12 ++++++
 6 files changed, 106 insertions(+), 58 deletions(-)
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
index f8188b833350..b554a1e65e3e 100644
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
@@ -2312,4 +2315,78 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#ifndef COMPILE_OFFSETS
+
+extern void __migrate_enable(void);
+
+struct rq;
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+
+#ifdef CONFIG_SMP
+#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
+#else
+#define this_rq_raw() PERCPU_PTR(&runqueues)
+#endif
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
index c4f69a9e9af6..88bf2ef3e60c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23855,8 +23855,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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


