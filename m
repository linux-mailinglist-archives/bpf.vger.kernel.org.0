Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB0649319
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLKHtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 02:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLKHtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 02:49:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E084D13E
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 23:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9B360DC8
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 07:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15537C4339B
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670744954;
        bh=iKhB+x85Y44rcwW81uXsE7vfiZs3wf+uJ2n5QyDonP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMPLLc2Gj0T01rsnFtqhXBJ7tskaNFX5jaUzFXRcQQ5bQH6dHbmOQkLqazRKWa9fE
         LaNON3TfyQr0xS2W93MmifPS+oryM6pwR7cKqT/KoIEscobjVIjb1N8upfB3tpxOLa
         1qlb7gL+9EsX71u0b/qgaPWy2AiDHNLConTGlfw0g9+nXSnqjpEouOY7iDs5Wgpj6v
         ttaR0u5RMvVI358NK+F1xoLAQLLyFlW1xk3uCNgJZLv/zwswr6uYyqDF9q6iLZc02i
         nw941HOv018nFmxDN17zm4fHnVTU1l2sFJwrja7AxK7akmCSlRTjNR8xgTDXAKFVgi
         E5LVu0JpoX37A==
Received: by mail-ed1-f49.google.com with SMTP id c66so8719937edf.5
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 23:49:13 -0800 (PST)
X-Gm-Message-State: ANoB5plFrKQlPGpaIrZWl7KGu9J7guAdHRXsZjYDbhNTC3C9FSq0lY79
        0b7/QxK73+nqGNHVaxPStbaiySLLLeZaDn5U+N2m1w==
X-Google-Smtp-Source: AA0mqf5W9clnzL/U0TtvIeRFtGXcW2GGQgs5zmL+g68JnLoefinLgmRj3yuwTuIdS+dAEImPGwc7yLmfRe2QKWpVobQ=
X-Received: by 2002:a05:6402:5149:b0:46f:c942:7775 with SMTP id
 n9-20020a056402514900b0046fc9427775mr98716edd.385.1670744952071; Sat, 10 Dec
 2022 23:49:12 -0800 (PST)
MIME-Version: 1.0
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org> <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
 <20221206162035.97ae19674d6d17108bed1910@kernel.org> <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
 <20221206233947.4c27cc9d@gandalf.local.home> <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
 <20221207074806.6f869be2@gandalf.local.home> <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
 <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org>
In-Reply-To: <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 11 Dec 2022 08:49:01 +0100
X-Gmail-Original-Message-ID: <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
Message-ID: <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 11, 2022 at 3:52 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Alexei,
>
> On Wed, 7 Dec 2022 20:36:28 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Yet for 2 days this 'taint' arguing is preventing people from looking at the bug.
> > And that happens all the time on lkml. Somebody reports a bug and kernel devs
> > jump on the poor person:
> > "Can you repro without taint?",
> > "Can you repro with upstream kernel?"
> > This is discouraging.
> > The 'taint' concept makes it easier for kernel devs to ignore bug reports
> > and push back on the reporter.
> > Do it few times and people stop reporting bugs.
>
> That seems off topic for me. You seems complained against the taint flag
> itself.

The series is about adding a taint for, so discussing the user
experience, when someone reports a "tainted crash" seems reasonable to
me and not off topic.

>
> > Say, this particular bug in rethook was found by one of our BPF CI developers.
> > They're not very familiar with the kernel, but they can see plenty of 'rethook'
> > references in the stack trace, lookup MAINTAINER file and ping Massami,
> > but to the question "can you repro without taint?" they can only say NO,
> > because this is how our CI works. So they will keep silence and the bug will be lost.
>
> BTW, this sounds like the BPF CI system design issue. If user is NOT easily
> identifying what test caused the issue (e.g. what tests ran on the system
> until the bug was found), the CI system is totally useless, because after
> finding a problem, it must be investigated to solve the problem.
>
> Without investigation, how would you usually fix the bug??

Masami, this seems accusational and counter productive, it was never
said that issues can be solved without investigation.

The BPF CI does find issues, the BPF reviewers and maintainers
regularly fix bugs using it. Alexei's point here is that a taint does
not help in solving the problem, rather deter some people from even
looking at it. (not BPF people, but other maintainers [distro, kernel]
who would ask for a reproduction without a taint).

Let's take a step back and focus on solving debuggability and
introspection as we clearly have some perception issues about taints
in the community. (distro maintainers, users) before we go and add
more taints.

>
> > That's not the only reason why I'm against generalizing 'taint'.
> > Tainting because HW is misbehaving makes sense, but tainting because
> > of OoO module or because of live-patching does not.
> > It becomes an excuse that people abuse.
>
> yeah, it is possible to be abused. but that is the problem who
> abuse it.

I am sorry, but it's our responsibility as developers to design
features so that users don't face arduous pushbacks.

> > Right now syzbot is finding all sorts of bugs. Most of the time syzbot
> > turns error injection on to find those allocation issues.
> > If syzbot reports will start coming as tainted there will be even less
> > attention to them. That will not be good.
>
> Hmm, what kind of error injection does syzbot do? I would like to know
> how it is used. For example, does that use only a specify set of
> injection points, or use all existing points?
>
> If the latter, I feel safer because syzbot ensures the current all
> ALLOW_ERROR_INJECTION() functions will work with error injection. If not,
> we need to consider removing the ALLOW_ERROR_INJECTION() from the
> function which is not tested well (or add this taint flag.)
>
> Documentation/fault-injection/fault-injection.rst has no explanation
> about ALLOW_ERROR_INJECTION(), but obviously the ALLOW_ERROR_INJECTION()
> marked functions and its caller MUST be designed safely against the
> error injection. e.g.
>
> - It must return an error code. (so EI_ETYPE_NONE must be removed)

This is already the case with BPF, the modify return trampolines
further limits the error injection to functions that return errors.

> - Caller must check the return value always.
>   (but I thought this was the reason why we need this test framework...)
> - It should not run any 'effective' code before checking an error.
>   For example, increment counter, call other functions etc.
>   (this means it can return without any side-effect)

This is the case with modify_return trampolines in BPF which avoid
side effects and limit the attachment surface further and avoiding
side effects is a design goal. If we missed anything, let's fix that.

https://lwn.net/Articles/813724/https://lwn.net/Articles/813724/

>
> Anything else?
>
> [...]
> > All these years we've been working on improving bpf introspection and
> > debuggability. Today crash dumps look like this:
> >   bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
> >   bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk+0x2b/0x37
> >   bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
> >   __bpf_prog_run include/linux/filter.h:600 [inline]
> >   bpf_prog_run include/linux/filter.h:607 [inline]
> >
> > The 2nd from the top is a bpf prog. The rest are kernel functions.
> > bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk
> >          ^^ is a prog tag   ^^ name of bpf prog
> >
> > If you do 'bpftool prog show' you can see both tag and name.
> > 'bpftool prog dump jited'
> > dumps x86 code mixed with source line text.
> > Often enough +0x2b offset will have some C code right next to it.
>
> This is good, but this only works when the vmcore is dumped and
> on the stack. My concern about the function error injection is
> that makes some side effects, which can cause a problem afterwards
> (this means after unloading the bpf prog)

I think careful choices need to be made on when error injection is
allowed so that these situations don't occur. (as you mentioned in
your comment). [1]. If a BPF program is unloaded, there is no error
injection any more, let's ensure that we design the error injection
allow list and the BPF logic to ensure this cannot happen.


>
> >
> > One can monitor all prog load/unload via perf or via audit.

I would like us to focus on debuggability as it helps both the
maintainers and the user. And I see a few things that need to be done:

1. Revisit what is allowed for error injection in the kernel and if
they can cause any subtle issues. My initial take is that functions
that are directly called from syscall path should generally be okay.
But let's check them for the patterns you mentioned.
2. If it helps, add the list of BPF modify return programs to stack
traces. Although this is really needed if we don't do [1] properly.
3. Check if anything needs to be improved in the verification logic
for modify return trampolines.

- KP

>
> Ah, audit is helpful :), because we can dig the log what was loaded
> before crash.
>
>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
