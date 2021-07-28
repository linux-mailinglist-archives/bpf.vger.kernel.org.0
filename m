Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB983D91FC
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhG1PaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 11:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhG1PaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 11:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4494361019;
        Wed, 28 Jul 2021 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627486211;
        bh=iJwpXsKZ09Nzj3SzlL+t4RJ/RQtXzdCPhjS/z0l95zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLoOB3Re2MGaC09mNU4a8iA2lQ7c0wh/1F/vqgt9jfUutCiSIpV06YRttulUxNnaQ
         aJsnfZSwg0O5OZhFFwFftYiZsRFBI/tlbTSgfFkFGmjVGfApU8wgBQFRN+bkfih/1K
         kekDrWbv2OMbrW0EpamU94dAZQFQVlLDS+E0O69QEA+uqtvgCT2P2mkAkCTXuoibMY
         /pChMJ6VOYk8dLEmHR5+UfiXeMx2zUbYv0BGo6N8l7yQfOaxMTacAqTDBFD81AO7xM
         KXolygMkrAkgGPPOjMDL+jjelnBHO4kmNRj95JMrPyIRwI9B+WSSSsxIQiOPxEfw1P
         +9afUFcINRXYA==
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
Subject: [PATCH -tip v3 5/6] kprobes: treewide: Use 'kprobe_opcode_t *' for the code address in get_optimized_kprobe()
Date:   Thu, 29 Jul 2021 00:30:06 +0900
Message-Id: <162748620661.59465.6395105639811412052.stgit@devnote2>
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

Since get_optimized_kprobe() is only used inside kprobes,
it doesn't need to use 'unsigned long' type for 'addr' parameter.
Make it use 'kprobe_opcode_t *' for the 'addr' parameter and
subsequent call of arch_within_optimized_kprobe() also should use
'kprobe_opcode_t *'.

Note that MAX_OPTIMIZED_LENGTH and RELATIVEJUMP_SIZE are defined
by byte-size, but the size of 'kprobe_opcode_t' depends on the
architecture. Therefore, we must be careful when calculating
addresses using those macros.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/opt-arm.c |    7 ++++---
 arch/powerpc/kernel/optprobes.c   |    6 +++---
 arch/x86/kernel/kprobes/opt.c     |    6 +++---
 include/linux/kprobes.h           |    2 +-
 kernel/kprobes.c                  |   10 +++++-----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index c78180172120..dbef34ed933f 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -347,10 +347,11 @@ void arch_unoptimize_kprobes(struct list_head *oplist,
 }
 
 int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-				unsigned long addr)
+				 kprobe_opcode_t *addr)
 {
-	return ((unsigned long)op->kp.addr <= addr &&
-		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
+	return (op->kp.addr <= addr &&
+		op->kp.addr + (RELATIVEJUMP_SIZE / sizeof(kprobe_opcode_t)) > addr);
+
 }
 
 void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index c79899abcec8..325ba544883c 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -301,8 +301,8 @@ void arch_unoptimize_kprobes(struct list_head *oplist, struct list_head *done_li
 	}
 }
 
-int arch_within_optimized_kprobe(struct optimized_kprobe *op, unsigned long addr)
+int arch_within_optimized_kprobe(struct optimized_kprobe *op, kprobe_opcode_t *addr)
 {
-	return ((unsigned long)op->kp.addr <= addr &&
-		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
+	return (op->kp.addr <= addr &&
+		op->kp.addr + (RELATIVEJUMP_SIZE / sizeof(kprobe_opcode_t)) > addr);
 }
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 71425ebba98a..b4a54a52aa59 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -367,10 +367,10 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
 
 /* Check the addr is within the optimized instructions. */
 int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-				 unsigned long addr)
+				 kprobe_opcode_t *addr)
 {
-	return ((unsigned long)op->kp.addr <= addr &&
-		(unsigned long)op->kp.addr + op->optinsn.size > addr);
+	return (op->kp.addr <= addr &&
+		op->kp.addr + op->optinsn.size > addr);
 }
 
 /* Free optimized instruction slot */
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9c28fbb18e74..6a5995f334a0 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -329,7 +329,7 @@ extern void arch_unoptimize_kprobes(struct list_head *oplist,
 				    struct list_head *done_list);
 extern void arch_unoptimize_kprobe(struct optimized_kprobe *op);
 extern int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-					unsigned long addr);
+					kprobe_opcode_t *addr);
 
 extern void opt_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ec3d97fd8c6b..b6f1dcf4bff3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -485,15 +485,15 @@ static int kprobe_queued(struct kprobe *p)
  * Return an optimized kprobe whose optimizing code replaces
  * instructions including 'addr' (exclude breakpoint).
  */
-static struct kprobe *get_optimized_kprobe(unsigned long addr)
+static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 {
 	int i;
 	struct kprobe *p = NULL;
 	struct optimized_kprobe *op;
 
 	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
-		p = get_kprobe((void *)(addr - i));
+	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+		p = get_kprobe(addr - i);
 
 	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
@@ -967,7 +967,7 @@ static void __arm_kprobe(struct kprobe *p)
 	lockdep_assert_held(&text_mutex);
 
 	/* Find the overlapping optimized kprobes. */
-	_p = get_optimized_kprobe((unsigned long)p->addr);
+	_p = get_optimized_kprobe(p->addr);
 	if (unlikely(_p))
 		/* Fallback to unoptimized kprobe */
 		unoptimize_kprobe(_p, true);
@@ -989,7 +989,7 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 	if (!kprobe_queued(p)) {
 		arch_disarm_kprobe(p);
 		/* If another kprobe was blocked, re-optimize it. */
-		_p = get_optimized_kprobe((unsigned long)p->addr);
+		_p = get_optimized_kprobe(p->addr);
 		if (unlikely(_p) && reopt)
 			optimize_kprobe(_p);
 	}

