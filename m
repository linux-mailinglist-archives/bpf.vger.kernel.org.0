Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBF341CAF
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhCSMWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhCSMWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:22:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F30064F77;
        Fri, 19 Mar 2021 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156520;
        bh=cuK8J78AbxfogMJXXKkEvrxRm/eRUIxTyi0pKFZ7yKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcZC5/d6k6CI6oaOf1k5SHJ0CHrLtWOwdNmADHo7pziau9yuPr1gCmkFT8shu/G1V
         818EU+V8a4xshg/ZYRcFFHtoJKiYoCpy0K9k6qZ+HsXlJgMNw8YkmIswSBYP2XTYSO
         6zvSu/tVfEpLWbrkBsogCPXFk7mYHKLGjFZs2b92rGEvmBt8ymIhbchr0frApuMkRU
         zb8AwSQj/OV7rdYRAbYAAGjbOmtYKWhQcATVvCSq3uGFF2uKcfhqvKjsyDxuj8evit
         4mxMzAAE4weXwYD7mP2r9mhfdzH/oi714KZfHmb57YAQ+i4j4oiMhiEsXC9MCUQRJm
         57GwdSiwEwnTQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 01/11] ia64: kprobes: Fix to pass correct trampoline address to the handler
Date:   Fri, 19 Mar 2021 21:21:55 +0900
Message-Id: <161615651484.306069.13374738532116114679.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161615650355.306069.17260992641363840330.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
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
 arch/ia64/kernel/kprobes.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index fc1ff8a4d7de..006fbc1d7ae9 100644
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
+		dereference_function_description(kretprobe_trampoline);
 	return register_kprobe(&trampoline_p);
 }
 
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	if (p->addr ==
-		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip)
+		dereference_function_descriptor(kretprobe_trampoline))
 		return 1;
 
 	return 0;

