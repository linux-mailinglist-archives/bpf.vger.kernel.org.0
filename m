Return-Path: <bpf+bounces-62257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E69AF73A0
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D63B1C48ADC
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E12E717D;
	Thu,  3 Jul 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXe0la/V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C72E3AFF;
	Thu,  3 Jul 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545041; cv=none; b=gyvjKQWxjH/PRV1sXYjPDBg6GR+z2JQLJhbTJpDg7kVRdliHddNmmoxrHadtyVkV7Ic6eMCeaupkeQIGGkQjl8sWmYH97hVi99GbAz+IQdiyVd7lU7Dz+owfgLNZz7X0Qw0S/G9ms/XJju3CL8/YzuKsxXyqFbM0dWLh0kkyLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545041; c=relaxed/simple;
	bh=5/8PnfxeHN/Mmaku5UOh8UnVY98f3fyy4BvkmGsOquo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B27PIGbP9rLgomspKR3af0sYme2gzvkyaLVAov+ocDMcbWLZia5QtjTkAUlauTJ2tyAMtKQuJsRaOEJEco+7Kn0LRK6PcJmbn4+flVL5cijwF0fj21zOIufvbcsWUuYoAc32tjrqqt5Eg7CTvhkB6dR5gp5owWq7hWII/myaJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXe0la/V; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-748e81d37a7so5532309b3a.1;
        Thu, 03 Jul 2025 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545039; x=1752149839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28Fo6CyXq4yc2GWt9/Vp97XENzHrxY10ICTZm8f38CM=;
        b=YXe0la/VqV21oPWxWwhmn40LadLFp3UA8nTceptbslLdF9HG+LTihwQAxFTyxKjCGT
         UAzu1CHqXG9uaDc6yxQCJfojIR+QwP1gZTqEuVpbE/7iQp2rG3Sajy0KFgE4+cfAAecl
         z5Nm15wOpCERLfaKW40R/m6qI9wQ0ZTzMMzQyLMujbDCnFr275EYXVhG0HSYUQKVlF07
         /2BwcbHGj2Zffa/xMbPr+x6jIg22kNvkoEDUkeuDWBon1LBnvWQvqDHyVtr4Wt/TdgZ/
         1ceE/Pzg+4raBGHxQzJ4rEmFF27TTgopIhJQN4EocoaL5yd4tUPx/5BXnRJ0ws2Uuakj
         b2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545039; x=1752149839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28Fo6CyXq4yc2GWt9/Vp97XENzHrxY10ICTZm8f38CM=;
        b=W8Q60+P67JU6CbxChT3wolzDzEmhebTINVVOUyT0zfH7/WaV0YE4Cx0z76REkvWSs0
         zSmduMXyWjZvLF63VK9JG/ve7v/bzH/xdzbRNJ8e2iIb6uNsyB1Rz7dB+Ryqi+qvalGh
         ymOjOejjPcR1SBu42hS9a4TBk42lysrl4aej+1sEH676eSOkHEq2zAwkgIcFkuW4ozsS
         wGFsuqLd5XnOVJbowwo59O+iwX71jI7RQehj+icaaYgYX3Oao5XOtXcYrBFLaup51PdA
         04h6aSeAzyv7B04avE+h9Wl38WtG045zaJr62SG9M4C7hC7ncLNZQC4bOtcbYpu3yb9h
         HqSw==
X-Forwarded-Encrypted: i=1; AJvYcCX1fOW12KFgCppd7ETAWwm9MpuFNIwmHSIqconpJrOUZGMYWQByV1t9HMGgOyKS7H91JPFiYkNq@vger.kernel.org, AJvYcCXccVEldhAgFZR6p6U8uhH0qmQ2ViBWlyiJQ6Gq0Cwz2Sg2RIuKGjk4eO2q8GzbIbLPFRmV/uxZjyAnYks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4QBMH4kiQL0cG/gzd0jtLBk9Aq5s7p9erDGtGUpZabjHo7zb
	pLSdnbDmnkoim2yLitZYPaIeev+tMkuiEhDumcghFC4M5L03pXJTkMMM
X-Gm-Gg: ASbGncsn4AX7agpqWW61NkKv+fUC2+SxpnkUH8+msHjNYLd4MmOAnkwLARr7aGz1yqJ
	GBxVUB+BgLW/FB9aVzOy4LybULRrgSGacHv4ockJQN20zKuXQ7dmFeeZjFT3U+rVigJdq3wpnpq
	DeVg2rLdwIODbJm8qUOmvbnUucRLf+nEYLtAtUKln8+QP2S4rno3SlEoGvicNiGZh8q7vaLLyb6
	elLEUnyPoJU3vA5O0mAusjihpl+QOI0ezc61pKZmOllvxa+5zNzy2ZY7Bfua+zJnyu0IkGFQ2gy
	wXubbQgLOwoHTgQBmmgrkeXGgy9zkeHFxAq9cAiQO9ecYJplxS/BDAfYE6Yq3Yv/UzAZ7gRX/5/
	/vTE=
X-Google-Smtp-Source: AGHT+IEM5eV3fRj5yi8hIC5vT84TLtxQ3pa+WK0idFVGhsfh72X37ILc/+Pfo0jc6s2BRG6nQs2fjw==
X-Received: by 2002:a05:6a00:1911:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-74c99821e39mr3892571b3a.7.1751545038589;
        Thu, 03 Jul 2025 05:17:18 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:18 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for global trampoline
Date: Thu,  3 Jul 2025 20:15:05 +0800
Message-Id: <20250703121521.1874196-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the bpf global trampoline "bpf_global_caller" for x86_64. Thanks
to Alexei's advice, we implement most of the global trampoline with C
instead of asm.

We implement the entry of the trampoline with a "__naked" function, who
will save the regs to an array on the stack and call
bpf_global_caller_run(). The entry will pass the address of the array and
the address of the rip to bpf_global_caller_run().

In bpf_global_caller_run(), we will find the metadata by the function ip.
For origin call case, we call kfunc_md_enter() to protect the metadata,
which is similar to __bpf_tramp_enter(). Then we will call all the BPF
progs, just like what BPF trampoline do.

Without origin call, the bpf_global_caller_run() will return 0, and the
entry will restore the regs and return; In origin call case, it will
return 1, and the entry will make the RSP skip the rip before return.

In the FENTRY case, the performance of global trampoline is ~10% slower
than BPF trampoline. The global trampoline is optimized by inline some
function call, such as __bpf_prog_enter_recur and __bpf_prog_exit_recur.
However, more condition, branch and memory read is used in the
bpf_global_caller.

In the FEXIT and MODIFY_RETURN cases, the performance of the global
trampoline is the same(or even better) than BPF trampoline. It make sense,
as we also make the function call to __bpf_tramp_enter and
__bpf_tramp_exit inlined in the bpf_global_caller.

In fact, we can do more optimization to the bpf_global_caller. For
example, we can define more bpf_global_caller_xx_run() function and make
the "if (prog->sleepable)" and "if (do_origin_call)" fixed. It can be done
in a next series. After such optimization, I believe the performance of
FENTRY_MULTI can be closer or the same to FENTRY. And for the
FEXIT/MODIFY_RETURN cases, the performance can be better.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- rewrite the global trampoline with C instead of asm
---
 arch/x86/Kconfig            |   4 +
 arch/x86/net/bpf_jit_comp.c | 268 ++++++++++++++++++++++++++++++++++++
 include/linux/bpf_tramp.h   |  72 ++++++++++
 kernel/bpf/trampoline.c     |  23 +---
 4 files changed, 346 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/bpf_tramp.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..96962c61419a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -155,6 +155,7 @@ config X86
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
+	select ARCH_HAS_BPF_GLOBAL_CALLER	if X86_64
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_WATCHDOG
@@ -432,6 +433,9 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+config ARCH_HAS_BPF_GLOBAL_CALLER
+	bool
+
 menu "Processor type and features"
 
 config SMP
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc..8d2fc436a748 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,6 +11,8 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/bpf_tramp.h>
+#include <linux/kfunc_md.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -3413,6 +3415,272 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret;
 }
 
+#define FUNC_ARGS_0		((2 - 1) * 8)
+#define FUNC_ARGS_1		((2 + 0) * 8)
+#define FUNC_ARGS_2		((2 + 1) * 8)
+#define FUNC_ARGS_3		((2 + 2) * 8)
+#define FUNC_ARGS_4		((2 + 3) * 8)
+#define FUNC_ARGS_5		((2 + 4) * 8)
+#define FUNC_ARGS_6		((2 + 5) * 8)
+
+#define SAVE_ARGS_0
+#define SAVE_ARGS_1						\
+	"movq %rdi, " __stringify(FUNC_ARGS_1) "(%rsp)\n"
+#define SAVE_ARGS_2 SAVE_ARGS_1					\
+	"movq %rsi, " __stringify(FUNC_ARGS_2) "(%rsp)\n"
+#define SAVE_ARGS_3 SAVE_ARGS_2					\
+	"movq %rdx, " __stringify(FUNC_ARGS_3) "(%rsp)\n"
+#define SAVE_ARGS_4 SAVE_ARGS_3					\
+	"movq %rcx, " __stringify(FUNC_ARGS_4) "(%rsp)\n"
+#define SAVE_ARGS_5 SAVE_ARGS_4					\
+	"movq %r8, " __stringify(FUNC_ARGS_5) "(%rsp)\n"
+#define SAVE_ARGS_6 SAVE_ARGS_5					\
+	"movq %r9, " __stringify(FUNC_ARGS_6) "(%rsp)\n"	\
+
+#define RESTORE_ARGS_0
+#define RESTORE_ARGS_1						\
+	"movq " __stringify(FUNC_ARGS_1) "(%rsp), %rdi\n"
+#define RESTORE_ARGS_2 RESTORE_ARGS_1				\
+	"movq " __stringify(FUNC_ARGS_2) "(%rsp), %rsi\n"
+#define RESTORE_ARGS_3 RESTORE_ARGS_2				\
+	"movq " __stringify(FUNC_ARGS_3) "(%rsp), %rdx\n"
+#define RESTORE_ARGS_4 RESTORE_ARGS_3				\
+	"movq " __stringify(FUNC_ARGS_4) "(%rsp), %rcx\n"
+#define RESTORE_ARGS_5 RESTORE_ARGS_4				\
+	"movq " __stringify(FUNC_ARGS_5) "(%rsp), %r8\n"
+#define RESTORE_ARGS_6 RESTORE_ARGS_5				\
+	"movq " __stringify(FUNC_ARGS_6) "(%rsp), %r9\n"
+
+#define RESTORE_ORIGIN_0
+#define RESTORE_ORIGIN_1						\
+	"movq " __stringify(FUNC_ARGS_1 - FUNC_ARGS_1) "(%[args]), %%rdi\n"
+#define RESTORE_ORIGIN_2 RESTORE_ORIGIN_1				\
+	"movq " __stringify(FUNC_ARGS_2 - FUNC_ARGS_1) "(%[args]), %%rsi\n"
+#define RESTORE_ORIGIN_3 RESTORE_ORIGIN_2				\
+	"movq " __stringify(FUNC_ARGS_3 - FUNC_ARGS_1) "(%[args]), %%rdx\n"
+#define RESTORE_ORIGIN_4 RESTORE_ORIGIN_3				\
+	"movq " __stringify(FUNC_ARGS_4 - FUNC_ARGS_1) "(%[args]), %%rcx\n"
+#define RESTORE_ORIGIN_5 RESTORE_ORIGIN_4				\
+	"movq " __stringify(FUNC_ARGS_5 - FUNC_ARGS_1) "(%[args]), %%r8\n"
+#define RESTORE_ORIGIN_6 RESTORE_ORIGIN_5				\
+	"movq " __stringify(FUNC_ARGS_6 - FUNC_ARGS_1) "(%[args]), %%r9\n"
+
+static __always_inline void
+do_origin_call(unsigned long *args, unsigned long *ip, int nr_args)
+{
+	/* Following code will be optimized by the compiler, as nr_args
+	 * is a const, and there will be no condition here.
+	 */
+	if (nr_args == 0) {
+		asm volatile(
+			RESTORE_ORIGIN_0 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			:
+		);
+	} else if (nr_args == 1) {
+		asm volatile(
+			RESTORE_ORIGIN_1 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			: "rdi"
+		);
+	} else if (nr_args == 2) {
+		asm volatile(
+			RESTORE_ORIGIN_2 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			: "rdi", "rsi"
+		);
+	} else if (nr_args == 3) {
+		asm volatile(
+			RESTORE_ORIGIN_3 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			: "rdi", "rsi", "rdx"
+		);
+	} else if (nr_args == 4) {
+		asm volatile(
+			RESTORE_ORIGIN_4 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			: "rdi", "rsi", "rdx", "rcx"
+		);
+	} else if (nr_args == 5) {
+		asm volatile(
+			RESTORE_ORIGIN_5 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			: "rdi", "rsi", "rdx", "rcx", "r8"
+		);
+	} else if (nr_args == 6) {
+		asm volatile(
+			RESTORE_ORIGIN_6 CALL_NOSPEC "\n"
+			"movq %%rax, %0\n"
+			: "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
+			: [args]"r"(args), [thunk_target]"r"(*ip)
+			: "rdi", "rsi", "rdx", "rcx", "r8", "r9"
+		);
+	}
+}
+
+static __always_inline notrace void
+run_tramp_prog(struct kfunc_md_tramp_prog *tramp_prog,
+	       struct bpf_tramp_run_ctx *run_ctx, unsigned long *args)
+{
+	struct bpf_prog *prog;
+	u64 start_time;
+
+	while (tramp_prog) {
+		prog = tramp_prog->prog;
+		run_ctx->bpf_cookie = tramp_prog->cookie;
+		start_time = bpf_gtramp_enter(prog, run_ctx);
+
+		if (likely(start_time)) {
+			asm volatile(
+				CALL_NOSPEC "\n"
+				: : [thunk_target]"r"(prog->bpf_func), [args]"D"(args)
+			);
+		}
+
+		bpf_gtramp_exit(prog, start_time, run_ctx);
+		tramp_prog = tramp_prog->next;
+	}
+}
+
+static __always_inline notrace int
+bpf_global_caller_run(unsigned long *args, unsigned long *ip, int nr_args)
+{
+	unsigned long origin_ip = (*ip) & 0xfffffffffffffff0; // Align to 16 bytes
+	struct kfunc_md_tramp_prog *tramp_prog;
+	struct bpf_tramp_run_ctx run_ctx;
+	struct kfunc_md *md;
+	bool do_orgin;
+
+	rcu_read_lock();
+	md = kfunc_md_get_rcu(origin_ip);
+	do_orgin = md->bpf_origin_call;
+	if (do_orgin)
+		kfunc_md_enter(md);
+	rcu_read_unlock();
+
+	/* save the origin function ip for bpf_get_func_ip() */
+	*(args - 2) = origin_ip;
+	*(args - 1) = nr_args;
+
+	run_tramp_prog(md->bpf_progs[BPF_TRAMP_FENTRY], &run_ctx, args);
+
+	/* no fexit and modify_return, return directly */
+	if (!do_orgin)
+		return 0;
+
+	/* modify return case */
+	tramp_prog = md->bpf_progs[BPF_TRAMP_MODIFY_RETURN];
+	/* initialize return value */
+	args[nr_args] = 0;
+	while (tramp_prog) {
+		struct bpf_prog *prog;
+		u64 start_time, ret;
+
+		prog = tramp_prog->prog;
+		run_ctx.bpf_cookie = tramp_prog->cookie;
+		start_time = bpf_gtramp_enter(prog, &run_ctx);
+
+		if (likely(start_time)) {
+			asm volatile(
+				CALL_NOSPEC "\n"
+				: "=a"(ret), ASM_CALL_CONSTRAINT
+				: [thunk_target]"r"(prog->bpf_func),
+				  [args]"D"(args)
+			);
+			args[nr_args] = ret;
+		} else {
+			ret = 0;
+		}
+
+		bpf_gtramp_exit(prog, start_time, &run_ctx);
+		if (ret)
+			goto do_fexit;
+		tramp_prog = tramp_prog->next;
+	}
+
+	/* restore the function arguments and call the origin function */
+	do_origin_call(args, ip, nr_args);
+do_fexit:
+	run_tramp_prog(md->bpf_progs[BPF_TRAMP_FEXIT], &run_ctx, args);
+	kfunc_md_exit(md);
+	return 1;
+}
+
+/* Layout of the stack frame:
+ *   rip		----> 8 bytes
+ *   return value	----> 8 bytes
+ *   args		----> 8 * 6 bytes
+ *   arg count		----> 8 bytes
+ *   origin ip		----> 8 bytes
+ */
+#define stack_size __stringify(8 + 8 + 6 * 8 + 8)
+
+#define CALLER_DEFINE(name, nr_args)					\
+static __always_used __no_stack_protector notrace int			\
+name##_run(unsigned long *args, unsigned long *ip)			\
+{									\
+	return bpf_global_caller_run(args, ip, nr_args);		\
+}									\
+static __naked void name(void)						\
+{									\
+	asm volatile(							\
+		"subq $" stack_size ", %rsp\n"				\
+		SAVE_ARGS_##nr_args					\
+	);								\
+									\
+	asm volatile(							\
+		"leaq " __stringify(FUNC_ARGS_1) "(%rsp), %rdi\n"	\
+		"leaq " stack_size "(%rsp), %rsi\n"			\
+		"call " #name "_run\n"					\
+		"test %rax, %rax\n"					\
+		"jne 1f\n"						\
+	);								\
+									\
+	asm volatile(							\
+		RESTORE_ARGS_##nr_args					\
+		"addq $" stack_size ", %rsp\n"				\
+		ASM_RET							\
+	);								\
+									\
+	asm volatile(							\
+		"1:\n"							\
+		"movq " __stringify(FUNC_ARGS_##nr_args + 8)		\
+		"(%rsp), %rax\n"					\
+		"addq $(" stack_size " + 8), %rsp\n"			\
+		ASM_RET);						\
+}									\
+STACK_FRAME_NON_STANDARD(name)
+
+CALLER_DEFINE(bpf_global_caller_0, 0);
+CALLER_DEFINE(bpf_global_caller_1, 1);
+CALLER_DEFINE(bpf_global_caller_2, 2);
+CALLER_DEFINE(bpf_global_caller_3, 3);
+CALLER_DEFINE(bpf_global_caller_4, 4);
+CALLER_DEFINE(bpf_global_caller_5, 5);
+CALLER_DEFINE(bpf_global_caller_6, 6);
+
+void *bpf_gloabl_caller_array[MAX_BPF_FUNC_ARGS + 1] = {
+	bpf_global_caller_0,
+	bpf_global_caller_1,
+	bpf_global_caller_2,
+	bpf_global_caller_3,
+	bpf_global_caller_4,
+	bpf_global_caller_5,
+	bpf_global_caller_6,
+};
+
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
 {
 	u8 *jg_reloc, *prog = *pprog;
diff --git a/include/linux/bpf_tramp.h b/include/linux/bpf_tramp.h
new file mode 100644
index 000000000000..32447fcfc017
--- /dev/null
+++ b/include/linux/bpf_tramp.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_BPF_TRAMP_H__
+#define __LINUX_BPF_TRAMP_H__
+#ifdef CONFIG_BPF_JIT
+#include <linux/filter.h>
+
+#ifdef CONFIG_ARCH_HAS_BPF_GLOBAL_CALLER
+extern void *bpf_gloabl_caller_array[MAX_BPF_FUNC_ARGS + 1];
+#endif
+
+void notrace __update_prog_stats(struct bpf_prog *prog, u64 start);
+
+#define NO_START_TIME 1
+static __always_inline u64 notrace bpf_prog_start_time(void)
+{
+	u64 start = NO_START_TIME;
+
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
+		start = sched_clock();
+		if (unlikely(!start))
+			start = NO_START_TIME;
+	}
+	return start;
+}
+
+static __always_inline void notrace update_prog_stats(struct bpf_prog *prog,
+						      u64 start)
+{
+	if (static_branch_unlikely(&bpf_stats_enabled_key))
+		__update_prog_stats(prog, start);
+}
+
+static __always_inline u64 notrace
+bpf_gtramp_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
+	__acquires(RCU)
+{
+	if (unlikely(prog->sleepable)) {
+		rcu_read_lock_trace();
+		might_fault();
+	} else {
+		rcu_read_lock();
+	}
+	migrate_disable();
+
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+
+	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+		bpf_prog_inc_misses_counter(prog);
+		if (prog->aux->recursion_detected)
+			prog->aux->recursion_detected(prog);
+		return 0;
+	}
+	return bpf_prog_start_time();
+}
+
+static __always_inline void notrace
+bpf_gtramp_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
+	__releases(RCU)
+{
+	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+
+	update_prog_stats(prog, start);
+	this_cpu_dec(*(prog->active));
+	migrate_enable();
+	if (unlikely(prog->sleepable))
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock();
+}
+
+#endif
+#endif
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b1e358c16eeb..fa90c225c93b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/bpf_tramp.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -868,19 +869,6 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
-#define NO_START_TIME 1
-static __always_inline u64 notrace bpf_prog_start_time(void)
-{
-	u64 start = NO_START_TIME;
-
-	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
-		start = sched_clock();
-		if (unlikely(!start))
-			start = NO_START_TIME;
-	}
-	return start;
-}
-
 /* The logic is similar to bpf_prog_run(), but with an explicit
  * rcu_read_lock() and migrate_disable() which are required
  * for the trampoline. The macro is split into
@@ -911,7 +899,7 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 	return bpf_prog_start_time();
 }
 
-static void notrace __update_prog_stats(struct bpf_prog *prog, u64 start)
+void notrace __update_prog_stats(struct bpf_prog *prog, u64 start)
 {
 	struct bpf_prog_stats *stats;
 	unsigned long flags;
@@ -932,13 +920,6 @@ static void notrace __update_prog_stats(struct bpf_prog *prog, u64 start)
 	u64_stats_update_end_irqrestore(&stats->syncp, flags);
 }
 
-static __always_inline void notrace update_prog_stats(struct bpf_prog *prog,
-						      u64 start)
-{
-	if (static_branch_unlikely(&bpf_stats_enabled_key))
-		__update_prog_stats(prog, start);
-}
-
 static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 					  struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
-- 
2.39.5


