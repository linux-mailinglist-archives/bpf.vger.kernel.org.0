Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50A83C3CFC
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhGKNjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhGKNjP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E966128E;
        Sun, 11 Jul 2021 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010588;
        bh=/kIXBM8f89+lESwxnOunxm5owE9KTjLRRJqj6gvxtak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G96Jhx4GXlmIZ2DXda/xNY16yCh7qKEO8O2BwXkM0UGAk4xroO0q5UvGdrWUp7NRx
         96PG9ZbIloUv1i0+VG6AywovRKag9vYAv+jio5RHxlUrq7bixmb6EDTOEipzxL/sCm
         th2ksYV1HLuTfGcEI2ZPV1yIZn4V4OSGcNfeBjywGa7IRmxUXcTOxOF/bj12CXmTek
         iiDG7M9JnNHWQSNbmDj4HvM5DKMCkHmYXcUJPOCut3dmZS9LYk1AF5Ums6eD6mmi3H
         MPa6gc5sNrSlCtrqmJ6ETLDyg5Sf+1pogzOwkneQqJ5Zg01ZdRqhNUzUe043h2Q20S
         zEnEdnfQV5cBQ==
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
Subject: [PATCH -tip v9 10/14] kprobes: Enable stacktrace from pt_regs in kretprobe handler
Date:   Sun, 11 Jul 2021 22:36:24 +0900
Message-Id: <162601058474.1318837.14382888792125339316.stgit@devnote2>
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

Since the ORC unwinder from pt_regs requires setting up regs->ip
correctly, set the correct return address to the regs->ip before
calling user kretprobe handler.

This allows the kretrprobe handler to trace stack from the
kretprobe's pt_regs by stack_trace_save_regs() (eBPF will do
this), instead of stack tracing from the handler context by
stack_trace_save() (ftrace will do this).

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Changes in v9:
  - Update comment to explain specifically why this is necessary.
 Changes in v8:
  - Update comment to clarify why this is needed.
 Changes in v3:
  - Cast the correct_ret_addr to unsigned long.
---
 kernel/kprobes.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8f7d659eb277..e7c75725934b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1924,6 +1924,13 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
+	/*
+	 * Set the return address as the instruction pointer, because if the
+	 * user handler calls stack_trace_save_regs() with this 'regs',
+	 * the stack trace will start from the instruction pointer.
+	 */
+	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
+
 	/* Run the user handler of the nodes. */
 	first = current->kretprobe_instances.first;
 	while (first) {

