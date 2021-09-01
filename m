Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173673FE0FF
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhIARPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhIARPb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 13:15:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069CC061575;
        Wed,  1 Sep 2021 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zg4ky3u1RR7vC5bG9vuqWMj5I+IaNaulBMg2E9bQTao=; b=UieUOrwel3zqVGYXHx8/ef1RXx
        yzQaZ18OTcx5/++7C3QcK0sBMCLX4jZRflFwADFtPjUBxsGpVPQqsLvsHhLTTd3W4xsmWEqQ66kmn
        MvV/HC0S768szwWMmZRzyFU4xjbOHjFxUmtowHc+qRUEV9HuupBFLaRf/lXjTtvsf+8bepinc5DIS
        BtjIGPpj6nUZq63YN/PxAkswKiHwmUfXoC9cXwJ9kjhCNnlrjNYfDxKPiKgDpNv8Hmux9u86h7Q0Y
        lPqm9xSQ6gIpkSF6HKks/o635nsscsMlftAGwhShSe0od0Q/dZPqBtZmaMYrBfyH4DY+BJ5ytNutC
        85dFwzJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLTmk-002atN-Tb; Wed, 01 Sep 2021 17:12:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78D6E30029F;
        Wed,  1 Sep 2021 19:12:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51FC52B838722; Wed,  1 Sep 2021 19:12:24 +0200 (CEST)
Date:   Wed, 1 Sep 2021 19:12:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YS+0eIeAJsRRArk4@hirez.programming.kicks-ass.net>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
 <719D2DC2-CC5D-4C6A-94F4-DBCADDA291CC@fb.com>
 <YS0eXMd5Y5yV/m1m@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0eXMd5Y5yV/m1m@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 08:07:24PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 30, 2021 at 05:41:46PM +0000, Song Liu wrote:
> > DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
> >                    int (*)(struct perf_branch_snapshot *));
> 
> > Something like 
> > 
> > typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_snapshot *);
> > DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
> > 
> > seems to work fine. 
> 
> Oh urg, indeed. It wants a function type, not a function pointer type.
> I've been bitten by that before. Go with the typedef, that's the sanest.

The below is the best I can make of it... it's a little inconsistent and
somewhat tricky, but at least the compiler yells hard if you get it
wrong.

I can *almost* get to: DEFINE_STATIC_CALL(foo, &func), except for
ARCH_DEFINE_STATIC_CALL_TRAMP() which needs the actual function name
string for the ASM :-(

The rest can do with a function pointer type and have it work.


---

diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index 95d5b0d625cd..1094b3abd910 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -9,9 +9,7 @@ struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
-u64 dummy_steal_clock(int cpu);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+DECLARE_STATIC_CALL(pv_steal_clock, u64 (*)(int));
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index 9aa193e0e8f2..26539c1c277a 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -9,9 +9,7 @@ struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
-u64 dummy_steal_clock(int cpu);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+DECLARE_STATIC_CALL(pv_steal_clock, u64 (*)(int));
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a57dbed4894..0c3b302026dc 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -60,35 +60,35 @@ DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
  * This here uses DEFINE_STATIC_CALL_NULL() to get a static_call defined
  * from just a typename, as opposed to an actual function.
  */
-DEFINE_STATIC_CALL_NULL(x86_pmu_handle_irq,  *x86_pmu.handle_irq);
-DEFINE_STATIC_CALL_NULL(x86_pmu_disable_all, *x86_pmu.disable_all);
-DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enable_all);
-DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
-DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_handle_irq,  x86_pmu.handle_irq);
+DEFINE_STATIC_CALL_NULL(x86_pmu_disable_all, x86_pmu.disable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  x86_pmu.enable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     x86_pmu.enable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     x86_pmu.disable);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
-DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
-DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
+DEFINE_STATIC_CALL_NULL(x86_pmu_add,  x86_pmu.add);
+DEFINE_STATIC_CALL_NULL(x86_pmu_del,  x86_pmu.del);
+DEFINE_STATIC_CALL_NULL(x86_pmu_read, x86_pmu.read);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
-DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
-DEFINE_STATIC_CALL_NULL(x86_pmu_put_event_constraints, *x86_pmu.put_event_constraints);
+DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       x86_pmu.schedule_events);
+DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
+DEFINE_STATIC_CALL_NULL(x86_pmu_put_event_constraints, x86_pmu.put_event_constraints);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_start_scheduling,  *x86_pmu.start_scheduling);
-DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
-DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_start_scheduling,  x86_pmu.start_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, x86_pmu.commit_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   x86_pmu.stop_scheduling);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
-DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
+DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    x86_pmu.sched_task);
+DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
-DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
+DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   x86_pmu.drain_pebs);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
 
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
  */
-DEFINE_STATIC_CALL_RET0(x86_pmu_guest_get_msrs, *x86_pmu.guest_get_msrs);
+DEFINE_STATIC_CALL_RET0(x86_pmu_guest_get_msrs, x86_pmu.guest_get_msrs);
 
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index af6ce8d4c86a..d383bda4316e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1503,7 +1503,7 @@ extern bool __read_mostly enable_apicv;
 extern struct kvm_x86_ops kvm_x86_ops;
 
 #define KVM_X86_OP(func) \
-	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
+	DECLARE_STATIC_CALL(kvm_x86_##func, (((struct kvm_x86_ops *)0)->func));
 #define KVM_X86_OP_NULL KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index da3a1ac82be5..3db2237e9a8d 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -18,11 +18,8 @@
 #include <linux/static_call_types.h>
 #include <asm/frame.h>
 
-u64 dummy_steal_clock(int cpu);
-u64 dummy_sched_clock(void);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
+DECLARE_STATIC_CALL(pv_steal_clock, u64 (*)(int));
+DECLARE_STATIC_CALL(pv_sched_clock, u64 (*)(void));
 
 void paravirt_set_sched_clock(u64 (*func)(void));
 
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index fe5efbcba824..65b2e6ec87a7 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -117,7 +117,7 @@ extern asmlinkage void preempt_schedule_notrace_thunk(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+DECLARE_STATIC_CALL(preempt_schedule, &__preempt_schedule_func);
 
 #define __preempt_schedule() \
 do { \
@@ -125,7 +125,7 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+DECLARE_STATIC_CALL(preempt_schedule_notrace, &__preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
 do { \
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e5d5c5ed7dd4..940c17099fcf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -125,7 +125,7 @@ EXPORT_SYMBOL_GPL(kvm_x86_ops);
 
 #define KVM_X86_OP(func)					     \
 	DEFINE_STATIC_CALL_NULL(kvm_x86_##func,			     \
-				*(((struct kvm_x86_ops *)0)->func));
+				(((struct kvm_x86_ops *)0)->func));
 #define KVM_X86_OP_NULL KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..d4106a3f3243 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,7 +456,7 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, &irqentry_exit_cond_resched);
 #endif
 
 /**
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1b2f0a7e00d6..58aa80015db6 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -97,7 +97,7 @@ extern int __cond_resched(void);
 
 extern int __cond_resched(void);
 
-DECLARE_STATIC_CALL(might_resched, __cond_resched);
+DECLARE_STATIC_CALL(might_resched, &__cond_resched);
 
 static __always_inline void might_resched(void)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1780260f237b..93aad9c6fad1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2012,7 +2012,7 @@ extern int __cond_resched(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(cond_resched, __cond_resched);
+DECLARE_STATIC_CALL(cond_resched, &__cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a9751c06..18ee529b4937 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -14,16 +14,16 @@
  *
  * API overview:
  *
- *   DECLARE_STATIC_CALL(name, func);
- *   DEFINE_STATIC_CALL(name, func);
- *   DEFINE_STATIC_CALL_NULL(name, typename);
- *   DEFINE_STATIC_CALL_RET0(name, typename);
+ *   DECLARE_STATIC_CALL(name, &func);
+ *   DEFINE_STATIC_CALL(name, func);		// needs an actual function
+ *   DEFINE_STATIC_CALL_NULL(name, &func);
+ *   DEFINE_STATIC_CALL_RET0(name, &func);
  *
  *   __static_call_return0;
  *
  *   static_call(name)(args...);
  *   static_call_cond(name)(args...);
- *   static_call_update(name, func);
+ *   static_call_update(name, &func);
  *   static_call_query(name);
  *
  *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
@@ -46,6 +46,9 @@
  *   # Call func_b()
  *   static_call(my_name)(arg1, arg2);
  *
+ *   @ To query which function is currently set to be called, use:
+ *   func = static_call_query(name);
+ *
  *
  * Implementation details:
  *
@@ -66,7 +69,8 @@
  * Notes on NULL function pointers:
  *
  *   Static_call()s support NULL functions, with many of the caveats that
- *   regular function pointers have.
+ *   regular function pointers have and a few extra. In particular they rely on
+ *   the function return type being void.
  *
  *   Clearly calling a NULL function pointer is 'BAD', so too for
  *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
@@ -79,10 +83,11 @@
  *
  *     void (*my_func_ptr)(int arg1) = NULL;
  *
- *   or using static_call_update() with a NULL function. In both cases the
- *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
- *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
- *   architectures can patch the trampoline call to a NOP.
+ *   or using static_call_update() with a NULL function pointer. In both cases
+ *   the HAVE_STATIC_CALL implementation will patch the trampoline with a RET
+ *   instruction, instead of an immediate tail-call JMP.
+ *   HAVE_STATIC_CALL_INLINE architectures can patch the trampoline call to a
+ *   NOP.
  *
  *   In all cases, any argument evaluation is unconditional. Unlike a regular
  *   conditional function pointer call:
@@ -97,11 +102,8 @@
  *     static_call_cond(name)(arg1);
  *
  *   which will include the required value tests to avoid NULL-pointer
- *   dereferences.
- *
- *   To query which function is currently set to be called, use:
- *
- *   func = static_call_query(name);
+ *   dereferences. Note that this is a statement, not an expression, hence the
+ *   requirement for a void return value.
  *
  *
  * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
@@ -122,6 +124,14 @@
  *
  *   Notably argument setup is unconditional.
  *
+ *   For example:
+ *
+ *     DEFINE_STATIC_CALL_RET0(my_ret_func, int (*)(int));
+ *
+ *     ret = static_call(my_ret_func)(5);
+ *
+ *   will, unless static_call_update() is used, return 0.
+ *
  *
  * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
  *
@@ -180,16 +190,16 @@ extern int static_call_text_reserved(void *start, void *end);
 
 extern long __static_call_return0(void);
 
-#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define __DEFINE_STATIC_CALL(name, func_ptr, func_init)			\
+	DECLARE_STATIC_CALL(name, func_ptr);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func_init,					\
+		.func = func_init,					\
 		.type = 1,						\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, func_init)
 
-#define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define DEFINE_STATIC_CALL_NULL(name, func_ptr)				\
+	DECLARE_STATIC_CALL(name, func_ptr);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
 		.type = 1,						\
@@ -217,15 +227,15 @@ extern long __static_call_return0(void);
 
 static inline int static_call_init(void) { return 0; }
 
-#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define __DEFINE_STATIC_CALL(name, func_ptr, func_init)			\
+	DECLARE_STATIC_CALL(name, func_ptr);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func_init,					\
+		.func = func_init,					\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, func_init)
 
-#define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define DEFINE_STATIC_CALL_NULL(name, func_ptr)				\
+	DECLARE_STATIC_CALL(name, func_ptr);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
 	};								\
@@ -275,14 +285,14 @@ static inline long __static_call_return0(void)
 	return 0;
 }
 
-#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define __DEFINE_STATIC_CALL(name, func_ptr, func_init)			\
+	DECLARE_STATIC_CALL(name, func_ptr);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func_init,					\
+		.func = func_init,					\
 	}
 
-#define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
+#define DEFINE_STATIC_CALL_NULL(name, func_ptr)				\
+	DECLARE_STATIC_CALL(name, func_ptr);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
 	}
@@ -327,10 +337,10 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-#define DEFINE_STATIC_CALL(name, _func)					\
-	__DEFINE_STATIC_CALL(name, _func, _func)
+#define DEFINE_STATIC_CALL(name, func)					\
+	__DEFINE_STATIC_CALL(name, &func, func)
 
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+#define DEFINE_STATIC_CALL_RET0(name, func_ptr)				\
+	__DEFINE_STATIC_CALL(name, func_ptr, __static_call_return0)
 
 #endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..3f87aa682e14 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -34,9 +34,15 @@ struct static_call_site {
 	s32 key;
 };
 
-#define DECLARE_STATIC_CALL(name, func)					\
+/*
+ * Type mismatch on __SCP__ functions is due to mismatched function vs function
+ * pointer arguments between DECLARE_STATIC_CALL() and DEFINE_STATIC_CALL*()
+ * variants.
+ */
+#define DECLARE_STATIC_CALL(name, func_ptr)				\
 	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern typeof(func_ptr) __SCP__##name;				\
+	extern typeof(*__SCP__##name) STATIC_CALL_TRAMP(name);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index ab58696d0ddd..118b78fffc9d 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -240,7 +240,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	extern int __traceiter_##name(data_proto);			\
-	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
+	DECLARE_STATIC_CALL(tp_func_##name, &__traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4462c454ab9..def3aa224ae5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8171,10 +8171,10 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+DEFINE_STATIC_CALL_RET0(cond_resched, &__cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
-DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+DEFINE_STATIC_CALL_RET0(might_resched, &__cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 43ba0b1e0edb..b652c32a7250 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -517,6 +517,12 @@ static int func_b(int x)
 }
 
 DEFINE_STATIC_CALL(sc_selftest, func_a);
+DEFINE_STATIC_CALL_NULL(sc_null, void (*)(int *));
+
+static void null_a(int *arg)
+{
+	*arg = 1;
+}
 
 static struct static_call_data {
       int (*func)(int);
@@ -530,18 +536,26 @@ static struct static_call_data {
 
 static int __init test_static_call_init(void)
 {
-      int i;
+	int i;
 
-      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
-	      struct static_call_data *scd = &static_call_data[i];
+	for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
+		struct static_call_data *scd = &static_call_data[i];
 
-              if (scd->func)
-                      static_call_update(sc_selftest, scd->func);
+		if (scd->func)
+			static_call_update(sc_selftest, scd->func);
 
-              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
-      }
+		WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
+	}
 
-      return 0;
+	i = 5;
+	static_call_cond(sc_null)(&i);
+	WARN_ON(i != 5);
+
+	static_call_update(sc_null, &null_a);
+	static_call_cond(sc_null)(&i);
+	WARN_ON(i != 1);
+
+	return 0;
 }
 early_initcall(test_static_call_init);
 
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index d5c891d8d353..1d91eb6b242e 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -35,13 +35,13 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
-DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
+DEFINE_STATIC_CALL_NULL(trusted_key_init, trusted_key_sources[0].ops->init);
+DEFINE_STATIC_CALL_NULL(trusted_key_seal, trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
-			*trusted_key_sources[0].ops->unseal);
+			trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
-			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+			trusted_key_sources[0].ops->get_random);
+DEFINE_STATIC_CALL_NULL(trusted_key_exit, trusted_key_sources[0].ops->exit);
 static unsigned char migratable;
 
 enum {
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 5a00b8b2cf9f..3f87aa682e14 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -34,9 +34,15 @@ struct static_call_site {
 	s32 key;
 };
 
-#define DECLARE_STATIC_CALL(name, func)					\
+/*
+ * Type mismatch on __SCP__ functions is due to mismatched function vs function
+ * pointer arguments between DECLARE_STATIC_CALL() and DEFINE_STATIC_CALL*()
+ * variants.
+ */
+#define DECLARE_STATIC_CALL(name, func_ptr)				\
 	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern typeof(func_ptr) __SCP__##name;				\
+	extern typeof(*__SCP__##name) STATIC_CALL_TRAMP(name);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
