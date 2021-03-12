Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859AE338624
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhCLGoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 01:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232135AbhCLGnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:43:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6428364F7E;
        Fri, 12 Mar 2021 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531419;
        bh=HNiMwqo1C1xuNs1I168/w0oQXwOxZBUoPxMzUr3M3P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiwRXEOVZMmXWF1jP+OsWNohVWFozGUrKKgMfuVkfQw8bJViTBi5KI57P5ABbnL0E
         P6pOjoV+wLQElTBNUp+c6aLvhLFUwTVuNnK6uwtIQvuwo20ohAd0C0hbiB7bniaqMY
         aMr+7hqINZH79GBycp8/wlE7LFPnsdLkTfo7e3Q9LfmYGCNxS4wKwC/VBSiigSzlES
         VfJqR52qI8TwTlW6irLoiHO4BZC6Uo+VkDejKcd+O/sEupUrojOvtQYg6Ze5oTr4s8
         IYmFf9MCYuABzdVVDfPXcyD3FU6BYeYVYiW3JfvCTasdgRyWxixQM2sfAYCFslruy7
         OOoEu4wxFt7iw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 10/10] tracing: Remove kretprobe unknown indicator from stacktrace
Date:   Fri, 12 Mar 2021 15:43:34 +0900
Message-Id: <161553141415.1038734.16331033149026826592.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161553130371.1038734.7661319550287837734.stgit@devnote2>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the stacktrace API fixup the kretprobed address correctly,
there is no need to convert the "kretprobe_trampoline" to
 "[unknown/kretprobe'd]" anymore. Remove it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 61255bad7e01..f5f8b081b668 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -346,37 +346,18 @@ int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(trace_output_call);
 
-#ifdef CONFIG_KRETPROBES
-static inline const char *kretprobed(const char *name)
-{
-	static const char tramp_name[] = "kretprobe_trampoline";
-	int size = sizeof(tramp_name);
-
-	if (strncmp(tramp_name, name, size) == 0)
-		return "[unknown/kretprobe'd]";
-	return name;
-}
-#else
-static inline const char *kretprobed(const char *name)
-{
-	return name;
-}
-#endif /* CONFIG_KRETPROBES */
-
 void
 trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 {
 #ifdef CONFIG_KALLSYMS
-	char str[KSYM_SYMBOL_LEN];
-	const char *name;
+	char name[KSYM_SYMBOL_LEN];
 
 	if (offset)
-		sprint_symbol(str, address);
+		sprint_symbol(name, address);
 	else
-		kallsyms_lookup(address, NULL, NULL, NULL, str);
-	name = kretprobed(str);
+		kallsyms_lookup(address, NULL, NULL, NULL, name);
 
-	if (name && strlen(name)) {
+	if (strlen(name)) {
 		trace_seq_puts(s, name);
 		return;
 	}

