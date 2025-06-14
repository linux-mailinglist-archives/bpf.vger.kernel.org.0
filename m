Return-Path: <bpf+bounces-60662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7CCAD9A7B
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 08:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF195189ED3A
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584041E493C;
	Sat, 14 Jun 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI5BgUKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F701E378C
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883306; cv=none; b=sFmLHKt95XhNSxFBbX3nNocqsdUunSqfBzx2Zvz/aqTcbTpCsnZO2pYeDdZ2x3y4nY0VFH2WaO3j7nY15bJ9s+LrkLu170bbRCaNlLp93b/wMPsMl5eJqkRSlK8SGkoJ8zUBN70B9bdYySjfZUXl7iyOdJTGsnS2RgGmatix0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883306; c=relaxed/simple;
	bh=dEnWM4+Tz0OO2c9ScoGyzbhOXlM3j6LNvTaoOn9q+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUoPWHKe1yf8TLJsPKtfkktu2S8SA7k70iOAvsHm51zM3MwKXKTmeV09UFrxoedPYvDELxL90e/C0UG/Qrdm7bA3+IPMhsxz9Vq2HkslzHMb/Qhzd+NTtzMJoVXqlDmPby8kJCFCv5pvyq2+GZpFbcgrm3D9Ury6Ztg2g7FO3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI5BgUKf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2380160b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 23:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749883304; x=1750488104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0g832+h+I9cdEDWNpDO0GIbr3VODOA2GlOM93ezp9s=;
        b=DI5BgUKft3TczKTs2OOMWy7hy9VXZVwGFPAbWEHqetUM6cmMcGHvc2MlJph2oCtSHo
         fGGTNWrrpX9rjoU1Jo7oI5sWvKspWNckXuxivJVzj7BzyeRZaE6dXo186FiCtHMs64Nx
         IZbo4HiUa52WKe8fsNNTFgzhy6xPz3Vf5u7a5kUU//BqN8GWiWf0WlyPiv5M5M0/+scZ
         vOWFBVpva05VnA14TtmOEayISy0KPqhkcjdNHhqOD1GGcStu1ZWVKwpcljOeBF8reC4S
         KJxpSJ2D2YPsiUKfvLwSZNTTMpuPfgjARpmFXU6+dDoicqfushgimPqOQBjq5bkPnWum
         0pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749883304; x=1750488104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0g832+h+I9cdEDWNpDO0GIbr3VODOA2GlOM93ezp9s=;
        b=h34QrQfvsQY1HlofYDc9KNLJ762BCYs816wrd9wkJH6FQSqfCdDwzw0STmRBxBqFgG
         t3CYRE/+vBRlqEL3XbRAyXldhuJ9MRz7f/ObGMo3Fu4GB+JerhtoG1G3UHgj3l88nd5E
         5aHsOS6WMYp4CHOrnS8XFQQ/U2HyaxIccF/S5/YYdOIS91JCKCUuk5GoIX8lm1jJ23YM
         bYeia6/0ukpLzN0dK/vXBUdpdYS+1dG5Jb4LhOmEgpLM5hMwax2Tza+fTbChjC+XmMa0
         E72dGqJIk5Ka02GOTgdhnfTOGdC8Qcg1Q5c3RKgwzEAO2UgTzPoxCM4sPJYxUWX8K8mA
         kTtQ==
X-Gm-Message-State: AOJu0YyrLUV8AzTQumk5ajgpo5rKs2UDckNU/56fn+fQjwJX/RFXoiZD
	LHsPbu4qvRr82hAwV9TxFiwr7+zk7pDsUziCIqu1XIvV7/3PuHBLoiIq3DijskOD
X-Gm-Gg: ASbGncvnuaqhCR5o237xtUDhw1i8T1JY+MAMfQI8rbzVjhpiXibljIkfiOXEBSn3T0D
	6zpawj4+MHZWCV7Y3OBrjVSN6Od2Y5NFdrnN8Y2+Y9BxLI1V42CdzWgIOVTbM9OhsmdUi3FELx0
	z3aak3ZTEsDXEoKqRamalZUUnjyuLiixfC9kRE+uCBZs3ZVCjx5BMHl8Yw4roLqIyTuvZOB5/ZQ
	gZpnK3ouDpKhJtuEdJRVGErLhycKnExJ1KqBhsV7zHcEWaixhsi9FxKLh0DuykuHJmNMNWCKbpU
	nTTLwIH7l4BkE936caE0BgrRd3RRXRYNDAh8tY7dE/YQEvArrOK4iq1cYXqOHZrR2vND6wOh/HO
	71ha1MtO5oyn3/Lcwic3GEMf+amo1hegCHiWcki37thuQ6A1KtvRU+N/ILN8BJ+A=
X-Google-Smtp-Source: AGHT+IFLOyt5DbUOiHQMUW/pc0UvN5uK5F/BXJn3ndy4rJtOEZh0U4GCfcsn8wx9In8/tGjyVR+uYQ==
X-Received: by 2002:a05:6a00:2d20:b0:748:3485:b99d with SMTP id d2e1a72fcca58-7489cfd3197mr2835100b3a.18.1749883304079;
        Fri, 13 Jun 2025 23:41:44 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([20.120.208.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083ba7sm2812124b3a.102.2025.06.13.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 23:41:43 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
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
	egor@vt.edu,
	sairoop10@gmail.com,
	Raj Sahu <rjsu26@gmail.com>
Subject: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
Date: Sat, 14 Jun 2025 06:40:55 +0000
Message-ID: <20250614064056.237005-4-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250614064056.237005-1-sidchintamaneni@gmail.com>
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces watchdog based runtime mechanism to terminate
a BPF program. When a BPF program is interrupted by
an watchdog, its registers are are passed onto the bpf_die.

Inside bpf_die we perform the text_poke and stack walk
to stub helpers/kfunc replace bpf_loop helper if called
inside bpf program.

Current implementation doesn't handle the termination of
tailcall programs.

There is a known issue by calling text_poke inside interrupt
context - https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815.

Please let us know if you have any suggestions around this?

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 include/linux/bpf.h     |   1 +
 include/linux/filter.h  |  41 +++++++-
 kernel/bpf/core.c       |  15 +++
 kernel/bpf/syscall.c    | 206 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c |   5 +
 5 files changed, 267 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1c534b3e10d8..5dd0f06bbf02 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1547,6 +1547,7 @@ struct cpu_aux {
 
 struct bpf_term_aux_states {
 	struct bpf_prog *patch_prog;
+	struct bpf_prog *prog;
 	struct cpu_aux *per_cpu_state;
 	struct hrtimer hrtimer;
 };
diff --git a/include/linux/filter.h b/include/linux/filter.h
index cd9f1c2727ec..921d2318bcf7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -689,11 +689,40 @@ extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
 				     const struct bpf_reg_state *reg,
 				     int off, int size);
 
+void bpf_die(void *data);
+
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  const struct bpf_insn *insnsi,
 					  unsigned int (*bpf_func)(const void *,
 								   const struct bpf_insn *));
 
+static void update_term_per_cpu_flag(const struct bpf_prog *prog, u8 cpu_flag)
+{
+	unsigned long flags;
+	u32 cpu_id = raw_smp_processor_id();
+	spin_lock_irqsave(&prog->term_states->per_cpu_state[cpu_id].lock, 
+				flags);
+	prog->term_states->per_cpu_state[cpu_id].cpu_flag = cpu_flag;
+	spin_unlock_irqrestore(&prog->term_states->per_cpu_state[cpu_id].lock,
+				flags);
+}
+
+static void bpf_terminate_timer_init(const struct bpf_prog *prog)
+{
+	ktime_t timeout = ktime_set(1, 0); // 1s, 0ns
+
+	/* Initialize timer on Monotonic clock, relative mode */
+	hrtimer_setup(&prog->term_states->hrtimer, bpf_termination_wd_callback, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	/* Start watchdog */
+	hrtimer_start(&prog->term_states->hrtimer, timeout, HRTIMER_MODE_REL);
+}
+
+static void bpf_terminate_timer_cancel(const struct bpf_prog *prog)
+{
+	hrtimer_cancel(&prog->term_states->hrtimer);  
+}
+
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
 					  bpf_dispatcher_fn dfunc)
@@ -706,7 +735,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 		u64 duration, start = sched_clock();
 		unsigned long flags;
 
+		update_term_per_cpu_flag(prog, 1);
+		bpf_terminate_timer_init(prog);
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		bpf_terminate_timer_cancel(prog);
+		update_term_per_cpu_flag(prog, 0);
 
 		duration = sched_clock() - start;
 		stats = this_cpu_ptr(prog->stats);
@@ -715,8 +748,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 		u64_stats_add(&stats->nsecs, duration);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	} else {
+		update_term_per_cpu_flag(prog, 1);
+		bpf_terminate_timer_init(prog);
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
-	}
+		bpf_terminate_timer_cancel(prog);
+		update_term_per_cpu_flag(prog, 0);}
 	return ret;
 }
 
@@ -1119,6 +1155,9 @@ int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
 bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
 
+#ifdef CONFIG_X86_64
+int bpf_loop_termination(u32 nr_loops, void *callback_fn, void *callback_ctx, u64 flags);
+#endif
 int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx);
 void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2a02e9cafd5a..735518735779 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1583,6 +1583,21 @@ noinline int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx)
 }
 EXPORT_SYMBOL_GPL(bpf_loop_term_callback);
 
+#ifdef CONFIG_X86_64
+noinline int bpf_loop_termination(u32 nr_loops, void *callback_fn, void *callback_ctx, u64 flags)
+{
+	asm volatile(
+		"pop %rbx\n\t"
+		"pop %rbp\n\t"
+		"pop %r12\n\t"
+		"pop %r13\n\t"
+	);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bpf_loop_termination);
+STACK_FRAME_NON_STANDARD(bpf_loop_termination);
+#endif
+
 /* Base function for offset calculation. Needs to go into .text section,
  * therefore keeping it non-static as well; will also be used by JITs
  * anyway later on, so do not let the compiler omit it. This also needs
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cd8e7c47e3fe..065767ae1bd1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -37,6 +37,10 @@
 #include <linux/trace_events.h>
 #include <linux/tracepoint.h>
 #include <linux/overflow.h>
+#include <asm/unwind.h>
+#include <asm/insn.h>
+#include <asm/text-patching.h>
+#include <asm/irq_regs.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2767,6 +2771,207 @@ static int sanity_check_jit_len(struct bpf_prog *prog)
 	return 0;
 }
 
+static bool per_cpu_flag_is_true(struct bpf_term_aux_states *term_states, int cpu_id)
+{
+	unsigned long flags;
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
+static int is_bpf_address(struct bpf_prog *prog, unsigned long addr) 
+{
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
+/* 
+ * For a call instruction in a BPF program, return the stubbed insn buff.
+ * Returns new instruction buff if stubbing required,
+ *	   NULL if no change needed.
+ */
+__always_inline char* find_termination_realloc(struct insn orig_insn, unsigned char *orig_addr, 
+					       struct insn patch_insn, unsigned char *patch_addr) {
+
+	unsigned long new_target;
+	unsigned long original_call_target = (unsigned long)orig_addr + 5 + orig_insn.immediate.value;
+
+	unsigned long patch_call_target = (unsigned long)patch_addr + 5 + patch_insn.immediate.value;
+
+	/* As per patch prog, no stubbing needed. */
+	if (patch_call_target == original_call_target)
+		return NULL;
+
+	/* bpf_termination_null_func is the generic stub function unless its either of
+	* the bpf_loop helper or the associated callback
+	*/
+	new_target = (unsigned long)bpf_termination_null_func;
+	if (patch_call_target == (unsigned long)bpf_loop_term_callback)
+		new_target = (unsigned long)bpf_loop_term_callback;
+	
+
+	unsigned long new_rel = (unsigned long)(new_target - (unsigned long)(orig_addr + 5));
+
+	char *new_insn = kmalloc(5, GFP_KERNEL);
+	new_insn[0] = 0xE8;
+	new_insn[1] = (new_rel >> 0) & 0xff;
+	new_insn[2] = (new_rel >> 8) & 0xff;
+	new_insn[3] = (new_rel >> 16) & 0xff;
+	new_insn[4] = (new_rel >> 24) & 0xff;
+
+ 	return new_insn;
+}
+
+/* 
+ * Given a bpf program and a corresponding termination patch prog
+ * (generated during verification), this program will patch all
+ * call instructions in prog and decide whether to stub them
+ * based on whether the termination_prog has stubbed or not.
+ */
+static void __maybe_unused in_place_patch_bpf_prog(struct bpf_prog *prog, struct bpf_prog *patch_prog){
+
+       uint32_t size = 0;
+  
+       while (size < prog->jited_len) {
+	       unsigned char *addr = (unsigned char*)prog->bpf_func;
+	       unsigned char *addr_patch = (unsigned char*)patch_prog->bpf_func;
+
+	       struct insn insn;
+	       struct insn insn_patch;
+
+	       addr += size;
+	       /* Decode original instruction */
+               if (WARN_ON_ONCE(insn_decode_kernel(&insn, addr))) {
+	       		return;
+               }
+
+               /* Check for call instruction */
+               if (insn.opcode.bytes[0] != CALL_INSN_OPCODE) {
+                       goto next_insn;  
+               }
+  
+	       addr_patch += size;
+	       /* Decode patch_prog instruction */
+               if (WARN_ON_ONCE(insn_decode_kernel(&insn_patch, addr_patch))) {
+	       		return ;
+               }
+
+	       // Stub the call instruction if needed
+	       char *buf;
+	       if ((buf = find_termination_realloc(insn, addr, insn_patch, addr_patch)) != NULL) {
+		       smp_text_poke_batch_add(addr, buf, insn.length, NULL);
+		       kfree(buf);
+	       }
+               
+       next_insn:
+               size += insn.length;
+       }       
+}
+
+
+void bpf_die(void *data)
+{
+	struct bpf_prog *prog, *patch_prog;
+	int cpu_id = raw_smp_processor_id();
+
+	prog = (struct bpf_prog *)data;
+	patch_prog = prog->term_states->patch_prog;
+
+	if (!per_cpu_flag_is_true(prog->term_states, cpu_id))
+		return;
+
+	unsigned long jmp_offset = prog->jited_len - (4 /*First endbr is 4 bytes*/
+						+ 5 /*5 bytes of noop*/ 
+						+ 5 /*5 bytes of jmp return_thunk*/);
+	char new_insn[5];
+	new_insn[0] = 0xE9;
+	new_insn[1] = (jmp_offset >> 0) & 0xff;
+	new_insn[2] = (jmp_offset >> 8) & 0xff;
+	new_insn[3] = (jmp_offset >> 16) & 0xff;
+	new_insn[4] = (jmp_offset >> 24) & 0xff;
+	smp_text_poke_batch_add(prog->bpf_func + 4, new_insn, 5, NULL);
+
+	/* poke all progs and subprogs */
+	if (prog->aux->func_cnt) {
+		for(int i=0; i<prog->aux->func_cnt; i++){
+			in_place_patch_bpf_prog(prog->aux->func[i], patch_prog->aux->func[i]);
+		}
+	} else {
+		in_place_patch_bpf_prog(prog, patch_prog);
+	}
+	/* flush all text poke calls */
+	smp_text_poke_batch_finish();
+
+
+ #ifdef CONFIG_X86_64
+	struct unwind_state state;
+	unsigned long addr, bpf_loop_addr, bpf_loop_term_addr;
+	struct pt_regs *regs = get_irq_regs();
+	char str[KSYM_SYMBOL_LEN];
+	bpf_loop_addr = (unsigned long)bpf_loop_proto.func;
+	bpf_loop_term_addr = (unsigned long)bpf_loop_termination;
+	unwind_start(&state, current, regs, NULL);
+
+	addr = unwind_get_return_address(&state);
+
+	unsigned long stack_addr = regs->sp;
+	while (addr) {
+		if (is_bpf_address(prog, addr)) {
+			break;
+		} else {
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
+#endif
+
+	return;
+}
+
+enum hrtimer_restart bpf_termination_wd_callback(struct hrtimer *hr)
+{
+
+	struct bpf_term_aux_states *term_states = container_of(hr, struct bpf_term_aux_states, hrtimer);
+	struct bpf_prog *prog = term_states->prog;
+	bpf_die(prog);
+	return HRTIMER_NORESTART;
+
+}
+EXPORT_SYMBOL_GPL(bpf_termination_wd_callback);
+
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
@@ -2995,6 +3200,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	err = sanity_check_jit_len(prog);
 	if (err < 0)
 		goto free_used_maps;
+	prog->term_states->prog = prog;
 
 	err = bpf_prog_alloc_id(prog);
 	if (err)
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c4b1a98ff726..16f685c861a3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -908,6 +908,9 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 			prog->aux->recursion_detected(prog);
 		return 0;
 	}
+
+	update_term_per_cpu_flag(prog, 1);
+	bpf_terminate_timer_init(prog);
 	return bpf_prog_start_time();
 }
 
@@ -941,6 +944,8 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
+	bpf_terminate_timer_cancel(prog);
+	update_term_per_cpu_flag(prog, 0);
 	this_cpu_dec(*(prog->active));
 	migrate_enable();
 	rcu_read_unlock();
-- 
2.43.0


