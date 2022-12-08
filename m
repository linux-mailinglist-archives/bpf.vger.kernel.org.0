Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CB647259
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLHO76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLHO75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 09:59:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927BEBF71;
        Thu,  8 Dec 2022 06:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4E161F34;
        Thu,  8 Dec 2022 14:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CF9C433D7;
        Thu,  8 Dec 2022 14:59:53 +0000 (UTC)
Date:   Thu, 8 Dec 2022 09:59:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-ID: <20221208095952.7c83333a@gandalf.local.home>
In-Reply-To: <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
        <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
        <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
        <20221206162035.97ae19674d6d17108bed1910@kernel.org>
        <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
        <20221206233947.4c27cc9d@gandalf.local.home>
        <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
        <20221207074806.6f869be2@gandalf.local.home>
        <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Dec 2022 20:36:28 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > But in all seriousness, what I would actually ask (and what I'll ask now)
> > is, what module did you use that is out of tree, and was it relevant to
> > this test?
> > 
> > That's a reasonable question to ask, and one that only gets asked with a
> > taint.  
> 
> When we receive bug reports in bpf@vger the only question we ask is:
> "How to reproduce this bug?"
> We ignoring taint completely.

Um, I'm guessing that bug reports that go to bpf@vger are focused on issues
with BPF and not core kernel infrastructure. No, I do not consider BPF (nor
tracing for that matter) as core infrastructure. The bug reports I'm
talking about is for the scheduler, exception handling, interrupts, VFS,
MM, and networking. When one of these have a bug report, you most
definitely do look at taints. There's been several times where a bug report
was caused by an out of tree module, or a machine check exception.

> tbh I didn't even know that our BPF CI causes taint until that email.

That's because BPF development probably never gets hit by things that cause
taints. That doesn't go for the rest of the kernel.

> 
> In the previous email I said that the bug report comes from bpf selftest on bpf-next.
> Clearly there is no ambiguity that this is as upstream as it can get.
> Yet for 2 days this 'taint' arguing is preventing people from looking at the bug.

Who isn't looking at the bug because of the 'taint' argument? I'm not
looking at it right now, because it isn't top of my priority list.


> And that happens all the time on lkml. Somebody reports a bug and kernel devs
> jump on the poor person:
> "Can you repro without taint?",
> "Can you repro with upstream kernel?"
> This is discouraging.

So is spending 5 days debugging something and then finding out that what
caused the taint *was* the culprit!

Sorry, but that has happened to me too many times. Which is why you get
grumpy kernel developers pushing back on this.

> The 'taint' concept makes it easier for kernel devs to ignore bug reports
> and push back on the reporter. Do it few times and people stop reporting bugs.
> Say, this particular bug in rethook was found by one of our BPF CI developers.
> They're not very familiar with the kernel, but they can see plenty of 'rethook'
> references in the stack trace, lookup MAINTAINER file and ping Massami,
> but to the question "can you repro without taint?" they can only say NO,
> because this is how our CI works. So they will keep silence and the bug will be lost.
> That's not the only reason why I'm against generalizing 'taint'.
> Tainting because HW is misbehaving makes sense, but tainting because
> of OoO module or because of live-patching does not.
> It becomes an excuse that people abuse.

Again, I've been burned by OoO modules more than once. If you send 5 days
debugging something to find out that the cause was from an OoO module,
you'd change your tune too.

> 
> Right now syzbot is finding all sorts of bugs. Most of the time syzbot
> turns error injection on to find those allocation issues.
> If syzbot reports will start coming as tainted there will be even less
> attention to them. That will not be good.
> 
> > If there's a BPF injection taint, one can ask that same question, as the
> > bug may happen sometime after the injection but be caused by that injection,
> > and not be in the backtrace. Not all kernel developers have the access to
> > debugging utilities that backend production servers have. A lot of bugs that
> > kernel developers debug are from someone's laptop.  
> 
> I would have to disagree.
> We see few human reported bugs and prioritize them higher,
> but majority are coming from the production fleet, test tiers,
> syzbot, CIs, and automated things.
> 
> > Where all they have is
> > that backtrace.   
> 
> Even laptops typically leave vmcore after crash. distro support packages have
> clear rules what scripts to run to collect all the necessary data in case
> of the crash from vmcore.

They are not as common as you think.

> These tools support extracting everything bpf related too.
> For example see:
> Documentation/bpf/drgn.rst
> It works on vmcore and on the running kernel.
> 
> > If a tool or root kit, added function error injection, it
> > would be extremely useful information to debug what happened.
> > 
> > I don't understand the push back here.  
> 
> All these years we've been working on improving bpf introspection and
> debuggability. Today crash dumps look like this:
>   bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
>   bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk+0x2b/0x37
>   bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
>   __bpf_prog_run include/linux/filter.h:600 [inline]
>   bpf_prog_run include/linux/filter.h:607 [inline]
> 
> The 2nd from the top is a bpf prog. The rest are kernel functions.
> bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk
>          ^^ is a prog tag   ^^ name of bpf prog
> 
> If you do 'bpftool prog show' you can see both tag and name. 
> 'bpftool prog dump jited'
> dumps x86 code mixed with source line text.
> Often enough +0x2b offset will have some C code right next to it.
> 
> One can monitor all prog load/unload via perf or via audit.
> 'perf record' collects all bpf progs that were loaded before
> the start and even thouse that were loaded and unloaded quickly
> while 'perf record' was running.
> So 'perf report' has all the data including annotation and source code.
> 
> Currently we're working on adding 'file.c:lineno' to dump_stack()
> for bpf progs.
> 
> If you have ideas how we can improve debuggability we are all ears.

I talked with KP on IRC, and he said he's going to work on the same thing
as above. That is, showing what BPF programs are loaded, and if they modify
the return of any function, as well as what those functions are. And have
that reported in the oops message.

I'm not hell bent on BPF triggering a taint, as long as the oops message
explicitly defines what BPF is doing. I think that's much more informative
than a taint, and I would greatly welcome that. The main issue I'm raising
is that I want the oops message to have most the information to gather what
went wrong, and not rely on other tooling like kernel core dumps and drgn
for debugging the problem.

-- Steve
