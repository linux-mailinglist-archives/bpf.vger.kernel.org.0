Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49683AC4AA
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhFRHJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 03:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhFRHJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 03:09:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 465FF6100A;
        Fri, 18 Jun 2021 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624000040;
        bh=3tn+mKttIhl6B6aZ+Em2tVtX8FIsTpCZn3isL59O8XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYUuucuXybx9Cj6rRgXrnwP6OX92aZMtUezV4uFUr/lIdBX44tTYXZuyfAuxlB8bW
         L6l29aClqpEpL+OY/CpNTWKcNEOy0SKpysS3AUBHTkLQAS7W/WP7BVIzS8Mlt0GXO6
         PFyxEyw6pLSSex65itU4+QktY8/iVuEB8RZgTfrEH+c9hih99RujGQC+BOm0us/+gI
         CkBKPkYlTc/0StD/2COWAda1zWGJz21+2Yt63FPlJZTpxwyEb+Kgp2O6LyNYRwG9CO
         yQwvGRURTZsNOkafL/cqavAsNvMpZ7eIzQ7IwoU0IYqC3l155hhMKhdSDkvX96zPJj
         nCo04txgC/TJA==
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
Subject: [PATCH -tip v8 12/13] tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
Date:   Fri, 18 Jun 2021 16:07:17 +0900
Message-Id: <162400003685.506599.13956516484858326490.stgit@devnote2>
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

ftrace shows "[unknown/kretprobe'd]" indicator all addresses in the
kretprobe_trampoline, but the modified address by kretprobe should
be only kretprobe_trampoline+0.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Andrii Nakryik <andrii@kernel.org>
---
 kernel/trace/trace_output.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d0368a569bfa..e46780670742 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 
@@ -346,22 +347,12 @@ int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(trace_output_call);
 
-#ifdef CONFIG_KRETPROBES
-static inline const char *kretprobed(const char *name)
+static inline const char *kretprobed(const char *name, unsigned long addr)
 {
-	static const char tramp_name[] = "kretprobe_trampoline";
-	int size = sizeof(tramp_name);
-
-	if (strncmp(tramp_name, name, size) == 0)
+	if (is_kretprobe_trampoline(addr))
 		return "[unknown/kretprobe'd]";
 	return name;
 }
-#else
-static inline const char *kretprobed(const char *name)
-{
-	return name;
-}
-#endif /* CONFIG_KRETPROBES */
 
 void
 trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
@@ -374,7 +365,7 @@ trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 		sprint_symbol(str, address);
 	else
 		kallsyms_lookup(address, NULL, NULL, NULL, str);
-	name = kretprobed(str);
+	name = kretprobed(str, address);
 
 	if (name && strlen(name)) {
 		trace_seq_puts(s, name);

