Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60DF6151BE
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 19:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKASrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKASrM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 14:47:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00371C91B;
        Tue,  1 Nov 2022 11:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 155D1CE1DBE;
        Tue,  1 Nov 2022 18:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246AAC433D6;
        Tue,  1 Nov 2022 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667328427;
        bh=QLdC5NhmlPCsZ0fQmjLQ1e7hJz99WGjywddDhFXtMLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fN/bZfOXY8KV51v5e96jmg59JEkoMANra1x65SSyTmWwyGs6gZJh1P92p+oWqulwP
         gXlJ1rwaerpAu7IZ1yhZWhpJuhNlvLgX5BonQpF2lFVh2E3oUwEa/qnYZW5h+2Oc2q
         I9pXK97sKXNNxIu1Q2INqW3r1kUKlv1VPHyOAEQ/ZkRJdCAcQs+of61HrPpWUzONSs
         QQPUO2W6YAYOPg1icW0qQmzDoytmrgBcAesiEo1Pwd3QMLG2tkTKuUL6aaB3LSF0ij
         s2x5ZGvjBJ8d3G6hm5ol2KqI/b1ptmr9VgDFBsNJAsjG6JL2h8btWw1vZBg81Waks7
         icf4yaqPFIPxQ==
Received: by mail-ed1-f43.google.com with SMTP id z18so18069029edb.9;
        Tue, 01 Nov 2022 11:47:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf3gZJHObIJmBbfKvKzh1JjKljwN1owQzQyae7d4RnLaAsErPGm4
        b2TvdcLwchrUNbeB+KPZDQZr8GivwEJ63F70OQg=
X-Google-Smtp-Source: AMsMyM7NG+V8QRtMbNL/bl9B7tt5Ew1cnsBIqP2w5Q3U6mKYB6o20GQfUPZVH4oFcKHsN5dOIuUhYpiqRFHpKG2zU0M=
X-Received: by 2002:aa7:d710:0:b0:463:bd7b:2b44 with SMTP id
 t16-20020aa7d710000000b00463bd7b2b44mr3721414edq.385.1667328425396; Tue, 01
 Nov 2022 11:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
In-Reply-To: <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Nov 2022 11:46:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
Message-ID: <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 11:26 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 1, 2022 at 3:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
> > > The bpf_perf_event_read_sample() helper is to get the specified sample
> > > data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
> > > decision for filtering on samples.  Currently PERF_SAMPLE_IP and
> > > PERF_SAMPLE_DATA flags are supported only.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  include/uapi/linux/bpf.h       | 23 ++++++++++++++++
> > >  kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
> > >  3 files changed, 95 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 94659f6b3395..cba501de9373 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -5481,6 +5481,28 @@ union bpf_attr {
> > >   *           0 on success.
> > >   *
> > >   *           **-ENOENT** if the bpf_local_storage cannot be found.
> > > + *
> > > + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> > > + *   Description
> > > + *           For an eBPF program attached to a perf event, retrieve the
> > > + *           sample data associated to *ctx* and store it in the buffer
> > > + *           pointed by *buf* up to size *size* bytes.
> > > + *
> > > + *           The *sample_flags* should contain a single value in the
> > > + *           **enum perf_event_sample_format**.
> > > + *   Return
> > > + *           On success, number of bytes written to *buf*. On error, a
> > > + *           negative value.
> > > + *
> > > + *           The *buf* can be set to **NULL** to return the number of bytes
> > > + *           required to store the requested sample data.
> > > + *
> > > + *           **-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> > > + *
> > > + *           **-ENOENT** if the associated perf event doesn't have the data.
> > > + *
> > > + *           **-ENOSYS** if system doesn't support the sample data to be
> > > + *           retrieved.
> > >   */
> > >  #define ___BPF_FUNC_MAPPER(FN, ctx...)                       \
> > >       FN(unspec, 0, ##ctx)                            \
> > > @@ -5695,6 +5717,7 @@ union bpf_attr {
> > >       FN(user_ringbuf_drain, 209, ##ctx)              \
> > >       FN(cgrp_storage_get, 210, ##ctx)                \
> > >       FN(cgrp_storage_delete, 211, ##ctx)             \
> > > +     FN(perf_event_read_sample, 212, ##ctx)          \
> > >       /* */
> > >
> > >  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index ce0228c72a93..befd937afa3c 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -28,6 +28,7 @@
> > >
> > >  #include <uapi/linux/bpf.h>
> > >  #include <uapi/linux/btf.h>
> > > +#include <uapi/linux/perf_event.h>
> > >
> > >  #include <asm/tlb.h>
> > >
> > > @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
> > >       .arg4_type      = ARG_ANYTHING,
> > >  };
> > >
> > > +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
> > > +        void *, buf, u32, size, u64, flags)
> > > +{
> >
> > I wonder we could add perf_btf (like we have tp_btf) program type that
> > could access ctx->data directly without helpers
> >
> > > +     struct perf_sample_data *sd = ctx->data;
> > > +     void *data;
> > > +     u32 to_copy = sizeof(u64);
> > > +
> > > +     /* only allow a single sample flag */
> > > +     if (!is_power_of_2(flags))
> > > +             return -EINVAL;
> > > +
> > > +     /* support reading only already populated info */
> > > +     if (flags & ~sd->sample_flags)
> > > +             return -ENOENT;
> > > +
> > > +     switch (flags) {
> > > +     case PERF_SAMPLE_IP:
> > > +             data = &sd->ip;
> > > +             break;
> > > +     case PERF_SAMPLE_ADDR:
> > > +             data = &sd->addr;
> > > +             break;
> >
> > AFAICS from pe_prog_convert_ctx_access you should be able to read addr
> > directly from context right? same as sample_period.. so I think if this
> > will be generic way to read sample data, should we add sample_period
> > as well?
>
> +1
> Let's avoid new stable helpers for this.
> Pls use CORE and read perf_sample_data directly.

We have legacy ways to access sample_period and addr with
struct bpf_perf_event_data and struct bpf_perf_event_data_kern. I
think mixing that
with CORE makes it confusing for the user. And a helper or a kfunc would make it
easier to follow. perf_btf might also be a good approach for this.

Thanks,
Song
