Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9A3AC488
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhFRHHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 03:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhFRHHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 03:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B91DB61351;
        Fri, 18 Jun 2021 07:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623999934;
        bh=miHpFDmx4DL40GEYK1JdPaxrsRuu26/ovjGnumdfRuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3VCCg+wmAT956pykeGY4cNGDqzOCTzUylcdGRRgOZFgQckbqF2FK7OGwQ79LaO2J
         BlOK70+bQkdDBcmUArgPaOehVBRrKShCdkqCxB2lx+hUwJPS+PRN8CAp9zADfKqxVO
         seUbawz9GzdhHiVCljrNCspyJaw5zsIAGASRy4vruChCiR+3rs75F7KI9rL6tp2tam
         7E4zUtpQdUVCklBTDk2ygjmOWQzVarm6Mwlmp31Lw2ujK5qwo+Y1MvUWtvzNoQ8QzP
         +SFxsYreFmKXGvx/Xmpig6XlvRYylrzFaQ2L9nIybAwemMx/v8dW/YiFbAVqfcNLb3
         lyCGSnXNTpESg==
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
Subject: [PATCH -tip v8 01/13] ia64: kprobes: Fix to pass correct trampoline address to the handler
Date:   Fri, 18 Jun 2021 16:05:31 +0900
Message-Id: <162399993125.506599.11062077324255866677.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162399992186.506599.8457763707951687195.stgit@devnote2>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
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

