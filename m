Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF93D91E4
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhG1P3e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 11:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhG1P3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 11:29:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3C660F9D;
        Wed, 28 Jul 2021 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627486172;
        bh=GssK7w9ZVMwbL5nR3QvlfogG28Uvu/3wxSJKEdU9QCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWo5v1EqYoIJ9rEMXFfWUK/77ZRfXL1KQsDZFtpc0lcPNV/em/KOXh7LlEkFBX6v6
         Je3zyA8M44lOZgbpauvna2Yio6zjQqFPxveEt23/YjI2Zom9yh96ERdlKEvskYzSup
         TEDwarL2ZbO0SWtj40wTOR6fJTifLy3j+NwQBu14LDbczyNnJyWfrqePqg5UeKVUpR
         uHLU9TmHMO78/P96gP5U0wsacIfnTFA4Ks2KgOfkaOa6S4U1c35SJ/2a0YxyRS0pOm
         SNZiffrSz9YnsWRYxa9TVEjvO7uvTHO/SsQt/6dyqLphmM7m9VRkEHtat/BPXqMeRl
         GiGIrcqY2Q56w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH -tip v3 1/6] kprobes: treewide: Cleanup the error messages for kprobes
Date:   Thu, 29 Jul 2021 00:29:29 +0900
Message-Id: <162748616893.59465.5859769689290877137.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162748615977.59465.13262421617578791515.stgit@devnote2>
References: <162748615977.59465.13262421617578791515.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This clean up the error/notification messages in kprobes related code.
Basically this defines 'pr_fmt()' macros for each files and update
the messages which describes

 - what happened,
 - what is the kernel going to do or not do,
 - is the kernel fine,
 - what can the user do about it.

Also, if the message is not needed (e.g. the function returns unique
error code, or other error message is already shown.) remove it,
and replace the message with WARN_*() macros if suitable.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/core.c     |    4 +++-
 arch/arm64/kernel/probes/kprobes.c |    5 ++++-
 arch/csky/kernel/probes/kprobes.c  |   10 +++++-----
 arch/mips/kernel/kprobes.c         |   11 +++++------
 arch/riscv/kernel/probes/kprobes.c |   11 +++++------
 arch/s390/kernel/kprobes.c         |    4 +++-
 kernel/kprobes.c                   |   36 ++++++++++++++++--------------------
 7 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 27e0af78e88b..a59e38de4a03 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -11,6 +11,8 @@
  * Copyright (C) 2007 Marvell Ltd.
  */
 
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 #include <linux/module.h>
@@ -278,7 +280,7 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				break;
 			case KPROBE_REENTER:
 				/* A nested probe was hit in FIQ, it is a BUG */
-				pr_warn("Unrecoverable kprobe detected.\n");
+				pr_warn("Failed to recover from reentered kprobes.\n");
 				dump_kprobe(p);
 				fallthrough;
 			default:
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 6dbcc89f6662..ce429cbacd35 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -7,6 +7,9 @@
  * Copyright (C) 2013 Linaro Limited.
  * Author: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
  */
+
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/extable.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -218,7 +221,7 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 		break;
 	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
-		pr_warn("Unrecoverable kprobe detected.\n");
+		pr_warn("Failed to recover from reentered kprobes.\n");
 		dump_kprobe(p);
 		BUG();
 		break;
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 68b22b499aeb..e823c3051b24 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/kprobes.h>
 #include <linux/extable.h>
 #include <linux/slab.h>
@@ -77,10 +79,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
 
-	if (probe_addr & 0x1) {
-		pr_warn("Address not aligned.\n");
-		return -EINVAL;
-	}
+	if (probe_addr & 0x1)
+		return -EILSEQ;
 
 	/* copy instruction */
 	p->opcode = le32_to_cpu(*p->addr);
@@ -225,7 +225,7 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 		break;
 	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
-		pr_warn("Unrecoverable kprobe detected.\n");
+		pr_warn("Failed to recover from reentered kprobes.\n");
 		dump_kprobe(p);
 		BUG();
 		break;
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 75bff0f77319..b0934a0d7aed 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -11,6 +11,8 @@
  *   Copyright (C) IBM Corporation, 2002, 2004
  */
 
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/kprobes.h>
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
@@ -80,8 +82,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	insn = p->addr[0];
 
 	if (insn_has_ll_or_sc(insn)) {
-		pr_notice("Kprobes for ll and sc instructions are not"
-			  "supported\n");
+		pr_notice("Kprobes for ll and sc instructions are not supported\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -219,7 +220,7 @@ static int evaluate_branch_instruction(struct kprobe *p, struct pt_regs *regs,
 	return 0;
 
 unaligned:
-	pr_notice("%s: unaligned epc - sending SIGBUS.\n", current->comm);
+	pr_notice("Failed to emulate branch instruction because of unaligned epc - sending SIGBUS to %s.\n", current->comm);
 	force_sig(SIGBUS);
 	return -EFAULT;
 
@@ -238,10 +239,8 @@ static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->cp0_epc = (unsigned long)p->addr;
 	else if (insn_has_delayslot(p->opcode)) {
 		ret = evaluate_branch_instruction(p, regs, kcb);
-		if (ret < 0) {
-			pr_notice("Kprobes: Error in evaluating branch\n");
+		if (ret < 0)
 			return;
-		}
 	}
 	regs->cp0_epc = (unsigned long)&p->ainsn.insn[0];
 }
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 00088dc6da4b..cab6f874358e 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/kprobes.h>
 #include <linux/extable.h>
 #include <linux/slab.h>
@@ -50,11 +52,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
 
-	if (probe_addr & 0x1) {
-		pr_warn("Address not aligned.\n");
-
-		return -EINVAL;
-	}
+	if (probe_addr & 0x1)
+		return -EILSEQ;
 
 	/* copy instruction */
 	p->opcode = *p->addr;
@@ -191,7 +190,7 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 		break;
 	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
-		pr_warn("Unrecoverable kprobe detected.\n");
+		pr_warn("Failed to recover from reentered kprobes.\n");
 		dump_kprobe(p);
 		BUG();
 		break;
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 52d056a5f89f..952d44b0610b 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -7,6 +7,8 @@
  * s390 port, used ppc64 as template. Mike Grundy <grundym@us.ibm.com>
  */
 
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/moduleloader.h>
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
@@ -259,7 +261,7 @@ static void kprobe_reenter_check(struct kprobe_ctlblk *kcb, struct kprobe *p)
 		 * is a BUG. The code path resides in the .kprobes.text
 		 * section and is executed with interrupts disabled.
 		 */
-		pr_err("Invalid kprobe detected.\n");
+		pr_err("Failed to recover from reentered kprobes.\n");
 		dump_kprobe(p);
 		BUG();
 	}
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 30199bfcc74a..7663c8a51889 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -18,6 +18,9 @@
  *		<jkenisto@us.ibm.com> and Prasanna S Panchamukhi
  *		<prasanna@in.ibm.com> added function-return probes.
  */
+
+#define pr_fmt(fmt) "kprobes: " fmt
+
 #include <linux/kprobes.h>
 #include <linux/hash.h>
 #include <linux/init.h>
@@ -892,7 +895,7 @@ static void optimize_all_kprobes(void)
 				optimize_kprobe(p);
 	}
 	cpus_read_unlock();
-	printk(KERN_INFO "Kprobes globally optimized\n");
+	pr_info("kprobe jump-optimization is enabled. All kprobes are optimized if possible.\n");
 out:
 	mutex_unlock(&kprobe_mutex);
 }
@@ -925,7 +928,7 @@ static void unoptimize_all_kprobes(void)
 
 	/* Wait for unoptimizing completion */
 	wait_for_kprobe_optimizer();
-	printk(KERN_INFO "Kprobes globally unoptimized\n");
+	pr_info("kprobe jump-optimization is disabled. All kprobes are based on software breakpoint.\n");
 }
 
 static DEFINE_MUTEX(kprobe_sysctl_mutex);
@@ -1003,7 +1006,7 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 	 * unregistered.
 	 * Thus there should be no chance to reuse unused kprobe.
 	 */
-	printk(KERN_ERR "Error: There should be no unused kprobe here.\n");
+	WARN_ON_ONCE(1);
 	return -EINVAL;
 }
 
@@ -1040,18 +1043,13 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	int ret = 0;
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
-	if (ret) {
-		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
-			 p->addr, ret);
+	if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
 		return ret;
-	}
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (ret) {
-			pr_debug("Failed to init kprobe-ftrace (%d)\n", ret);
+		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret))
 			goto err_ftrace;
-		}
 	}
 
 	(*cnt)++;
@@ -1083,14 +1081,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 
 	if (*cnt == 1) {
 		ret = unregister_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (%d)\n", ret))
+		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (error %d)\n", ret))
 			return ret;
 	}
 
 	(*cnt)--;
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (error %d)\n",
 		  p->addr, ret);
 	return ret;
 }
@@ -1880,7 +1878,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 
 		node = node->next;
 	}
-	pr_err("Oops! Kretprobe fails to find correct return address.\n");
+	pr_err("kretprobe: Return address not found, not execute handler. Maybe there is a bug in the kernel.\n");
 	BUG_ON(1);
 
 found:
@@ -2209,8 +2207,7 @@ EXPORT_SYMBOL_GPL(enable_kprobe);
 /* Caller must NOT call this in usual path. This is only for critical case */
 void dump_kprobe(struct kprobe *kp)
 {
-	pr_err("Dumping kprobe:\n");
-	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
+	pr_err("Dump kprobe:\n.symbol_name = %s, .offset = %x, .addr = %pS\n",
 	       kp->symbol_name, kp->offset, kp->addr);
 }
 NOKPROBE_SYMBOL(dump_kprobe);
@@ -2473,8 +2470,7 @@ static int __init init_kprobes(void)
 	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
 					__stop_kprobe_blacklist);
 	if (err) {
-		pr_err("kprobes: failed to populate blacklist: %d\n", err);
-		pr_err("Please take care of using kprobes.\n");
+		pr_err("Failed to populate blacklist (error %d), kprobes not restricted, be careful using them!\n", err);
 	}
 
 	if (kretprobe_blacklist_size) {
@@ -2483,7 +2479,7 @@ static int __init init_kprobes(void)
 			kretprobe_blacklist[i].addr =
 				kprobe_lookup_name(kretprobe_blacklist[i].name, 0);
 			if (!kretprobe_blacklist[i].addr)
-				printk("kretprobe: lookup failed: %s\n",
+				pr_err("Failed to lookup symbol '%s' for kretprobe blacklist. Maybe the target function is removed or renamed.\n",
 				       kretprobe_blacklist[i].name);
 		}
 	}
@@ -2687,7 +2683,7 @@ static int arm_all_kprobes(void)
 	}
 
 	if (errors)
-		pr_warn("Kprobes globally enabled, but failed to arm %d out of %d probes\n",
+		pr_warn("Kprobes globally enabled, but failed to enable %d out of %d probes. Please check which kprobes are kept disabled via debugfs.\n",
 			errors, total);
 	else
 		pr_info("Kprobes globally enabled\n");
@@ -2730,7 +2726,7 @@ static int disarm_all_kprobes(void)
 	}
 
 	if (errors)
-		pr_warn("Kprobes globally disabled, but failed to disarm %d out of %d probes\n",
+		pr_warn("Kprobes globally disabled, but failed to disable %d out of %d probes. Please check which kprobes are kept enabled via debugfs.\n",
 			errors, total);
 	else
 		pr_info("Kprobes globally disabled\n");

