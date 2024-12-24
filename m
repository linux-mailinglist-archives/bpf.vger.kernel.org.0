Return-Path: <bpf+bounces-47598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3819FC1BA
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 20:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B62162412
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFB21322C;
	Tue, 24 Dec 2024 19:38:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF4212FB0;
	Tue, 24 Dec 2024 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735069087; cv=none; b=OyUMrFROCSyDRuYk5VwzE9Vo2eroe397+kxlIkEueBPMFXpE8mvU+pP48WVz5i63YqvKeRp1IEUaUYfOY7ZXsYOudMk+Z1sNwmM/nmbUZ8MYUMnWTQ4My2DXL7e31qM+nbOyyj0xZ5vGUzfOVzbOQLjhQiBn0YJXI9CNEQVWr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735069087; c=relaxed/simple;
	bh=SCpIyQbj0fJ1XZeODbcJGD9LztMw8yE4rbUHoxdFwHM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fG10ctWjEGr5jr+IKYNKA3ef1pPl+ggqUvkt+3QV/NNSUMMB+S9Z4qlZbXqLvTSeVTG9jUh5xdG2ENRVB6aV1rZQ1sy0EkJ8LOL+1iE4XXOKAiTuxucg0ZJC/ORgAaM2+70s3oW1use0AgIBc0pUan+SQf/yk1Dzi94O0rbcmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4222FC4CED0;
	Tue, 24 Dec 2024 19:38:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tQAk9-0000000EVHd-2H5G;
	Tue, 24 Dec 2024 14:39:01 -0500
Message-ID: <20241224193901.391549751@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 24 Dec 2024 14:38:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [for-next][PATCH 5/5] fgraph: Get ftrace recursion lock in function_graph_enter
References: <20241224193836.812390655@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Get the ftrace recursion lock in the generic function_graph_enter()
instead of each architecture code.
This changes all function_graph tracer callbacks running in
non-preemptive state. On x86 and powerpc, this is by default, but
on the other architecutres, this will be new.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/173379653720.973433.18438622234884980494.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/powerpc/kernel/trace/ftrace.c       | 6 ------
 arch/powerpc/kernel/trace/ftrace_64_pg.c | 6 ------
 arch/x86/kernel/ftrace.c                 | 7 -------
 kernel/trace/fgraph.c                    | 8 +++++++-
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 5ccd791761e8..e41daf2c4a31 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -658,7 +658,6 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	unsigned long sp = arch_ftrace_regs(fregs)->regs.gpr[1];
-	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
@@ -666,14 +665,9 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0)
-		goto out;
-
 	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
 		parent_ip = ppc_function_entry(return_to_handler);
 
-	ftrace_test_recursion_unlock(bit);
 out:
 	arch_ftrace_regs(fregs)->regs.link = parent_ip;
 }
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 98787376eb87..8fb860b90ae1 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -790,7 +790,6 @@ static unsigned long
 __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
 {
 	unsigned long return_hooker;
-	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
@@ -798,16 +797,11 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 
-	bit = ftrace_test_recursion_trylock(ip, parent);
-	if (bit < 0)
-		goto out;
-
 	return_hooker = ppc_function_entry(return_to_handler);
 
 	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
 		parent = return_hooker;
 
-	ftrace_test_recursion_unlock(bit);
 out:
 	return parent;
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4dd0ad6c94d6..33f50c80f481 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -615,7 +615,6 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	int bit;
 
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
@@ -635,14 +634,8 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	bit = ftrace_test_recursion_trylock(ip, *parent);
-	if (bit < 0)
-		return;
-
 	if (!function_graph_enter(*parent, ip, frame_pointer, parent))
 		*parent = return_hooker;
-
-	ftrace_test_recursion_unlock(bit);
 }
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ddedcb50917f..5c68d6109119 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -650,8 +650,13 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
 	int offset;
+	int bit;
 	int i;
 
+	bit = ftrace_test_recursion_trylock(func, ret);
+	if (bit < 0)
+		return -EBUSY;
+
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
@@ -697,12 +702,13 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	 * flag, set that bit always.
 	 */
 	set_bitmap(current, offset, bitmap | BIT(0));
-
+	ftrace_test_recursion_unlock(bit);
 	return 0;
  out_ret:
 	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
  out:
 	current->curr_ret_depth--;
+	ftrace_test_recursion_unlock(bit);
 	return -EBUSY;
 }
 
-- 
2.45.2



