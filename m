Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15812E9D9C
	for <lists+bpf@lfdr.de>; Mon,  4 Jan 2021 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhADTAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jan 2021 14:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbhADTAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jan 2021 14:00:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCEEC061795;
        Mon,  4 Jan 2021 10:59:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a12so66880289lfl.6;
        Mon, 04 Jan 2021 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ju7IWr2o7B0xcZ24vOgX7+9HeXjRtELbBEBKgfPgELY=;
        b=p3I65vE2aSTlqyMTL5ONOD8taoZXaxjwji/bYM2hUegfEUMvhXPIEPQSwdmEYY0kUa
         Zv0rTZ9npCaiAL3Xcx+yS7lkAuU3sbe6HeaDWI4nivjwNMUrXpgsHrAvYgvqWfKV8lV4
         tV4zi1zFQPSjBjah2t/5e4MRXwi+uncDjgxWL+ATs3yibacBSEAQQpi72DG/W7DyNK9Q
         32Xm2LGp0533lVObGfbcnz9CqAJaDjkSFYV2VKeQpZn1u+hFUieWQueaH4RrBdIIPdF3
         2g/xDOG5F+HRfi/afwub2ZmXrbwM9NIB3H9YyuR6BIK8Wbu0SQ+8XhY26VDJ2rjMms9E
         OIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ju7IWr2o7B0xcZ24vOgX7+9HeXjRtELbBEBKgfPgELY=;
        b=UACF6tJrzkkdP+lHT9JQylPsuo4C/3AqLiffGUSRvKKkyTCW5aKyDEbBSXACM5RBGP
         ROyC1QrKUDh9YkvUXylW6UvZ3TgagTOuiZSvNUh0VGnR06RGnjmN+XllHyPvdaClTWV+
         BecZKiKly99DbRb812NMy1+WCWLQ5K1QcmVo5vGJxeurUXHYQa4ZeSjVK4GyYCylLcvQ
         6B9SQwlod9S4ULs/fNklPwQ7Yyelsh/v9twNZUndSaqjnoLO5C48yKNZ3q/x6nBpAe2e
         dD941s1jquzcCXyNgMg+nP4Y+eIOkyJEuVVBNQsOgtMhDO2tvI5hhF/eFzG9SEb5CPzC
         j/IA==
X-Gm-Message-State: AOAM532rLmsnD3yhf3lQzhasweVDhzwTWsg0tf/t3KvdsTiF2ieR9fJQ
        Bqi7b3UtnYdPEzmGasAkHNOtDjh0+WQe6Q+VZ7o8IuxgeBuv+Q==
X-Google-Smtp-Source: ABdhPJxs9nhb8aFEeOyulkXeWFD+wTvkmzgJJkhnl+LIwlXTMui9K1+5Od+HTeCgRlRkglptzecYAn67//vUfnh8oco=
X-Received: by 2002:ac2:43c1:: with SMTP id u1mr33606446lfl.38.1609786758153;
 Mon, 04 Jan 2021 10:59:18 -0800 (PST)
MIME-Version: 1.0
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com> <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com> <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com> <20210104182642.xglderapsfrop6pi@e107158-lin>
In-Reply-To: <20210104182642.xglderapsfrop6pi@e107158-lin>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 4 Jan 2021 10:59:06 -0800
Message-ID: <CAADnVQ+1BNO577iz+05M4nNk+DB2n9ffwr4KrktWxO+2mP1b-Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, Ingo Molnar <mingo@redhat.com>,
        vincent.guittot@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 4, 2021 at 10:29 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 09/08/20 09:19, Phil Auld wrote:
> > Hi Quais,
> >
> > On Mon, Sep 07, 2020 at 12:02:24PM +0100 Qais Yousef wrote:
> > > On 09/02/20 09:54, Phil Auld wrote:
> > > > >
> > > > > I think this decoupling is not necessary. The natural place for those
> > > > > scheduler trace_event based on trace_points extension files is
> > > > > kernel/sched/ and here the internal sched.h can just be included.
> > > > >
> > > > > If someone really wants to build this as an out-of-tree module there is
> > > > > an easy way to make kernel/sched/sched.h visible.
> > > > >
> > > >
> > > > It's not so much that we really _want_ to do this in an external module.
> > > > But we aren't adding more trace events and my (limited) knowledge of
> > > > BPF let me to the conclusion that its raw tracepoint functionality
> > > > requires full events.  I didn't see any other way to do it.
> > >
> > > I did have a patch that allowed that. It might be worth trying to upstream it.
> > > It just required a new macro which could be problematic.
> > >
> > > https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > >
> > > With the above I could attach using bpf::RAW_TRACEPOINT mechanism.
> > >
> >
> > Yeah, that could work. I meant there was no way to do it with what was there :)
> >
> > In our initial attempts at using BPF to get at nr_running (which I was not
> > involved in and don't have all the details...) there were issues being able to
> > keep up and losing events.  That may have been an implementation issue, but
> > using the module and trace-cmd doesn't have that problem. Hopefully you don't
> > see that using RAW_TRACEPOINTs.
>
> So I have a proper patch for that now, that actually turned out to be really
> tiny once you untangle exactly what is missing.
>
> Peter, bpf programs aren't considered ABIs AFAIK, do you have concerns about
> that?
>
> Thanks
>
> --
> Qais Yousef
>
> -->8--
>
> From cf81de8c7db03d62730939aa902579339e2fc859 Mon Sep 17 00:00:00 2001
> From: Qais Yousef <qais.yousef@arm.com>
> Date: Wed, 30 Dec 2020 22:20:34 +0000
> Subject: [PATCH] trace: bpf: Allow bpf to attach to bare tracepoints
>
> Some subsystems only have bare tracepoints (a tracepoint with no
> associated trace event) to avoid the problem of trace events being an
> ABI that can't be changed.
>
> From bpf presepective, bare tracepoints are what it calls
> RAW_TRACEPOINT().
>
> Since bpf assumed there's 1:1 mapping, it relied on hooking to
> DEFINE_EVENT() macro to create bpf mapping of the tracepoints. Since
> bare tracepoints use DECLARE_TRACE() to create the tracepoint, bpf had
> no knowledge about their existence.
>
> By teaching bpf_probe.h to parse DECLARE_TRACE() in a similar fashion to
> DEFINE_EVENT(), bpf can find and attach to the new raw tracepoints.
>
> Enabling that comes with the contract that changes to raw tracepoints
> don't constitute a regression if they break existing bpf programs.
> We need the ability to continue to morph and modify these raw
> tracepoints without worrying about any ABI.
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  include/trace/bpf_probe.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index cd74bffed5c6..a23be89119aa 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -55,8 +55,7 @@
>  /* tracepoints with more than 12 arguments will hit build error */
>  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
>
> -#undef DECLARE_EVENT_CLASS
> -#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
> +#define __BPF_DECLARE_TRACE(call, proto, args)                         \
>  static notrace void                                                    \
>  __bpf_trace_##call(void *__data, proto)                                        \
>  {                                                                      \
> @@ -64,6 +63,10 @@ __bpf_trace_##call(void *__data, proto)                                      \
>         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
>  }
>
> +#undef DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
> +
>  /*
>   * This part is compiled out, it is only here as a build time check
>   * to make sure that if the tracepoint handling changes, the
> @@ -111,6 +114,11 @@ __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
>  #define DEFINE_EVENT_PRINT(template, name, proto, args, print) \
>         DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
>
> +#undef DECLARE_TRACE
> +#define DECLARE_TRACE(call, proto, args)                               \
> +       __BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))          \
> +       __DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
> +
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)

The patch looks fine to me.
Please add a few things:
- selftests to make sure it gets routinely tested with bpf CI.
- add a doc with contents from commit log.
The "Does bpf make things into an abi ?" question keeps coming back
over and over again.
Everytime we have the same answer that No, bpf cannot bake things into abi.
I think once it's spelled out somewhere in Documentation/ it would be easier to
repeat this message.
Also please tag future patches to bpf-next tree to make sure things
keep being tested.

Thanks
