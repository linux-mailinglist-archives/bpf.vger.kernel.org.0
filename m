Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6A34A754
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZMbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhCZMas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:30:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C468561949;
        Fri, 26 Mar 2021 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616761848;
        bh=CQnx3jNZ9PtYKmb+4+Wr6KaZMg1oCyI1sHneUUD/zYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVAw5ApnAfP15lcOutRZM+MlmxjZ/tOdlSR2Yfq2xxG9Q2Iy6zdCXTHiaMZ+/hcfF
         gFRIS/eAOQOBleCkvfbnWv/uKMvBWOrZPOabmrOhEYusC41JYIkjl8CytXALGg+rdN
         lk052/ELO7LWIx41f5Jc6k6cgz0KxSPG1GM0oi/Rv6vfy+36AZ9jdbiUq+vnknTzO3
         kNpKdG3T/tvFrvtdSipI8+rO09Gyza5aGDydNIA1S6qxRGMbcKwmq4ar3LYi4HOYEP
         sILTtjy8P0pZwdoc0mMWONOTUKPHvUQHbDN/8x+sz5/JmYSCEtsTLg5YH/7l9WuCbd
         WjmuNTpP6IMpQ==
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
Subject: [PATCH -tip v5 12/12] tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
Date:   Fri, 26 Mar 2021 21:30:42 +0900
Message-Id: <161676184261.330141.6575911414561853358.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
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
---
 kernel/trace/trace_output.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 61255bad7e01..e12437388686 100644
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

