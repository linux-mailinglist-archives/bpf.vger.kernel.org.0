Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6964E74F7
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiCYOY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbiCYOYx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2BDF3B;
        Fri, 25 Mar 2022 07:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC4F61B54;
        Fri, 25 Mar 2022 14:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63223C36AE2;
        Fri, 25 Mar 2022 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648218190;
        bh=nUY05pK65gv7YynBy69L6DI+o3Uu996Vli2qilfaxLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvxgYnxlYVSwNMEeeYxaJj9Z4oTQMX8dO2HANE/YtsscwJQUyhdThOT1kav3b4uV1
         yULWAEANbLQioAbhY/zEg7utyYDu/SbXn8E/acgDJxlXPRPWxfmqtbzppMoTcHbBNe
         MXTeG+r4X30w+Enrbq0M0WYkNH/LKfijI6dE+fiE4PGSVaVpU1io+FSiSjK9pQzytu
         IhnYfDROCY9Bu+k1CLNhWQuJqoJgH5leKC+hrj/YjgKQ6caSx+7gGmGUAmj3lw+ZCx
         AyQRPM51Ok3Ktmxkyklwph6nx9pVfqiS07MqOhcfSb7fl4uXEDq4oqR06DKD002tsV
         fdqQJDUkhOqqQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] kprobes: Use rethook for kretprobe if possible
Date:   Fri, 25 Mar 2022 23:23:04 +0900
Message-Id: <164821818458.2373735.845217530054599105.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164821817332.2373735.12048266953420821089.stgit@devnote2>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use rethook for kretprobe function return hooking if the arch sets
CONFIG_HAVE_RETHOOK=y. In this case, CONFIG_KRETPROBE_ON_RETHOOK is
set to 'y' automatically, and the kretprobe internal data fields
switches to use rethook. If not, it continues to use kretprobe
specific function return hooks.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/Kconfig                |    7 ++
 include/linux/kprobes.h     |   51 +++++++++++++++++-
 kernel/kprobes.c            |  124 ++++++++++++++++++++++++++++++++++++-------
 kernel/trace/trace_kprobe.c |    4 +
 4 files changed, 161 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e12a4268c01d..9570854c4683 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -164,7 +164,12 @@ config ARCH_USE_BUILTIN_BSWAP
 
 config KRETPROBES
 	def_bool y
-	depends on KPROBES && HAVE_KRETPROBES
+	depends on KPROBES && (HAVE_KRETPROBES || HAVE_RETHOOK)
+
+config KRETPROBE_ON_RETHOOK
+	def_bool y
+	depends on HAVE_RETHOOK
+	select RETHOOK
 
 config USER_RETURN_NOTIFIER
 	bool
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 312ff997c743..157168769fc2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -28,6 +28,7 @@
 #include <linux/ftrace.h>
 #include <linux/refcount.h>
 #include <linux/freelist.h>
+#include <linux/rethook.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -149,13 +150,20 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+	struct rethook *rh;
+#else
 	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
+#endif
 };
 
 #define KRETPROBE_MAX_DATA_SIZE	4096
 
 struct kretprobe_instance {
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+	struct rethook_node node;
+#else
 	union {
 		struct freelist_node freelist;
 		struct rcu_head rcu;
@@ -164,6 +172,7 @@ struct kretprobe_instance {
 	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
 	void *fp;
+#endif
 	char data[];
 };
 
@@ -186,10 +195,24 @@ extern void kprobe_busy_begin(void);
 extern void kprobe_busy_end(void);
 
 #ifdef CONFIG_KRETPROBES
-extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				   struct pt_regs *regs);
+/* Check whether @p is used for implementing a trampoline. */
 extern int arch_trampoline_kprobe(struct kprobe *p);
 
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+		"Kretprobe is accessed from instance under preemptive context");
+
+	return (struct kretprobe *)READ_ONCE(ri->node.rethook->data);
+}
+static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
+{
+	return ri->node.ret_addr;
+}
+#else
+extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
+				   struct pt_regs *regs);
 void arch_kretprobe_fixup_return(struct pt_regs *regs,
 				 kprobe_opcode_t *correct_ret_addr);
 
@@ -232,6 +255,12 @@ static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance
 	return READ_ONCE(ri->rph->rp);
 }
 
+static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
+{
+	return (unsigned long)ri->ret_addr;
+}
+#endif /* CONFIG_KRETPROBE_ON_RETHOOK */
+
 #else /* !CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
@@ -395,7 +424,11 @@ void unregister_kretprobe(struct kretprobe *rp);
 int register_kretprobes(struct kretprobe **rps, int num);
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+#define kprobe_flush_task(tk)	do {} while (0)
+#else
 void kprobe_flush_task(struct task_struct *tk);
+#endif
 
 void kprobe_free_init_mem(void);
 
@@ -509,6 +542,19 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 #endif /* !CONFIG_OPTPROBES */
 
 #ifdef CONFIG_KRETPROBES
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return is_rethook_trampoline(addr);
+}
+
+static nokprobe_inline
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur)
+{
+	return rethook_find_ret_addr(tsk, (unsigned long)fp, cur);
+}
+#else
 static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
 {
 	return (void *)addr == kretprobe_trampoline_addr();
@@ -516,6 +562,7 @@ static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
 
 unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 				      struct llist_node **cur);
+#endif
 #else
 static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 185badc780b7..dbe57df2e199 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1237,6 +1237,27 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
+static struct kprobe kprobe_busy = {
+	.addr = (void *) get_kprobe,
+};
+
+void kprobe_busy_begin(void)
+{
+	struct kprobe_ctlblk *kcb;
+
+	preempt_disable();
+	__this_cpu_write(current_kprobe, &kprobe_busy);
+	kcb = get_kprobe_ctlblk();
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+}
+
+void kprobe_busy_end(void)
+{
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+}
+
+#if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
@@ -1258,26 +1279,6 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-static struct kprobe kprobe_busy = {
-	.addr = (void *) get_kprobe,
-};
-
-void kprobe_busy_begin(void)
-{
-	struct kprobe_ctlblk *kcb;
-
-	preempt_disable();
-	__this_cpu_write(current_kprobe, &kprobe_busy);
-	kcb = get_kprobe_ctlblk();
-	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-}
-
-void kprobe_busy_end(void)
-{
-	__this_cpu_write(current_kprobe, NULL);
-	preempt_enable();
-}
-
 /*
  * This function is called from delayed_put_task_struct() when a task is
  * dead and cleaned up to recycle any kretprobe instances associated with
@@ -1327,6 +1328,7 @@ static inline void free_rp_inst(struct kretprobe *rp)
 		rp->rph = NULL;
 	}
 }
+#endif	/* !CONFIG_KRETPROBE_ON_RETHOOK */
 
 /* Add the new probe to 'ap->list'. */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
@@ -1925,6 +1927,7 @@ static struct notifier_block kprobe_exceptions_nb = {
 
 #ifdef CONFIG_KRETPROBES
 
+#if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
 /* This assumes the 'tsk' is the current task or the is not running. */
 static kprobe_opcode_t *__kretprobe_find_ret_addr(struct task_struct *tsk,
 						  struct llist_node **cur)
@@ -2087,6 +2090,57 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	return 0;
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
+#else /* CONFIG_KRETPROBE_ON_RETHOOK */
+/*
+ * This kprobe pre_handler is registered with every kretprobe. When probe
+ * hits it will set up the return probe.
+ */
+static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
+	struct kretprobe_instance *ri;
+	struct rethook_node *rhn;
+
+	rhn = rethook_try_get(rp->rh);
+	if (!rhn) {
+		rp->nmissed++;
+		return 0;
+	}
+
+	ri = container_of(rhn, struct kretprobe_instance, node);
+
+	if (rp->entry_handler && rp->entry_handler(ri, regs))
+		rethook_recycle(rhn);
+	else
+		rethook_hook(rhn, regs, kprobe_ftrace(p));
+
+	return 0;
+}
+NOKPROBE_SYMBOL(pre_handler_kretprobe);
+
+static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
+				      struct pt_regs *regs)
+{
+	struct kretprobe *rp = (struct kretprobe *)data;
+	struct kretprobe_instance *ri;
+	struct kprobe_ctlblk *kcb;
+
+	/* The data must NOT be null. This means rethook data structure is broken. */
+	if (WARN_ON_ONCE(!data))
+		return;
+
+	__this_cpu_write(current_kprobe, &rp->kp);
+	kcb = get_kprobe_ctlblk();
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
+	ri = container_of(rh, struct kretprobe_instance, node);
+	rp->handler(ri, regs);
+
+	__this_cpu_write(current_kprobe, NULL);
+}
+NOKPROBE_SYMBOL(kretprobe_rethook_handler);
+
+#endif /* !CONFIG_KRETPROBE_ON_RETHOOK */
 
 /**
  * kprobe_on_func_entry() -- check whether given address is function entry
@@ -2155,6 +2209,29 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler);
+	if (!rp->rh)
+		return -ENOMEM;
+
+	for (i = 0; i < rp->maxactive; i++) {
+		inst = kzalloc(sizeof(struct kretprobe_instance) +
+			       rp->data_size, GFP_KERNEL);
+		if (inst == NULL) {
+			rethook_free(rp->rh);
+			rp->rh = NULL;
+			return -ENOMEM;
+		}
+		rethook_add_node(rp->rh, &inst->node);
+	}
+	rp->nmissed = 0;
+	/* Establish function entry probe point */
+	ret = register_kprobe(&rp->kp);
+	if (ret != 0) {
+		rethook_free(rp->rh);
+		rp->rh = NULL;
+	}
+#else	/* !CONFIG_KRETPROBE_ON_RETHOOK */
 	rp->freelist.head = NULL;
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	if (!rp->rph)
@@ -2179,6 +2256,7 @@ int register_kretprobe(struct kretprobe *rp)
 	ret = register_kprobe(&rp->kp);
 	if (ret != 0)
 		free_rp_inst(rp);
+#endif
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_kretprobe);
@@ -2217,7 +2295,11 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	for (i = 0; i < num; i++) {
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+		rethook_free(rps[i]->rh);
+#else
 		rps[i]->rph->rp = NULL;
+#endif
 	}
 	mutex_unlock(&kprobe_mutex);
 
@@ -2225,7 +2307,9 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	for (i = 0; i < num; i++) {
 		if (rps[i]->kp.addr) {
 			__unregister_kprobe_bottom(&rps[i]->kp);
+#ifndef CONFIG_KRETPROBE_ON_RETHOOK
 			free_rp_inst(rps[i]);
+#endif
 		}
 	}
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b62fd785b599..47cebef78532 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1433,7 +1433,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	fbuffer.regs = regs;
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
-	entry->ret_ip = (unsigned long)ri->ret_addr;
+	entry->ret_ip = get_kretprobe_retaddr(ri);
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
@@ -1628,7 +1628,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		return;
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
-	entry->ret_ip = (unsigned long)ri->ret_addr;
+	entry->ret_ip = get_kretprobe_retaddr(ri);
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);

