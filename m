Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72E540B1C5
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhINOqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhINOoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 394EF603E8;
        Tue, 14 Sep 2021 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630565;
        bh=TUCsxly137sqYFrcw/nhrPHVZpvyjgU/5fxaIE/rkoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfdvhyAXdrfDz/ean1GBuf2G+Sb0a8z85QZ6YotOejjwe827lMbyt8diZxcwnboEG
         /xWmp9KavjsczacvC4LdcMp1VlYDEhdz7+Irr0r98gg2mYf6tpt28EExDgJrnNLzA0
         THaL1yAkSuswO30oKwqi3PuNuGOJyYD1U1z68QfctN9fKSAGsS52GFJ3VKvcto7fma
         Ho3X71JVagSyEokQ/5tt4kGogpj9qB2bIYorOPtU4VCfZKPGesGCxOxWyBjWvnEQ86
         ce6u1DBFLpQvdSJ4CQEcZG18BomkuhJnQIyAOSWeZE3gJ9lOb9OnsvlMog0swjbij3
         0XEdZZ/nHVh1Q==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 26/27] tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
Date:   Tue, 14 Sep 2021 23:42:40 +0900
Message-Id: <163163056044.489837.794883849706638013.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
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
index 5a5949c659d0..3547e7176ff7 100644
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

