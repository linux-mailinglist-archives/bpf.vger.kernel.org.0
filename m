Return-Path: <bpf+bounces-55755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC69A863DC
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33438188D6E8
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE7221F0F;
	Fri, 11 Apr 2025 17:00:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FE218AA3;
	Fri, 11 Apr 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390838; cv=none; b=KqHkc4F6/gf0PVRT6vfn+whAYBobVnYjvC5vOgdjqezLh1YC78/lYdh/hD74Iiig6a7mxjapoF4mG1oT2K5taYkxX7w9k1l5JWlf3ZdW4/qGhsi9kAOmTtCk0ovW2sfo8emGkYLaUBU/nsNX4dk4fJTB/vIifGU7fpQxhi5SMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390838; c=relaxed/simple;
	bh=hO4XGME8TAzrE0q5v6+x5le7ATOxe1KHXdX7KCcunQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUXPRZdOZhQgcxvzgJv4Cq3wjdeK6e/SOQGgtdEyf2hFnCjhGA+EtP+ZS/EgZapnE5xVWgpzr0KiQzPb0tiWOJGAT1PdWqaP+4llJ9FsoDkj0TlL4fBjzm9dEYB37sIkuk4wKCnbkos+tyd2ZPYfn6TXHGLWOaYV+IStFfF3w9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6DAC4CEE2;
	Fri, 11 Apr 2025 17:00:35 +0000 (UTC)
Date: Fri, 11 Apr 2025 13:02:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250411130200.76b52a61@gandalf.local.home>
In-Reply-To: <20250411124849.30d612ed@gandalf.local.home>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
	<20250411124552.36564a07@gandalf.local.home>
	<20250411124849.30d612ed@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 12:48:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Apr 2025 12:45:52 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Also, is it possible to just enable function_graph tarcing and see if it
> > adds these blank lines between events?  
> 
> Never mind. When I enable the funcgraph-retval option, I get the blank
> lines too.
> 
> There's likely an added '\n' that shouldn't be. Let me go look.
> 

Found it, and yes it is the commit you bisected it to:

It added a '\n' when the retval option would print one too.

This should fix it:

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2f077d4158e5..718f6e84cc83 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -971,11 +971,10 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
 			print_function_args(s, entry->args, ret_func);
-			trace_seq_putc(s, ';');
+			trace_seq_puts(s, ";\n");
 		} else
-			trace_seq_puts(s, "();");
+			trace_seq_puts(s, "();\n");
 	}
-	trace_seq_printf(s, "\n");
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
-- Steve

