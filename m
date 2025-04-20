Return-Path: <bpf+bounces-56288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13083A94788
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A58188F5CC
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1451E832D;
	Sun, 20 Apr 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWqTUanJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAA1E5B61
	for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146571; cv=none; b=BSXzmYrSLw1yAT+RGLuRwUsenLiLhxwAiKtV9Uo++3nVOWV2j6X4COSs5lo5/+PKHbUuBmFM91rDaz+2Xb/OLnT5o54CAykfVVVkw4oceL/KlqEcSjySVHqF5TEYWGRoB8C3ouRAiwj8Z+Uj/P/SAOXGsSSRSnDUIN+Io+BHusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146571; c=relaxed/simple;
	bh=6eEAAOnU/9q6/KQOi37mZM8BBbbWg+teScrt9LNPs4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKVnsPBCX32e0s3hZ+AJQbJ+/No1u3e59uspdr5C/Z9R9r1nLtxsrOFuLqys5KoxAUFvG4W62sxcFSskSEFtpQcEl7P0ftnTlTaUjBD8PRjS+/y5ROke1aAtJhJFqVjwVVhEq83bNWnb4d3E4DAKg1v2yeHbCX8g9trha6pH5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWqTUanJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47698757053so37810831cf.0
        for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146568; x=1745751368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XETriTReLgVEtcfAmie7Mh17ghUqnUU8yo+Mu5clnxk=;
        b=IWqTUanJwKLJTQgq348UnUdRRIeMc+NhaaGqAVp3H3CK/tvnygfh3DZecNU/dfoJC5
         CeQ7UGN64+LTbQpBCVTf40+weG41wIhHxdV3WArQLhSFgirCCUANg3ynDSPEkF6lJBeU
         W3v/qRRYG2sjQYYEuKIsl1Lzlvla19wiDeLym4qXyauKzeatKrXV7/MPSO+7ygkrcWsS
         krMPUxN8dV4O2fUm5rbPEseLLGbe/VsABsd1RuZhHQH3OIt8CG7GFfmGA91Ed7Byg7uS
         LEBjK9aC0M2FkIRd1umskbd2+G1TLfSN+o+hLzbw1GnrvVMAxQeaGZDrERpWTKoEHSH8
         yG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146568; x=1745751368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XETriTReLgVEtcfAmie7Mh17ghUqnUU8yo+Mu5clnxk=;
        b=QgbNx5i3T1ZmPaxORoB8q/Fyd77FI2uMKG/V1Y2yABTkZfDzIClMC9K3ij/ji3Eph3
         lNqGbVOIgcDu7MYFfAbn7DRqo113af1RiOp9ujPvYcz9Hls7AdF8lzXPuBOweCS15hoq
         ekfTg3xOWmR7O5gZ5Z55xBFerfyouyVXj9lDR+8LNEXGUgE+AkQ3xZttPl8c1yLL4LIY
         DXRuUoSQF1yLYTEmklOG8WP3M+KtEtnIweB7X1nCPWuuX5c2GnZTNlNsrQkFoEa7dr/h
         Ub3vtLzdhEk0gMh3GGw2lzODqbGfe3xWYdjmmJMXCVBkhZKooKJY5ZWtv59b+U3UYcK5
         5BWQ==
X-Gm-Message-State: AOJu0YxLyBDdyysc2FF6NI1xKSbEcFM9535LjMr0Wg4d6OAELsOwho8i
	9lpEfMjhpdDd5P23HOvKx0SRKH93F1/fDtSxn4FQh67Qg4BI4jNyERWLS7Sh
X-Gm-Gg: ASbGncu4Y0LkKgDHpd5PmUHY5sdDyn5AsQxv4wTbtrXn4su47yQr44q2bR+2thXKEqB
	D0K3Zjgza1kL4Zk0Z2nDOjioOVcjAE1iwRze4vKeXUz3bJIaS0bVx7VyIaU1Tl7oLJcUxuEK9t5
	carSRSvMPNO56dCPcyYq61KQeQgCDJ3KJSUE/x8lUAkJADZhCwpEJfWBuRynuUYblMtUmZZNIg2
	0k+OrifiBYuUr71ZNpzHn7cHrJshJahANHaCQV5dTLa/l0HWAs1mMb32Oi6Z3ooIbX0LWkhiYTE
	PERLucnbNwX5nmKRa9FiGjKP/0M31np+TjoNBynljdpZRHI0
X-Google-Smtp-Source: AGHT+IGE1no3lAdTujywEi8R0mjauSiyteJ9drjVUPwBLriNtQBXJNGUOGZtuJ7Avo8x8leba7k9mw==
X-Received: by 2002:a05:622a:1346:b0:477:887f:29ce with SMTP id d75a77b69052e-47aec35402cmr161255331cf.5.1745146568205;
        Sun, 20 Apr 2025 03:56:08 -0700 (PDT)
Received: from rajGilbertMachine.. ([2607:b400:30:a100:a5e9:b904:d3d9:b816])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4c608sm30851771cf.41.2025.04.20.03.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 03:56:07 -0700 (PDT)
From: Raj Sahu <rjsu26@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	sidchintamaneni <sidchintamaneni@vt.edu>,
	Raj <rjsu26@gmail.com>
Subject: [RFC bpf-next 4/4] bpf: Runtime part of fast-path termination approach
Date: Sun, 20 Apr 2025 06:55:22 -0400
Message-ID: <20250420105524.2115690-5-rjsu26@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420105524.2115690-1-rjsu26@gmail.com>
References: <20250420105524.2115690-1-rjsu26@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sidchintamaneni <sidchintamaneni@vt.edu>

Introduces IPI based runtime mechanism to terminate
a BPF program. When a BPF program is interrupted by
an IPI, its registers are are passed onto the bpf_die.

Inside bpf_die we perform the RIP switch and stack walk
to replace the return addresses of BPF progs/subprogs to
the patched program. In bpf_die, we are supporting non-inlined
bpf_die scenario as well, later could be extended to other
unrestricted iterators.

Signed-off-by: Raj <rjsu26@gmail.com>
Signed-off-by: Siddharth <sidchintamaneni@gmail.com>
---
 arch/x86/kernel/smp.c  |   4 +-
 include/linux/filter.h |  16 +++++
 include/linux/smp.h    |   2 +-
 kernel/bpf/syscall.c   | 159 +++++++++++++++++++++++++++++++++++++++++
 kernel/smp.c           |  22 ++++--
 5 files changed, 193 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 18266cc3d98c..aca5a97be19f 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -259,7 +259,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
 	apic_eoi();
 	trace_call_function_entry(CALL_FUNCTION_VECTOR);
 	inc_irq_stat(irq_call_count);
-	generic_smp_call_function_interrupt();
+	generic_smp_call_function_interrupt(regs);
 	trace_call_function_exit(CALL_FUNCTION_VECTOR);
 }
 
@@ -268,7 +268,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	apic_eoi();
 	trace_call_function_single_entry(CALL_FUNCTION_SINGLE_VECTOR);
 	inc_irq_stat(irq_call_count);
-	generic_smp_call_function_single_interrupt();
+	generic_smp_call_function_single_interrupt(regs);
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..cb75f62a1357 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -689,10 +689,21 @@ extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
 				     const struct bpf_reg_state *reg,
 				     int off, int size);
 
+void bpf_die(void *data);
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  const struct bpf_insn *insnsi,
 					  unsigned int (*bpf_func)(const void *,
 								   const struct bpf_insn *));
+static void update_term_per_cpu_flag(const struct bpf_prog *prog, u8 cpu_flag)
+{
+	unsigned long flags;
+	u32 cpu_id = raw_smp_processor_id();
+	spin_lock_irqsave(&prog->termination_states->per_cpu_state[cpu_id].lock, 
+				flags);
+	prog->termination_states->per_cpu_state[cpu_id].cpu_flag = cpu_flag;
+	spin_unlock_irqrestore(&prog->termination_states->per_cpu_state[cpu_id].lock,
+				flags);
+}
 
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
@@ -701,12 +712,15 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 	u32 ret;
 
 	cant_migrate();
+
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		struct bpf_prog_stats *stats;
 		u64 duration, start = sched_clock();
 		unsigned long flags;
 
+		update_term_per_cpu_flag(prog, 1);
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		update_term_per_cpu_flag(prog, 0);
 
 		duration = sched_clock() - start;
 		stats = this_cpu_ptr(prog->stats);
@@ -715,7 +729,9 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 		u64_stats_add(&stats->nsecs, duration);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	} else {
+		update_term_per_cpu_flag(prog, 1);
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		update_term_per_cpu_flag(prog, 0);
 	}
 	return ret;
 }
diff --git a/include/linux/smp.h b/include/linux/smp.h
index f1aa0952e8c3..a0d8b3263a15 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -173,7 +173,7 @@ void wake_up_all_idle_cpus(void);
  * Generic and arch helpers
  */
 void __init call_function_init(void);
-void generic_smp_call_function_single_interrupt(void);
+void generic_smp_call_function_single_interrupt(struct pt_regs *regs);
 #define generic_smp_call_function_interrupt \
 	generic_smp_call_function_single_interrupt
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fb54c5e948ff..c5911b67eb15 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6008,6 +6008,162 @@ static int token_create(union bpf_attr *attr)
 	return bpf_token_create(attr);
 }
 
+static bool per_cpu_flag_is_true(struct termination_aux_states *term_states, int cpu_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&term_states->per_cpu_state[cpu_id].lock, 
+				flags);
+	if (term_states->per_cpu_state[cpu_id].cpu_flag == 1) {
+		spin_unlock_irqrestore(&term_states->per_cpu_state[cpu_id].lock,
+					flags);
+		return true;
+	}
+	spin_unlock_irqrestore(&term_states->per_cpu_state[cpu_id].lock,
+				flags);
+	return false;
+}
+
+static int is_bpf_address(struct bpf_prog *prog, unsigned long addr) {
+
+        unsigned long bpf_func_addr = (unsigned long)prog->bpf_func;
+        if ((addr > bpf_func_addr) &&
+                        (addr < bpf_func_addr + prog->jited_len)){
+                return 1;
+        }
+
+        for (int subprog = 1; subprog < prog->aux->func_cnt; subprog++) {
+                struct bpf_prog *bpf_subprog = prog->aux->func[subprog];
+                unsigned long bpf_subprog_func_addr =
+                                        (unsigned long)bpf_subprog->bpf_func;
+                if ((addr > bpf_subprog_func_addr) && (addr < bpf_subprog_func_addr +
+                                                        bpf_subprog->jited_len)) {
+                        return 1;
+                }
+        }
+
+        return 0;
+}
+
+static unsigned long find_offset_in_patch_prog(struct bpf_prog *patch_prog,
+                struct bpf_prog *prog, unsigned long addr)
+{
+
+        unsigned long bpf_func_addr = (unsigned long)prog->bpf_func;
+        if ((addr > bpf_func_addr) &&
+                        (addr < bpf_func_addr + prog->jited_len)){
+                unsigned long offset = addr - (unsigned long)prog->bpf_func;
+                return (unsigned long)patch_prog->bpf_func + offset;
+        }
+
+        for (int subprog = 1; subprog < prog->aux->func_cnt; subprog++) {
+                struct bpf_prog *bpf_subprog = prog->aux->func[subprog];
+                unsigned long bpf_subprog_func_addr =
+                                        (unsigned long)bpf_subprog->bpf_func;
+                if ((addr > bpf_subprog_func_addr) && (addr < bpf_subprog_func_addr +
+                                                        bpf_subprog->jited_len)) {
+                        unsigned long offset = addr - (unsigned
+                                        long)prog->aux->func[subprog]->bpf_func;
+                        return (unsigned long)patch_prog->aux->func[subprog]->bpf_func + offset;
+                }
+        }
+
+	return -EINVAL;
+}
+
+
+void bpf_die(void *data)
+{
+	struct unwind_state state;
+	struct bpf_prog *prog, *patch_prog;
+	struct pt_regs *regs;
+	char str[KSYM_SYMBOL_LEN];
+	unsigned long addr, new_addr, bpf_loop_addr, bpf_loop_term_addr;
+	int cpu_id = raw_smp_processor_id();
+
+	prog = (struct bpf_prog *)data;
+	patch_prog = prog->termination_states->patch_prog;
+
+	if(!per_cpu_flag_is_true(prog->termination_states, cpu_id))
+		return;
+
+	regs = &prog->termination_states->pre_execution_state[cpu_id];
+	bpf_loop_addr = (unsigned long)bpf_loop_proto.func;
+	bpf_loop_term_addr = (unsigned long)bpf_loop_termination_proto.func;
+
+	unwind_start(&state, current, regs, NULL);
+	addr = unwind_get_return_address(&state);
+
+	/* BPF programs RIP is in bpf program context when termination
+	 * signal raises an IPI
+	 */
+	if (is_bpf_address(prog, addr)) {
+		new_addr = find_offset_in_patch_prog(patch_prog, prog, addr);
+		if (new_addr < 0)
+			return;
+		regs->ip = new_addr;
+	}
+
+	unsigned long stack_addr = regs->sp;
+	while (addr) {
+		if (is_bpf_address(prog, addr)) {
+			while (*(unsigned long *)stack_addr != addr) {
+				stack_addr += 1;
+			}
+			new_addr = find_offset_in_patch_prog(patch_prog, prog, addr);
+			if (new_addr < 0)
+				return;
+			*(unsigned long *)stack_addr = new_addr;
+		} else {
+			/* Handles termination non-inline bpf_loop scenario.
+			 * Could be modular and later extended to other iterators.
+			 */
+			const char *name = kallsyms_lookup(addr, NULL, NULL, NULL, str);
+			if (name) {
+				unsigned long lookup_addr = kallsyms_lookup_name(name);
+				if (lookup_addr && lookup_addr == bpf_loop_addr) {
+					while (*(unsigned long *)stack_addr != addr) {
+						stack_addr += 1;
+					}
+					*(unsigned long *)stack_addr = bpf_loop_term_addr;
+				}
+			}
+		}
+		unwind_next_frame(&state);
+		addr = unwind_get_return_address(&state);
+	}
+
+	atomic64_dec(&prog->aux->refcnt);
+
+	return;
+}
+
+static int bpf_prog_terminate(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct termination_aux_states *term_states;
+	int cpu_id;
+
+	prog = bpf_prog_by_id(attr->prog_id);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	term_states = prog->termination_states;
+	if (!term_states)
+		return -ENOTSUPP;
+
+	cpu_id = attr->prog_terminate.term_cpu_id;
+	if (cpu_id < 0 && cpu_id >= NR_CPUS)
+		return -EINVAL;
+
+	if (!per_cpu_flag_is_true(term_states, cpu_id))
+		return -EFAULT;
+
+	smp_call_function_single(cpu_id, bpf_die, (void *)prog, 1);
+
+	return 0;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -6144,6 +6300,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_TOKEN_CREATE:
 		err = token_create(&attr);
 		break;
+	case BPF_PROG_TERMINATE:
+		err = bpf_prog_terminate(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..f4dcc493b63f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -26,6 +26,7 @@
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
 #include <linux/string_choices.h>
+#include <linux/filter.h>
 
 #include <trace/events/ipi.h>
 #define CREATE_TRACE_POINTS
@@ -49,7 +50,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
 static DEFINE_PER_CPU(atomic_t, trigger_backtrace) = ATOMIC_INIT(1);
 
-static void __flush_smp_call_function_queue(bool warn_cpu_offline);
+static void __flush_smp_call_function_queue(struct pt_regs *regs, bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
 {
@@ -94,7 +95,7 @@ int smpcfd_dying_cpu(unsigned int cpu)
 	 * ensure that the outgoing CPU doesn't go offline with work
 	 * still pending.
 	 */
-	__flush_smp_call_function_queue(false);
+	__flush_smp_call_function_queue(NULL, false);
 	irq_work_run();
 	return 0;
 }
@@ -452,14 +453,15 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
  * Invoked by arch to handle an IPI for call function single.
  * Must be called with interrupts disabled.
  */
-void generic_smp_call_function_single_interrupt(void)
+void generic_smp_call_function_single_interrupt(struct pt_regs *regs)
 {
-	__flush_smp_call_function_queue(true);
+	__flush_smp_call_function_queue(regs, true);
 }
 
 /**
  * __flush_smp_call_function_queue - Flush pending smp-call-function callbacks
  *
+ * @regs : register state when the interrupted the CPU
  * @warn_cpu_offline: If set to 'true', warn if callbacks were queued on an
  *		      offline CPU. Skip this check if set to 'false'.
  *
@@ -471,7 +473,7 @@ void generic_smp_call_function_single_interrupt(void)
  * Loop through the call_single_queue and run all the queued callbacks.
  * Must be called with interrupts disabled.
  */
-static void __flush_smp_call_function_queue(bool warn_cpu_offline)
+static void __flush_smp_call_function_queue(struct pt_regs *regs, bool warn_cpu_offline)
 {
 	call_single_data_t *csd, *csd_next;
 	struct llist_node *entry, *prev;
@@ -536,6 +538,12 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 				entry = &csd_next->node.llist;
 			}
 
+			if (func == bpf_die) {
+				int cpu_id = raw_smp_processor_id();
+				struct bpf_prog *prog = (struct bpf_prog *)info;
+				prog->termination_states->
+					pre_execution_state[cpu_id] = *regs;
+			}
 			csd_lock_record(csd);
 			csd_do_func(func, info, csd);
 			csd_unlock(csd);
@@ -567,8 +575,8 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 				void *info = csd->info;
 
 				csd_lock_record(csd);
-				csd_unlock(csd);
 				csd_do_func(func, info, csd);
+				csd_unlock(csd);
 				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
@@ -612,7 +620,7 @@ void flush_smp_call_function_queue(void)
 	local_irq_save(flags);
 	/* Get the already pending soft interrupts for RT enabled kernels */
 	was_pending = local_softirq_pending();
-	__flush_smp_call_function_queue(true);
+	__flush_smp_call_function_queue(NULL, true);
 	if (local_softirq_pending())
 		do_softirq_post_smp_call_flush(was_pending);
 
-- 
2.43.0


