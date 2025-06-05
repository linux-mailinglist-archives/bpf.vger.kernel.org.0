Return-Path: <bpf+bounces-59703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13446ACECB3
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 11:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B94F189A9E8
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 09:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3EB20B7FC;
	Thu,  5 Jun 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="QjzLtYpO"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DE40855;
	Thu,  5 Jun 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115157; cv=none; b=JagjdMLJrSVX0pqrK/80CVx/29tyDIDcAk17bzW4svgQqwXWsdqqbNICLszcWbiQxUnL9/vv9W7JkNvQnGfojAQ5TXXWghFXwpeJlHYiQHl1Yfb1lXttNlf/iT4Yqanp6E9Mnkvf4u0bWuBUoyQzmVDfflZUkfrW//S8W1qCSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115157; c=relaxed/simple;
	bh=2W/yaBdYiYtL1sMWCv66ZTUE5HFtBggpB8LxmphQP3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3fzM/OSivKN327yl4cFd+4YPfmHeADqq1BtOEOER0JYPj7NdOsabZIwd3mrynGfjcu205mpC02Bxhwbp3jMWsUWnPU8KYT0Oq+sdnuuCPZQNeFwDnpG1VIILtCgI/tleSf/Bjt7PdU7XhfXjcIDYfYy+obFv5LskoF9FSyN5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=QjzLtYpO; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749115146; x=1749719946; i=spasswolf@web.de;
	bh=fWTPL72czF0TW5VEu3Yv0WdxuWfZkzKVmXftYNM50kM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QjzLtYpO4cmn5dkzRYGoJ4z3fwwHKo05zah+1R2kUgMl08jNYVcgBsqq0dZNAO3r
	 GM3x5F03T7h77C1/KRvA2Lj/03UXgQOhSuzcM3VKWfUjooza4XqnCxtndlWbYkR+L
	 YUf/dLxNcxiqSkYDvV3Si8oFV2l8wseoif7uOkUnNaCCGkS06O9kqjlbajQlgjZJb
	 EUSEgLa+nvmm1UaLCqcRfsTjH1N2wwJ/s8TmxZLyJfGqYJeWdOWLB+RgU+T+2lfoL
	 5OY36VYUima+6Ykyv44Y7ZziFJK4MLu8CxywG8VI3Ok+XpkgHC04JmhILjEvDwvu2
	 N9I0lZyiDLsRw3PGPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MfKxj-1v3LST0kWZ-00bJWn; Thu, 05 Jun 2025 11:19:06 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
Date: Thu,  5 Jun 2025 11:19:03 +0200
Message-ID: <20250605091904.5853-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: 20250527071922.tMPqxpsB@linutronix.de
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0DsXGMXu/ZBCfZrq9krjKhbSSTXGi96GQI8Oy7AJsT36/+CkblZ
 gNH+i7uuLLz74iSM4AG1UbQRxNWcog3VpOBpf6E9nefO0OOexqfOszmDCBVPoiTTpJt7lew
 TC9x8mD/df9clrGkf/J+KJ0Sd+riZQA9jKmloU0JNgCxJhPxVPCmj/EwDYWV/PZ0flI9K5U
 m0FjWWMNDxm0Q3vZ+Kh8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eDtkaZx7P/s=;12U/wfgNlK0JBWTkB+P2lz/ns/y
 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
 zT21XLvq/uS141pZEgGgci9BbMMyYmY7bqN1CQ==

To debug the issue I've created a patch that monitors preempt_count_{sub,a=
dd}
(except those used by printk to avoid infinite recursion).

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409b..37992b164282 100644
=2D-- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2219,6 +2219,8 @@ bpf_prog_run_array(const struct bpf_prog_array *arra=
y,
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret =3D 1;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: ctx =3D %px preempt_count =3D %u\n", __func__, ctx, preempt=
_count());
=20
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
=20
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..ac9ddd1b9bac 100644
=2D-- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -699,6 +699,8 @@ static __always_inline u32 __bpf_prog_run(const struct=
 bpf_prog *prog,
 					  bpf_dispatcher_fn dfunc)
 {
 	u32 ret;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: preempt_count =3D %u\n", __func__, preempt_count());
=20
 	cant_migrate();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b0af8d4ef6e6..e1d5d1e00860 100644
=2D-- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -194,12 +194,17 @@ static __always_inline unsigned char interrupt_conte=
xt_level(void)
 #if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
+extern void preempt_count_add_printk(int val);
+extern void preempt_count_sub_printk(int val);
 #define preempt_count_dec_and_test() \
 	({ preempt_count_sub(1); should_resched(0); })
+#define preempt_count_dec_and_test_printk() \
+	({ preempt_count_sub_printk(1); should_resched(0); })
 #else
 #define preempt_count_add(val)	__preempt_count_add(val)
 #define preempt_count_sub(val)	__preempt_count_sub(val)
 #define preempt_count_dec_and_test() __preempt_count_dec_and_test()
+#define preempt_count_dec_and_test_printk() __preempt_count_dec_and_test_=
printk()
 #endif
=20
 #define __preempt_count_inc() __preempt_count_add(1)
@@ -208,8 +213,20 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
=20
+#define preempt_count_inc_printk() preempt_count_add_printk(1)
+#define preempt_count_dec_printk() preempt_count_sub_printk(1)
+
 #ifdef CONFIG_PREEMPT_COUNT
=20
+/* We can't monitor preempt_count changes in printk or we go into
+ * an infinte recursion loop!
+ * */
+#define preempt_disable_printk() \
+do { \
+	preempt_count_inc_printk(); \
+	barrier(); \
+} while (0)
+
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -227,6 +244,13 @@ do { \
 #define preemptible()	(preempt_count() =3D=3D 0 && !irqs_disabled())
=20
 #ifdef CONFIG_PREEMPTION
+#define preempt_enable_printk() \
+do { \
+	barrier(); \
+	if (unlikely(preempt_count_dec_and_test_printk())) \
+		__preempt_schedule(); \
+} while (0)
+
 #define preempt_enable() \
 do { \
 	barrier(); \
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1113b74e1e2..555c01c7f983 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
=20
+#include <asm/preempt.h>
+
 #include "../../lib/kstrtox.h"
=20
 /* If kernel subsystem is allowing eBPF programs to call this function,
@@ -2596,6 +2598,9 @@ const struct bpf_func_proto bpf_current_task_under_c=
group_proto =3D {
 __bpf_kfunc struct cgroup *
 bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 {
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: calling task_get_cgroup1 preempt_count =3D 0x%x\n", __func_=
_, preempt_count());
+
 	struct cgroup *cgrp =3D task_get_cgroup1(task, hierarchy_id);
=20
 	if (IS_ERR(cgrp))
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dd5304c6ac3c..137478a0b8f6 100644
=2D-- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3339,6 +3339,8 @@ int bpf_link_settle(struct bpf_link_primer *primer)
 	primer->link->id =3D primer->id;
 	spin_unlock_bh(&link_idr_lock);
 	/* make bpf_link fetchable by FD */
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s calling fd_install() preemt_count =3D %u\n", __func__, preem=
pt_count());
 	fd_install(primer->fd, primer->file);
 	/* pass through installed FD */
 	return primer->fd;
@@ -5798,6 +5800,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uatt=
r, unsigned int size)
 {
 	union bpf_attr attr;
 	int err;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: preempt_count =3D %u\n", __func__, preempt_count());
=20
 	err =3D bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
@@ -5986,6 +5990,8 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsi=
gned int size)
 {
 	struct bpf_prog * __maybe_unused prog;
 	struct bpf_tramp_run_ctx __maybe_unused run_ctx;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: preempt_count =3D %u\n", __func__, preempt_count());
=20
 	switch (cmd) {
 #ifdef CONFIG_BPF_JIT /* __bpf_prog_enter_sleepable used by trampoline an=
d JIT */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..001632155bfe 100644
=2D-- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1295,6 +1295,8 @@ struct cgroup *task_get_cgroup1(struct task_struct *=
tsk, int hierarchy_id)
 	struct cgroup *cgrp =3D ERR_PTR(-ENOENT);
 	struct cgroup_root *root;
 	unsigned long flags;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: preempt_count =3D 0x%x\n", __func__, preempt_count());
=20
 	rcu_read_lock();
 	for_each_root(root) {
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aed..cce689bc6280 100644
=2D-- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1634,7 +1634,7 @@ void nbcon_cpu_emergency_enter(void)
 {
 	unsigned int *cpu_emergency_nesting;
=20
-	preempt_disable();
+	preempt_disable_printk();
=20
 	cpu_emergency_nesting =3D nbcon_get_cpu_emergency_nesting();
 	(*cpu_emergency_nesting)++;
@@ -1654,7 +1654,7 @@ void nbcon_cpu_emergency_exit(void)
 	if (!WARN_ON_ONCE(*cpu_emergency_nesting =3D=3D 0))
 		(*cpu_emergency_nesting)--;
=20
-	preempt_enable();
+	preempt_enable_printk();
 }
=20
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1eea80d0648e..d070220a817b 100644
=2D-- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2439,7 +2439,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
 		 */
-		preempt_disable();
+		preempt_disable_printk();
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
@@ -2448,7 +2448,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (console_trylock_spinning())
 			console_unlock();
-		preempt_enable();
+		preempt_enable_printk();
 	}
=20
 	if (ft.legacy_offload)
@@ -4536,7 +4536,7 @@ static void __wake_up_klogd(int val)
 	if (!printk_percpu_data_ready())
 		return;
=20
-	preempt_disable();
+	preempt_disable_printk();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the wait queue is empty.
@@ -4553,7 +4553,7 @@ static void __wake_up_klogd(int val)
 		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
-	preempt_enable();
+	preempt_enable_printk();
 }
=20
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dce50fa57471..41426f8f806f 100644
=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5857,7 +5857,9 @@ static inline void preempt_latency_start(int val)
 	}
 }
=20
-void preempt_count_add(int val)
+/* non printing version of preempt_count_add for use in
+ * printk to avoid infinite recursion */
+void preempt_count_add_printk(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -5876,6 +5878,34 @@ void preempt_count_add(int val)
 #endif
 	preempt_latency_start(val);
 }
+EXPORT_SYMBOL(preempt_count_add_printk);
+NOKPROBE_SYMBOL(preempt_count_add_printk);
+
+void preempt_count_add(int val)
+{
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Underflow?
+	 */
+	if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
+		return;
+#endif
+	if (!strcmp(get_current()->comm, "test_progs")) {
+		pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_cou=
nt());
+		__preempt_count_add(val);
+		pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_cou=
nt());
+	} else {
+		__preempt_count_add(val);
+	}
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Spinlock count overflowing soon?
+	 */
+	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=3D
+				PREEMPT_MASK - 10);
+#endif
+	preempt_latency_start(val);
+}
 EXPORT_SYMBOL(preempt_count_add);
 NOKPROBE_SYMBOL(preempt_count_add);
=20
@@ -5889,7 +5919,7 @@ static inline void preempt_latency_stop(int val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
=20
-void preempt_count_sub(int val)
+void preempt_count_sub_printk(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -5908,6 +5938,34 @@ void preempt_count_sub(int val)
 	preempt_latency_stop(val);
 	__preempt_count_sub(val);
 }
+EXPORT_SYMBOL(preempt_count_sub_printk);
+NOKPROBE_SYMBOL(preempt_count_sub_printk);
+
+void preempt_count_sub(int val)
+{
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Underflow?
+	 */
+	if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
+		return;
+	/*
+	 * Is the spinlock portion underflowing?
+	 */
+	if (DEBUG_LOCKS_WARN_ON((val < PREEMPT_MASK) &&
+			!(preempt_count() & PREEMPT_MASK)))
+		return;
+#endif
+
+	preempt_latency_stop(val);
+	if (!strcmp(get_current()->comm, "test_progs")) {
+		pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_cou=
nt());
+		__preempt_count_sub(val);
+		pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_cou=
nt());
+	} else {
+		__preempt_count_sub(val);
+	}
+}
 EXPORT_SYMBOL(preempt_count_sub);
 NOKPROBE_SYMBOL(preempt_count_sub);
=20
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0eb721fcfb5..762f8b429af3 100644
=2D-- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -35,6 +35,9 @@
 #include "trace_probe.h"
 #include "trace.h"
=20
+#include <asm/preempt.h>
+#include <linux/sched.h>
+
 #define CREATE_TRACE_POINTS
 #include "bpf_trace.h"
=20
@@ -110,6 +113,8 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ct=
x *ctx);
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
 	unsigned int ret;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: call =3D %px ctx =3D %px preempt_count =3D %u\n", __func__,=
 call, ctx, preempt_count());
=20
 	cant_sleep();
=20
@@ -766,6 +771,8 @@ const struct bpf_func_proto bpf_get_current_task_proto=
 =3D {
=20
 BPF_CALL_0(bpf_get_current_task_btf)
 {
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: preempt_count =3D 0x%x", __func__, preempt_count());
 	return (unsigned long) current;
 }
=20
@@ -2244,6 +2251,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u=
64 *args)
 	struct bpf_prog *prog =3D link->link.prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
+	if (!strcmp(get_current()->comm, "test_progs"))
+		pr_err("%s: preempt_count =3D %u\n", __func__, preempt_count());
=20
 	cant_sleep();
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/te=
sting/selftests/bpf/progs/dynptr_success.c
index a0391f9da2d4..0d179a1192ca 100644
=2D-- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -7,6 +7,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 #include "errno.h"
=20
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/=
testing/selftests/bpf/test_kmods/bpf_testmod.c
index e6c248e3ae54..e9e918cdf31f 100644
=2D-- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
=20
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_read_ctx ctx =3D {
@@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
=20
 noinline ssize_t
 bpf_testmod_test_write(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_write_ctx ctx =3D {
@@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
=20
 static ssize_t
 bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
-			 struct bin_attribute *bin_attr,
+			 const struct bin_attribute *bin_attr,
 			 char *buf, loff_t off, size_t len)
 {
 	unsigned long offset =3D 0;

This patch seems to create so much output that the orginal error message a=
nd
backtrace often get lost, so I needed several runs to get a meaningful mes=
sage
when running

$ ./test_progs -a cgrp_local_storage/cgrp1_tp_btf

Here's the crucial part of the message which show an unexplained increase=
=20
in preempt_count:

[   99.467001] [   T2857] bpf_link_settle calling fd_install() preemt_coun=
t =3D 0

The next two message are from fd install calling rcu_read_lock_sched() (I =
know
that from an earlier version of the debug patch which also monitored fd_in=
stall()):

[   99.467003] [   T2857] preempt_count_add 5894: preempt_count =3D 0x0
[   99.467004] [   T2857] preempt_count_add 5896: preempt_count =3D 0x1

The next two message are from fd install calling rcu_read_unlock_sched():

[   99.467006] [   T2857] preempt_count_sub 5962: preempt_count =3D 0x1
[   99.467007] [   T2857] preempt_count_sub 5964: preempt_count =3D 0x0

Here we are after fd_install which exited with preempt_count =3D 0, but
when entering __bpf_trace_run we have preempt_count =3D 1 anyway without
a call to preempt_count_add(). So who or what is increasing preempt_count =
here?

[   99.467014] [   T2857] __bpf_trace_run: preempt_count =3D 1
[   99.467015] [   T2857] __bpf_prog_run: preempt_count =3D 1
[   99.467017] [   T2857] ____bpf_get_current_task_btf: preempt_count =3D =
0x1
[   99.467018] [   T2857] bpf_task_get_cgroup1: calling task_get_cgroup1 p=
reempt_count =3D 0x1
[   99.467019] [   T2857] task_get_cgroup1: preempt_count =3D 0x1
[   99.467022] [   T2857] BUG: sleeping function called from invalid conte=
xt at kernel/locking/spinlock_rt.c:48
[   99.467024] [   T2857] in_atomic(): 1, irqs_disabled(): 0, non_block: 0=
, pid: 2857, name: test_progs
[   99.467025] [   T2857] preempt_count: 1, expected: 0
[   99.467027] [   T2857] RCU nest depth: 2, expected: 2
[   99.467028] [   T2857] 4 locks held by test_progs/2857:
[   99.467029] [   T2857]  #0: ffffffffa6932de0 (rcu_read_lock_trace){....=
}-{0:0}, at: syscall_trace_enter+0x18e/0x260
[   99.467040] [   T2857]  #1: ffffffffa6933880 (rcu_read_lock){....}-{1:3=
}, at: bpf_trace_run2+0xa6/0x2a0
[   99.467048] [   T2857]  #2: ffffffffa6933880 (rcu_read_lock){....}-{1:3=
}, at: task_get_cgroup1+0x4c/0x360
[   99.467054] [   T2857]  #3: ffffffffa6956878 (css_set_lock){+.+.}-{3:3}=
, at: task_get_cgroup1+0x109/0x360

The "Preemption disabled at:" message is not useful here because it just c=
omes
from printk() (which enables preemption again). In the usual case (no moni=
toring)
we get fd_install as the "Preemption disable at:" message, but as can be s=
een above
fd_install exits with preempt_count =3D 0.

[   99.467060] [   T2857] Preemption disabled at:
[   99.467060] [   T2857] [<ffffffffa503a823>] __wake_up_klogd.part.0+0x13=
/0xa0
[   99.467066] [   T2857] CPU: 13 UID: 0 PID: 2857 Comm: test_progs Tainte=
d: G           O        6.15.0-rc7-next-20250523-cgroupbpfbug-00024-gc1d60=
c8159da #66 PREEMPT_{RT,(full)}=20
[   99.467070] [   T2857] Tainted: [O]=3DOOT_MODULE
[   99.467071] [   T2857] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[   99.467072] [   T2857] Call Trace:
[   99.467075] [   T2857]  <TASK>
[   99.467077] [   T2857]  dump_stack_lvl+0x6d/0xb0
[   99.467083] [   T2857]  __might_resched.cold+0xfa/0x135
[   99.467089] [   T2857]  rt_spin_lock+0x5f/0x190
[   99.467092] [   T2857]  ? task_get_cgroup1+0x109/0x360
[   99.467098] [   T2857]  task_get_cgroup1+0x109/0x360
[   99.467102] [   T2857]  bpf_task_get_cgroup1+0x3d/0x50
[   99.467109] [   T2857]  bpf_prog_8d22669ef1ee8049_on_enter+0x62/0x1d4
[   99.467115] [   T2857]  bpf_trace_run2+0x108/0x2a0
[   99.467119] [   T2857]  ? srso_alias_return_thunk+0x5/0xfbef5
[   99.467126] [   T2857]  __bpf_trace_sys_enter+0x37/0x60
[   99.467131] [   T2857]  syscall_trace_enter+0x1c7/0x260
[   99.467136] [   T2857]  do_syscall_64+0x395/0xfa0
[   99.467139] [   T2857]  ? srso_alias_return_thunk+0x5/0xfbef5
[   99.467142] [   T2857]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   99.467142] [   T2857] preempt_count_add 5894: preempt_count =3D 0x1
[   99.467142] [   T2857] preempt_count_add 5896: preempt_count =3D 0x2
[   99.467142] [   T2857] preempt_count_sub 5962: preempt_count =3D 0x2
[   99.467142] [   T2857] preempt_count_sub 5964: preempt_count =3D 0x1
[   99.467142] [   T2857] RIP: 0033:0x7f23eb72c779
[   99.467142] [   T2857] preempt_count_add 5894: preempt_count =3D 0x1
[   99.467142] [   T2857] preempt_count_add 5896: preempt_count =3D 0x2
[   99.467142] [   T2857] preempt_count_sub 5962: preempt_count =3D 0x2
[   99.467142] [   T2857] preempt_count_sub 5964: preempt_count =3D 0x1
[   99.467142] [   T2857] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f =
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24=
 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01=
 48
[   99.467142] [   T2857] RSP: 002b:00007ffd8b5d7f38 EFLAGS: 00000202 ORIG=
_RAX: 0000000000000141
[   99.467142] [   T2857] RAX: ffffffffffffffda RBX: 00007ffd8b5d86c8 RCX:=
 00007f23eb72c779
[   99.467142] [   T2857] RDX: 0000000000000040 RSI: 00007ffd8b5d7fb0 RDI:=
 000000000000001c
[   99.467142] [   T2857] RBP: 00007ffd8b5d7f50 R08: 0000000000000001 R09:=
 00007ffd8b5d7fb0
[   99.467142] [   T2857] R10: 00007f23eb805ac0 R11: 0000000000000202 R12:=
 0000000000000000
[   99.467142] [   T2857] R13: 00007ffd8b5d86e8 R14: 00007f23ebd61000 R15:=
 0000563e4fd2d890
[   99.467142] [   T2857]  </TASK>


Bert Karwatzki

