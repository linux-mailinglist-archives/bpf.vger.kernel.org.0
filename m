Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1034A730
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCZM3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhCZM3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5F061949;
        Fri, 26 Mar 2021 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616761744;
        bh=feI/2Mu06cmOd8eld6Q3cv6Gc40X4zMXRfdbCXzu0uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0rOy/jPJxLXNfnfl3IDqhzY+DJTVS/Rg6SFrnR9NiZTXMuf1mfBO2lczO6BxHU37
         g1WH3I7VvwZ3k33HXFLkD9WoZbZz5BideRXKrRCh5ldymQI1Fg1krXMgO6tyWXOnO1
         31xeXTR+4WzFJ1454zQIbZgPO6VdLiN421+8W7S1H8vbINlK22klDCuilzii9HLcvd
         Pnjm/Ilsy1hsL3XjofKXmoAI6gB5EpC5z/D0tk8l1h850ZU6VV0jhwa3ePQ04AJQkH
         qQMyINZCXrtKb0DWqJdOJ5YWWg5KArLD3WlisCsHcGI4I1EPA1pYZg5slHzGiHxDyX
         Or41rKZofREjw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v5 03/12] kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
Date:   Fri, 26 Mar 2021 21:28:59 +0900
Message-Id: <161676173948.330141.10885440129385936837.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove trampoline_address from kretprobe_trampoline_handler().
Instead of passing the address, kretprobe_trampoline_handler()
can use new kretprobe_trampoline_addr().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
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
index cabef45f11df..3ae01bb5820c 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -397,7 +397,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	regs->ret = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	regs->ret = __kretprobe_trampoline_handler(regs, NULL);
 
 	/* By returning a non zero value, we are telling the kprobe handler
 	 * that we don't want the post_handler to run
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index a9653117ca0d..1782b41df095 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -413,8 +413,7 @@ void __naked __kprobes kretprobe_trampoline(void)
 /* Called from kretprobe_trampoline */
 static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
-						    (void *)regs->ARM_fp);
+	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->ARM_fp);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 66aac2881ba8..fce681fdfce6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -412,8 +412,7 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
-					(void *)kernel_stack_pointer(regs));
+	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 589f090f48b9..cc589bc11904 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -404,7 +404,7 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	return (void *)kretprobe_trampoline_handler(regs, NULL);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index eaf3c734719b..0204953a06cf 100644
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
index 54dfba8fa77c..001a2f07ef44 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -489,8 +489,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
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
index eb0460949e1b..dfd532c43525 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -399,7 +399,7 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long orig_ret_address;
 
-	orig_ret_address = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	orig_ret_address = __kretprobe_trampoline_handler(regs, NULL);
 	/*
 	 * We get here through one of two paths:
 	 * 1. by taking a trap -> kprobe_handler() -> here
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 7e2c78e2ca6b..25fce713a060 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -375,7 +375,7 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	return (void *)kretprobe_trampoline_handler(regs, NULL);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index aae24dc75df6..b149e9169709 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -351,7 +351,7 @@ static void __used kretprobe_trampoline_holder(void)
  */
 static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->psw.addr = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
+	regs->psw.addr = __kretprobe_trampoline_handler(regs, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 756100b01e84..48356e81836a 100644
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
index 217c21a6986a..fa30f9dadff8 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -468,7 +468,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
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
index a061a8c8089a..444a7b6b396e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1070,7 +1070,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 	regs->ip = (unsigned long)&kretprobe_trampoline;
 	regs->orig_ax = ~0UL;
 
-	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline, &regs->sp);
+	return (void *)kretprobe_trampoline_handler(regs, &regs->sp);
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index d65c041b5c22..65dadd4238a2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -205,15 +205,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
 
+void kretprobe_trampoline(void);
+/*
+ * Since some architecture uses structured function pointer,
+ * use dereference_function_descriptor() to get real function address.
+ */
+static nokprobe_inline void *kretprobe_trampoline_addr(void)
+{
+	return dereference_function_descriptor(kretprobe_trampoline);
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
@@ -222,7 +230,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 	 * be running at this point.
 	 */
 	kprobe_busy_begin();
-	ret = __kretprobe_trampoline_handler(regs, trampoline_address, frame_pointer);
+	ret = __kretprobe_trampoline_handler(regs, frame_pointer);
 	kprobe_busy_end();
 
 	return ret;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2913de07f4a3..75c0a58c19c2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1859,7 +1859,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 #ifdef CONFIG_KRETPROBES
 
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *trampoline_address,
 					     void *frame_pointer)
 {
 	kprobe_opcode_t *correct_ret_addr = NULL;
@@ -1874,7 +1873,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 
 		BUG_ON(ri->fp != frame_pointer);
 
-		if (ri->ret_addr != trampoline_address) {
+		if (ri->ret_addr != kretprobe_trampoline_addr()) {
 			correct_ret_addr = ri->ret_addr;
 			/*
 			 * This is the real return address. Any other

