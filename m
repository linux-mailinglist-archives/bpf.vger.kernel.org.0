Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A597D6151CD
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKASxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKASxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 14:53:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED411D660;
        Tue,  1 Nov 2022 11:53:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 21so23110582edv.3;
        Tue, 01 Nov 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ7/MwAQn4LrD4Cf9RqJ2+ZX45LUaYFp5K5tPUEtopc=;
        b=CZygNYllInTMzzqdHiFTJOLrkjxTQgO1oQpuU+yG/Fw3VBPhuP0ceXjWxu8kChGduR
         fqoTqd6VAL1EQRLZQ4MK0QChp5USOBCwR+P4aWf0CUDCpDsIMtioht+Ys1bHkOr3XZTq
         rYq32ODtMzjhUAAYGglasgB85wad2W4smQhN0wyxM1XS7lw7JJLEK1Js0jamImBd/OJ/
         5xo2VyQ/B/5OwC7g7z/RJrJZlTvaUD7eM8CcC/zl8UDhfXVy7MOZe0z7PWwzO0ZqR/Xw
         3hmX0MDaRR3l5Yyzqcl3+EWMrYp5qSoirBxw4sjHT0/QFv+kvvIuIJiKvnxW9vsVfZ+R
         PhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ7/MwAQn4LrD4Cf9RqJ2+ZX45LUaYFp5K5tPUEtopc=;
        b=NimcRsmeVUvNFumwSNkspAJLr4UNcAWW9FvmICvOQ0nn0O1WhWkU+Jx9v0vgeVHrms
         6dm8/0dIzPWgW7/cnMYH0M+KWctRbgEsUhPwP+Uk7vRmGWycsaN9vBJui6pE2YFFYO9Q
         WBedBjKoRYWh532M1mfnYk/RsUk/CjYADr/PJg4B1vRK/X+lBhoB3lHjg9MkEi7Gpwax
         AK8ntU3FhUuadCSzOe/DS3d58EpWEdjLfKrMhmJuAlTUh50N8sLi7/RK4tFIOA59ThCw
         ePqoxwW9GGXjod2pwps8BoLfI5sZCP1ypB70ADrIEKf5b7JB7+/GiI18k6qk65HT0WL7
         7Hjw==
X-Gm-Message-State: ACrzQf3F39CP2ZPxg5eTWyMmgM7f6jjvM7lu2GJ3DD7n+o3egvrm0Fyn
        vlaPhxMAAO8NOjyn9CwBEGc2UI9V28ivGH46sDA=
X-Google-Smtp-Source: AMsMyM4NWTcwa6GoOT/IG73obE/jQ6ZPCtMq7hwJI8TVjbfrYopO5y4KbfIIOZ2nPTKTMxHQ+eZTTqse6EjRNmXOdp8=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr20659134edb.333.1667328788216; Tue, 01
 Nov 2022 11:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
 <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
In-Reply-To: <CAPhsuW6iuEZCCYJk-cra8DkEWNtdin8GyJDZ6Y8zd4ecfd1gQA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Nov 2022 11:52:56 -0700
Message-ID: <CAADnVQ+SYv5O+UxnGaBAvxptopWyANdbQRg=e2GXiRBPyJMGgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
To:     Song Liu <song@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 11:47 AM Song Liu <song@kernel.org> wrote:
>
> On Tue, Nov 1, 2022 at 11:26 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 1, 2022 at 3:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
> > > > The bpf_perf_event_read_sample() helper is to get the specified sample
> > > > data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
> > > > decision for filtering on samples.  Currently PERF_SAMPLE_IP and
> > > > PERF_SAMPLE_DATA flags are supported only.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  include/uapi/linux/bpf.h       | 23 ++++++++++++++++
> > > >  kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
> > > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
> > > >  3 files changed, 95 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 94659f6b3395..cba501de9373 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -5481,6 +5481,28 @@ union bpf_attr {
> > > >   *           0 on success.
> > > >   *
> > > >   *           **-ENOENT** if the bpf_local_storage cannot be found.
> > > > + *
> > > > + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> > > > + *   Description
> > > > + *           For an eBPF program attached to a perf event, retrieve the
> > > > + *           sample data associated to *ctx* and store it in the buffer
> > > > + *           pointed by *buf* up to size *size* bytes.
> > > > + *
> > > > + *           The *sample_flags* should contain a single value in the
> > > > + *           **enum perf_event_sample_format**.
> > > > + *   Return
> > > > + *           On success, number of bytes written to *buf*. On error, a
> > > > + *           negative value.
> > > > + *
> > > > + *           The *buf* can be set to **NULL** to return the number of bytes
> > > > + *           required to store the requested sample data.
> > > > + *
> > > > + *           **-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> > > > + *
> > > > + *           **-ENOENT** if the associated perf event doesn't have the data.
> > > > + *
> > > > + *           **-ENOSYS** if system doesn't support the sample data to be
> > > > + *           retrieved.
> > > >   */
> > > >  #define ___BPF_FUNC_MAPPER(FN, ctx...)                       \
> > > >       FN(unspec, 0, ##ctx)                            \
> > > > @@ -5695,6 +5717,7 @@ union bpf_attr {
> > > >       FN(user_ringbuf_drain, 209, ##ctx)              \
> > > >       FN(cgrp_storage_get, 210, ##ctx)                \
> > > >       FN(cgrp_storage_delete, 211, ##ctx)             \
> > > > +     FN(perf_event_read_sample, 212, ##ctx)          \
> > > >       /* */
> > > >
> > > >  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index ce0228c72a93..befd937afa3c 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -28,6 +28,7 @@
> > > >
> > > >  #include <uapi/linux/bpf.h>
> > > >  #include <uapi/linux/btf.h>
> > > > +#include <uapi/linux/perf_event.h>
> > > >
> > > >  #include <asm/tlb.h>
> > > >
> > > > @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
> > > >       .arg4_type      = ARG_ANYTHING,
> > > >  };
> > > >
> > > > +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
> > > > +        void *, buf, u32, size, u64, flags)
> > > > +{
> > >
> > > I wonder we could add perf_btf (like we have tp_btf) program type that
> > > could access ctx->data directly without helpers
> > >
> > > > +     struct perf_sample_data *sd = ctx->data;
> > > > +     void *data;
> > > > +     u32 to_copy = sizeof(u64);
> > > > +
> > > > +     /* only allow a single sample flag */
> > > > +     if (!is_power_of_2(flags))
> > > > +             return -EINVAL;
> > > > +
> > > > +     /* support reading only already populated info */
> > > > +     if (flags & ~sd->sample_flags)
> > > > +             return -ENOENT;
> > > > +
> > > > +     switch (flags) {
> > > > +     case PERF_SAMPLE_IP:
> > > > +             data = &sd->ip;
> > > > +             break;
> > > > +     case PERF_SAMPLE_ADDR:
> > > > +             data = &sd->addr;
> > > > +             break;
> > >
> > > AFAICS from pe_prog_convert_ctx_access you should be able to read addr
> > > directly from context right? same as sample_period.. so I think if this
> > > will be generic way to read sample data, should we add sample_period
> > > as well?
> >
> > +1
> > Let's avoid new stable helpers for this.
> > Pls use CORE and read perf_sample_data directly.
>
> We have legacy ways to access sample_period and addr with
> struct bpf_perf_event_data and struct bpf_perf_event_data_kern. I
> think mixing that
> with CORE makes it confusing for the user. And a helper or a kfunc would make it
> easier to follow. perf_btf might also be a good approach for this.

imo that's a counter argument to non-CORE style.
struct bpf_perf_event_data has sample_period and addr,
and as soon as we pushed the boundaries it turned out it's not enough.
Now we're proposing to extend uapi a bit with sample_ip.
That will repeat the same mistake.
Just use CORE and read everything that is there today
and will be there in the future.
