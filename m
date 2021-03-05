Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78732EF1C
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCEPkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 10:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhCEPj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 10:39:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 447FB64F04;
        Fri,  5 Mar 2021 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614958796;
        bh=rhzQz+A72KQDegEoAZ4qfq3CspPfFQwEwfTz2wzIjhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfV8ZEv2LNV8F1Xpn89SL9DgAJuw7qm1rGNMCMD6JqVuyVXsRVU92zAm0Dprsrb4a
         xKr7CZRu/tNrqna/1n29C73vbTrkgktqIzp4O+O5QX4NnfRRrDgVxY67Vtme1faHjq
         i6FYyPyXnFzaVPAcEZJdclxRNzxMCf/oSBCPONCedZJcN7fwi3JVnAmSemUWJlQd3u
         5uiAgG/Fg4qZTw2fPkc7RtnZPkOA3SuKkgsUe/Va01/2cgbVVT0ePJ8bNEWxGiy+Z/
         AwTMFhDCmhmQqtMM+DA5weNyWEoJ+pulBwL0NQjAJ2tL6KVuRIb3uCUYSiqta2HbjC
         2KHKu/TYfnLsg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: [PATCH -tip 5/5] tracing: Remove kretprobe unknown indicator from stacktrace
Date:   Sat,  6 Mar 2021 00:39:50 +0900
Message-Id: <161495879052.346821.1701648047040447725.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161495873696.346821.10161501768906432924.stgit@devnote2>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
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

