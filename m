Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8670B6152AC
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKAUEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAUEY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 16:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750201C437;
        Tue,  1 Nov 2022 13:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93A96171A;
        Tue,  1 Nov 2022 20:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1A2C4347C;
        Tue,  1 Nov 2022 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667333062;
        bh=7XHcT9f5J4g8DUVSlnwzPNm8LhYkpUS0/AMNBo9GJUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FBRvkOYHviuunbD60ryqT2SJpVXzILmLsbk4oCCN1PPUfZRoRMXfcftBWHsnhzQvP
         X2rSulY8YSkIZTb1mdOW9/BA3EwawUJp3PVXrugJeQMkBARSHfXu4/9KvsFeAqQm8b
         l2sWys+IS01a7pFM36ouHY/NolCKq1SFzVWSL8Z0Z7BoX7awZgJE6hXdVDD0qcy5SK
         fsHusHEjEAJgmJey+F5Rhiy6pdb3Ss9ZJF4fbgHu8BGyIjt8DubYtOaJOd4c0yYpIl
         yBzPGVjBPguUyB9EhYyaE92t3RNK8lJrwAdUVkFgozFeI+NgOlGqzcdN+gQtN1SCh7
         bV9Y0/tHfzlhw==
Received: by mail-ej1-f44.google.com with SMTP id y14so39864568ejd.9;
        Tue, 01 Nov 2022 13:04:22 -0700 (PDT)
X-Gm-Message-State: ACrzQf0F5hkJS42QDJN3kX7JcBbpT9JvcrrLh0QVtpOL76gV/6jaVgdw
        V6ZJSf5IUCKvDAopbQqIYNliDQcRV2HVSmvgT6s=
X-Google-Smtp-Source: AMsMyM4BvokXG3mZAS3b6jtYCaK0TRjw2+YB+yV5CbP3BvAOvmHfYrXMyuLHe6QIfsRHg3bjK47x7pBeER/rI4lAZaE=
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id
 wu1-20020a170906eec100b00782638476bemr19830640ejb.756.1667333060421; Tue, 01
 Nov 2022 13:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
 <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com> <CAADnVQ+SYv5O+UxnGaBAvxptopWyANdbQRg=e2GXiRBPyJMGgA@mail.gmail.com>
In-Reply-To: <CAADnVQ+SYv5O+UxnGaBAvxptopWyANdbQRg=e2GXiRBPyJMGgA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Nov 2022 13:04:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW55zAYCipf1P4dM8Cu9QFewnyZE+SOquKhSbdqUWG_EKg@mail.gmail.com>
Message-ID: <CAPhsuW55zAYCipf1P4dM8Cu9QFewnyZE+SOquKhSbdqUWG_EKg@mail.gmail.com>
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

On Tue, Nov 1, 2022 at 11:53 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 1, 2022 at 11:47 AM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Nov 1, 2022 at 11:26 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Nov 1, 2022 at 3:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
> > > > > The bpf_perf_event_read_sample() helper is to get the specified sample
> > > > > data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
> > > > > decision for filtering on samples.  Currently PERF_SAMPLE_IP and
> > > > > PERF_SAMPLE_DATA flags are supported only.
> > > > >
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  include/uapi/linux/bpf.h       | 23 ++++++++++++++++
> > > > >  kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
> > > > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
> > > > >  3 files changed, 95 insertions(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index 94659f6b3395..cba501de9373 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -5481,6 +5481,28 @@ union bpf_attr {
> > > > >   *           0 on success.
> > > > >   *
> > > > >   *           **-ENOENT** if the bpf_local_storage cannot be found.
> > > > > + *
> > > > > + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> > > > > + *   Description
> > > > > + *           For an eBPF program attached to a perf event, retrieve the
> > > > > + *           sample data associated to *ctx* and store it in the buffer
> > > > > + *           pointed by *buf* up to size *size* bytes.
> > > > > + *
> > > > > + *           The *sample_flags* should contain a single value in the
> > > > > + *           **enum perf_event_sample_format**.
> > > > > + *   Return
> > > > > + *           On success, number of bytes written to *buf*. On error, a
> > > > > + *           negative value.
> > > > > + *
> > > > > + *           The *buf* can be set to **NULL** to return the number of bytes
> > > > > + *           required to store the requested sample data.
> > > > > + *
> > > > > + *           **-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> > > > > + *
> > > > > + *           **-ENOENT** if the associated perf event doesn't have the data.
> > > > > + *
> > > > > + *           **-ENOSYS** if system doesn't support the sample data to be
> > > > > + *           retrieved.
> > > > >   */
> > > > >  #define ___BPF_FUNC_MAPPER(FN, ctx...)                       \
> > > > >       FN(unspec, 0, ##ctx)                            \
> > > > > @@ -5695,6 +5717,7 @@ union bpf_attr {
> > > > >       FN(user_ringbuf_drain, 209, ##ctx)              \
> > > > >       FN(cgrp_storage_get, 210, ##ctx)                \
> > > > >       FN(cgrp_storage_delete, 211, ##ctx)             \
> > > > > +     FN(perf_event_read_sample, 212, ##ctx)          \
> > > > >       /* */
> > > > >
> > > > >  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> > > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > > index ce0228c72a93..befd937afa3c 100644
> > > > > --- a/kernel/trace/bpf_trace.c
> > > > > +++ b/kernel/trace/bpf_trace.c
> > > > > @@ -28,6 +28,7 @@
> > > > >
> > > > >  #include <uapi/linux/bpf.h>
> > > > >  #include <uapi/linux/btf.h>
> > > > > +#include <uapi/linux/perf_event.h>
> > > > >
> > > > >  #include <asm/tlb.h>
> > > > >
> > > > > @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
> > > > >       .arg4_type      = ARG_ANYTHING,
> > > > >  };
> > > > >
> > > > > +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
> > > > > +        void *, buf, u32, size, u64, flags)
> > > > > +{
> > > >
> > > > I wonder we could add perf_btf (like we have tp_btf) program type that
> > > > could access ctx->data directly without helpers
> > > >
> > > > > +     struct perf_sample_data *sd = ctx->data;
> > > > > +     void *data;
> > > > > +     u32 to_copy = sizeof(u64);
> > > > > +
> > > > > +     /* only allow a single sample flag */
> > > > > +     if (!is_power_of_2(flags))
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     /* support reading only already populated info */
> > > > > +     if (flags & ~sd->sample_flags)
> > > > > +             return -ENOENT;
> > > > > +
> > > > > +     switch (flags) {
> > > > > +     case PERF_SAMPLE_IP:
> > > > > +             data = &sd->ip;
> > > > > +             break;
> > > > > +     case PERF_SAMPLE_ADDR:
> > > > > +             data = &sd->addr;
> > > > > +             break;
> > > >
> > > > AFAICS from pe_prog_convert_ctx_access you should be able to read addr
> > > > directly from context right? same as sample_period.. so I think if this
> > > > will be generic way to read sample data, should we add sample_period
> > > > as well?
> > >
> > > +1
> > > Let's avoid new stable helpers for this.
> > > Pls use CORE and read perf_sample_data directly.
> >
> > We have legacy ways to access sample_period and addr with
> > struct bpf_perf_event_data and struct bpf_perf_event_data_kern. I
> > think mixing that
> > with CORE makes it confusing for the user. And a helper or a kfunc would make it
> > easier to follow. perf_btf might also be a good approach for this.
>
> imo that's a counter argument to non-CORE style.
> struct bpf_perf_event_data has sample_period and addr,
> and as soon as we pushed the boundaries it turned out it's not enough.
> Now we're proposing to extend uapi a bit with sample_ip.
> That will repeat the same mistake.
> Just use CORE and read everything that is there today
> and will be there in the future.

Another work of this effort is that we need the perf_event to prepare
required fields before calling the BPF program. I think we will need
some logic in addition to CORE to get that right. How about we add
perf_btf where the perf_event prepare all fields before calling the
BPF program? perf_btf + CORE will be able to read all fields in the
sample.

Thanks,
Song
