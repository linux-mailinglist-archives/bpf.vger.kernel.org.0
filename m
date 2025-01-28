Return-Path: <bpf+bounces-49930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53EAA2038F
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 05:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28AF7A3C03
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 04:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266818BC3F;
	Tue, 28 Jan 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA1iElbk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CD7485
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040241; cv=none; b=msNe+FTecOdKWjXTUJ3Cup/SHzmxfX1XkgalhrYfYmm21MA+FBt71rhWOHfhjtj8M8EMj+Ma8qgQxvLINPlhzHJWsSeYezQWoGEnemMPikHoWIL2vaPRQpldMwaerkH1AsaTKFV+sPSPnFXcEcQ/Qz4TpMGC1pNF2WBkcy/wvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040241; c=relaxed/simple;
	bh=LFEBPleBP8OEUp5sw3/IH1CCaKA+kGUcMQLaZPvE8OY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tTpD0NbWDbnDqIi3zpmrSRaEUTtQ4eWcWu4Y9ZBVDdfBtiuqKKhUP3TgDGbzC4M4IX3nW7G3347/7UzRHBVKDhMGT7xCLl9cAqNX9r1iXYbOWIlHb0xX9QRlV03Km1ZaHi3YzTy52R8UdlmzFoSCj4r/6ABCKbyKDgRxUN+QTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA1iElbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBE4C4CED3;
	Tue, 28 Jan 2025 04:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738040240;
	bh=LFEBPleBP8OEUp5sw3/IH1CCaKA+kGUcMQLaZPvE8OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IA1iElbkN6eNoNFcOju6dIW66J5wsuZ/+VTDTQ5nglQPCLpC4O3aMgGy2aHINS5RO
	 SEQDQLloGeO+uuyNG79/sPK7lymowboLhQNZoPzn/lLCsjzdQr2Bdrpk7yqgLBmoWE
	 5xN2Yrcv7LjSFYvO9PzKZA7XmHMNk/sppkYLEjTAQQcaC/8Ltjr282N1hsWG1mCD/o
	 1bVow9+WLST2CVCm9cczd3Cih0OnbYjyrUOFUuxlE+jSYjztcankGbQbPPw6qTPWKv
	 Y8YdzR7w74p/zTCvpl9b7ZKucZ2qMHP/GWXHn+rDKB8vqhcb1hYJkweUxAJqulFXKb
	 44SobhBi1SuSA==
Date: Tue, 28 Jan 2025 13:57:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Ilya Leoshkevich <iii@linux.ibm.com>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Message-Id: <20250128135718.e89fbb19f6f57a53373d499e@kernel.org>
In-Reply-To: <CAEf4BzaT8Vw+82b974S_7pDUjA+PGYKsoSzoTuO33ZQJwgrcMA@mail.gmail.com>
References: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
	<Z5N4N6MUMt8_EwGS@krava>
	<Z5O0shrdgeExZ2kF@krava>
	<20250126234005.70cb3b43193b08ed8a211553@kernel.org>
	<Z5ax5AKwIaD6ONM-@krava>
	<CAEf4BzaT8Vw+82b974S_7pDUjA+PGYKsoSzoTuO33ZQJwgrcMA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jan 2025 11:09:27 -0800
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Sun, Jan 26, 2025 at 2:06 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sun, Jan 26, 2025 at 11:40:05PM +0900, Masami Hiramatsu wrote:
> > > On Fri, 24 Jan 2025 16:41:38 +0100
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > > On Fri, Jan 24, 2025 at 12:23:35PM +0100, Jiri Olsa wrote:
> > > > > On Thu, Jan 23, 2025 at 02:32:38PM -0800, Martin KaFai Lau wrote:
> > > > > > Hi Jiri,
> > > > > >
> > > > > > The "missed/kprobe_recursion" fails consistently on s390. It seems to start
> > > > > > failing after the recent bpf and bpf-next tree ffwd.
> > > > > >
> > > > > > An example:
> > > > > > https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920
> > > > > >
> > > > > > Can you help to take a look?
> > > > > >
> > > > > > afaict, it only happens on s390 so far, so cc IIya if there is any recent
> > > > > > change that may ring the bell.
> > > > >
> > > > > hi,
> > > > > I need to check more but I wonder it's the:
> > > > >   7495e179b478 s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> > > > >
> > > > > which seems to add recursion check and bail out before we have
> > > > > a chance to trigger it in bpf code
> > > >
> > > > so the test attaches bpf program test1 to bpf_fentry_test1 via kprobe.multi
> > > >
> > > >     SEC("kprobe.multi/bpf_fentry_test1")
> > > >     int test1(struct pt_regs *ctx)
> > > >     {
> > > >             bpf_kfunc_common_test();
> > > >             return 0;
> > > >     }
> > > >
> > > > and several other programs are attached to bpf_kfunc_common_test function
> > > >
> > > >
> > > > I can't test this on s390, but looks like following is happening:
> > > >
> > > > kprobe.multi uses fprobe, so the test kernel path goes:
> > > >
> > > >     bpf_fentry_test1
> > > >       ftrace_graph_func
> > > >         function_graph_enter_regs
> > > >        fprobe_entry
> > > >          kprobe_multi_link_prog_run
> > > >            test1 (bpf program)
> > > >              bpf_kfunc_common_test
> > > >                kprobe_ftrace_handler
> > > >                  kprobe_perf_func
> > > >                    trace_call_bpf
> > > >                      -> bpf_prog_active check fails, missed count is incremented
> > > >
> > > >
> > > > kprobe_ftrace_handler calls/takes ftrace_test_recursion_trylock (ftrace recursion lock)
> > > >
> > > > but s390 now calls/takes ftrace_test_recursion_trylock already in ftrace_graph_func,
> > > > so s390 stops at kprobe_ftrace_handler and does not get to trace_call_bpf to increment
> > > > prog->missed counters
> > >
> > > Oops, good catch! I missed to remove it from s390. We've already moved it
> > > in function_graph_enter_regs().
> > >
> > >
> > > >
> > > > adding Sven, Masami, any idea?
> > > >
> > > > if the ftrace_test_recursion_trylock is needed ftrace_graph_func on s390, then
> > > > I think we will need to fix our test to skip s390 arch
> > >
> > > Yes. Please try this patch;
> > >
> > >
> > > From 12fcda79d0b1082449d5f7cfb8039b0237cf246d Mon Sep 17 00:00:00 2001
> > > From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > > Date: Sun, 26 Jan 2025 23:38:59 +0900
> > > Subject: [PATCH] s390: fgraph: Fix to remove ftrace_test_recursion_trylock()
> > >
> > > Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func()
> > > because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
> > > function_graph_enter") has been moved it to function_graph_enter_regs()
> > > already.
> > >
> > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_graph_enter")
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > great, ci is passing with this fix
> >
> > Tested-by: Jiri Olsa <jolsa@kernel.org>

Thanks for testing!

> 
> Masami,
> 
> Are you going to land this fix in your tree? We can create a temporary
> patch for BPF CI once you have the commit in the tree.

I think this should be a fix from linux-trace tree. I also found
another issue on s390. (s390 does not implemented )
Let me resend it because I missed to Cc to linux-trace ML.

Thank you,
> 
> >
> > thanks,
> > jirka
> >
> >
> > > ---
> > >  arch/s390/kernel/ftrace.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > >
> > > diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> > > index c0b2c97efefb..63ba6306632e 100644
> > > --- a/arch/s390/kernel/ftrace.c
> > > +++ b/arch/s390/kernel/ftrace.c
> > > @@ -266,18 +266,13 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > >                      struct ftrace_ops *op, struct ftrace_regs *fregs)
> > >  {
> > >       unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
> > > -     int bit;
> > >
> > >       if (unlikely(ftrace_graph_is_dead()))
> > >               return;
> > >       if (unlikely(atomic_read(&current->tracing_graph_pause)))
> > >               return;
> > > -     bit = ftrace_test_recursion_trylock(ip, *parent);
> > > -     if (bit < 0)
> > > -             return;
> > >       if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
> > >               *parent = (unsigned long)&return_to_handler;
> > > -     ftrace_test_recursion_unlock(bit);
> > >  }
> > >
> > >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> > > --
> > > 2.43.0
> > >
> > > Thank you,
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

