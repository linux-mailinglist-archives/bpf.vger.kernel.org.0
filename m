Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376273439A4
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCVGkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVGkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:40:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D86216196C;
        Mon, 22 Mar 2021 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395213;
        bh=gA6qym6a5DphTZNgwFeBr65Ji0n4GlNkaWEMJsVYqfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQmSQVVQLNaoATR1TaUewU07MZAlNETEaK539O1cJCXDc37zn5saeX0v3eu+PE/BN
         Z/fhNXeh4DwTWrDFZ8AZmKqwaZsc8LYglPWGQpBfjZ0flC4ltDdr9ZN1q2UR/G4YVf
         sD8S7uiiD9zCNEbc74f8mxtBiFvty6ipnfU7rabrkc3lna9l0/pJpkxiCuGzcTlx1G
         aaQ3EP/dZCQoJ2MyveUV+XaPfxk2dcj4Q4PvZt8CIbtbnxjqE7qbWLnjybJVvVpCQq
         AUw2Lmq875BQYREr0TSn613RWYhu0U63yR1eFWr1tpXdgR4FIiTcv39iHugK7pFT/7
         N2AKXqZckLUrQ==
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
Subject: [PATCH -tip v4 02/12] kprobes: treewide: Replace arch_deref_entry_point() with dereference_function_descriptor()
Date:   Mon, 22 Mar 2021 15:40:07 +0900
Message-Id: <161639520703.895304.14963399769218643957.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161639518354.895304.15627519393073806809.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace arch_deref_entry_point() with dereference_function_descriptor()
because those are doing same thing.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/ia64/kernel/kprobes.c    |    5 -----
 arch/powerpc/kernel/kprobes.c |   11 -----------
 include/linux/kprobes.h       |    1 -
 kernel/kprobes.c              |    7 +------
 lib/error-inject.c            |    3 ++-
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 006fbc1d7ae9..15871eb170c0 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -907,11 +907,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
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
index 01ab2163659e..eb0460949e1b 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -539,17 +539,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
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
index 1883a4a9f16a..d65c041b5c22 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -390,7 +390,6 @@ int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
 void unregister_kretprobe(struct kretprobe *rp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..2913de07f4a3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1856,11 +1856,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 	.priority = 0x7fffffff /* we need to be notified first */
 };
 
-unsigned long __weak arch_deref_entry_point(void *entry)
-{
-	return (unsigned long)entry;
-}
-
 #ifdef CONFIG_KRETPROBES
 
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
@@ -2324,7 +2319,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	int ret;
 
 	for (iter = start; iter < end; iter++) {
-		entry = arch_deref_entry_point((void *)*iter);
+		entry = (unsigned long)dereference_function_descriptor((void *)*iter);
 		ret = kprobe_add_ksym_blacklist(entry);
 		if (ret == -EINVAL)
 			continue;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index c73651b15b76..f71875ac5f9f 100644
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
+		entry = (unsigned long)dereference_function_descriptor((void *)iter->addr);
 
 		if (!kernel_text_address(entry) ||
 		    !kallsyms_lookup_size_offset(entry, &size, &offset)) {

