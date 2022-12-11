Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01E64920E
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 03:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLKCwZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 21:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLKCwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 21:52:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F913F27;
        Sat, 10 Dec 2022 18:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F72360D39;
        Sun, 11 Dec 2022 02:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E86FC433EF;
        Sun, 11 Dec 2022 02:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670727142;
        bh=rlKZwK4Kj1fXsPuO+MKRZgsrKdoPPkaovawTnxF2v9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gWPF8u48O67+JbK7s4pT1emnY6txtEG37xTU/4QNsWfmg9cg4oBF7HAtdSIdgzB/z
         OLTF5u8hy2dNJw9Liopf/GjC2QXwOcqU8CE1Wl7RkzPVkTBe2p5f3LeZ+1Mdzdho4V
         UVd7ZdWeJjtfBtZ5M2VgpbYdkjlSXy76u+IgV7d49H6H4cZVIPSrlE1qxvXgU8J/tX
         yqIjREuC08ueh+Qt6RXe/YrotxMSg3oXR1X7ca4TBNolskrXluYcanrauT52Go/ttW
         NTeQpVSJuWylX9d78paDwog5YF2nD7k3eQnsbcT6UsWmFcm54icPXWMfcRqV8zgvQJ
         8y23ArxGsuptg==
Date:   Sun, 11 Dec 2022 11:52:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-Id: <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org>
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
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On Wed, 7 Dec 2022 20:36:28 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Yet for 2 days this 'taint' arguing is preventing people from looking at the bug.
> And that happens all the time on lkml. Somebody reports a bug and kernel devs
> jump on the poor person:
> "Can you repro without taint?",
> "Can you repro with upstream kernel?"
> This is discouraging.
> The 'taint' concept makes it easier for kernel devs to ignore bug reports
> and push back on the reporter.
> Do it few times and people stop reporting bugs.

That seems off topic for me. You seems complained against the taint flag
itself.

> Say, this particular bug in rethook was found by one of our BPF CI developers.
> They're not very familiar with the kernel, but they can see plenty of 'rethook'
> references in the stack trace, lookup MAINTAINER file and ping Massami,
> but to the question "can you repro without taint?" they can only say NO,
> because this is how our CI works. So they will keep silence and the bug will be lost.

BTW, this sounds like the BPF CI system design issue. If user is NOT easily
identifying what test caused the issue (e.g. what tests ran on the system
until the bug was found), the CI system is totally useless, because after
finding a problem, it must be investigated to solve the problem.

Without investigation, how would you usually fix the bug??

> That's not the only reason why I'm against generalizing 'taint'.
> Tainting because HW is misbehaving makes sense, but tainting because
> of OoO module or because of live-patching does not.
> It becomes an excuse that people abuse.

yeah, it is possible to be abused. but that is the problem who
abuse it.

> Right now syzbot is finding all sorts of bugs. Most of the time syzbot
> turns error injection on to find those allocation issues.
> If syzbot reports will start coming as tainted there will be even less
> attention to them. That will not be good.

Hmm, what kind of error injection does syzbot do? I would like to know
how it is used. For example, does that use only a specify set of
injection points, or use all existing points?

If the latter, I feel safer because syzbot ensures the current all
ALLOW_ERROR_INJECTION() functions will work with error injection. If not,
we need to consider removing the ALLOW_ERROR_INJECTION() from the
function which is not tested well (or add this taint flag.)

Documentation/fault-injection/fault-injection.rst has no explanation
about ALLOW_ERROR_INJECTION(), but obviously the ALLOW_ERROR_INJECTION()
marked functions and its caller MUST be designed safely against the
error injection. e.g.

- It must return an error code. (so EI_ETYPE_NONE must be removed)
- Caller must check the return value always.
  (but I thought this was the reason why we need this test framework...)
- It should not run any 'effective' code before checking an error.
  For example, increment counter, call other functions etc.
  (this means it can return without any side-effect)

Anything else?

[...]
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

This is good, but this only works when the vmcore is dumped and
on the stack. My concern about the function error injection is
that makes some side effects, which can cause a problem afterwards
(this means after unloading the bpf prog)

> 
> One can monitor all prog load/unload via perf or via audit.

Ah, audit is helpful :), because we can dig the log what was loaded
before crash.


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
