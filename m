Return-Path: <bpf+bounces-23077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F084586D388
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67F0286006
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488E13F434;
	Thu, 29 Feb 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdCx0Qtu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED413C9E5;
	Thu, 29 Feb 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235826; cv=none; b=Oy+wbgsFqVOzPN6XFJWvo3bzjAhg4zz7qtRtL5Jm4bHOR+F9lZcLZToh/vCfIwcEH+GUJjITqohga9jmSTQKcNa523juXpzCnxm8mxpAkvo0daHtghgITxhZu5zZqr6OEEhRWsVWvlAFWIF8Xk6Z8uzxRq4kQEjfq02+0fH2T8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235826; c=relaxed/simple;
	bh=fcaPBvJsB42z/fUuoywTyYUMe7RT+I5xtuNSPSRKUwA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f66zIj9bbxRZXqGbXyyFEOvlEJZ+N7fP0/LHNG4Rqu8WGG84gtngFuOI//BPMZwcpAw4Y5xhFMX15ei1nrcuh0DeYG/2n7QwlgOwx+f8GuJKqBaSBDIaTCnfx/Ra4PSpW4TY7O8c3pMZdGDBxHT08/SqACrgTjSG8FKAOhmG05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdCx0Qtu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d311081954so9859371fa.2;
        Thu, 29 Feb 2024 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709235822; x=1709840622; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbgtyMZ4mWENGjxFShiImxlPm+xFjI/du4H0Na3k0jg=;
        b=VdCx0QtuWgjk3mw/OswIUSPnXlTNO1MBGZD6Dp7Nz0V76WYHqxHrJckTsP0oXS7bCS
         BMOrgeOaHaS5l9wK3cdKf6v/Vej3D76bbSR8vda18Yo3Ov54g8h9hBcy5b+LENxEikdw
         4WPljoLv92ocYy7a9JIXPjw/DCE+w+k2gn8+Or7Tj1XhIlFDQxGDjmodaqnzys7S3xXi
         qYW2UoHAQFOfqWNT/asTqltiBDD8PHuYBjWgbgXW3r2Lb2Xfn5CMdO/oA4WKaC4P1Bgg
         m+U7c6MRzE3rlCjty5SL6P4flw45xOk+uE6UfwKkqdQ3YxfZR7BxXsqEZdQmReY0opC7
         2hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235822; x=1709840622;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbgtyMZ4mWENGjxFShiImxlPm+xFjI/du4H0Na3k0jg=;
        b=UqzjbGwaPzL+wAC/CJHIkinpuXGm2QmWD4BFbOhSAGzi4KXApAWT6IIZp0QOJ+FsgG
         rEMU82uUwoOEZ0EOD+IyjVUYR6Z+m8wzf1FLd8y45k0X0R5+seiDGQPWHMKtmjg7MM29
         XfXonY1rkLYmNXjb4r+aR5FURyS5xz0E6lsT88Om9VIDnlivpg4kZeQ2DZlOqpyy6IHs
         vYsPfCA8znzdb4u3jS9B2ct6wQskm6qWMvabjsNbk1dQOLBVMraQ1QLw49v5RvbE9NUI
         t1yPa05HVlc0TydUrFAU6btU2tamyGY+BiTq6g/W+UPT5pqJmESe3UhKRHuR5mFpcSPb
         2EUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzVsPC7HZXc/dxchfor3PcUx1V/wpUspDp7V8sg2sYuYqm8DxV2GCHAsA4vYIWgkBTKoMhBSv/G9Vd9dZJ94ep2lbqIKjmXP1rWAiVQAqoI6rSAZP872syO5mTpQ2Vn3ao
X-Gm-Message-State: AOJu0Yz+ulAShtS19+aYvGaXjlIDufPtz6r4oBgeShs4aRlHHR3VG9bk
	QMSGqPXzjkGbNxp9HjtKzxY5Iqm9tHaF+mCVqhytMBU+B6AyVAwG
X-Google-Smtp-Source: AGHT+IFroyYD4JgISoV5wedMc8AviWrj+5iahY6O5IIcTmaLYV2N5XSkomfiCAyduVhONJi7YZrl4g==
X-Received: by 2002:a2e:8195:0:b0:2d2:39ab:eee1 with SMTP id e21-20020a2e8195000000b002d239abeee1mr2163066ljg.32.1709235822131;
        Thu, 29 Feb 2024 11:43:42 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b0041069adbd87sm6020534wmj.21.2024.02.29.11.43.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Feb 2024 11:43:41 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: catalin.marinas@arm.com, ast@kernel.org, daniel@iogearbox.net,
 mark.rutland@arm.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: arm64: Supporting DYNAMIC_FTRACE_WITH_CALL_OPS with CLANG_CFI
In-Reply-To: <mb61ph6hsxj94.fsf@gmail.com>
References: <mb61ph6hsxj94.fsf@gmail.com>
Date: Thu, 29 Feb 2024 19:43:39 +0000
Message-ID: <mb61pedcvxdhw.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

puranjay12@gmail.com writes:

> I would propose the following changes to the compiler that could fix this
> issue:
>
> 1. The kCFI hash should always be generated at func_addr - 4, this would
> make the calling code consistent.
>
> 2. The two(n) nops should be generated before the kCFI hash. We would
> modify the ftrace code to look for these nops at (fun_addr - 12) and
> (func_addr - 8) when CFI is enabled, and (func_addr - 8), (func_addr -
> 4) when CFI is disabled.
>
> The generated code could then look like:
>
> ffff80008033e9b0:       d503201f        nop
> ffff80008033e9b4:       d503201f        nop
> ffff80008033e9b8:       16c516ce        kCFI hash
> ffff80008033e9bc <jump_label_cmp>:
> ffff80008033e9bc:       d503245f        bti     c
> ffff80008033e9c0:       d503201f        nop
> ffff80008033e9c4:       d503201f        nop
> [.....]
>

I hacked some patches and tried the above approach:

Both CFI and DIRECT CALLS are enabled:

[root@localhost ~]# zcat /proc/config.gz | grep DIRECT_CALLS
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
[root@localhost ~]# zcat /proc/config.gz | grep CONFIG_CFI
CONFIG_CFI_CLANG=y
CONFIG_CFI_PERMISSIVE=y
CONFIG_CFI_WITHOUT_STATIC_CALL=y

Running some BPF selftests that use this feature.

./test_progs -a "*fentry*,*fexit*,tracing_struct" -b "fentry_test/fentry_many_args" -b "fexit_test/fexit_many_args"

#77      fentry_attach_btf_presence:OK
#78      fentry_fexit:OK
#79/1    fentry_test/fentry:OK
#79      fentry_test:OK
#80/1    fexit_bpf2bpf/target_no_callees:OK
#80/2    fexit_bpf2bpf/target_yes_callees:OK
#80/3    fexit_bpf2bpf/func_replace:OK
#80/4    fexit_bpf2bpf/func_replace_verify:OK
#80/5    fexit_bpf2bpf/func_sockmap_update:OK
#80/6    fexit_bpf2bpf/func_replace_return_code:OK
#80/7    fexit_bpf2bpf/func_map_prog_compatibility:OK
#80/8    fexit_bpf2bpf/func_replace_unreliable:OK
#80/9    fexit_bpf2bpf/func_replace_multi:OK
#80/10   fexit_bpf2bpf/fmod_ret_freplace:OK
#80/11   fexit_bpf2bpf/func_replace_global_func:OK
#80/12   fexit_bpf2bpf/fentry_to_cgroup_bpf:OK
#80/13   fexit_bpf2bpf/func_replace_progmap:OK
#80      fexit_bpf2bpf:OK
#81      fexit_sleep:OK
#82      fexit_stress:OK
#83/1    fexit_test/fexit:OK
#83      fexit_test:OK
#158     module_fentry_shadow:OK
#193/1   recursive_fentry/attach:OK
#193/2   recursive_fentry/load:OK
#193/3   recursive_fentry/detach:OK
#193     recursive_fentry:OK
#385     tracing_struct:OK
Summary: 10/18 PASSED, 0 SKIPPED, 0 FAILED

Running basic ftrace selftest:

[root@localhost ftrace]# ./ftracetest test.d/00basic/
=== Ftrace unit tests ===
[1] Basic trace file check      [PASS]
[2] Basic test for tracers      [PASS]
[3] Basic trace clock test      [PASS]
[4] Basic event tracing check   [PASS]
[5] Change the ringbuffer size  [PASS]
[6] Change the ringbuffer sub-buffer size       [PASS]
[7] Snapshot and tracing setting        [PASS]
[8] Snapshot and tracing_cpumask        [PASS]
[9] Test file and directory owership changes for eventfs        [PASS]
[10] Basic tests on writing to trace_marker     [PASS]
[11] trace_pipe and trace_marker        [PASS]
[12] (instance)  Basic test for tracers [PASS]
[13] (instance)  Basic trace clock test [PASS]
[14] (instance)  Change the ringbuffer size     [PASS]
[15] (instance)  Change the ringbuffer sub-buffer size  [PASS]
[16] (instance)  Snapshot and tracing setting   [PASS]
[17] (instance)  Snapshot and tracing_cpumask   [PASS]
[18] (instance)  Basic tests on writing to trace_marker [PASS]
[19] (instance)  trace_pipe and trace_marker    [PASS]


# of passed:  19
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0

Here are the patches(RFC) that I created:

LLVM Patch:

--- >8 ---
diff --git a/llvm/lib/CodeGen/AsmPrinter/AsmPrinter.cpp b/llvm/lib/CodeGen/AsmPrinter/AsmPrinter.cpp
index e89a1c26c..f1ca33c26 100644
--- a/llvm/lib/CodeGen/AsmPrinter/AsmPrinter.cpp
+++ b/llvm/lib/CodeGen/AsmPrinter/AsmPrinter.cpp
@@ -982,9 +982,6 @@ void AsmPrinter::emitFunctionHeader() {
     }
   }

-  // Emit KCFI type information before patchable-function-prefix nops.
-  emitKCFITypeId(*MF);
-
   // Emit M NOPs for -fpatchable-function-entry=N,M where M>0. We arbitrarily
   // place prefix data before NOPs.
   unsigned PatchableFunctionPrefix = 0;
@@ -1006,6 +1003,9 @@ void AsmPrinter::emitFunctionHeader() {
     CurrentPatchableFunctionEntrySym = CurrentFnBegin;
   }

+  // Emit KCFI type information after patchable-function-prefix nops.
+  emitKCFITypeId(*MF);
+
   // Emit the function prologue data for the indirect call sanitizer.
   if (const MDNode *MD = F.getMetadata(LLVMContext::MD_func_sanitize)) {
     assert(MD->getNumOperands() == 2);
diff --git a/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp b/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp
index 4fa719ad6..678a38a6a 100644
--- a/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp
+++ b/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp
@@ -474,20 +474,11 @@ void AArch64AsmPrinter::LowerKCFI_CHECK(const MachineInstr &MI) {
     assert(ScratchRegs[0] != AddrReg && ScratchRegs[1] != AddrReg &&
            "Invalid scratch registers for KCFI_CHECK");

-    // Adjust the offset for patchable-function-prefix. This assumes that
-    // patchable-function-prefix is the same for all functions.
-    int64_t PrefixNops = 0;
-    (void)MI.getMF()
-        ->getFunction()
-        .getFnAttribute("patchable-function-prefix")
-        .getValueAsString()
-        .getAsInteger(10, PrefixNops);
-
     // Load the target function type hash.
     EmitToStreamer(*OutStreamer, MCInstBuilder(AArch64::LDURWi)
                                      .addReg(ScratchRegs[0])
                                      .addReg(AddrReg)
-                                     .addImm(-(PrefixNops * 4 + 4)));
+                                     .addImm(-4));
   }

   // Load the expected type hash.
--- 8< ---

Kernel Patch:

--- >8 ---
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435..979c290e6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -197,7 +197,7 @@ config ARM64
        select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
                if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
        select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
-               if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
+               if (DYNAMIC_FTRACE_WITH_ARGS && \
                    !CC_OPTIMIZE_FOR_SIZE)
        select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
                if DYNAMIC_FTRACE_WITH_ARGS
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index f0c16640e..9be421583 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -48,8 +48,15 @@ SYM_CODE_START(ftrace_caller)
         * alignment first as this allows us to fold the subtraction into the
         * LDR.
         */
+
+#ifdef CONFIG_CFI_CLANG
+       sub     x11, x30, #20
+       bic     x11, x11, 0x7
+       ldr     x11, [x11, 0]           // op
+#else
        bic     x11, x30, 0x7
        ldr     x11, [x11, #-(4 * AARCH64_INSN_SIZE)]           // op
+#endif

 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
        /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11..ed7a86b31 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -125,6 +125,10 @@ unsigned long ftrace_call_adjust(unsigned long addr)
        /* Skip the NOPs placed before the function entry point */
        addr += 2 * AARCH64_INSN_SIZE;

+       /* Skip the hash in case of CLANG_CFI */
+       if (IS_ENABLED(CONFIG_CFI_CLANG))
+               addr += AARCH64_INSN_SIZE;
+
        /* Skip any BTI */
        if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)) {
                u32 insn = le32_to_cpu(*(__le32 *)addr);
@@ -299,7 +303,11 @@ static const struct ftrace_ops *arm64_rec_get_ops(struct dyn_ftrace *rec)
 static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
                              const struct ftrace_ops *ops)
 {
+#ifdef CONFIG_CFI_CLANG
+       unsigned long literal = ALIGN_DOWN(rec->ip - 16, 8);
+#elif
        unsigned long literal = ALIGN_DOWN(rec->ip - 12, 8);
+#endif
        return aarch64_insn_write_literal_u64((void *)literal,
                                              (unsigned long)ops);
 }
--- 8< ---

I applied the kernel patch over my tree that has patches to fix kCFI
with BPF and also has a static call related fix [1].


Thanks,
Puranjay

[1] https://github.com/puranjaymohan/linux/tree/kcfi_bpf

