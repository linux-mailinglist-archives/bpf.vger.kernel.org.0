Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A119646849
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 05:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLHEgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 23:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHEge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 23:36:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC9950FB;
        Wed,  7 Dec 2022 20:36:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3435046pje.5;
        Wed, 07 Dec 2022 20:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccUzDrEghhLsXQFl1LnCRKBfNr2RNIsuFQMC+oBQ8aY=;
        b=MpnuuRPnc+1kms77dkQ6uzrnzrdjI7Xc/BGQ/SqiB272YGnNkwhGKKjtswJx7TAUXF
         6BIDK4gAaO7QL9rGzPLT2PM2/gkf4V8ycDrTC+7QR2j7BGCNz7uGJrWHCVjbEBmJ3W20
         EDaaLa9mFEGDGbFsjCheQpi/xINd9z16+L+gjfGmChBV+fAmHVfKTpjMDI51CEp5LuMJ
         HKX+8GjtX8VVjxgGS7dGUQdMNwoxMQn47pE7ds2AVGqu8I/28qKMdcVbG3cPWr50Ihmd
         usRgHz2vdWWUMHg1Cn/HBkO61Jtj2VSuWnIfJQO9Rkh1y+Uqz6Nti6vZfprC85yABmfZ
         D0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccUzDrEghhLsXQFl1LnCRKBfNr2RNIsuFQMC+oBQ8aY=;
        b=1oKvRkzZPfArn0qF0QRU9AhRdudnRScqngeug8/fMKVyt61gLpHY9e+YN3xbKdnsqS
         3S2RIz1/9OINUkFZ3d0KMTi/dTmVbDkN7Ieq1/wxg5TEqdQEeteI5jIzmFM3cNO5IBhs
         cchoPz6NFs5cDT+lRweBADZfyCID3g1PC9/FEhn16D5Xjgtp1cOK45C8NUxRK56yUyzs
         0U2CIQDmj2yYXhWNir329A317aSppeqFnKTRKK+Lf38plo5FQDBhfnOLm83jbvQmCz6d
         dj+sQsxP1e0ZSGs8DL7HicOshxEQoFL3mR19qfsohtb0Pznt3V5hplqGQl1792FqQDjE
         CJ0Q==
X-Gm-Message-State: ANoB5pnADv9qq/37NovGVJ3qyTfRS27Jm/Y1KGB5tpQ9BN/HAyO5h0pU
        9BhTL1MvoV/vb6luEuu9ax8=
X-Google-Smtp-Source: AA0mqf5YgapsOp/xkaCmHIMElgclnfQSdz19H4cycdcx251TrJ9pCixA4rIDwBKqC3ealPXvtVW8tA==
X-Received: by 2002:a05:6a20:958b:b0:a3:ca9a:ff82 with SMTP id iu11-20020a056a20958b00b000a3ca9aff82mr2320727pzb.61.1670474192864;
        Wed, 07 Dec 2022 20:36:32 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id d17-20020a63f251000000b00476d1385265sm12193973pgk.25.2022.12.07.20.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 20:36:32 -0800 (PST)
Date:   Wed, 7 Dec 2022 20:36:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
 <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
 <20221206162035.97ae19674d6d17108bed1910@kernel.org>
 <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
 <20221206233947.4c27cc9d@gandalf.local.home>
 <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
 <20221207074806.6f869be2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207074806.6f869be2@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 07:48:06AM -0500, Steven Rostedt wrote:
> On Tue, 6 Dec 2022 20:45:17 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > "G - Proprietary module" - "O - out of tree module"
> > >
> > > Can you reproduce this without those taints?  
> > 
> > Lol. That question is exactly the reason why my Nack stands.
> 
> First, that's a BS reason for a NACK.
> 
> But in all seriousness, what I would actually ask (and what I'll ask now)
> is, what module did you use that is out of tree, and was it relevant to
> this test?
> 
> That's a reasonable question to ask, and one that only gets asked with a
> taint.

When we receive bug reports in bpf@vger the only question we ask is:
"How to reproduce this bug?"
We ignoring taint completely.
tbh I didn't even know that our BPF CI causes taint until that email.

In the previous email I said that the bug report comes from bpf selftest on bpf-next.
Clearly there is no ambiguity that this is as upstream as it can get.
Yet for 2 days this 'taint' arguing is preventing people from looking at the bug.
And that happens all the time on lkml. Somebody reports a bug and kernel devs
jump on the poor person:
"Can you repro without taint?",
"Can you repro with upstream kernel?"
This is discouraging.
The 'taint' concept makes it easier for kernel devs to ignore bug reports
and push back on the reporter. Do it few times and people stop reporting bugs.
Say, this particular bug in rethook was found by one of our BPF CI developers.
They're not very familiar with the kernel, but they can see plenty of 'rethook'
references in the stack trace, lookup MAINTAINER file and ping Massami,
but to the question "can you repro without taint?" they can only say NO,
because this is how our CI works. So they will keep silence and the bug will be lost.
That's not the only reason why I'm against generalizing 'taint'.
Tainting because HW is misbehaving makes sense, but tainting because
of OoO module or because of live-patching does not.
It becomes an excuse that people abuse.

Right now syzbot is finding all sorts of bugs. Most of the time syzbot
turns error injection on to find those allocation issues.
If syzbot reports will start coming as tainted there will be even less
attention to them. That will not be good.

> If there's a BPF injection taint, one can ask that same question, as the
> bug may happen sometime after the injection but be caused by that injection,
> and not be in the backtrace. Not all kernel developers have the access to
> debugging utilities that backend production servers have. A lot of bugs that
> kernel developers debug are from someone's laptop.

I would have to disagree.
We see few human reported bugs and prioritize them higher,
but majority are coming from the production fleet, test tiers,
syzbot, CIs, and automated things.

> Where all they have is
> that backtrace. 

Even laptops typically leave vmcore after crash. distro support packages have
clear rules what scripts to run to collect all the necessary data in case
of the crash from vmcore.
These tools support extracting everything bpf related too.
For example see:
Documentation/bpf/drgn.rst
It works on vmcore and on the running kernel.

> If a tool or root kit, added function error injection, it
> would be extremely useful information to debug what happened.
> 
> I don't understand the push back here.

All these years we've been working on improving bpf introspection and
debuggability. Today crash dumps look like this:
  bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
  bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk+0x2b/0x37
  bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
  __bpf_prog_run include/linux/filter.h:600 [inline]
  bpf_prog_run include/linux/filter.h:607 [inline]

The 2nd from the top is a bpf prog. The rest are kernel functions.
bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk
         ^^ is a prog tag   ^^ name of bpf prog

If you do 'bpftool prog show' you can see both tag and name. 
'bpftool prog dump jited'
dumps x86 code mixed with source line text.
Often enough +0x2b offset will have some C code right next to it.

One can monitor all prog load/unload via perf or via audit.
'perf record' collects all bpf progs that were loaded before
the start and even thouse that were loaded and unloaded quickly
while 'perf record' was running.
So 'perf report' has all the data including annotation and source code.

Currently we're working on adding 'file.c:lineno' to dump_stack()
for bpf progs.

If you have ideas how we can improve debuggability we are all ears.
