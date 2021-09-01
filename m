Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83463FE2B1
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbhIATCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347659AbhIATBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 15:01:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E08C061575;
        Wed,  1 Sep 2021 12:00:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k65so541630yba.13;
        Wed, 01 Sep 2021 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSQvSdNEB0WdYPKaFlNQd28Ylc/UkTwMjKACbNyZydg=;
        b=crpOTMhXZ6DtUin5kX4I/74nObdvgvulsy9i1cF275A1w4UAGHJgN1/IpHk4FUtpjE
         MpfFceTnvgneptUBSrzOSzGHDFkNWxlnzWUOhEfpNYYuqADqLJwLmbPVnhk4jSL5Y82U
         3pr7sGU2BteRLfS8MTQnpf7NHcjR2178XJ/SPxTjR66J5KN2u3vhJQ1FHB7ypmk81eWR
         iQLc96TAjU8YywNjDOo5g4KqogqHa/dLflVa0Vo78QJmMXEOstAU83C8cuL6tyUW7CqV
         /HCHcaQ7RPtZj4WSxyVdqoIlq0L3G9aJRVB1cl3bIPH81geUwToIvXj5ndvb2dVgXYlY
         NdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSQvSdNEB0WdYPKaFlNQd28Ylc/UkTwMjKACbNyZydg=;
        b=rEGdO4rXTgEtQ+2RTQTaUh0ieDaQziBmWHTqmk7OaGFFtIkIMPY7Mf5CUlirdt5xin
         CiWuZtIlgmcY3Y39CAat/I1BVNxdRQ/wET3W9tbfj1KjWgfPIrKdxrzOTv+m0a8dHV2m
         pxSmQmqAROhtnB07MPu0JtssKVrwmBqnsq163OX09pknm1+81UqJtNjFUYp+/y7JhL8L
         y5m1kr+cdoWZ1OnkCIK1uhRyOWh1kPA0XQ/vNr/iEqvQ3YFWpaBcItid4b1rVmAx1KhS
         QWHBRxXFVdjW6kIhpXkm83axGBbtHxPAvnTHctXxbKBKxfmbNnvRJDShNMqmsSK1Zzcv
         2sGQ==
X-Gm-Message-State: AOAM531tmewDIcwCfU1KE4FwP2fZHVh1NZItVeevZHJPfVcjUZI93LuB
        o5xvCM3xHJzXiqftnBOBf6Er/q074MtTjDnx7/0=
X-Google-Smtp-Source: ABdhPJwbwFt3tEsWWSkU1jbRgG1p5Z2O7MqkQm8mPd16UuWi5zRxmXnfOYQF48IsEQl7/Zc3oh30ahQZccV/9LjOj/8=
X-Received: by 2002:a05:6902:70b:: with SMTP id k11mr940462ybt.510.1630522844468;
 Wed, 01 Sep 2021 12:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210901003517.3953145-1-songliubraving@fb.com>
 <20210901003517.3953145-3-songliubraving@fb.com> <CAEf4BzaPuPJKnVJ+Bi4aNs57A2x0jRnM3V-ud37U6V=wThHAYQ@mail.gmail.com>
 <0B76C4B1-F113-41F4-A141-163A2A71F4B8@fb.com>
In-Reply-To: <0B76C4B1-F113-41F4-A141-163A2A71F4B8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Sep 2021 12:00:33 -0700
Message-ID: <CAEf4BzbcbXD5jzpxMKi8_nnRBCfDCnb=Dst-Nk34xSPRuTacvw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 1, 2021 at 8:41 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 31, 2021, at 9:02 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 7:01 PM Song Liu <songliubraving@fb.com> wrote:
> >>
> >> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
> >> branch trace from hardware (e.g. Intel LBR). To use the feature, the
> >> user need to create perf_event with proper branch_record filtering
> >> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
> >> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
> >>
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> include/uapi/linux/bpf.h       | 22 +++++++++++++++++++
> >> kernel/bpf/trampoline.c        |  3 ++-
> >> kernel/trace/bpf_trace.c       | 40 ++++++++++++++++++++++++++++++++++
> >> tools/include/uapi/linux/bpf.h | 22 +++++++++++++++++++
> >> 4 files changed, 86 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 791f31dd0abee..c986e6fad5bc0 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -4877,6 +4877,27 @@ union bpf_attr {
> >>  *             Get the struct pt_regs associated with **task**.
> >>  *     Return
> >>  *             A pointer to struct pt_regs.
> >> + *
> >> + * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
> >> + *     Description
> >> + *             Get branch trace from hardware engines like Intel LBR. The
> >> + *             branch trace is taken soon after the trigger point of the
> >> + *             BPF program, so it may contain some entries after the
> >> + *             trigger point. The user need to filter these entries
> >> + *             accordingly.
> >> + *
> >> + *             The data is stored as struct perf_branch_entry into output
> >> + *             buffer *entries*. *size* is the size of *entries* in bytes.
> >> + *             *flags* is reserved for now and must be zero.
> >> + *
> >> + *     Return
> >> + *             On success, number of bytes written to *buf*. On error, a
> >> + *             negative value.
> >> + *
> >> + *             **-EINVAL** if arguments invalid or **size** not a multiple
> >> + *             of **sizeof**\ (**struct perf_branch_entry**\ ).
> >> + *
> >> + *             **-ENOENT** if architecture does not support branch records.
> >>  */
> >> #define __BPF_FUNC_MAPPER(FN)          \
> >>        FN(unspec),                     \
> >> @@ -5055,6 +5076,7 @@ union bpf_attr {
> >>        FN(get_func_ip),                \
> >>        FN(get_attach_cookie),          \
> >>        FN(task_pt_regs),               \
> >> +       FN(get_branch_snapshot),        \
> >>        /* */
> >>
> >> /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> >> index fe1e857324e66..39eaaff81953d 100644
> >> --- a/kernel/bpf/trampoline.c
> >> +++ b/kernel/bpf/trampoline.c
> >> @@ -10,6 +10,7 @@
> >> #include <linux/rcupdate_trace.h>
> >> #include <linux/rcupdate_wait.h>
> >> #include <linux/module.h>
> >> +#include <linux/static_call.h>
> >>
> >> /* dummy _ops. The verifier will operate on target program's ops. */
> >> const struct bpf_verifier_ops bpf_extension_verifier_ops = {
> >> @@ -526,7 +527,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
> >> }
> >>
> >> #define NO_START_TIME 1
> >> -static u64 notrace bpf_prog_start_time(void)
> >> +static __always_inline u64 notrace bpf_prog_start_time(void)
> >> {
> >>        u64 start = NO_START_TIME;
> >>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 8e2eb950aa829..a8ec3634a3329 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -1017,6 +1017,44 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_pe = {
> >>        .arg1_type      = ARG_PTR_TO_CTX,
> >> };
> >>
> >> +static DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
> >> +
> >> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> >> +{
> >> +#ifndef CONFIG_X86
> >> +       return -ENOENT;
> >
> > nit: -EOPNOTSUPP probably makes more sense for this?
>
> I had -EOPNOTSUPP in earlier version. But bpf_read_branch_records uses
> -ENOENT, so I updated here in v4. I guess -ENOENT also makes sense? I
> won't insist if you think -EOPNOTSUPP is better.

Hm... ok, I guess consistency takes priority, let's keep -ENOENT then.

>
> >
> >> +#else
> >> +       static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> >> +       u32 to_copy;
> >> +
> >> +       if (unlikely(flags))
> >> +               return -EINVAL;
> >> +
> >> +       if (!buf || (size % br_entry_size != 0))
> >> +               return -EINVAL;
> >> +
> >> +       static_call(perf_snapshot_branch_stack)(this_cpu_ptr(&bpf_perf_branch_snapshot));
> >
> > First, you have four this_cpu_ptr(&bpf_perf_branch_snapshot)
> > invocations in this function, probably cleaner to store the pointer in
> > local variable?
> >
> > But second, this still has the reentrancy problem, right? And further,
> > we copy the same LBR data twice (to per-cpu buffer and into
> > user-provided destination).
> >
> > What if we change perf_snapshot_branch_stack signature to this:
> >
> > int perf_snapshot_branch_stack(struct perf_branch_entry *entries, int
> > max_nr_entries);
> >
> > with the semantics that it will copy only min(max_nr_entreis,
> > PERF_MAX_BRANCH_RECORDS) * sizeof(struct perf_branch_entry) bytes.
> > That way we can copy directly into a user-provided buffer with no
> > per-cpu storage. Of course, perf_snapshot_branch_stack will return
> > number of entries copied, either as return result, or if static calls
> > don't support that, as another int *nr_entries output argument.
>
> I like this idea. Once we get feedback from Peter, I will change this
> in v5.

Sounds good, thanks!

>
> Thanks,
> Song
>
