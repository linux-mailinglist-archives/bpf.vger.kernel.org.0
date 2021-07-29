Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCD3DA5BA
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbhG2OJe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 10:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238168AbhG2OG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9E2B6054F;
        Thu, 29 Jul 2021 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567578;
        bh=kUjRAsUJAvqqF/fu50NFX1B7buaDJp8RhXmXiEEbx2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beXXkvwVsY2lwj6ejD3SF3rtmmdlFNu7a84xVNro7a+Wxh8V7SRqEf7RrW+DyGAr3
         lA6VHFfcFbPGWlDDLpm5V0DKSiOQWiqJp04IDUk6lmLl+9XSgixE2PmvvadlU2g9zL
         6K0lJShCxdM2YThlzrZ1GgXII66DnNlyIBUHvX9cXhqBGXV9Kq0e3oz7uwJhtvaPYJ
         KISQ4Yg7MyKSW9n6XP/jZBlCZ53y5DmSzbjCWLtlQufSX8hM7pLS4mesUxlwmN8Bbr
         gWY3L8zQ9n+yhQ8RVBTCLhMXsfm/qMzswb6yYLpqunsL01ylINd6KnaCHPXaKWC8LN
         O/BrgUjThl8/g==
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
Subject: [PATCH -tip v10 02/16] kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
Date:   Thu, 29 Jul 2021 23:06:14 +0900
Message-Id: <162756757416.301564.16511253361780129309.stgit@devnote2>
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

~15 years ago kprobes grew the 'arch_deref_entry_point()' __weak function:

  3d7e33825d87: ("jprobes: make jprobes a little safer for users")

But this is just open-coded dereference_symbol_descriptor() in essence, and
its obscure nature was causing bugs.

Just use the real thing and remove arch_deref_entry_point().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
---
 Changes in v9:
  - Update changelog according to Ingo's suggestion.
 Changes in v6:
  - Use dereference_symbol_descriptor() so that it can handle address in
    modules correctly.
---
 arch/ia64/kernel/kprobes.c    |    5 -----
 arch/powerpc/kernel/kprobes.c |   11 -----------
 include/linux/kprobes.h       |    1 -
 kernel/kprobes.c              |    7 +------
 lib/error-inject.c            |    3 ++-
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index d4048518a1d7..0f8573bbf520 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -891,11 +891,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-unsigned long arch_deref_entry_point(void *entry)
-{
-	return ((struct fnptr *)entry)->ip;
-}
-
 static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index cbc28d1a2e1b..077ab73e6e56 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -541,17 +541,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
-unsigned long arch_deref_entry_point(void *entry)
-{
-#ifdef PPC64_ELF_ABI_v1
-	if (!kernel_text_address((unsigned long)entry))
-		return ppc_global_function_entry(entry);
-	else
-#endif
-		return (unsigned long)entry;
-}
-NOKPROBE_SYMBOL(arch_deref_entry_point);
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ba3f9e316d4..2ed61fcbc89c 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -381,7 +381,6 @@ int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
 void unregister_kretprobe(struct kretprobe *rp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8021bccb7770..550042d9a6ef 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1861,11 +1861,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 	.priority = 0x7fffffff /* we need to be notified first */
 };
 
-unsigned long __weak arch_deref_entry_point(void *entry)
-{
-	return (unsigned long)entry;
-}
-
 #ifdef CONFIG_KRETPROBES
 
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
@@ -2327,7 +2322,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	int ret;
 
 	for (iter = start; iter < end; iter++) {
-		entry = arch_deref_entry_point((void *)*iter);
+		entry = (unsigned long)dereference_symbol_descriptor((void *)*iter);
 		ret = kprobe_add_ksym_blacklist(entry);
 		if (ret == -EINVAL)
 			continue;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index c73651b15b76..2ff5ef689d72 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <asm/sections.h>
 
 /* Whitelist of symbols that can be overridden for error injection. */
 static LIST_HEAD(error_injection_list);
@@ -64,7 +65,7 @@ static void populate_error_injection_list(struct error_injection_entry *start,
 
 	mutex_lock(&ei_mutex);
 	for (iter = start; iter < end; iter++) {
-		entry = arch_deref_entry_point((void *)iter->addr);
+		entry = (unsigned long)dereference_symbol_descriptor((void *)iter->addr);
 
 		if (!kernel_text_address(entry) ||
 		    !kallsyms_lookup_size_offset(entry, &size, &offset)) {

