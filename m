Return-Path: <bpf+bounces-49833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7CA1C870
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E597165C34
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93F14B094;
	Sun, 26 Jan 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Z1ZhXN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACD2AF00
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902411; cv=none; b=Bw3hIMCehusdoX19eCfgzGpUyPgVmCjzdpGfDtH7Z/HQIs3zgwWedvBEJoMNSTD81x9zw1QTMLYVIdoT5EorP672kNNL24E/1QhG1B6PY3gf/YWLgnlGoLS22+v6Mtpf2zNbzuhIHjOb93NyVk2id1Flo09HxA2Bq09wlgjRXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902411; c=relaxed/simple;
	bh=Of6s/34NuA/HPkSmdPrlVHZZnoDx8kQdpML1kh+efqY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ICWaWe6DorJPEemuHQo8jw2HuGlyB4QkCJwhv73QSo8EFFhR9mgRmTqaqKThfgMk5Xx8p5r6oYK4Z9QnniYUif2f2Ho+vQsBKhJMQp/17qmhX6bs82fVE3PPIooiFdu/WOZlIZ+O19Y/Xkav99IrLJXiu2iL9j0wZT5ZENGwNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6Z1ZhXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680DCC4CED3;
	Sun, 26 Jan 2025 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902409;
	bh=Of6s/34NuA/HPkSmdPrlVHZZnoDx8kQdpML1kh+efqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a6Z1ZhXNIBlQS+vgmffLTnv4K4LZgWkkoNm7vDRs1wsx2mE2cUwmlCtIrDbV5gQaz
	 9VRU+o/stI6WqgHvrENVQf15AKiScyd8vAFHbjsYwjYxkUNfdHazvseZLFN7J7DsVG
	 xwalIPPZ8i38b+ERk1Uz2JBXwOhEgeKxTInK5x5AwHgC0zCcL3SL12OqVBb4Ji8H50
	 sENOTnulzVwIGWr3fveeyMQPXFHQt/HX7FNXEZe5LLs+o0bcIEr1ni3z3xLVW8vB0z
	 7v3KiqmzwFTO/NHKhkHQxgB8FSFckIBl6aLzuTzELJ+YzrtCJ6hE+h91NkZKdtJfyZ
	 TPhAzZaLzJksA==
Date: Sun, 26 Jan 2025 23:40:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Ilya Leoshkevich <iii@linux.ibm.com>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Message-Id: <20250126234005.70cb3b43193b08ed8a211553@kernel.org>
In-Reply-To: <Z5O0shrdgeExZ2kF@krava>
References: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
	<Z5N4N6MUMt8_EwGS@krava>
	<Z5O0shrdgeExZ2kF@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 16:41:38 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Jan 24, 2025 at 12:23:35PM +0100, Jiri Olsa wrote:
> > On Thu, Jan 23, 2025 at 02:32:38PM -0800, Martin KaFai Lau wrote:
> > > Hi Jiri,
> > > 
> > > The "missed/kprobe_recursion" fails consistently on s390. It seems to start
> > > failing after the recent bpf and bpf-next tree ffwd.
> > > 
> > > An example:
> > > https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920
> > > 
> > > Can you help to take a look?
> > > 
> > > afaict, it only happens on s390 so far, so cc IIya if there is any recent
> > > change that may ring the bell.
> > 
> > hi,
> > I need to check more but I wonder it's the:
> >   7495e179b478 s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> > 
> > which seems to add recursion check and bail out before we have
> > a chance to trigger it in bpf code
> 
> so the test attaches bpf program test1 to bpf_fentry_test1 via kprobe.multi
> 
> 	SEC("kprobe.multi/bpf_fentry_test1")
> 	int test1(struct pt_regs *ctx)
> 	{
> 		bpf_kfunc_common_test();
> 		return 0;
> 	}
> 
> and several other programs are attached to bpf_kfunc_common_test function
> 
> 
> I can't test this on s390, but looks like following is happening:
> 
> kprobe.multi uses fprobe, so the test kernel path goes:
> 
>     bpf_fentry_test1
>       ftrace_graph_func
>         function_graph_enter_regs
> 	   fprobe_entry
> 	     kprobe_multi_link_prog_run
> 	       test1 (bpf program)
> 	         bpf_kfunc_common_test
> 		   kprobe_ftrace_handler
> 		     kprobe_perf_func
> 		       trace_call_bpf
> 		         -> bpf_prog_active check fails, missed count is incremented
> 
> 
> kprobe_ftrace_handler calls/takes ftrace_test_recursion_trylock (ftrace recursion lock)
> 
> but s390 now calls/takes ftrace_test_recursion_trylock already in ftrace_graph_func,
> so s390 stops at kprobe_ftrace_handler and does not get to trace_call_bpf to increment
> prog->missed counters

Oops, good catch! I missed to remove it from s390. We've already moved it
in function_graph_enter_regs().


> 
> adding Sven, Masami, any idea?
> 
> if the ftrace_test_recursion_trylock is needed ftrace_graph_func on s390, then
> I think we will need to fix our test to skip s390 arch

Yes. Please try this patch;


From 12fcda79d0b1082449d5f7cfb8039b0237cf246d Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Sun, 26 Jan 2025 23:38:59 +0900
Subject: [PATCH] s390: fgraph: Fix to remove ftrace_test_recursion_trylock()

Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func()
because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
function_graph_enter") has been moved it to function_graph_enter_regs()
already.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_graph_enter")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/s390/kernel/ftrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index c0b2c97efefb..63ba6306632e 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -266,18 +266,13 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
-	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		return;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
-	bit = ftrace_test_recursion_trylock(ip, *parent);
-	if (bit < 0)
-		return;
 	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
 		*parent = (unsigned long)&return_to_handler;
-	ftrace_test_recursion_unlock(bit);
 }
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.43.0

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

