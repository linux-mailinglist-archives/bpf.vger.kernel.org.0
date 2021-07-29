Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2693DA5B6
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhG2OJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 10:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238111AbhG2OGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:06:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 548AD60F4A;
        Thu, 29 Jul 2021 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567587;
        bh=uFEfIIjNpXGa+yRRhtojqRqbBApGCqL19SHhiSJSvqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bImZ+k8xdfFpt3ru4v37n988GoF8OkybD9kpRM9cCH4msuJeuck/DxQ0uGZzhK83h
         UEW4DVOCM+oEBPEtpZ8oUlrZpjODKcIxs9wxQBpC5qCEhrw4i15NprUJLkczQm8Tl0
         8JZAU8xTWxF7UuKyIe2reIp6H5JYVe6f8sq7x9HQdiUMW3P2S5sIJ9usb4IKzF+tDp
         I+b2Dnc0NhhJ6f0KzPwCpHMVkbVyPSEvxBo04Eji9GweGXP+AMKl5r+xrU4KsUfvMy
         4D70ncyu6oWSHIuYDYze8b0jBM6+kkcHxOLmTWJ/fK24TYCKjfQ4rvMQWcz+ArGZxw
         TpKcsKKUPIzpg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v10 03/16] kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
Date:   Thu, 29 Jul 2021 23:06:24 +0900
Message-Id: <162756758387.301564.1503902878275294240.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162756755600.301564.4957591913842010341.stgit@devnote2>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The __kretprobe_trampoline_handler() callback, called from low level
arch kprobes methods, has the 'trampoline_address' parameter, which is
entirely superfluous as it basically just replicates:

  dereference_kernel_function_descriptor(kretprobe_trampoline)

In fact we had bugs in arch code where it wasn't replicated correctly.

So remove this superfluous parameter and use kretprobe_trampoline_addr()
instead.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
---
 Changes in v9:
   - Update changelog according to Ingo's suggestion.
 Changes in v8:
   - Use dereference_kernel_function_descriptor() to
     get the kretprobe_trampoline address.
 Changes in v3:
   - Remove wrong kretprobe_trampoline declaration from
     arch/x86/include/asm/kprobes.h.
 Changes in v2:
   - Remove arch_deref_entry_point() from comment.
---
 arch/arc/kernel/kprobes.c          |    2 +-
 arch/arm/probes/kprobes/core.c     |    3 +--
 arch/arm64/kernel/probes/kprobes.c |    3 +--
 arch/csky/kernel/probes/kprobes.c  |    2 +-
 arch/ia64/kernel/kprobes.c         |    5 ++---
 arch/mips/kernel/kprobes.c         |    3 +--
 arch/parisc/kernel/kprobes.c       |    4 ++--
 arch/powerpc/kernel/kprobes.c      |    2 +-
 arch/riscv/kernel/probes/kprobes.c |    2 +-
 arch/s390/kernel/kprobes.c         |    2 +-
 arch/sh/kernel/kprobes.c           |    2 +-
 arch/sparc/kernel/kprobes.c        |    2 +-
 arch/x86/include/asm/kprobes.h     |    1 -
 arch/x86/kernel/kprobes/core.c     |    2 +-
 include/linux/kprobes.h            |   18 +++++++++++++-----
 kernel/kprobes.c                   |    3 +--
 16 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 5f0415fc7328..3cee75c87f97 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -381,7 +381,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	regs->ret = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	regs->ret = __kretprobe_trampoline_handler(regs, NULL);
 
 	/* By returning a non zero value, we are telling the kprobe handler
 	 * that we don't want the post_handler to run
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index a59e38de4a03..08098ed6f035 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -392,8 +392,7 @@ void __naked __kprobes kretprobe_trampoline(void)
 /* Called from kretprobe_trampoline */
 static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
-						    (void *)regs->ARM_fp);
+	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->ARM_fp);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index ce429cbacd35..f627a12984a8 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -401,8 +401,7 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
-					(void *)kernel_stack_pointer(regs));
+	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index e823c3051b24..bf1e6c7094fc 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -387,7 +387,7 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	return (void *)kretprobe_trampoline_handler(regs, NULL);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 0f8573bbf520..44c84c20b626 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -392,14 +392,13 @@ static void __kprobes set_current_kprobe(struct kprobe *p,
 	__this_cpu_write(current_kprobe, p);
 }
 
-static void kretprobe_trampoline(void)
+void kretprobe_trampoline(void)
 {
 }
 
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->cr_iip = __kretprobe_trampoline_handler(regs,
-		dereference_function_descriptor(kretprobe_trampoline), NULL);
+	regs->cr_iip = __kretprobe_trampoline_handler(regs, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index b0934a0d7aed..b33bd2498651 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -485,8 +485,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 						struct pt_regs *regs)
 {
-	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs,
-						kretprobe_trampoline, NULL);
+	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
index 6d21a515eea5..4a35ac6e2ca2 100644
--- a/arch/parisc/kernel/kprobes.c
+++ b/arch/parisc/kernel/kprobes.c
@@ -175,7 +175,7 @@ int __kprobes parisc_kprobe_ss_handler(struct pt_regs *regs)
 	return 1;
 }
 
-static inline void kretprobe_trampoline(void)
+void kretprobe_trampoline(void)
 {
 	asm volatile("nop");
 	asm volatile("nop");
@@ -193,7 +193,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 {
 	unsigned long orig_ret_address;
 
-	orig_ret_address = __kretprobe_trampoline_handler(regs, trampoline_p.addr, NULL);
+	orig_ret_address = __kretprobe_trampoline_handler(regs, NULL);
 	instruction_pointer_set(regs, orig_ret_address);
 
 	return 1;
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 077ab73e6e56..0764e8a0de69 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -416,7 +416,7 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long orig_ret_address;
 
-	orig_ret_address = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	orig_ret_address = __kretprobe_trampoline_handler(regs, NULL);
 	/*
 	 * We get here through one of two paths:
 	 * 1. by taking a trap -> kprobe_handler() -> here
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index cab6f874358e..62d477cf11da 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -347,7 +347,7 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	return (void *)kretprobe_trampoline_handler(regs, NULL);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 952d44b0610b..5fa86e54f129 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -343,7 +343,7 @@ static void __used kretprobe_trampoline_holder(void)
  */
 static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->psw.addr = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	regs->psw.addr = __kretprobe_trampoline_handler(regs, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 1c7f358ef0be..8e76a35e6e33 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -303,7 +303,7 @@ static void __used kretprobe_trampoline_holder(void)
  */
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->pc = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	regs->pc = __kretprobe_trampoline_handler(regs, NULL);
 
 	return 1;
 }
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 4c05a4ee6a0e..401534236c2e 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -451,7 +451,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 {
 	unsigned long orig_ret_address = 0;
 
-	orig_ret_address = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	orig_ret_address = __kretprobe_trampoline_handler(regs, NULL);
 	regs->tpc = orig_ret_address;
 	regs->tnpc = orig_ret_address + 4;
 
diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index bd7f5886a789..71ea2eab43d5 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -49,7 +49,6 @@ extern __visible kprobe_opcode_t optprobe_template_end[];
 extern const int kretprobe_blacklist_size;
 
 void arch_remove_kprobe(struct kprobe *p);
-asmlinkage void kretprobe_trampoline(void);
 
 extern void arch_kprobe_override_function(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b6e046e4b289..0c59ef5971de 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1064,7 +1064,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 	regs->ip = (unsigned long)&kretprobe_trampoline;
 	regs->orig_ax = ~0UL;
 
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline, &regs->sp);
+	return (void *)kretprobe_trampoline_handler(regs, &regs->sp);
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 2ed61fcbc89c..96f5df93e36e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -188,15 +188,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
 
+void kretprobe_trampoline(void);
+/*
+ * Since some architecture uses structured function pointer,
+ * use dereference_function_descriptor() to get real function address.
+ */
+static nokprobe_inline void *kretprobe_trampoline_addr(void)
+{
+	return dereference_kernel_function_descriptor(kretprobe_trampoline);
+}
+
 /* If the trampoline handler called from a kprobe, use this version */
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-				void *trampoline_address,
-				void *frame_pointer);
+					     void *frame_pointer);
 
 static nokprobe_inline
 unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
-				void *trampoline_address,
-				void *frame_pointer)
+					   void *frame_pointer)
 {
 	unsigned long ret;
 	/*
@@ -205,7 +213,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 	 * be running at this point.
 	 */
 	kprobe_busy_begin();
-	ret = __kretprobe_trampoline_handler(regs, trampoline_address, frame_pointer);
+	ret = __kretprobe_trampoline_handler(regs, frame_pointer);
 	kprobe_busy_end();
 
 	return ret;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 550042d9a6ef..6ed755111eea 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1864,7 +1864,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 #ifdef CONFIG_KRETPROBES
 
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *trampoline_address,
 					     void *frame_pointer)
 {
 	kprobe_opcode_t *correct_ret_addr = NULL;
@@ -1879,7 +1878,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 
 		BUG_ON(ri->fp != frame_pointer);
 
-		if (ri->ret_addr != trampoline_address) {
+		if (ri->ret_addr != kretprobe_trampoline_addr()) {
 			correct_ret_addr = ri->ret_addr;
 			/*
 			 * This is the real return address. Any other

