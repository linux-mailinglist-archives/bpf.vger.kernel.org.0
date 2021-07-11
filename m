Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DCD3C3CE2
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhGKNhw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhGKNhv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C880661206;
        Sun, 11 Jul 2021 13:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010505;
        bh=RiQ5TeDo9L4+HfffEbpaQpdMOfNNt182vJWwUTZHaKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9TrQyS+G0XB5HiypgdLec0hVVk96fPM4IUEX3YB4gfVzT5MDua1VkcKAMN8P9CBB
         rUXQM7Q/nTGeMNgxyhCFpaIJRdmwjhjbj8te4SkVat8c5/FDGKi8y0I6/Bfa3/+iRR
         tiM5apH86G23Q8I0h3d3gKkoiZ0fhs7VwTiMb+e/u4DnHDPzR490QW2DQZQMB9PioP
         +jXkarJpDcHAQHoDRiAIUnJRfjmaeCzpi+7zW+8Aatfa9cknpdjP4SQVoQt0e84GFR
         xJo2CV+3KlfFVVsflf1WT/tVzb01LEho1d2cQHeeB3ucSjTvONvWCMPg561+EfOaEr
         kc7JeY1fGH2ow==
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
Subject: [PATCH -tip v9 02/14] kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
Date:   Sun, 11 Jul 2021 22:35:01 +0900
Message-Id: <162601050128.1318837.14068646172038704785.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162601048053.1318837.1550594515476777588.stgit@devnote2>
References: <162601048053.1318837.1550594515476777588.stgit@devnote2>
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
index 7d0d21f2315a..c9e0c13db84a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -378,7 +378,6 @@ int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
 void unregister_kretprobe(struct kretprobe *rp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2029d7ceaa11..2540cd56fa81 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1866,11 +1866,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 	.priority = 0x7fffffff /* we need to be notified first */
 };
 
-unsigned long __weak arch_deref_entry_point(void *entry)
-{
-	return (unsigned long)entry;
-}
-
 #ifdef CONFIG_KRETPROBES
 
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
@@ -2332,7 +2327,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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

