Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D6615188
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKAS0f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKAS0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 14:26:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047CC1DF27;
        Tue,  1 Nov 2022 11:26:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id 13so39244142ejn.3;
        Tue, 01 Nov 2022 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/n2xvHfg8OGeHHzcBTtnpiFjtgymhEU/fTqPxcH6ZpQ=;
        b=nemwCOVSD2RqW1rSIh3CowKPBXI2ldcAzoAaOlo/NxnQGm9mUrZMk5ikZUGY+6kPSo
         MHQBgEz3cDx+0HF62a09G/Kjb13xGK8ZduT84UV867Os7WOSAcYZEDMeuawn/BdVGRN8
         K2+K8HIg6asBSXw/sj6i0/9CNHEx677gv8JASCo7aEbT6EO6ilXgbCVfCvU7H1xJiKaY
         e28koQf15pOkUPQ9Q77gZgfpplmxoSsF1cdpkddC5AepmRd0zYJ9UZ+Uca8x6TQBWofv
         GZdfI0inXtmqEfI2h9PmopKap1FLISIt2u95/DngGVVqnKISqbsg6Ms1GygVrX/Pdazh
         ZYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n2xvHfg8OGeHHzcBTtnpiFjtgymhEU/fTqPxcH6ZpQ=;
        b=VuIIQ0cM2fgHcPFrpJ8wzjSTtvxITysSGOfAjyIrgzVO+V2zXZl2xE1Kc4HTo5Z0/Z
         gyVSltsj9hgiKDLIfut1r+NabbRs+3oyqFmqMm2iZlZBgFZdKqCmi/geHfVwkdDuDiWH
         +JysAHCYsPssKd9/m5DjgKvGN92Wsga0fdJlssA8RbMstlaFQVifWlMMUeYE1OGPL/kM
         mlEU+H3EZJteRr6nE90/N0sdpZraJDixRKLl/oWJ4cEAkNclKOT0hPYJjpIxLniTYkjQ
         9AXyelEtMrYPFZ9qhVUf8whphAp+XYsKxhfmaAdrz44onj7KI3qSSaCcLKE00F0V5M5A
         adhQ==
X-Gm-Message-State: ACrzQf0LaQBzCixaFXdf5/7oMU7UfIdoaKfGwIHCpw+GjpMV3UbVAr+J
        wfB3bNVxTxunwBJg/N61pH++5jPWGY6yzQITS3k=
X-Google-Smtp-Source: AMsMyM49VJkek4EvcoMOFD9eNMkmVB7szmSQhewZ53aQy094SGg4UwkZVxflrUdUg7TzBsagSVaGnhf3xE14x0VE1IA=
X-Received: by 2002:a17:906:3b88:b0:78d:513d:f447 with SMTP id
 u8-20020a1709063b8800b0078d513df447mr170794ejf.708.1667327191384; Tue, 01 Nov
 2022 11:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava>
In-Reply-To: <Y2DuzmnUm6NIh25a@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Nov 2022 11:26:19 -0700
Message-ID: <CAADnVQJ6+N6vQ=ZUgUjoB_M2RoTGGPXpLwz81mNDmLWrGYKetw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
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

On Tue, Nov 1, 2022 at 3:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
> > The bpf_perf_event_read_sample() helper is to get the specified sample
> > data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
> > decision for filtering on samples.  Currently PERF_SAMPLE_IP and
> > PERF_SAMPLE_DATA flags are supported only.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 23 ++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 94659f6b3395..cba501de9373 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5481,6 +5481,28 @@ union bpf_attr {
> >   *           0 on success.
> >   *
> >   *           **-ENOENT** if the bpf_local_storage cannot be found.
> > + *
> > + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> > + *   Description
> > + *           For an eBPF program attached to a perf event, retrieve the
> > + *           sample data associated to *ctx* and store it in the buffer
> > + *           pointed by *buf* up to size *size* bytes.
> > + *
> > + *           The *sample_flags* should contain a single value in the
> > + *           **enum perf_event_sample_format**.
> > + *   Return
> > + *           On success, number of bytes written to *buf*. On error, a
> > + *           negative value.
> > + *
> > + *           The *buf* can be set to **NULL** to return the number of bytes
> > + *           required to store the requested sample data.
> > + *
> > + *           **-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> > + *
> > + *           **-ENOENT** if the associated perf event doesn't have the data.
> > + *
> > + *           **-ENOSYS** if system doesn't support the sample data to be
> > + *           retrieved.
> >   */
> >  #define ___BPF_FUNC_MAPPER(FN, ctx...)                       \
> >       FN(unspec, 0, ##ctx)                            \
> > @@ -5695,6 +5717,7 @@ union bpf_attr {
> >       FN(user_ringbuf_drain, 209, ##ctx)              \
> >       FN(cgrp_storage_get, 210, ##ctx)                \
> >       FN(cgrp_storage_delete, 211, ##ctx)             \
> > +     FN(perf_event_read_sample, 212, ##ctx)          \
> >       /* */
> >
> >  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index ce0228c72a93..befd937afa3c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -28,6 +28,7 @@
> >
> >  #include <uapi/linux/bpf.h>
> >  #include <uapi/linux/btf.h>
> > +#include <uapi/linux/perf_event.h>
> >
> >  #include <asm/tlb.h>
> >
> > @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
> >       .arg4_type      = ARG_ANYTHING,
> >  };
> >
> > +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
> > +        void *, buf, u32, size, u64, flags)
> > +{
>
> I wonder we could add perf_btf (like we have tp_btf) program type that
> could access ctx->data directly without helpers
>
> > +     struct perf_sample_data *sd = ctx->data;
> > +     void *data;
> > +     u32 to_copy = sizeof(u64);
> > +
> > +     /* only allow a single sample flag */
> > +     if (!is_power_of_2(flags))
> > +             return -EINVAL;
> > +
> > +     /* support reading only already populated info */
> > +     if (flags & ~sd->sample_flags)
> > +             return -ENOENT;
> > +
> > +     switch (flags) {
> > +     case PERF_SAMPLE_IP:
> > +             data = &sd->ip;
> > +             break;
> > +     case PERF_SAMPLE_ADDR:
> > +             data = &sd->addr;
> > +             break;
>
> AFAICS from pe_prog_convert_ctx_access you should be able to read addr
> directly from context right? same as sample_period.. so I think if this
> will be generic way to read sample data, should we add sample_period
> as well?

+1
Let's avoid new stable helpers for this.
Pls use CORE and read perf_sample_data directly.
