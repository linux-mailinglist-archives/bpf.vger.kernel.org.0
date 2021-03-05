Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139EC32DE3F
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 01:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhCEAId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 19:08:33 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57167 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhCEAIb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 19:08:31 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 487C35800B3;
        Thu,  4 Mar 2021 19:08:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 04 Mar 2021 19:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=IiDRQ37sskx7d5KyMH2U5RF6b5
        //RQRDi3PCWE84WEU=; b=B4QIqIVw1a+zcivc32iQNNGSw3QG/XAPpalELcADch
        KPG4AwsVQX8wQy+LWfvKZAQ35mU1eMjCSzDjvDzgC3Yfs4LR+WTcOiTGWeMFr7Su
        xXjHL0zlP4gzLF0n+mTQqB0uhvdEPtYX0ZWXwBmRap7MeRQUr2e0a+frokQuHpxD
        LYAIKxSrjJQIGzIR4PUF/KXXUR519opMIoJLw6I2EPcoIzYKsmNyWFFP6WLX6M0v
        AV12++jx0EyI8CSLj7peOyp+v//gLZoRDwa2Dhe3Hx3x6mspGN+zTXsC0oy2BAlA
        iA/LpdD+vR1L3iXsKeRd03WAbbPxyW13P5sxLrNaiS9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IiDRQ37sskx7d5KyM
        H2U5RF6b5//RQRDi3PCWE84WEU=; b=lUQOl4SLwBPXJ8SORqZj9CvAXQ4XdYxxP
        8SacfMua/RssSy5wudmppaYvqGv5uBz/kawBJU1tL/9Xtt62Mid3+kizeins5hUC
        v3zmFx1C/dnmA9Prlr0LmP4UJT4Ot/wxJdwK7ZCzTLAvm7j2ZJUx+h/LPT0MJSBQ
        o0fa3v29OiOfrZUDtL8t1BmW1PHN9TbRiycPgB5KIAvEnwJgSndYFaOResboWv/K
        DWT07Tg44wfoHXvQniQL5bUiMYjLuMqIOP4bVRL5FBQWp1Qrg7j1TDW2en5MYd8m
        CZx9UIKsLBCLWwFYCUPtd8Xqar2e8QI21J3jXpNuDEPu0a676oJZQ==
X-ME-Sender: <xms:fXZBYDoxCfqaT3dk_rE3vLYSTnmMblLNBIz2Gcl4Xq4k2hRQSS664A>
    <xme:fXZBYNotkq3dLn_rD4C1S055BbN1Lo9KBSEhakvs_bnmRs8PjAJYwOO_57G-IR8fp
    AYNY9_cAbJB5iWtPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddthedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucfkphepieelrddukedurddutdeh
    rdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:fXZBYAO6x4RnOh5lcgJkkhYcXFKu7wor8_jjYwb_VSEr5S7e_cqSmw>
    <xmx:fXZBYG5R0FNPwebHu_Yt4ngLJqhHkWMccGO2bwk2-dkBmWS9D7XY8Q>
    <xmx:fXZBYC5Eh4p11HAQcNh94__H1CGMI6Oqv4lbJI40822OwU0YOqbkMA>
    <xmx:fnZBYPw9H_BIfqnocW7PXHgfmijyF9aGteJpQD0vHZ0fKGrKzJ2M-w>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 703A524005B;
        Thu,  4 Mar 2021 19:08:26 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@redhat.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kuba@kernel.org, ast@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, yhs@fb.com
Subject: [PATCH] x86: kprobes: orc: Fix ORC walks in kretprobes
Date:   Thu,  4 Mar 2021 16:07:52 -0800
Message-Id: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Getting a stack trace from inside a kretprobe used to work with frame
pointer stack walks. After the default unwinder was switched to ORC,
stack traces broke because ORC did not know how to skip the
`kretprobe_trampoline` "frame".

Frame based stack walks used to work with kretprobes because
`kretprobe_trampoline` does not set up a new call frame. Thus, the frame
pointer based unwinder could walk directly to the kretprobe'd caller.

For example, this stack is walked incorrectly with ORC + kretprobe:

    # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
    Attaching 1 probe...
    ^C

    @[
        kretprobe_trampoline+0
    ]: 1

After this patch, the stack is walked correctly:

    # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
    Attaching 1 probe...
    ^C

    @[
        kretprobe_trampoline+0
        __x64_sys_nanosleep+150
        do_syscall_64+51
        entry_SYSCALL_64_after_hwframe+68
    ]: 12

Fixes: fc72ae40e303 ("x86/unwind: Make CONFIG_UNWINDER_ORC=y the default in kconfig for 64-bit")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 arch/x86/kernel/unwind_orc.c | 53 +++++++++++++++++++++++++++++++++++-
 kernel/kprobes.c             |  8 +++---
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2a1d47f47eee..1b88d75e2e9e 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kprobes.h>
 #include <linux/objtool.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <asm/kprobes.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -77,9 +79,11 @@ static struct orc_entry *orc_module_find(unsigned long ip)
 }
 #endif
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#if defined(CONFIG_DYNAMIC_FTRACE) || defined(CONFIG_KRETPROBES)
 static struct orc_entry *orc_find(unsigned long ip);
+#endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * Ftrace dynamic trampolines do not have orc entries of their own.
  * But they are copies of the ftrace entries that are static and
@@ -117,6 +121,43 @@ static struct orc_entry *orc_ftrace_find(unsigned long ip)
 }
 #endif
 
+#ifdef CONFIG_KRETPROBES
+static struct orc_entry *orc_kretprobe_find(void)
+{
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *node;
+
+	node = current->kretprobe_instances.first;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+
+		if ((void *)ri->ret_addr != &kretprobe_trampoline) {
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			correct_ret_addr = ri->ret_addr;
+			break;
+		}
+
+
+		node = node->next;
+	}
+
+	if (!correct_ret_addr)
+		return NULL;
+
+	return orc_find((unsigned long)correct_ret_addr);
+}
+#else
+static struct orc_entry *orc_kretprobe_find(void)
+{
+	return NULL;
+}
+#endif
+
 /*
  * If we crash with IP==0, the last successfully executed instruction
  * was probably an indirect function call with a NULL function pointer,
@@ -148,6 +189,16 @@ static struct orc_entry *orc_find(unsigned long ip)
 	if (ip == 0)
 		return &null_orc_entry;
 
+	/*
+	 * Kretprobe lookup -- must occur before vmlinux addresses as
+	 * kretprobe_trampoline is in the symbol table.
+	 */
+	if (ip == (unsigned long) &kretprobe_trampoline) {
+		orc = orc_kretprobe_find();
+		if (orc)
+			return orc;
+	}
+
 	/* For non-init vmlinux addresses, use the fast lookup table: */
 	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
 		unsigned int idx, start, stop;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..334c23d33451 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1895,10 +1895,6 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 	BUG_ON(1);
 
 found:
-	/* Unlink all nodes for this frame. */
-	current->kretprobe_instances.first = node->next;
-	node->next = NULL;
-
 	/* Run them..  */
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
@@ -1917,6 +1913,10 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		recycle_rp_inst(ri);
 	}
 
+	/* Unlink all nodes for this frame. */
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
+
 	return (unsigned long)correct_ret_addr;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
-- 
2.30.1

