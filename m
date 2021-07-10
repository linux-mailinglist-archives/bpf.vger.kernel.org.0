Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A33C34F5
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhGJO60 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 10:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhGJO60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 10:58:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 798A561248;
        Sat, 10 Jul 2021 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625928941;
        bh=PvtyqvrWggf5tdwssiohvrBKPf77sdk3nKa5vX7Ubew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlwfQnH0oXf331K6nF8o/nYG5qHeARJ0lOSLfgIHfmQbNMtLMXMHc9Ht3/63dSgrW
         God/z2kMJa9RbfAUXQBYcDGcRVL/T0cRhbTS/rHY5X80R0TGG5dVtoM5qp0L9Vouo5
         Va90lXtpHB7tURdEQekERXgnMW+ISlTEdA7P1CM1jaiV+TEQpPfaMG5WA0gp1w9+vh
         QwJiY6EBbzx8QqMAhWXmnwwnxZcCxRXk89f0of8QQ21tjBeSDP3bsxUmHfL9jQWeQq
         vM2NQGZoCTTrwUgPpD2u9VXe2+5A/7k1iAi/i1+pXuJPGypWIRjtczvICXJL/nIqFN
         b3RaKsuDv87Dg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip 2/6] kprobes: Fix coding style issues
Date:   Sat, 10 Jul 2021 23:55:37 +0900
Message-Id: <162592893692.1158485.4841825158140104690.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162592891873.1158485.768824457210707916.stgit@devnote2>
References: <162592891873.1158485.768824457210707916.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix coding style issues reported by checkpatch.pl and update
comments to quote variable names and add "()" to function
name.
One TODO comment in __disarm_kprobe() is removed because
it has been done by following commit.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   40 +++++---
 kernel/kprobes.c        |  238 ++++++++++++++++++++++++-----------------------
 2 files changed, 146 insertions(+), 132 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e4f3bfe08757..28c04f1f2b73 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -3,7 +3,6 @@
 #define _LINUX_KPROBES_H
 /*
  *  Kernel Probes (KProbes)
- *  include/linux/kprobes.h
  *
  * Copyright (C) IBM Corporation, 2002, 2004
  *
@@ -39,7 +38,7 @@
 #define KPROBE_REENTER		0x00000004
 #define KPROBE_HIT_SSDONE	0x00000008
 
-#else /* CONFIG_KPROBES */
+#else /* !CONFIG_KPROBES */
 #include <asm-generic/kprobes.h>
 typedef int kprobe_opcode_t;
 struct arch_specific_insn {
@@ -228,7 +227,7 @@ static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance
 	return READ_ONCE(ri->rph->rp);
 }
 
-#else /* CONFIG_KRETPROBES */
+#else /* !CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
 {
@@ -239,11 +238,15 @@ static inline int arch_trampoline_kprobe(struct kprobe *p)
 }
 #endif /* CONFIG_KRETPROBES */
 
+/* Markers of '_kprobe_blacklist' section */
+extern unsigned long __start_kprobe_blacklist[];
+extern unsigned long __stop_kprobe_blacklist[];
+
 extern struct kretprobe_blackpoint kretprobe_blacklist[];
 
 #ifdef CONFIG_KPROBES_SANITY_TEST
 extern int init_test_probes(void);
-#else
+#else /* !CONFIG_KPROBES_SANITY_TEST */
 static inline int init_test_probes(void)
 {
 	return 0;
@@ -303,7 +306,7 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
 #define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
 int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
 			     unsigned long *value, char *type, char *sym);
-#else /* __ARCH_WANT_KPROBES_INSN_SLOT */
+#else /* !__ARCH_WANT_KPROBES_INSN_SLOT */
 #define DEFINE_INSN_CACHE_OPS(__name)					\
 static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
 {									\
@@ -345,16 +348,17 @@ extern int sysctl_kprobes_optimization;
 extern int proc_kprobes_optimization_handler(struct ctl_table *table,
 					     int write, void *buffer,
 					     size_t *length, loff_t *ppos);
-#endif
+#endif /* CONFIG_SYSCTL */
 extern void wait_for_kprobe_optimizer(void);
-#else
+#else /* !CONFIG_OPTPROBES */
 static inline void wait_for_kprobe_optimizer(void) { }
 #endif /* CONFIG_OPTPROBES */
+
 #ifdef CONFIG_KPROBES_ON_FTRACE
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
-#endif
+#endif /* CONFIG_KPROBES_ON_FTRACE */
 
 int arch_check_ftrace_location(struct kprobe *p);
 
@@ -364,7 +368,7 @@ struct kprobe *get_kprobe(void *addr);
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
 {
-	return (__this_cpu_read(current_kprobe));
+	return __this_cpu_read(current_kprobe);
 }
 
 static inline void reset_current_kprobe(void)
@@ -428,11 +432,11 @@ static inline struct kprobe *kprobe_running(void)
 }
 static inline int register_kprobe(struct kprobe *p)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 static inline int register_kprobes(struct kprobe **kps, int num)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 static inline void unregister_kprobe(struct kprobe *p)
 {
@@ -442,11 +446,11 @@ static inline void unregister_kprobes(struct kprobe **kps, int num)
 }
 static inline int register_kretprobe(struct kretprobe *rp)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 static inline int register_kretprobes(struct kretprobe **rps, int num)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 static inline void unregister_kretprobe(struct kretprobe *rp)
 {
@@ -462,11 +466,11 @@ static inline void kprobe_free_init_mem(void)
 }
 static inline int disable_kprobe(struct kprobe *kp)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 static inline int enable_kprobe(struct kprobe *kp)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline bool within_kprobe_blacklist(unsigned long addr)
@@ -479,6 +483,7 @@ static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
 	return -ERANGE;
 }
 #endif /* CONFIG_KPROBES */
+
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
 	return disable_kprobe(&rp->kp);
@@ -493,13 +498,14 @@ static inline bool is_kprobe_insn_slot(unsigned long addr)
 {
 	return false;
 }
-#endif
+#endif /* !CONFIG_KPROBES */
+
 #ifndef CONFIG_OPTPROBES
 static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 {
 	return false;
 }
-#endif
+#endif /* !CONFIG_OPTPROBES */
 
 /* Returns true if kprobes handled the fault */
 static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 63532991ccb4..e5e1400072c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Kernel Probes (KProbes)
- *  kernel/kprobes.c
  *
  * Copyright (C) IBM Corporation, 2002, 2004
  *
@@ -52,18 +51,18 @@
 
 static int kprobes_initialized;
 /* kprobe_table can be accessed by
- * - Normal hlist traversal and RCU add/del under kprobe_mutex is held.
+ * - Normal hlist traversal and RCU add/del under 'kprobe_mutex' is held.
  * Or
  * - RCU hlist traversal under disabling preempt (breakpoint handlers)
  */
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 
-/* NOTE: change this value only with kprobe_mutex held */
+/* NOTE: change this value only with 'kprobe_mutex' held */
 static bool kprobes_all_disarmed;
 
-/* This protects kprobe_table and optimizing_list */
+/* This protects 'kprobe_table' and 'optimizing_list' */
 static DEFINE_MUTEX(kprobe_mutex);
-static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
+static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
 
 kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 					unsigned int __unused)
@@ -71,12 +70,15 @@ kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
 }
 
-/* Blacklist -- list of struct kprobe_blacklist_entry */
+/*
+ * Blacklist -- list of 'struct kprobe_blacklist_entry' to store info where
+ * kprobes can not probe.
+ */
 static LIST_HEAD(kprobe_blacklist);
 
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
- * kprobe->ainsn.insn points to the copy of the instruction to be
+ * 'kprobe::ainsn.insn' points to the copy of the instruction to be
  * single-stepped. x86_64, POWER4 and above have no-exec support and
  * stepping on the instruction on a vmalloced/kmalloced/data page
  * is a recipe for disaster
@@ -107,6 +109,12 @@ enum kprobe_slot_state {
 
 void __weak *alloc_insn_page(void)
 {
+	/*
+	 * Use module_alloc() so this page is within +/- 2GB of where the
+	 * kernel image and loaded module images reside. This is required
+	 * for most of the architectures.
+	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
+	 */
 	return module_alloc(PAGE_SIZE);
 }
 
@@ -142,6 +150,7 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	list_for_each_entry_rcu(kip, &c->pages, list) {
 		if (kip->nused < slots_per_page(c)) {
 			int i;
+
 			for (i = 0; i < slots_per_page(c); i++) {
 				if (kip->slot_used[i] == SLOT_CLEAN) {
 					kip->slot_used[i] = SLOT_USED;
@@ -167,11 +176,6 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	if (!kip)
 		goto out;
 
-	/*
-	 * Use module_alloc so this page is within +/- 2GB of where the
-	 * kernel image and loaded module images reside. This is required
-	 * so x86_64 can correctly handle the %rip-relative fixups.
-	 */
 	kip->insns = c->alloc();
 	if (!kip->insns) {
 		kfree(kip);
@@ -233,6 +237,7 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
 
 	list_for_each_entry_safe(kip, next, &c->pages, list) {
 		int i;
+
 		if (kip->ngarbage == 0)
 			continue;
 		kip->ngarbage = 0;	/* we will collect all garbages */
@@ -313,7 +318,7 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
 	list_for_each_entry_rcu(kip, &c->pages, list) {
 		if ((*symnum)--)
 			continue;
-		strlcpy(sym, c->sym, KSYM_NAME_LEN);
+		strscpy(sym, c->sym, KSYM_NAME_LEN);
 		*type = 't';
 		*value = (unsigned long)kip->insns;
 		ret = 0;
@@ -361,9 +366,9 @@ static inline void reset_kprobe_instance(void)
 
 /*
  * This routine is called either:
- * 	- under the kprobe_mutex - during kprobe_[un]register()
- * 				OR
- * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
+ *	- under the 'kprobe_mutex' - during kprobe_[un]register().
+ *				OR
+ *	- with preemption disabled - from architecture specific code.
  */
 struct kprobe *get_kprobe(void *addr)
 {
@@ -383,22 +388,20 @@ NOKPROBE_SYMBOL(get_kprobe);
 
 static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
-/* Return true if the kprobe is an aggregator */
+/* Return true if 'p' is an aggregator */
 static inline int kprobe_aggrprobe(struct kprobe *p)
 {
 	return p->pre_handler == aggr_pre_handler;
 }
 
-/* Return true(!0) if the kprobe is unused */
+/* Return true if 'p' is unused */
 static inline int kprobe_unused(struct kprobe *p)
 {
 	return kprobe_aggrprobe(p) && kprobe_disabled(p) &&
 	       list_empty(&p->list);
 }
 
-/*
- * Keep all fields in the kprobe consistent
- */
+/* Keep all fields in the kprobe consistent. */
 static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	memcpy(&p->opcode, &ap->opcode, sizeof(kprobe_opcode_t));
@@ -406,11 +409,11 @@ static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
 }
 
 #ifdef CONFIG_OPTPROBES
-/* NOTE: change this value only with kprobe_mutex held */
+/* NOTE: This is protected by 'kprobe_mutex'. */
 static bool kprobes_allow_optimization;
 
 /*
- * Call all pre_handler on the list, but ignores its return value.
+ * Call all 'kprobe::pre_handler' on the list, but ignores its return value.
  * This must be called from arch-dep optimized caller.
  */
 void opt_pre_handler(struct kprobe *p, struct pt_regs *regs)
@@ -438,7 +441,7 @@ static void free_aggr_kprobe(struct kprobe *p)
 	kfree(op);
 }
 
-/* Return true(!0) if the kprobe is ready for optimization. */
+/* Return true if the kprobe is ready for optimization. */
 static inline int kprobe_optready(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
@@ -451,7 +454,7 @@ static inline int kprobe_optready(struct kprobe *p)
 	return 0;
 }
 
-/* Return true(!0) if the kprobe is disarmed. Note: p must be on hash list */
+/* Return true if the kprobe is disarmed. Note: p must be on hash list */
 static inline int kprobe_disarmed(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
@@ -465,7 +468,7 @@ static inline int kprobe_disarmed(struct kprobe *p)
 	return kprobe_disabled(p) && list_empty(&op->list);
 }
 
-/* Return true(!0) if the probe is queued on (un)optimizing lists */
+/* Return true if the probe is queued on (un)optimizing lists */
 static int kprobe_queued(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
@@ -480,7 +483,7 @@ static int kprobe_queued(struct kprobe *p)
 
 /*
  * Return an optimized kprobe whose optimizing code replaces
- * instructions including addr (exclude breakpoint).
+ * instructions including 'addr' (exclude breakpoint).
  */
 static struct kprobe *get_optimized_kprobe(unsigned long addr)
 {
@@ -501,7 +504,7 @@ static struct kprobe *get_optimized_kprobe(unsigned long addr)
 	return NULL;
 }
 
-/* Optimization staging list, protected by kprobe_mutex */
+/* Optimization staging list, protected by 'kprobe_mutex' */
 static LIST_HEAD(optimizing_list);
 static LIST_HEAD(unoptimizing_list);
 static LIST_HEAD(freeing_list);
@@ -512,20 +515,20 @@ static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
 
 /*
  * Optimize (replace a breakpoint with a jump) kprobes listed on
- * optimizing_list.
+ * 'optimizing_list'.
  */
 static void do_optimize_kprobes(void)
 {
 	lockdep_assert_held(&text_mutex);
 	/*
-	 * The optimization/unoptimization refers online_cpus via
-	 * stop_machine() and cpu-hotplug modifies online_cpus.
-	 * And same time, text_mutex will be held in cpu-hotplug and here.
-	 * This combination can cause a deadlock (cpu-hotplug try to lock
-	 * text_mutex but stop_machine can not be done because online_cpus
-	 * has been changed)
-	 * To avoid this deadlock, caller must have locked cpu hotplug
-	 * for preventing cpu-hotplug outside of text_mutex locking.
+	 * The optimization/unoptimization refers 'online_cpus' via
+	 * stop_machine() and cpu-hotplug modifies the 'online_cpus'.
+	 * And same time, 'text_mutex' will be held in cpu-hotplug and here.
+	 * This combination can cause a deadlock (cpu-hotplug tries to lock
+	 * 'text_mutex' but stop_machine() can not be done because
+	 * the 'online_cpus' has been changed)
+	 * To avoid this deadlock, caller must have locked cpu-hotplug
+	 * for preventing cpu-hotplug outside of 'text_mutex' locking.
 	 */
 	lockdep_assert_cpus_held();
 
@@ -539,7 +542,7 @@ static void do_optimize_kprobes(void)
 
 /*
  * Unoptimize (replace a jump with a breakpoint and remove the breakpoint
- * if need) kprobes listed on unoptimizing_list.
+ * if need) kprobes listed on 'unoptimizing_list'.
  */
 static void do_unoptimize_kprobes(void)
 {
@@ -554,7 +557,7 @@ static void do_unoptimize_kprobes(void)
 		return;
 
 	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
-	/* Loop free_list for disarming */
+	/* Loop on 'freeing_list' for disarming */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
@@ -565,7 +568,7 @@ static void do_unoptimize_kprobes(void)
 			/*
 			 * Remove unused probes from hash list. After waiting
 			 * for synchronization, these probes are reclaimed.
-			 * (reclaiming is done by do_free_cleaned_kprobes.)
+			 * (reclaiming is done by do_free_cleaned_kprobes().)
 			 */
 			hlist_del_rcu(&op->kp.hlist);
 		} else
@@ -573,7 +576,7 @@ static void do_unoptimize_kprobes(void)
 	}
 }
 
-/* Reclaim all kprobes on the free_list */
+/* Reclaim all kprobes on the 'freeing_list' */
 static void do_free_cleaned_kprobes(void)
 {
 	struct optimized_kprobe *op, *tmp;
@@ -645,9 +648,9 @@ void wait_for_kprobe_optimizer(void)
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
 		mutex_unlock(&kprobe_mutex);
 
-		/* this will also make optimizing_work execute immmediately */
+		/* This will also make 'optimizing_work' execute immmediately */
 		flush_delayed_work(&optimizing_work);
-		/* @optimizing_work might not have been queued yet, relax */
+		/* 'optimizing_work' might not have been queued yet, relax */
 		cpu_relax();
 
 		mutex_lock(&kprobe_mutex);
@@ -678,7 +681,7 @@ static void optimize_kprobe(struct kprobe *p)
 	    (kprobe_disabled(p) || kprobes_all_disarmed))
 		return;
 
-	/* kprobes with post_handler can not be optimized */
+	/* kprobes with 'post_handler' can not be optimized */
 	if (p->post_handler)
 		return;
 
@@ -698,7 +701,10 @@ static void optimize_kprobe(struct kprobe *p)
 	}
 	op->kp.flags |= KPROBE_FLAG_OPTIMIZED;
 
-	/* On unoptimizing/optimizing_list, op must have OPTIMIZED flag */
+	/*
+	 * On the 'unoptimizing_list' and 'optimizing_list',
+	 * 'op' must have OPTIMIZED flag
+	 */
 	if (WARN_ON_ONCE(!list_empty(&op->list)))
 		return;
 
@@ -768,7 +774,7 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 	WARN_ON_ONCE(list_empty(&op->list));
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
-	/* Optimize it again (remove from op->list) */
+	/* Optimize it again. (remove from 'op->list') */
 	if (!kprobe_optready(ap))
 		return -EINVAL;
 
@@ -818,7 +824,7 @@ static void prepare_optimized_kprobe(struct kprobe *p)
 	__prepare_optimized_kprobe(op, p);
 }
 
-/* Allocate new optimized_kprobe and try to prepare optimized instructions */
+/* Allocate new optimized_kprobe and try to prepare optimized instructions. */
 static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
@@ -837,19 +843,19 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p);
 
 /*
- * Prepare an optimized_kprobe and optimize it
- * NOTE: p must be a normal registered kprobe
+ * Prepare an optimized_kprobe and optimize it.
+ * NOTE: 'p' must be a normal registered kprobe.
  */
 static void try_to_optimize_kprobe(struct kprobe *p)
 {
 	struct kprobe *ap;
 	struct optimized_kprobe *op;
 
-	/* Impossible to optimize ftrace-based kprobe */
+	/* Impossible to optimize ftrace-based kprobe. */
 	if (kprobe_ftrace(p))
 		return;
 
-	/* For preparing optimization, jump_label_text_reserved() is called */
+	/* For preparing optimization, jump_label_text_reserved() is called. */
 	cpus_read_lock();
 	jump_label_lock();
 	mutex_lock(&text_mutex);
@@ -860,14 +866,14 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 
 	op = container_of(ap, struct optimized_kprobe, kp);
 	if (!arch_prepared_optinsn(&op->optinsn)) {
-		/* If failed to setup optimizing, fallback to kprobe */
+		/* If failed to setup optimizing, fallback to kprobe. */
 		arch_remove_optimized_kprobe(op);
 		kfree(op);
 		goto out;
 	}
 
 	init_aggr_kprobe(ap, p);
-	optimize_kprobe(ap);	/* This just kicks optimizer thread */
+	optimize_kprobe(ap);	/* This just kicks optimizer thread. */
 
 out:
 	mutex_unlock(&text_mutex);
@@ -882,7 +888,7 @@ static void optimize_all_kprobes(void)
 	unsigned int i;
 
 	mutex_lock(&kprobe_mutex);
-	/* If optimization is already allowed, just return */
+	/* If optimization is already allowed, just return. */
 	if (kprobes_allow_optimization)
 		goto out;
 
@@ -908,7 +914,7 @@ static void unoptimize_all_kprobes(void)
 	unsigned int i;
 
 	mutex_lock(&kprobe_mutex);
-	/* If optimization is already prohibited, just return */
+	/* If optimization is already prohibited, just return. */
 	if (!kprobes_allow_optimization) {
 		mutex_unlock(&kprobe_mutex);
 		return;
@@ -926,7 +932,7 @@ static void unoptimize_all_kprobes(void)
 	cpus_read_unlock();
 	mutex_unlock(&kprobe_mutex);
 
-	/* Wait for unoptimizing completion */
+	/* Wait for unoptimizing completion. */
 	wait_for_kprobe_optimizer();
 	pr_info("kprobe jump-optimization is disabled. All kprobes are based on software breakpoint.\n");
 }
@@ -953,12 +959,12 @@ int proc_kprobes_optimization_handler(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_SYSCTL */
 
-/* Put a breakpoint for a probe. Must be called with text_mutex locked */
+/* Put a breakpoint for a probe. Must be called with 'text_mutex' locked. */
 static void __arm_kprobe(struct kprobe *p)
 {
 	struct kprobe *_p;
 
-	/* Check collision with other optimized kprobes */
+	/* Find the overlapping optimized kprobes. */
 	_p = get_optimized_kprobe((unsigned long)p->addr);
 	if (unlikely(_p))
 		/* Fallback to unoptimized kprobe */
@@ -968,7 +974,7 @@ static void __arm_kprobe(struct kprobe *p)
 	optimize_kprobe(p);	/* Try to optimize (add kprobe to a list) */
 }
 
-/* Remove the breakpoint of a probe. Must be called with text_mutex locked */
+/* Remove the breakpoint of a probe. Must be called with 'text_mutex' locked. */
 static void __disarm_kprobe(struct kprobe *p, bool reopt)
 {
 	struct kprobe *_p;
@@ -978,12 +984,17 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 
 	if (!kprobe_queued(p)) {
 		arch_disarm_kprobe(p);
-		/* If another kprobe was blocked, optimize it. */
+		/* If another kprobe was blocked, re-optimize it. */
 		_p = get_optimized_kprobe((unsigned long)p->addr);
 		if (unlikely(_p) && reopt)
 			optimize_kprobe(_p);
 	}
-	/* TODO: reoptimize others after unoptimized this probe */
+	/*
+	 * TODO: Since unoptimization and real disarming will be done by
+	 * the worker thread, we can not check whether another probe are
+	 * unoptimized because of this probe here. It should be re-optimized
+	 * by the worker thread.
+	 */
 }
 
 #else /* !CONFIG_OPTPROBES */
@@ -1036,7 +1047,7 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
-/* Must ensure p->addr is really on ftrace */
+/* Must ensure 'p->addr' is really on ftrace. */
 static int prepare_kprobe(struct kprobe *p)
 {
 	if (!kprobe_ftrace(p))
@@ -1045,7 +1056,7 @@ static int prepare_kprobe(struct kprobe *p)
 	return arch_prepare_kprobe_ftrace(p);
 }
 
-/* Caller must lock kprobe_mutex */
+/* Caller must lock 'kprobe_mutex' */
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
 {
@@ -1082,7 +1093,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 
-/* Caller must lock kprobe_mutex */
+/* Caller must lock 'kprobe_mutex'. */
 static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 				  int *cnt)
 {
@@ -1127,7 +1138,7 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
-/* Arm a kprobe with text_mutex */
+/* Arm a kprobe with 'text_mutex'. */
 static int arm_kprobe(struct kprobe *kp)
 {
 	if (unlikely(kprobe_ftrace(kp)))
@@ -1142,7 +1153,7 @@ static int arm_kprobe(struct kprobe *kp)
 	return 0;
 }
 
-/* Disarm a kprobe with text_mutex */
+/* Disarm a kprobe with 'text_mutex'. */
 static int disarm_kprobe(struct kprobe *kp, bool reopt)
 {
 	if (unlikely(kprobe_ftrace(kp)))
@@ -1192,17 +1203,17 @@ static void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(aggr_post_handler);
 
-/* Walks the list and increments nmissed count for multiprobe case */
+/* Walks the list and increments 'nmissed' if 'p' has child probes. */
 void kprobes_inc_nmissed_count(struct kprobe *p)
 {
 	struct kprobe *kp;
+
 	if (!kprobe_aggrprobe(p)) {
 		p->nmissed++;
 	} else {
 		list_for_each_entry_rcu(kp, &p->list, list)
 			kp->nmissed++;
 	}
-	return;
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
@@ -1220,9 +1231,9 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 
-	if (likely(rp)) {
+	if (likely(rp))
 		freelist_add(&ri->freelist, &rp->freelist);
-	} else
+	else
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
@@ -1248,8 +1259,8 @@ void kprobe_busy_end(void)
 }
 
 /*
- * This function is called from finish_task_switch when task tk becomes dead,
- * so that we can recycle any function-return probe instances associated
+ * This function is called from finish_task_switch() when task 'tk' becomes
+ * dead, so that we can recycle any kretprobe instances associated
  * with this task. These left over instances represent probed functions
  * that have been called but will never return.
  */
@@ -1297,7 +1308,7 @@ static inline void free_rp_inst(struct kretprobe *rp)
 	}
 }
 
-/* Add the new probe to ap->list */
+/* Add the new probe to 'ap->list'. */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	if (p->post_handler)
@@ -1311,12 +1322,12 @@ static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 }
 
 /*
- * Fill in the required fields of the "manager kprobe". Replace the
- * earlier kprobe in the hlist with the manager kprobe
+ * Fill in the required fields of the aggregator kprobe. Replace the
+ * earlier kprobe in the hlist with the aggregator kprobe.
  */
 static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 {
-	/* Copy p's insn slot to ap */
+	/* Copy the insn slot of 'p' to 'ap'. */
 	copy_kprobe(p, ap);
 	flush_insn_slot(ap);
 	ap->addr = p->addr;
@@ -1334,8 +1345,7 @@ static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 }
 
 /*
- * This is the second or subsequent kprobe at the address - handle
- * the intricacies
+ * This registers the second or subsequent kprobe at the same address.
  */
 static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
@@ -1349,7 +1359,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 	mutex_lock(&text_mutex);
 
 	if (!kprobe_aggrprobe(orig_p)) {
-		/* If orig_p is not an aggr_kprobe, create new aggr_kprobe. */
+		/* If 'orig_p' is not an 'aggr_kprobe', create new one. */
 		ap = alloc_aggr_kprobe(orig_p);
 		if (!ap) {
 			ret = -ENOMEM;
@@ -1374,8 +1384,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 		if (ret)
 			/*
 			 * Even if fail to allocate new slot, don't need to
-			 * free aggr_probe. It will be used next time, or
-			 * freed by unregister_kprobe.
+			 * free the 'ap'. It will be used next time, or
+			 * freed by unregister_kprobe().
 			 */
 			goto out;
 
@@ -1390,7 +1400,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 			    | KPROBE_FLAG_DISABLED;
 	}
 
-	/* Copy ap's insn slot to p */
+	/* Copy the insn slot of 'p' to 'ap'. */
 	copy_kprobe(ap, p);
 	ret = add_new_kprobe(ap, p);
 
@@ -1416,7 +1426,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 
 bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 {
-	/* The __kprobes marked functions and entry code must not be probed */
+	/* The '__kprobes' functions and entry code must not be probed. */
 	return addr >= (unsigned long)__kprobes_text_start &&
 	       addr < (unsigned long)__kprobes_text_end;
 }
@@ -1428,8 +1438,8 @@ static bool __within_kprobe_blacklist(unsigned long addr)
 	if (arch_within_kprobe_blacklist(addr))
 		return true;
 	/*
-	 * If there exists a kprobe_blacklist, verify and
-	 * fail any probe registration in the prohibited area
+	 * If 'kprobe_blacklist' is defined, check the address and
+	 * reject any probe registration in the prohibited area.
 	 */
 	list_for_each_entry(ent, &kprobe_blacklist, list) {
 		if (addr >= ent->start_addr && addr < ent->end_addr)
@@ -1459,7 +1469,7 @@ bool within_kprobe_blacklist(unsigned long addr)
 }
 
 /*
- * If we have a symbol_name argument, look it up and add the offset field
+ * If 'symbol_name' is specified, look it up and add the 'offset'
  * to it. This way, we can specify a relative address to a symbol.
  * This returns encoded errors if it fails to look up symbol or invalid
  * combination of parameters.
@@ -1489,7 +1499,10 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
 }
 
-/* Check passed kprobe is valid and return kprobe in kprobe_table. */
+/*
+ * Check the 'p' is valid and return the aggregator kprobe
+ * at the same address.
+ */
 static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 {
 	struct kprobe *ap, *list_p;
@@ -1566,7 +1579,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
-	/* Check if are we probing a module */
+	/* Check if 'p' is probing a module. */
 	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
 		/*
@@ -1579,7 +1592,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		}
 
 		/*
-		 * If the module freed .init.text, we couldn't insert
+		 * If the module freed '.init.text', we couldn't insert
 		 * kprobes in there.
 		 */
 		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
@@ -1626,7 +1639,7 @@ int register_kprobe(struct kprobe *p)
 
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
-		/* Since this may unoptimize old_p, locking text_mutex. */
+		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
 		ret = register_aggr_kprobe(old_p, p);
 		goto out;
 	}
@@ -1665,7 +1678,7 @@ int register_kprobe(struct kprobe *p)
 }
 EXPORT_SYMBOL_GPL(register_kprobe);
 
-/* Check if all probes on the aggrprobe are disabled */
+/* Check if all probes on the 'ap' are disabled. */
 static int aggr_kprobe_disabled(struct kprobe *ap)
 {
 	struct kprobe *kp;
@@ -1675,15 +1688,15 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 	list_for_each_entry(kp, &ap->list, list)
 		if (!kprobe_disabled(kp))
 			/*
-			 * There is an active probe on the list.
-			 * We can't disable this ap.
+			 * Since there is an active probe on the list,
+			 * we can't disable this 'ap'.
 			 */
 			return 0;
 
 	return 1;
 }
 
-/* Disable one kprobe: Make sure called under kprobe_mutex is locked */
+/* Disable one kprobe: Make sure called under 'kprobe_mutex' is locked. */
 static struct kprobe *__disable_kprobe(struct kprobe *p)
 {
 	struct kprobe *orig_p;
@@ -1702,7 +1715,7 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 		/* Try to disarm and disable this/parent probe */
 		if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
 			/*
-			 * If kprobes_all_disarmed is set, orig_p
+			 * If 'kprobes_all_disarmed' is set, 'orig_p'
 			 * should have already been disarmed, so
 			 * skip unneed disarming process.
 			 */
@@ -1989,7 +2002,7 @@ int register_kretprobe(struct kretprobe *rp)
 	if (ret)
 		return ret;
 
-	/* If only rp->kp.addr is specified, check reregistering kprobes */
+	/* If only 'rp->kp.addr' is specified, check reregistering kprobes */
 	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
 		return -EINVAL;
 
@@ -2094,13 +2107,13 @@ EXPORT_SYMBOL_GPL(unregister_kretprobes);
 #else /* CONFIG_KRETPROBES */
 int register_kretprobe(struct kretprobe *rp)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(register_kretprobe);
 
 int register_kretprobes(struct kretprobe **rps, int num)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(register_kretprobes);
 
@@ -2149,7 +2162,7 @@ static void kill_kprobe(struct kprobe *p)
 	/*
 	 * The module is going away. We should disarm the kprobe which
 	 * is using ftrace, because ftrace framework is still available at
-	 * MODULE_STATE_GOING notification.
+	 * 'MODULE_STATE_GOING' notification.
 	 */
 	if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
 		disarm_kprobe_ftrace(p);
@@ -2322,13 +2335,13 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 			return ret;
 	}
 
-	/* Symbols in __kprobes_text are blacklisted */
+	/* Symbols in '__kprobes_text' are blacklisted */
 	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
 					(unsigned long)__kprobes_text_end);
 	if (ret)
 		return ret;
 
-	/* Symbols in noinstr section are blacklisted */
+	/* Symbols in 'noinstr' section are blacklisted */
 	ret = kprobe_add_area_blacklist((unsigned long)__noinstr_text_start,
 					(unsigned long)__noinstr_text_end);
 
@@ -2400,9 +2413,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/*
-	 * When MODULE_STATE_GOING was notified, both of module .text and
-	 * .init.text sections would be freed. When MODULE_STATE_LIVE was
-	 * notified, only .init.text section would be freed. We need to
+	 * When 'MODULE_STATE_GOING' was notified, both of module '.text' and
+	 * '.init.text' sections would be freed. When 'MODULE_STATE_LIVE' was
+	 * notified, only '.init.text' section would be freed. We need to
 	 * disable kprobes which have been inserted in the sections.
 	 */
 	mutex_lock(&kprobe_mutex);
@@ -2419,9 +2432,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				 *
 				 * Note, this will also move any optimized probes
 				 * that are pending to be removed from their
-				 * corresponding lists to the freeing_list and
+				 * corresponding lists to the 'freeing_list' and
 				 * will not be touched by the delayed
-				 * kprobe_optimizer work handler.
+				 * kprobe_optimizer() work handler.
 				 */
 				kill_kprobe(p);
 			}
@@ -2437,10 +2450,6 @@ static struct notifier_block kprobe_module_nb = {
 	.priority = 0
 };
 
-/* Markers of _kprobe_blacklist section */
-extern unsigned long __start_kprobe_blacklist[];
-extern unsigned long __stop_kprobe_blacklist[];
-
 void kprobe_free_init_mem(void)
 {
 	void *start = (void *)(&__init_begin);
@@ -2451,7 +2460,7 @@ void kprobe_free_init_mem(void)
 
 	mutex_lock(&kprobe_mutex);
 
-	/* Kill all kprobes on initmem */
+	/* Kill all kprobes on initmem because the target code has been freed. */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		hlist_for_each_entry(p, head, hlist) {
@@ -2474,9 +2483,8 @@ static int __init init_kprobes(void)
 
 	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
 					__stop_kprobe_blacklist);
-	if (err) {
+	if (err)
 		pr_err("Failed to populate blacklist (error %d), kprobes not restricted, be careful using them!\n", err);
-	}
 
 	if (kretprobe_blacklist_size) {
 		/* lookup the function address from its name */
@@ -2493,7 +2501,7 @@ static int __init init_kprobes(void)
 	kprobes_all_disarmed = false;
 
 #if defined(CONFIG_OPTPROBES) && defined(__ARCH_WANT_KPROBES_INSN_SLOT)
-	/* Init kprobe_optinsn_slots for allocation */
+	/* Init 'kprobe_optinsn_slots' for allocation */
 	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
 #endif
 
@@ -2627,7 +2635,7 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 		list_entry(v, struct kprobe_blacklist_entry, list);
 
 	/*
-	 * If /proc/kallsyms is not showing kernel address, we won't
+	 * If '/proc/kallsyms' is not showing kernel address, we won't
 	 * show them here either.
 	 */
 	if (!kallsyms_show_value(m->file->f_cred))

