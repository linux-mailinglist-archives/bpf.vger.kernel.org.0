Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02A3911C4
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhEZID5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhEZID4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:03:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E4B7613D3;
        Wed, 26 May 2021 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016145;
        bh=lruHPAWz+JCx1JmZ/0Vse4XTb21USc/CY1aMZrfI25g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJd0Rk23zHcoI4KJ4yWdfJ/xU3z3lhlEVC5s0XCINOGDmbvZnW4erjhOFYAfL/wYk
         DnQXZ79DJr9SUf8OnY/76848Vvo6ukfk6u7pu+KQriN4bq99z6xsd9fILzSOCuiEm9
         DBR11L8RllQHJyBsHo8sACGmT5FhWoyB19Hlf0iGaKIMUiORrkOnbvJhFCv1na1VKV
         P+vyCd53galgzKurW2iSM42FXBXcycr+WqIl//yLaITTSKKjBEIcpbr4bKa6UCJ4ze
         Xx0j27ickBYBR11hR6hmWO/0/bTVOv1sLwuXTcFQuUJTA2hLDlkOK53nfNBC95cGgc
         Ai3KVNnVC+1Kw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v6 01/13] ia64: kprobes: Fix to pass correct trampoline address to the handler
Date:   Wed, 26 May 2021 17:02:20 +0900
Message-Id: <162201614019.278331.4298879353454259298.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162201612941.278331.5293566981784464165.stgit@devnote2>
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
missed to pass the wrong trampoline address (it passes the descriptor address
instead of function entry address).
This fixes it to pass correct trampoline address to __kretprobe_trampoline_handler().
This also changes to use correct symbol dereference function to get the
function address from the kretprobe_trampoline.

Fixes: e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Fix a compile error typo.
---
 arch/ia64/kernel/kprobes.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index fc1ff8a4d7de..ca4b4fa45aef 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -398,7 +398,8 @@ static void kretprobe_trampoline(void)
 
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
+	regs->cr_iip = __kretprobe_trampoline_handler(regs,
+		dereference_function_descriptor(kretprobe_trampoline), NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
@@ -414,7 +415,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
-	regs->b0 = ((struct fnptr *)kretprobe_trampoline)->ip;
+	regs->b0 = (unsigned long)dereference_function_descriptor(kretprobe_trampoline);
 }
 
 /* Check the instruction in the slot is break */
@@ -918,14 +919,14 @@ static struct kprobe trampoline_p = {
 int __init arch_init_kprobes(void)
 {
 	trampoline_p.addr =
-		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip;
+		dereference_function_descriptor(kretprobe_trampoline);
 	return register_kprobe(&trampoline_p);
 }
 
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	if (p->addr ==
-		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip)
+		dereference_function_descriptor(kretprobe_trampoline))
 		return 1;
 
 	return 0;

