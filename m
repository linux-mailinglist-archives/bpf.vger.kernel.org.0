Return-Path: <bpf+bounces-59094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96599AC604F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAB9E7588
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03EA207DFE;
	Wed, 28 May 2025 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM0fgQvf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC61FAC4B;
	Wed, 28 May 2025 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404190; cv=none; b=il+M48ksbThwQazPzf6IWIpUl6Jas+RvNmAglIWBXdwKBt771aYtvCnhEl1zeyLathxHr7/AM5QBato+Tmna/i/CpDEQAUPmlUJQ8rpk2lACvk2u6/yVCThaUmsHyGq49UW7WLsM5LX+fBB52eMt8XPp8c8hqcYytSDK+7LqEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404190; c=relaxed/simple;
	bh=yDOTdN1geg/TbHZc+fDhUVZt5n0IxaqnyAa52LAD0ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZAC+BbAVsE65yeAiV96MbdhPgFh1f4/2qZlvTpmInQIUKkIKWG6bd/6LqFjAmJaTBZbMUI5ModWTLhiGCmMOi6LQZe8sD/z0BglxuuCjVtCvdf0bIHDttzxfhOdhJ71FklkIINk5iwWx2iFIoA818fk/XHjVk4i6VIzIhTIs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM0fgQvf; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-23278ce78efso28586395ad.2;
        Tue, 27 May 2025 20:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404187; x=1749008987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqTzPgLr+m5glEqqQjNvOSOGxBWQn19GNEWF6ihzcEE=;
        b=hM0fgQvf4jYg/3V90PzRKWNvs/NYPyF2fYku+am1OuxEeBYLvr7ycWcpRCPAoy9u9R
         k/Iw/45Yj7tkS55NimEYIryxfV+ZTLl74uMXLYK6VWWxhwIhVHZJhF+w785Jbrpl034A
         HCXGyxbmXrFmn3IKXg3CxMytpFDpDE6VDN24ZZoS46jAzWz8+vjMnZzWNO/uFaoCjJLZ
         WFoo/6E/bz4BVUK/etQmpsQXHMJ8+VG++ZD4UtTYO1ruGJmYF56jSpB1uiIM7cJ5abMG
         FR7yN4V1q91JKjUQNzZZbrDTmOTHw/5H1LyEKwbd5PAgKoTw0axbVpItLZORfoWqAaSa
         8z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404187; x=1749008987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqTzPgLr+m5glEqqQjNvOSOGxBWQn19GNEWF6ihzcEE=;
        b=hXikZXKz748zT6HwvCZrHPHxWkt1R1oi5Tj7a7yMs28tWwn5eSuSxa6r/Si2VKVlKM
         BgUnt/N5onn4z2EcTwfxB3ISErcszBy74xhK768tvitEXMdCmIg296iHPvq3X8ibdr/q
         kgwVT1cmxO+5fAZyouVBEruBS5smryOpcRq2XynI1BczFvkSBH6T8+q+WoeqLOOUNK3r
         /CK1mgGVM9yvGF/HFVtkdtrYvtGYGfpCY6xcgX0GLXUGb/Z09/Ey3D9KZ/1+AgfUNViG
         dngjrL1FUrEzgKByz4kePB51nifts6HjTjMROXNS9I0iKsrLhGNFbjm4nXuzaWk/5x7F
         ANqg==
X-Forwarded-Encrypted: i=1; AJvYcCUBkI8mFwg+oCUlSjidUewL7/Vr4/EmOPseJ0rifIGEJEBktZTxq3w8r85u94QHR+7OZROGL1QvIClVEAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTHlXhAKTazuiHkNBNT5Dn+x1WI+hE8uRR+jNJx37+GNJFz55
	bzggUuMbqg4WunmI8xywTHtA0NZVjj1nHfBjoOQ/4E6WruuGd8dqC8Xe
X-Gm-Gg: ASbGncuOLorDBwKh8GOsU4rxvqHPxPYUnor4LScDRN63OWVqxnY4z6N7E04YlO9zG3a
	fVsaiu6yr7OgQZdQn5Nt+oIC3ex0evcUQSEd/eRmHw91RSYgMw5Cymo5rr6IavZv2owK3iAgRp2
	jLJgWU8xueqU9rhCWNKWaVVxJHTCK+wjeRXL7xIGMeQ8Yso5EMECUt4Nnr4SbY0Z7M6wX4COgqP
	boxjf9YvxqW/4ILE8m3k6ncXtVnCEsPFVasbEg936Cj3FmH5X2niijKNp6juwFTtz+jBXd0SDD2
	qI9fKfYjCewv7jVLGzy++WvFZpaPZUMk8CrWsebZZCQrMp6miaKcxM46RE8inJETJriM
X-Google-Smtp-Source: AGHT+IGdQntgd4Zc/Jhr6r4tuWsvlozIWuOfn03xxWPEcd5HkuvUovYpYC60uVO9F3+QdLAtAPYREg==
X-Received: by 2002:a17:903:32c8:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23414f9f230mr244494005ad.29.1748404187451;
        Tue, 27 May 2025 20:49:47 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 05/25] x86,bpf: add bpf_global_caller for global trampoline
Date: Wed, 28 May 2025 11:46:52 +0800
Message-Id: <20250528034712.138701-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the bpf global trampoline "bpf_global_caller" for x86_64. The
logic of it is similar to the bpf trampoline:

1. save the regs for function args. For now, only the function with args
   count no more than 6 is supported
2. save rbx and r12, which will be used to store the prog list and return
   value of __bpf_prog_enter_recur
3. get the origin function address on the stack. To get the real function
   address, we make it "&= $0xfffffffffffffff0", as it is always 16-bytes
   aligned
4. get the function metadata by calling kfunc_md_get_noref()
5. get the function args count from the kfunc_md and store it on the
   stack.
6. get the kfunc_md flags and store it on the stack. Call kfunc_md_enter()
   if origin call is needed
7. get the prog list for FENTRY, and run all the progs in the list with
   bpf_caller_prog_run
8. goto the end if origin call is not necessary
9. get the prog list for MODIFY_RETURN, and run all the progs in the list
   with bpf_caller_prog_run
10.restore the regs and do the origin call. We get the ip of the origin
   function by the rip in the stack
11.save the return value of the origin call to the stack.
12.get the prog list for FEXIT, and run all the progs in the list with
   bpf_caller_prog_run
13.restore rbx, r12, r13. In order to rebalance the RSB, we call
   bpf_global_caller_rsb here.

Indirect call is used in bpf_caller_prog_run, as we load and call the
function address from the stack in the origin call case. What's more, we
get the bpf progs from the kfunc_md and call it indirectly. We make the
indirect call with CALL_NOSPEC, and I'm not sure if it can prevent the
Spectre. I just saw others do it in the same way :/

We use the r13 to keep the address where we put the return value of the
origin call on the stack. The offset of it is
"FUNC_ARGS_OFFSET + 8 * nr_args".

The calling of kfunc_md_get_noref() should be within rcu_read_lock, which
I don't, as this will increase the overhead of a function call. And I'm
considering to make the calling of the bpf prog list within the rcu lock:

  rcu_read_lock()
  kfunc_md_get_noref()
  call fentry progs
  call modify_return progs
  rcu_read_unlock()

  call origin

  rcu_read_lock()
  call fexit progs
  rcu_read_unlock()

I'm not sure why the general bpf trampoline don't do it this way. Because
this will make the trampoline hold the rcu lock too long?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/Kconfig              |   4 +
 arch/x86/kernel/asm-offsets.c |  15 +++
 arch/x86/kernel/ftrace_64.S   | 231 ++++++++++++++++++++++++++++++++++
 include/linux/bpf.h           |   4 +
 kernel/bpf/trampoline.c       |   6 +-
 5 files changed, 257 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0405288c42c6..6d37f814701a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
+	select ARCH_HAS_BPF_GLOBAL_CALLER	if X86_64
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_WATCHDOG
@@ -431,6 +432,9 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+config ARCH_HAS_BPF_GLOBAL_CALLER
+	bool
+
 menu "Processor type and features"
 
 config SMP
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ad4ea6fb3b6c..a35831be3054 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -12,7 +12,9 @@
 #include <linux/stddef.h>
 #include <linux/hardirq.h>
 #include <linux/suspend.h>
+#include <linux/bpf.h>
 #include <linux/kbuild.h>
+#include <linux/kfunc_md.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/sigframe.h>
@@ -115,4 +117,17 @@ static void __used common(void)
 	OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
 #endif
 
+	DEFINE(RUN_CTX_SIZE, sizeof(struct bpf_tramp_run_ctx));
+	OFFSET(RUN_CTX_cookie, bpf_tramp_run_ctx, bpf_cookie);
+
+	OFFSET(BPF_PROG_func, bpf_prog, bpf_func);
+
+	DEFINE(KFUNC_MD_SIZE, sizeof(struct kfunc_md));
+	OFFSET(KFUNC_MD_progs, kfunc_md, bpf_progs);
+	OFFSET(KFUNC_MD_addr, kfunc_md, func);
+	OFFSET(KFUNC_MD_flags, kfunc_md, flags);
+	OFFSET(KFUNC_MD_nr_args, kfunc_md, nr_args);
+
+	OFFSET(KFUNC_MD_PROG_prog, kfunc_md_tramp_prog, prog);
+	OFFSET(KFUNC_MD_PROG_cookie, kfunc_md_tramp_prog, cookie);
 }
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 367da3638167..62269a67bf3a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/cfi_types.h>
 #include <linux/linkage.h>
+#include <linux/kfunc_md.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
@@ -384,3 +385,233 @@ SYM_CODE_START(return_to_handler)
 		    X86_FEATURE_CALL_DEPTH
 SYM_CODE_END(return_to_handler)
 #endif
+
+/*
+ * the stack layout for bpf_global_caller:
+ *
+ *	callee rip
+ *	rbp
+ *	---------------------- rbp
+ *	return value	- for origin call
+ *	arg6
+ *	......
+ *	arg1
+ *	arg count
+ *	origin ip	- for bpf_get_func_ip()
+ *	rbx		- keep pointer to kfunc_md_tramp_prog
+ *	bpf_tramp_run_ctx
+ *	kfunc_md_ptr
+ *	kfunc_md_flags
+ *	r12		- keep the start time
+ *	r13		- keep the return value address, for origin call
+ *
+ * Note: the return value can be in the position of arg6, arg5, etc,
+ *       depending on the number of args. That's why we need the %r13
+ */
+
+#define FUNC_RETURN_OFFSET	(-8)
+
+#define FUNC_ARGS_SIZE		(6 * 8)
+#define FUNC_ARGS_OFFSET	(FUNC_RETURN_OFFSET - FUNC_ARGS_SIZE)
+#define FUNC_ARGS_1		(FUNC_ARGS_OFFSET + 0 * 8)
+#define FUNC_ARGS_2		(FUNC_ARGS_OFFSET + 1 * 8)
+#define FUNC_ARGS_3		(FUNC_ARGS_OFFSET + 2 * 8)
+#define FUNC_ARGS_4		(FUNC_ARGS_OFFSET + 3 * 8)
+#define FUNC_ARGS_5		(FUNC_ARGS_OFFSET + 4 * 8)
+#define FUNC_ARGS_6		(FUNC_ARGS_OFFSET + 5 * 8)
+
+/* the args count, rbp - 8 * 8 */
+#define FUNC_ARGS_COUNT_OFFSET	(FUNC_ARGS_OFFSET - 1 * 8)
+#define FUNC_ORIGIN_IP		(FUNC_ARGS_OFFSET - 2 * 8) /* -9 * 8 */
+#define RBX_OFFSET		(FUNC_ARGS_OFFSET - 3 * 8)
+
+/* bpf_tramp_run_ctx, rbp - RUN_CTX_OFFSET */
+#define RUN_CTX_OFFSET		(RBX_OFFSET - RUN_CTX_SIZE)
+#define KFUNC_MD_OFFSET		(RUN_CTX_OFFSET - 1 * 8)
+#define KFUNC_MD_FLAGS_OFFSET	(KFUNC_MD_OFFSET - 8)
+#define R12_OFFSET		(KFUNC_MD_OFFSET - 16)
+#define R13_OFFSET		(KFUNC_MD_OFFSET - 24)
+#define STACK_SIZE		(-1 * R13_OFFSET)
+
+/* restore the regs before we return or before we do the origin call */
+.macro tramp_restore_regs
+	movq FUNC_ARGS_1(%rbp), %rdi
+	movq FUNC_ARGS_2(%rbp), %rsi
+	movq FUNC_ARGS_3(%rbp), %rdx
+	movq FUNC_ARGS_4(%rbp), %rcx
+	movq FUNC_ARGS_5(%rbp), %r8
+	movq FUNC_ARGS_6(%rbp), %r9
+	.endm
+
+/* save the args to stack, only regs is supported for now */
+.macro tramp_save_regs
+	movq %rdi, FUNC_ARGS_1(%rbp)
+	movq %rsi, FUNC_ARGS_2(%rbp)
+	movq %rdx, FUNC_ARGS_3(%rbp)
+	movq %rcx, FUNC_ARGS_4(%rbp)
+	movq %r8, FUNC_ARGS_5(%rbp)
+	movq %r9, FUNC_ARGS_6(%rbp)
+	.endm
+
+#define BPF_TRAMP_FENTRY	0
+#define BPF_TRAMP_FEXIT		1
+#define BPF_TRAMP_MODIFY_RETURN	2
+
+.macro bpf_caller_prog_run type
+	/* check if the prog list is NULL */
+1:	testq %rbx, %rbx
+	jz 3f
+
+	/* load bpf prog to the 1st arg */
+	movq KFUNC_MD_PROG_prog(%rbx), %rdi
+
+	/* load the pointer of tramp_run_ctx to the 2nd arg */
+	leaq RUN_CTX_OFFSET(%rbp), %rsi
+	/* save the bpf cookie to the tramp_run_ctx */
+	movq KFUNC_MD_PROG_cookie(%rbx), %rax
+	movq %rax, RUN_CTX_cookie(%rsi)
+	call __bpf_prog_enter_recur
+	/* save the start time to r12 */
+	movq %rax, %r12
+	testq %rax, %rax
+	jz 2f
+
+	movq KFUNC_MD_PROG_prog(%rbx), %rdi
+	/* load the JITed prog to rax */
+	movq BPF_PROG_func(%rdi), %rax
+	/* load func args array to the 1st arg */
+	leaq FUNC_ARGS_OFFSET(%rbp), %rdi
+
+	/* load and call the JITed bpf func */
+	CALL_NOSPEC rax
+.if \type==BPF_TRAMP_MODIFY_RETURN
+	/* modify_return case, save the return value */
+	movq %rax, (%r13)
+.endif
+
+	/* load bpf prog to the 1st arg */
+2:	movq KFUNC_MD_PROG_prog(%rbx), %rdi
+	/* load the rbx(start time) to the 2nd arg */
+	movq %r12, %rsi
+	/* load the pointer of tramp_run_ctx to the 3rd arg */
+	leaq RUN_CTX_OFFSET(%rbp), %rdx
+	call __bpf_prog_exit_recur
+
+.if \type==BPF_TRAMP_MODIFY_RETURN
+	/* modify_return case, break the loop and skip the origin function call */
+	cmpq $0, (%r13)
+	jne do_bpf_fexit
+.endif
+	/* load the next tramp prog to rbx */
+	movq 0(%rbx), %rbx
+	jmp 1b
+
+3:
+	.endm
+
+SYM_FUNC_START(bpf_global_caller)
+	ANNOTATE_NOENDBR
+
+	/* prepare the stack space and store the args to the stack */
+	pushq %rbp
+	movq %rsp, %rbp
+	subq $STACK_SIZE, %rsp
+	tramp_save_regs
+
+	CALL_DEPTH_ACCOUNT
+
+	/* save rbx and r12, which will be used later */
+	movq %rbx, RBX_OFFSET(%rbp)
+	movq %r12, R12_OFFSET(%rbp)
+
+	/* get the function address */
+	movq 8(%rbp), %rdi
+	/* for x86_64, the function is 16-bytes aligned */
+	andq $0xfffffffffffffff0, %rdi
+	/* save the origin function ip */
+	movq %rdi, FUNC_ORIGIN_IP(%rbp)
+
+	/* get the function meta data */
+	call kfunc_md_get_noref
+	testq %rax, %rax
+	jz do_bpf_out
+	movq %rax, %rbx
+	movq %rbx, KFUNC_MD_OFFSET(%rbp)
+
+	/* save the function args count */
+	movzbq KFUNC_MD_nr_args(%rbx), %rax
+	movq %rax, FUNC_ARGS_COUNT_OFFSET(%rbp)
+
+	/* call kfunc_md_enter only if we need origin call */
+	movl KFUNC_MD_flags(%rbx), %edi
+	movl %edi, KFUNC_MD_FLAGS_OFFSET(%rbp)
+	andl $KFUNC_MD_FL_TRACING_ORIGIN, %edi
+	jz 1f
+
+	/* save the address of the return value to r13 */
+	movq %r13, R13_OFFSET(%rbp)
+	leaq FUNC_ARGS_OFFSET(%rbp, %rax, 8), %r13
+
+	movq %rbx, %rdi
+	call kfunc_md_enter
+
+	/* try run fentry progs */
+1:	movq (KFUNC_MD_progs + BPF_TRAMP_FENTRY * 8)(%rbx), %rbx
+	bpf_caller_prog_run BPF_TRAMP_FENTRY
+
+	/* check if we need to do the origin call */
+	movl KFUNC_MD_FLAGS_OFFSET(%rbp), %eax
+	andl $KFUNC_MD_FL_TRACING_ORIGIN, %eax
+	jz do_bpf_out
+
+	/* try run modify_return progs */
+	movq KFUNC_MD_OFFSET(%rbp), %r12
+	movq (KFUNC_MD_progs + BPF_TRAMP_MODIFY_RETURN * 8)(%r12), %rbx
+	movq $0, (%r13)
+	bpf_caller_prog_run BPF_TRAMP_MODIFY_RETURN
+
+	/* do the origin call */
+	tramp_restore_regs
+	/* call the origin function from the stack, just like BPF_TRAMP_F_ORIG_STACK */
+	movq 8(%rbp), %rax
+	CALL_NOSPEC rax
+	movq %rax, (%r13)
+
+do_bpf_fexit:
+	/* for origin case, run fexit and return */
+	movq KFUNC_MD_OFFSET(%rbp), %r12
+	movq (KFUNC_MD_progs + BPF_TRAMP_FEXIT * 8)(%r12), %rbx
+	bpf_caller_prog_run BPF_TRAMP_FEXIT
+	movq KFUNC_MD_OFFSET(%rbp), %rdi
+	call kfunc_md_exit
+
+	movq (%r13), %rax
+	movq RBX_OFFSET(%rbp), %rbx
+	movq R12_OFFSET(%rbp), %r12
+	movq R13_OFFSET(%rbp), %r13
+	leave
+
+	/* rebalance the RSB. We can simply use:
+	 *
+	 *   leaq 8(%rsp), %rsp
+	 *   RET
+	 *
+	 * instead here if we don't want do the rebalance.
+	 */
+	movq $bpf_global_caller_rsb, (%rsp)
+	RET
+SYM_INNER_LABEL(bpf_global_caller_rsb, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	RET
+
+do_bpf_out:
+	/* for no origin call case, restore regs and return */
+	tramp_restore_regs
+
+	movq RBX_OFFSET(%rbp), %rbx
+	movq R12_OFFSET(%rbp), %r12
+	leave
+	RET
+
+SYM_FUNC_END(bpf_global_caller)
+STACK_FRAME_NON_STANDARD(bpf_global_caller)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409b..8979e397ea06 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3554,6 +3554,10 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 
+u64 __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx);
+void __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
+			   struct bpf_tramp_run_ctx *run_ctx);
+
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
 void bpf_cgroup_atype_put(int cgroup_atype);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c4b1a98ff726..da4be23f03c3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -894,7 +894,7 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
  * [2..MAX_U64] - execute bpf prog and record execution time.
  *     This is start time.
  */
-static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
+u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
 	rcu_read_lock();
@@ -934,8 +934,8 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
 	}
 }
 
-static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
-					  struct bpf_tramp_run_ctx *run_ctx)
+void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
+				   struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
-- 
2.39.5


