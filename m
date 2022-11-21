Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71097632428
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 14:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKUNra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 08:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKUNr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 08:47:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE86B06
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 05:47:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBA7FB81037
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 13:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A453C4314D
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669038443;
        bh=WLmQPieY/32ZBlobTgkPgqKa+KfkJsr19/fUw7so9Zo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SiuxS6lvR2h0XP97jZ1FO39f7sHYqOYM+A8J+wF9ePnYRxf9gKB7k6yfFmgA8vO+7
         cLancaylCL9QPWmv94+kQlCVRsKKpdTwXyVQv4JLTysN5pC2EdJykT+D+wUiE1+trd
         KT9olyUNURj53GfMAeECi+Q0ipgPL+LwUq9KuvUEbuMw3uXcVg78z07nInDOdPeWB9
         TA5/Ay9BGdaxUS3cLgL3K36Le2Ah4rNYjggfcJxNPsCCID3lyzJPpeLe+F8bST04Wo
         G2kcflT5UZgEZd6N3i5kCXWJylWYxHgiJQ5yj/GAl3GIqOg+4jvwOhSh+ikT6B4iTw
         wezZAoaRBloUQ==
Received: by mail-lf1-f45.google.com with SMTP id g12so18926854lfh.3
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 05:47:23 -0800 (PST)
X-Gm-Message-State: ANoB5pkdB8IfYI1GtWHqXO/Esw1pbK7fON8FfkS3crHlkPY1Ra24gmu5
        eME2iT6lr+UVPWmnHA4aq6GcjI/QrvRjZ+7VtQaEcw==
X-Google-Smtp-Source: AA0mqf7v8WCda89LXA6/tr76kH+DxPHn5svWXXAXFDeemVuyBdED8n/VqjrNbfqDB4CLgbztSqjuOR88iwMKngyi7oE=
X-Received: by 2002:a19:6755:0:b0:4ac:3f87:151f with SMTP id
 e21-20020a196755000000b004ac3f87151fmr6553432lfj.398.1669038441285; Mon, 21
 Nov 2022 05:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20221108220651.24492-1-revest@chromium.org> <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home> <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home> <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home> <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home> <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
In-Reply-To: <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 21 Nov 2022 14:47:10 +0100
X-Gmail-Original-Message-ID: <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com>
Message-ID: <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
To:     Chris Mason <clm@meta.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 7:52 PM Chris Mason <clm@meta.com> wrote:
>
> On 11/18/22 1:06 PM, Steven Rostedt wrote:
> > On Fri, 18 Nov 2022 12:44:00 -0500
> > Chris Mason <clm@meta.com> wrote:
> >

(adding this back here)

> >>>> On Fri, 18 Nov 2022 16:34:50 +0000
> >>>> Mark Rutland <mark.rutland@arm.com> wrote:
> >>>> FWIW, given that the aim here seems to be to expose all kernel internals to be
> >>>> overridden arbitrarily, I'm also concerned that there's a huge surface area for
> >>>> issues with maintainability, robustness/correctness, and security.
> >>>>

This is not all kernel internals, just the functions allowed for error
injection.

> >>>> I really don't want to be stuck in a position where someone argues that all
> >>>> kernel internal functions are ABI and need to stay around as-is to be hooked by
> >>>> eBPF, and I hope that we all agree that there are no guarantees on that front.
> >>>>

Yes, BPF provides no guarantee that kernel functions will remain
stable (similar to tracepoints and kprobes).

> >>>> Thanks,
> >>>> Mark.
> >>>>
> >>> My biggest concern is changing functionality of arbitrary functions by BPF.
> >>> I would much rather limit what functions BPF could change with some
> >>> annotation.
> >>>
> >>> int __bpf_modify foo()
> >>> {
> >>>     ...
> >>> }

This annotation already exists, i.e. ALLOW_ERROR_INJECTION

Users, with CONFIG_FUNCTION_ERROR_INJECTION, can already modify return
values of kernel functions using kprobes and the failure injection
framework [1] for functions annotated with ALLOW_ERROR_INJECTION.

BPF just provides another way to do the same thing with "modify
return" programs and this also respects the error injection list [2]
and users can *only* attach these programs to the functions annotated
with ALLOW_ERROR_INJECTION.

[1] https://www.kernel.org/doc/Documentation/fault-injection/fault-injection.txt
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c?id=f4c4ca70dedc1bce8e7b1648e652aa9be1d3fcd7#n14948

> >>>
> >>>
> >>> That way if somethings not working, you can see directly in the code that
> >>> the function could be modified by a BPF program, instead of getting some
> >>> random bug report because a function returned an unexpected result that the
> >>> code of that function could never produce.
> >>>
> >>
> >> The good news is that BPF generally confines the function replacement
> >> through struct ops interfaces.
> >
> > What struct ops interfaces?
>
> https://lwn.net/Articles/811631/
>
> >
> >>   There are also explicit allow lists to
> >> limit functions where you can do return value overrides etc, so I think
> >
> > Where are these lists.
>
> Some of the original features:
>
> https://lwn.net/Articles/811631/

I think you meant: https://lwn.net/Articles/740146/ ?

>
> It has changed and expanded since then, but hopefully you get the idea.
>
> >
> >> it's fair to say these concerns are already baked in.  I'm sure they can
> >
> > How do I know that a function return was modified by BPF? If I'm debugging

You can list the BPF programs that are loaded in the kernel with

# bpftool prog list

Also, the BPF programs show up in call stacks when you are debugging.

> > something, is it obvious to the developer that is debugging an issue
> > (perhaps unaware of what BPF programs are loaded on the users machine),
> > that the return of a function was tweaked by BPF and that could be the
> > source of the bug?
> >
> >> be improved over the long term, but I don't think that's related to this
> >> set of functionality on ARM.

There are workloads and applications (e.g. https://kubearmor.io/) that
already use BPF Tracing and LSM programs and are currently blocked on
their ARM server deployments.

This may be obvious, but I want to reiterate that while the attachment
points are not UAPI and users have to tolerate kernel function
changes, they do expect the core loading and attachment mechanisms to
exist (i.e. the ability to use LSM and tracing programs).

> >
> > I disagree. These issues may have been added to x86, but perhaps we should
> > take a deeper look at them again before extending them to other
> > architectures.
>
> Honestly, I think a large scale architecture review of every BPF feature
> and decision over the last 10 years is just the wrong bar for this patch
> series.

+1

>
>  From my understanding, Mark and Florent have some changes planned
> that'll improve ftrace, livepatching, and bpf.  Lets talk about those,
> and tackle any long term improvements you'd like to make to BPF in other
> patch series.

+1

 - KP

>
> -chris
>
