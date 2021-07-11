Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0963C3CDF
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhGKNhn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhGKNhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E170611C0;
        Sun, 11 Jul 2021 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010496;
        bh=ZNH37xRqRkeLbZ1aRCFRgCl0otMIRMYADO1YOQyAq1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX4Xw0OCrnxnLoe255Km9ealns90o/yGKYWDV1alVF//4hKbJypqShmAhhRpt824C
         JkAbDXNfpgRXWJ1e+Bj2DB7uy3jjCsFgdsR9CtQyL8qhpOY3Pdq3dXGZR5KdpWp/C9
         HDkk3cbEPXG5JHSWlyah4CqQggx2lXeHKvuBbnzkH/oEZvq1oeVDp3V2KM4miqr1YK
         /7E+Zjh7A19MSBETBhA6wq+27JsyKcta8J51kwxrGV+p9FdzBQsVFYF3awmlQcynIS
         nj6+qUVrAYFAUPhGYDjSM0thIidVTs+oFKyBJS2tSVq3OzjUrxKLZ0ud2htT1qsTku
         t/i3dvHGISYcw==
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
Subject: [PATCH -tip v9 01/14] ia64: kprobes: Fix to pass correct trampoline address to the handler
Date:   Sun, 11 Jul 2021 22:34:50 +0900
Message-Id: <162601049060.1318837.14249101984226564922.stgit@devnote2>
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

The following commit:

   Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")

Passed the wrong trampoline address to __kretprobe_trampoline_handler(): it
passes the descriptor address instead of function entry address.

Pass the right parameter.

Also use correct symbol dereference function to get the function address
from 'kretprobe_trampoline' - an IA64 special.

Fixes: e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v9:
  - Update changelog according to Ingo's suggestion.
  - Add Cc: stable tag.
 Changes in v5:
  - Fix a compile error typo.
---
 arch/ia64/kernel/kprobes.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 441ed04b1037..d4048518a1d7 100644
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
@@ -902,14 +903,14 @@ static struct kprobe trampoline_p = {
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

