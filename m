Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2C2EB063
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbhAEQoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jan 2021 11:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbhAEQoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 11:44:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36EC061574;
        Tue,  5 Jan 2021 08:44:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b26so74126093lff.9;
        Tue, 05 Jan 2021 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBCJ3467pFpzu3Ws0eKRl2qSB4n17iKkJeF+xf/ypVc=;
        b=uco/WKOFuHH4uRZVA9bS7LqaYM3AbaGyHok7Pp+1AgionhdbsCchU0IE3IPwP0ozfG
         EnemHTg5IVLCJaY4AS0F7k3JiZLzF9+Q7ikZTpg5TSRo5flB7/tQWtpUQ/zSEeK3Fbt9
         GJkNbSJ/R0YN/+F4KzhglqOQ3vUKy0eSSC76YO2S0fGIa1WBjiTQiICqarn6/JoTPiFc
         lv0nzRPOfdTdZ+TkHh17EzAIUNa2mJWit7c2d8odMNFqDvX7aCpgtqeku+ujuxS4RiX/
         wc5A2RbpZ6xqUXiui495ru33C1PQVp7zMMP4r5y9gon386l9XaAHpe7ZpZhsmP68ZVx0
         BxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBCJ3467pFpzu3Ws0eKRl2qSB4n17iKkJeF+xf/ypVc=;
        b=BX7ILWzvKt8RAluttwLxA44xXBGrcnAXO5/Cr3I23hi25m4MmhDqUS6WgB/wIcBKgn
         T68AOgx8JjEBFi/0D4EypTDz/UNAws3Q+kS2VXzJGnlNNf2Py8bZ7mAjpyx+OMRMIJXp
         0PtqZiKtgSywgICtLBYMisUDy28kHa/DoqD2j62/hPl83rGY3ro/D7VPK0r8E2XF0uVb
         tKiHEAAek/x6d9CSqcHinpWASPIX6W8JnwPySYvijE2/a8ArUP+OyidJC3whm5mm3Ec6
         FSlDHo2cWj+iqyVY4ea4VYLfq5HM5kvhmFMRE4Fol3uMPpiRPsk10w9YGa8oZP9wjGfs
         yI4g==
X-Gm-Message-State: AOAM532k5gqcsm5kNEktcRpfrUaxcGsUbOjZdRvc0fwHsH2SNs2YJsWu
        Z+JXsGFbXRlDrPo50C81gDFreZ/Yg8dAqpYBBNGCY1pAOFR5EQ==
X-Google-Smtp-Source: ABdhPJwo9ovtmL+xWjt+CiuupdXmuMjW112JAsyF/nnqvaCOVhNi0/67s9uq7O0ieiyCGjvGRXkSiLrX6yDA4OHzmQU=
X-Received: by 2002:a05:6512:34c5:: with SMTP id w5mr70419lfr.214.1609865052579;
 Tue, 05 Jan 2021 08:44:12 -0800 (PST)
MIME-Version: 1.0
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com> <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com> <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com> <20210104182642.xglderapsfrop6pi@e107158-lin>
 <CAADnVQ+1BNO577iz+05M4nNk+DB2n9ffwr4KrktWxO+2mP1b-Q@mail.gmail.com> <20210105113857.gzqaiuhxsxdtu474@e107158-lin>
In-Reply-To: <20210105113857.gzqaiuhxsxdtu474@e107158-lin>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 Jan 2021 08:44:01 -0800
Message-ID: <CAADnVQ+GH9DfaRJ3CCDYL8o9UUH-eAuBq6EhjVLbicY_XWbySw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, Ingo Molnar <mingo@redhat.com>,
        vincent.guittot@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 5, 2021 at 3:39 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/04/21 10:59, Alexei Starovoitov wrote:
> > > > > I did have a patch that allowed that. It might be worth trying to upstream it.
> > > > > It just required a new macro which could be problematic.
> > > > >
> > > > > https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > > > >
> > > > > With the above I could attach using bpf::RAW_TRACEPOINT mechanism.
> > > > >
> > > >
> > > > Yeah, that could work. I meant there was no way to do it with what was there :)
> > > >
> > > > In our initial attempts at using BPF to get at nr_running (which I was not
> > > > involved in and don't have all the details...) there were issues being able to
> > > > keep up and losing events.  That may have been an implementation issue, but
> > > > using the module and trace-cmd doesn't have that problem. Hopefully you don't
> > > > see that using RAW_TRACEPOINTs.
> > >
> > > So I have a proper patch for that now, that actually turned out to be really
> > > tiny once you untangle exactly what is missing.
> > >
> > > Peter, bpf programs aren't considered ABIs AFAIK, do you have concerns about
> > > that?
> > >
> > > Thanks
> > >
> > > --
> > > Qais Yousef
> > >
> > > -->8--
> > >
> > > From cf81de8c7db03d62730939aa902579339e2fc859 Mon Sep 17 00:00:00 2001
> > > From: Qais Yousef <qais.yousef@arm.com>
> > > Date: Wed, 30 Dec 2020 22:20:34 +0000
> > > Subject: [PATCH] trace: bpf: Allow bpf to attach to bare tracepoints
> > >
> > > Some subsystems only have bare tracepoints (a tracepoint with no
> > > associated trace event) to avoid the problem of trace events being an
> > > ABI that can't be changed.
> > >
> > > From bpf presepective, bare tracepoints are what it calls
> > > RAW_TRACEPOINT().
> > >
> > > Since bpf assumed there's 1:1 mapping, it relied on hooking to
> > > DEFINE_EVENT() macro to create bpf mapping of the tracepoints. Since
> > > bare tracepoints use DECLARE_TRACE() to create the tracepoint, bpf had
> > > no knowledge about their existence.
> > >
> > > By teaching bpf_probe.h to parse DECLARE_TRACE() in a similar fashion to
> > > DEFINE_EVENT(), bpf can find and attach to the new raw tracepoints.
> > >
> > > Enabling that comes with the contract that changes to raw tracepoints
> > > don't constitute a regression if they break existing bpf programs.
> > > We need the ability to continue to morph and modify these raw
> > > tracepoints without worrying about any ABI.
> > >
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > ---
> > >  include/trace/bpf_probe.h | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > index cd74bffed5c6..a23be89119aa 100644
> > > --- a/include/trace/bpf_probe.h
> > > +++ b/include/trace/bpf_probe.h
> > > @@ -55,8 +55,7 @@
> > >  /* tracepoints with more than 12 arguments will hit build error */
> > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > >
> > > -#undef DECLARE_EVENT_CLASS
> > > -#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
> > > +#define __BPF_DECLARE_TRACE(call, proto, args)                         \
> > >  static notrace void                                                    \
> > >  __bpf_trace_##call(void *__data, proto)                                        \
> > >  {                                                                      \
> > > @@ -64,6 +63,10 @@ __bpf_trace_##call(void *__data, proto)                                      \
> > >         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > >  }
> > >
> > > +#undef DECLARE_EVENT_CLASS
> > > +#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
> > > +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
> > > +
> > >  /*
> > >   * This part is compiled out, it is only here as a build time check
> > >   * to make sure that if the tracepoint handling changes, the
> > > @@ -111,6 +114,11 @@ __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
> > >  #define DEFINE_EVENT_PRINT(template, name, proto, args, print) \
> > >         DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
> > >
> > > +#undef DECLARE_TRACE
> > > +#define DECLARE_TRACE(call, proto, args)                               \
> > > +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))          \
> > > +       __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
> > > +
> > >  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >
> > The patch looks fine to me.
> > Please add a few things:
> > - selftests to make sure it gets routinely tested with bpf CI.
>
> Any pointer to an example test I could base this on?

selftests/bpf/

> > - add a doc with contents from commit log.
>
> You're referring to the ABI part of the changelog, right?
>
> > The "Does bpf make things into an abi ?" question keeps coming back
> > over and over again.
> > Everytime we have the same answer that No, bpf cannot bake things into abi.
> > I think once it's spelled out somewhere in Documentation/ it would be easier to
> > repeat this message.
>
> How about a new Documentation/bpf/ABI.rst? I can write something up initially
> for us to discuss in detail when I post.

There is Documentation/bpf/bpf_design_QA.rst
and we already have this text in there that was added back in 2017:

Q: Does BPF have a stable ABI?
------------------------------
A: YES. BPF instructions, arguments to BPF programs, set of helper
functions and their arguments, recognized return codes are all part
of ABI. However there is one specific exception to tracing programs
which are using helpers like bpf_probe_read() to walk kernel internal
data structures and compile with kernel internal headers. Both of these
kernel internals are subject to change and can break with newer kernels
such that the program needs to be adapted accordingly.

I'm suggesting to add an additional section to this Q/A doc to include
more or less
the same text you had in the commit log.
