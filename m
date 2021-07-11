Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62353C3D05
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhGKNjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233007AbhGKNjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA2A8613B9;
        Sun, 11 Jul 2021 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010620;
        bh=eGghxSMhE8YV8HgA+8KEotN9f5UNHicxTLeVqU+uIPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LihW0XiF/5X6g/zeymjROWaGBXRRrKTnMaBx3s645kOpYLfqXFzIaxoa8SBEkZkZl
         OxjT9Ul4sAs6aDLwOMMoGHQmb3Mm/dphf2ANeMn1gxETO2SFY4oU15lFyXortG9Tit
         RvfL+pbPM5B8kWLNxMgKaVnIK1yJaZ7uVEe2a0Rp/78MSTjaNPRE6sGyHeUkHMZP42
         5mYctpboXgAVOlMuiPDMo8r7gVZ0DozrVn4QzbaODVfpB9+GJvmEHlcPGnrzJEZqvd
         YwaPWP7ywcrH6SuhYOLVKUtg8x/tCvTXQTo/ctVu6oMRs5UL47u8xvbDq6YyWduYwt
         LrdYU4RYFnAjw==
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
Subject: [PATCH -tip v9 13/14] tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
Date:   Sun, 11 Jul 2021 22:36:54 +0900
Message-Id: <162601061456.1318837.7158565595387058955.stgit@devnote2>
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

ftrace shows "[unknown/kretprobe'd]" indicator all addresses in the
kretprobe_trampoline, but the modified address by kretprobe should
be only kretprobe_trampoline+0.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_output.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 9b2e69619057..bdadcc8cee75 100644
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
-	static const char tramp_name[] = "__kretprobe_trampoline";
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

