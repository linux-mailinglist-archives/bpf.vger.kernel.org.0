Return-Path: <bpf+bounces-27766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B98B17A3
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 02:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124EB1F2449B
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE32A3D;
	Thu, 25 Apr 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjK1Wv+h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287B36E;
	Thu, 25 Apr 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003335; cv=none; b=dF7meUuSH7Ip2KFIMhyMY+hYxAKj0RvTXTwILH+JYxGPXXcy8Mk8w2PEvoh5ovkltGgxYbyeDaZ8ATzkiTG9YesOQcIpQoho4dKxxpF16gs/rBnYymOG+7rRYxcpzezYnCUZtQxK1K+ReRKt82dNkVmdVNfKkmH2kW1+0Hzq9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003335; c=relaxed/simple;
	bh=uULInvgP4WaXTcpiN5zWSR1+1Q4u+PCE543FW+s4Ay8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XUhQG+jRleAUgiEG/sCHoaNuz4hBcYaGVoHegocYLfPRwqEI/FSF7CNZpYc6o8QgudhbsF2MniQ+6yiI/SwzJl9MqM70TKlh7PVBGvSIj2h/sxV8DwGwjvJ0/gNGxnc5rgdQbDZFnR98j/PL52F27+2Q/Ar1fSys5F8Z3Tpjm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjK1Wv+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C908DC113CD;
	Thu, 25 Apr 2024 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714003335;
	bh=uULInvgP4WaXTcpiN5zWSR1+1Q4u+PCE543FW+s4Ay8=;
	h=From:To:Cc:Subject:Date:From;
	b=cjK1Wv+hxver0lgHTavnio/dJ4YLpoY2QDDtcWxToW78W34ZRGE5oCDxvHZBpf4tR
	 PL+36DOinzZOPugOqWk5Ay0SZBXl3ewXeCyCzSeneCvkAILBgUPQampH3XLhGIX5Zv
	 PnQfym2nj02ss+3vJziAdEQg9b+rqiGGEbEMnhoXt0GKqDm3HDXEnqoz6hIAtwmYTd
	 PLMySOgecRoisHvWvTwFha1AXe7cLoXkIvxy+asIzv14/AQkY2I2TTYsNdX74maPfq
	 rIiLHurVsDFEFXeNRbZnJg9dVUtd/8AmJqEWTZrY62pngn3c0zj4AXZi28Ha9MCjlE
	 dZOmfPf6Bl6LA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC] rethook: inline arch_rethook_trampoline_callback() in assembly code
Date: Wed, 24 Apr 2024 17:02:11 -0700
Message-ID: <20240425000211.708557-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At the lowest level, rethook-based kretprobes on x86-64 architecture go
through arch_rethoook_trampoline() function, manually written in
assembly, which calls into a simple arch_rethook_trampoline_callback()
function, written in C, and only doing a few straightforward field
assignments, before calling further into rethook_trampoline_handler(),
which handles kretprobe callbacks generically.

Looking at simplicity of arch_rethook_trampoline_callback(), it seems
not really worthwhile to spend an extra function call just to do 4 or
5 assignments. As such, this patch proposes to "inline"
arch_rethook_trampoline_callback() into arch_rethook_trampoline() by
manually implementing it in an assembly code.

This has two motivations. First, we do get a bit of runtime speed up by
avoiding function calls. Using BPF selftests's bench tool, we see
0.6%-0.8% throughput improvement for kretprobe/multi-kretprobe
triggering code path:

BEFORE (latest probes/for-next)
===============================
kretprobe      :   10.455 ± 0.024M/s
kretprobe-multi:   11.150 ± 0.012M/s

AFTER (probes/for-next + this patch)
====================================
kretprobe      :   10.540 ± 0.009M/s (+0.8%)
kretprobe-multi:   11.219 ± 0.042M/s (+0.6%)

Second, and no less importantly for some specialized use cases, this
avoids unnecessarily "polluting" LBR records with an extra function call
(recorded as a jump by CPU). This is the case for the retsnoop ([0])
tool, which relies havily on capturing LBR records to provide users with
lots of insight into kernel internals.

This RFC patch is only inlining this function for x86-64, but it's
possible to do that for 32-bit x86 arch as well and then remove
arch_rethook_trampoline_callback() implementation altogether. Please let
me know if this change is acceptable and whether I should complete it
with 32-bit "inlining" as well. Thanks!

  [0] https://nakryiko.com/posts/retsnoop-intro/#peering-deep-into-functions-with-lbr

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/kernel/asm-offsets_64.c |  4 ++++
 arch/x86/kernel/rethook.c        | 37 +++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bb65371ea9df..5c444abc540c 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -42,6 +42,10 @@ int main(void)
 	ENTRY(r14);
 	ENTRY(r15);
 	ENTRY(flags);
+	ENTRY(ip);
+	ENTRY(cs);
+	ENTRY(ss);
+	ENTRY(orig_ax);
 	BLANK();
 #undef ENTRY
 
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c0111ae79..3e1c01beebd1 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -6,6 +6,7 @@
 #include <linux/rethook.h>
 #include <linux/kprobes.h>
 #include <linux/objtool.h>
+#include <asm/asm-offsets.h>
 
 #include "kprobes/common.h"
 
@@ -34,10 +35,36 @@ asm(
 	"	pushq %rsp\n"
 	"	pushfq\n"
 	SAVE_REGS_STRING
-	"	movq %rsp, %rdi\n"
-	"	call arch_rethook_trampoline_callback\n"
+	"	movq %rsp, %rdi\n" /* $rdi points to regs */
+	/* fixup registers */
+	/* regs->cs = __KERNEL_CS; */
+	"	movq $" __stringify(__KERNEL_CS) ", " __stringify(pt_regs_cs) "(%rdi)\n"
+	/* regs->ip = (unsigned long)&arch_rethook_trampoline; */
+	"	movq $arch_rethook_trampoline, " __stringify(pt_regs_ip) "(%rdi)\n"
+	/* regs->orig_ax = ~0UL; */
+	"	movq $0xffffffffffffffff, " __stringify(pt_regs_orig_ax) "(%rdi)\n"
+	/* regs->sp += 2*sizeof(long); */
+	"	addq $16, " __stringify(pt_regs_sp) "(%rdi)\n"
+	/* 2nd arg is frame_pointer = (long *)(regs + 1); */
+	"	lea " __stringify(PTREGS_SIZE) "(%rdi), %rsi\n"
+	/*
+	 * The return address at 'frame_pointer' is recovered by the
+	 * arch_rethook_fixup_return() which called from this
+	 * rethook_trampoline_handler().
+	 */
+	"	call rethook_trampoline_handler\n"
+	/*
+	 * Copy FLAGS to 'pt_regs::ss' so we can do RET right after POPF.
+	 *
+	 * We don't save/restore %rax below, because we ignore
+	 * rethook_trampoline_handler result.
+	 *
+	 * *(unsigned long *)&regs->ss = regs->flags;
+	 */
+	"	mov " __stringify(pt_regs_flags) "(%rsp), %rax\n"
+	"	mov %rax, " __stringify(pt_regs_ss) "(%rsp)\n"
 	RESTORE_REGS_STRING
-	/* In the callback function, 'regs->flags' is copied to 'regs->ss'. */
+	/* We just copied 'regs->flags' into 'regs->ss'. */
 	"	addq $16, %rsp\n"
 	"	popfq\n"
 #else
@@ -61,6 +88,7 @@ asm(
 );
 NOKPROBE_SYMBOL(arch_rethook_trampoline);
 
+#ifdef CONFIG_X86_32
 /*
  * Called from arch_rethook_trampoline
  */
@@ -70,9 +98,7 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 
 	/* fixup registers */
 	regs->cs = __KERNEL_CS;
-#ifdef CONFIG_X86_32
 	regs->gs = 0;
-#endif
 	regs->ip = (unsigned long)&arch_rethook_trampoline;
 	regs->orig_ax = ~0UL;
 	regs->sp += 2*sizeof(long);
@@ -92,6 +118,7 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 	*(unsigned long *)&regs->ss = regs->flags;
 }
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+#endif
 
 /*
  * arch_rethook_trampoline() skips updating frame pointer. The frame pointer
-- 
2.43.0


