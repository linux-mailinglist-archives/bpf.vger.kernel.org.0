Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13A64A99F
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiLLVjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 16:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiLLVji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 16:39:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6534301
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:39:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C6FFCE1177
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 21:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F24C433EF
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670881173;
        bh=B9gTkTNlu/xQ+gB/j1rIPXB65DL5r+u8wRXwz/iJixY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PEz+9eJqQCOZMmvPrfo3VEo9OqHglPy+y4STHULwpRMn7eY1bpiLC9nr9TdZSfRcj
         g3zSayKgK1kQ7eZiorebU8CpCUmamAKhW7nGigXPpQS0v/JkFWiA3ZqwEhPVCGe/ZZ
         uNwlC5Qo5oopzMicYd3nQVkn4ctKWkXehrdJERS+/FZxYa7fcCweX3q8xnZseL1RZR
         hEKRGmzehkoahb6XH4lPq57Ww8liyVrQfB6+Jdr5b7IYQxv9dETPHq+EpaD4HIbVSp
         FtU6Fx3tqDHiVR6mc4Wg+JJ3jpCVL9ko5ccIJr2Ah0VDxTfoENLHfL1tvR4B7x59sz
         Jvt7Wh5aPUQnQ==
Received: by mail-ej1-f41.google.com with SMTP id t17so31698060eju.1
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:39:33 -0800 (PST)
X-Gm-Message-State: ANoB5pmOjvjBS4mIffcY1m1DXqNV83+O5NXTCatetS2vUUiT9BOs8pl8
        SkCj458Lnc1tx3CbPFAfwBLpwJIVvQ1JLKweMJoL5g==
X-Google-Smtp-Source: AA0mqf4pEiHn8wvEY7FGeZ/vxLAgQXyNYTFZTRNKh5w9Scz4NmKDAzYpHFJWjsPMNUGKWXrn6dx1ZsyiRsxCcx9QdUg=
X-Received: by 2002:a17:906:48d6:b0:7c1:b67:6a28 with SMTP id
 d22-20020a17090648d600b007c10b676a28mr9538124ejt.2.1670881171311; Mon, 12 Dec
 2022 13:39:31 -0800 (PST)
MIME-Version: 1.0
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org> <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
 <20221206162035.97ae19674d6d17108bed1910@kernel.org> <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
 <20221206233947.4c27cc9d@gandalf.local.home> <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
 <20221207074806.6f869be2@gandalf.local.home> <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
 <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org> <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
 <20221212001431.ac84a6320cff8d5fa8aa943e@kernel.org>
In-Reply-To: <20221212001431.ac84a6320cff8d5fa8aa943e@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 12 Dec 2022 22:39:20 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5WAgh17_+CxKQjzk-611ua3tyHGhWS6Hj3TM4rt7jDWg@mail.gmail.com>
Message-ID: <CACYkzJ5WAgh17_+CxKQjzk-611ua3tyHGhWS6Hj3TM4rt7jDWg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 11, 2022 at 4:14 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sun, 11 Dec 2022 08:49:01 +0100
> KP Singh <kpsingh@kernel.org> wrote:
>
> > On Sun, Dec 11, 2022 at 3:52 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi Alexei,
> > >
> > > On Wed, 7 Dec 2022 20:36:28 -0800
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > Yet for 2 days this 'taint' arguing is preventing people from looking at the bug.
> > > > And that happens all the time on lkml. Somebody reports a bug and kernel devs
> > > > jump on the poor person:
> > > > "Can you repro without taint?",
> > > > "Can you repro with upstream kernel?"
> > > > This is discouraging.
> > > > The 'taint' concept makes it easier for kernel devs to ignore bug reports
> > > > and push back on the reporter.
> > > > Do it few times and people stop reporting bugs.
> > >
> > > That seems off topic for me. You seems complained against the taint flag
> > > itself.
> >
> > The series is about adding a taint for, so discussing the user
> > experience, when someone reports a "tainted crash" seems reasonable to
> > me and not off topic.
> >
> > >
> > > > Say, this particular bug in rethook was found by one of our BPF CI developers.
> > > > They're not very familiar with the kernel, but they can see plenty of 'rethook'
> > > > references in the stack trace, lookup MAINTAINER file and ping Massami,
> > > > but to the question "can you repro without taint?" they can only say NO,
> > > > because this is how our CI works. So they will keep silence and the bug will be lost.
> > >
> > > BTW, this sounds like the BPF CI system design issue. If user is NOT easily
> > > identifying what test caused the issue (e.g. what tests ran on the system
> > > until the bug was found), the CI system is totally useless, because after
> > > finding a problem, it must be investigated to solve the problem.
> > >
> > > Without investigation, how would you usually fix the bug??
> >
> > Masami, this seems accusational and counter productive, it was never
> > said that issues can be solved without investigation.
>
> Let me apologies about my misunderstanding.

e-mail is hard, I am glad this is already progressing constructively
and we are making things better.

>
> >
> > The BPF CI does find issues, the BPF reviewers and maintainers
> > regularly fix bugs using it. Alexei's point here is that a taint does
> > not help in solving the problem, rather deter some people from even
> > looking at it. (not BPF people, but other maintainers [distro, kernel]
> > who would ask for a reproduction without a taint).
>
> Hmm, that is a problem. Some taint flag should be useful hints
> for finding the error patterns.

the boolean information contained in taints is not helpful, stuff like
audit logs / crash dumps / bpftool reports are much more helpful.
>
> > Let's take a step back and focus on solving debuggability and
> > introspection as we clearly have some perception issues about taints
> > in the community. (distro maintainers, users) before we go and add
> > more taints.
>
> Agreed.
>
> > > > That's not the only reason why I'm against generalizing 'taint'.
> > > > Tainting because HW is misbehaving makes sense, but tainting because
> > > > of OoO module or because of live-patching does not.
> > > > It becomes an excuse that people abuse.
> > >
> > > yeah, it is possible to be abused. but that is the problem who
> > > abuse it.
> >
> > I am sorry, but it's our responsibility as developers to design
> > features so that users don't face arduous pushbacks.
>
> Sorry if I confuse you. I meant that taint flag abusing. :(

Again no worries, but we need to make sure that the taint flag is not
abused, and if it is being abused, limit the damage somewhere.

>
> >
> > > > Right now syzbot is finding all sorts of bugs. Most of the time syzbot
> > > > turns error injection on to find those allocation issues.
> > > > If syzbot reports will start coming as tainted there will be even less
> > > > attention to them. That will not be good.
> > >
> > > Hmm, what kind of error injection does syzbot do? I would like to know
> > > how it is used. For example, does that use only a specify set of
> > > injection points, or use all existing points?
> > >
> > > If the latter, I feel safer because syzbot ensures the current all
> > > ALLOW_ERROR_INJECTION() functions will work with error injection. If not,
> > > we need to consider removing the ALLOW_ERROR_INJECTION() from the
> > > function which is not tested well (or add this taint flag.)
> > >
> > > Documentation/fault-injection/fault-injection.rst has no explanation
> > > about ALLOW_ERROR_INJECTION(), but obviously the ALLOW_ERROR_INJECTION()
> > > marked functions and its caller MUST be designed safely against the
> > > error injection. e.g.
> > >
> > > - It must return an error code. (so EI_ETYPE_NONE must be removed)
> >
> > This is already the case with BPF, the modify return trampolines
> > further limits the error injection to functions that return errors.
>
> OK, so I also should remove it from FEI.
>
> >
> > > - Caller must check the return value always.
> > >   (but I thought this was the reason why we need this test framework...)
> > > - It should not run any 'effective' code before checking an error.
> > >   For example, increment counter, call other functions etc.
> > >   (this means it can return without any side-effect)
> >
> > This is the case with modify_return trampolines in BPF which avoid
> > side effects and limit the attachment surface further and avoiding
> > side effects is a design goal. If we missed anything, let's fix that.
> >
> > https://lwn.net/Articles/813724/
>
> Yeah, if BPF tests already tested all ALLOW_ERROR_INJECTION() functions,
> it may be checked already. I think we just need adding the above
> explanation on the document, so that the people who will add additional
> ALLOW_ERROR_INJECTION() on a function, can understand the limitation.
>
> >
> > >
> > > Anything else?
> > >
> > > [...]
> > > > All these years we've been working on improving bpf introspection and
> > > > debuggability. Today crash dumps look like this:
> > > >   bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
> > > >   bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk+0x2b/0x37
> > > >   bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
> > > >   __bpf_prog_run include/linux/filter.h:600 [inline]
> > > >   bpf_prog_run include/linux/filter.h:607 [inline]
> > > >
> > > > The 2nd from the top is a bpf prog. The rest are kernel functions.
> > > > bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk
> > > >          ^^ is a prog tag   ^^ name of bpf prog
> > > >
> > > > If you do 'bpftool prog show' you can see both tag and name.
> > > > 'bpftool prog dump jited'
> > > > dumps x86 code mixed with source line text.
> > > > Often enough +0x2b offset will have some C code right next to it.
> > >
> > > This is good, but this only works when the vmcore is dumped and
> > > on the stack. My concern about the function error injection is
> > > that makes some side effects, which can cause a problem afterwards
> > > (this means after unloading the bpf prog)
> >
> > I think careful choices need to be made on when error injection is
> > allowed so that these situations don't occur. (as you mentioned in
> > your comment). [1]. If a BPF program is unloaded, there is no error
> > injection any more, let's ensure that we design the error injection
> > allow list and the BPF logic to ensure this cannot happen.
>
> OK. Actually, I trust the BPF logic itself will be handle this
> correctly. I just concerned that some people who don't know much
> (because it is not carefully documented) might add ALLOW_ERROR_INJECTION()
> to a function which is not injectable by design. Thus I thought the
> taint flag can help.

We should definitely carefully review any new ALLOW_ERROR_INJECTION
functions, that's the real value add.

> But if those are always Cc'd to bpf@vger and it will be tested by BPF
> CI, I'm OK for that.
>
> > > > One can monitor all prog load/unload via perf or via audit.
> >
> > I would like us to focus on debuggability as it helps both the
> > maintainers and the user. And I see a few things that need to be done:
> >
> > 1. Revisit what is allowed for error injection in the kernel and if
> > they can cause any subtle issues. My initial take is that functions
> > that are directly called from syscall path should generally be okay.
> > But let's check them for the patterns you mentioned.
>
> Yeah, I agree that syscall entries should be safe.
>
> > 2. If it helps, add the list of BPF modify return programs to stack
> > traces. Although this is really needed if we don't do [1] properly.
>
> Would you mean a list of enabled BPF programs in Oops code? If so,
> I also want to add enabled FEI list on it.
>
> > 3. Check if anything needs to be improved in the verification logic
> > for modify return trampolines.
>
> I think BPF logic itself is safe. But the targeted function itself
> or the caller may not be designed for such error injection.
> I think this is my fault that I have not documented about
> ALLOW_ERROR_INJECTION() well. Sorry about that.

We aim to be blameless and constructive :)

Thanks again for sending the patches!

Cheers,
- KP

>
> Thank you,
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
