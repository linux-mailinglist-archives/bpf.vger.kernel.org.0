Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E959F36E
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 08:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiHXGKD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHXGKC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 02:10:02 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE121A3;
        Tue, 23 Aug 2022 23:10:01 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id n124so7593055oih.7;
        Tue, 23 Aug 2022 23:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MJ6AZ1UWd0bT97akas4NpKCnvFJdnaXZc24uDT8zc78=;
        b=0S0Nsr74HOZ5Sth0eRvbEcACy6JfuFG91U/SkcWGoympK/Ox2MhJAj0nCkWKdicTml
         XZTaF1ot6gzNGvTfcCOOEtduyXwf12TQuLOHZszIouD2V4EKKWhdIxN3fmtrRT5ezPF2
         m21pLC4J3ytF9pFN6Q3o4/sd2ML1YODrIDYFvLqFgA88HcAW085W+aoNPLEa3iZWAAF4
         FHwzck3urNah/zrDq0iDRfY6unjMb0RUob8s1PqyV6O8EnYr2fJ20IwYAg7mmb6662SX
         MruS+LNZ+I3oX7fDJWUPa/yi149NiQGn5A5fPDOzFczoHUJLNDVVCy0FbGODq1WklVCl
         QMRw==
X-Gm-Message-State: ACgBeo2Bf6Su7R0QANlTS6SPE3NL1F8how70y9FFuviD7aweOA/InkGq
        7VmCAsCHF6H91hbrxJOUAAse6oEiZy9x3YzsW49/PrU3
X-Google-Smtp-Source: AA6agR4wc/X7kvuUNTX+NKgrplh9/ona3y4y8jQSgnPeFKSucl+Dux3tu7wgz5JY2X2aTsf1nNsfi+Q6eDIcSfnMr+g=
X-Received: by 2002:a05:6808:d46:b0:345:7b42:f987 with SMTP id
 w6-20020a0568080d4600b003457b42f987mr2312446oik.92.1661321400646; Tue, 23 Aug
 2022 23:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <6305b7bcbd7a3_6d4fc208d9@john.notmuch>
In-Reply-To: <6305b7bcbd7a3_6d4fc208d9@john.notmuch>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 23 Aug 2022 23:09:49 -0700
Message-ID: <CAM9d7cjrXf5Ook+wBHrQv9tL2v=i+yasUzS-F3tJuDZDq88hhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Aug 23, 2022 at 10:31 PM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Namhyung Kim wrote:
> > The helper is for BPF programs attached to perf_event in order to read
> > event-specific raw data.  I followed the convention of the
> > bpf_read_branch_records() helper so that it can tell the size of
> > record using BPF_F_GET_RAW_RECORD flag.
> >
> > The use case is to filter perf event samples based on the HW provided
> > data which have more detailed information about the sample.
> >
> > Note that it only reads the first fragment of the raw record.  But it
> > seems mostly ok since all the existing PMU raw data have only single
> > fragment and the multi-fragment records are only for BPF output attached
> > to sockets.  So unless it's used with such an extreme case, it'd work
> > for most of tracing use cases.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks!

>
> > I don't know how to test this.  As the raw data is available on some
> > hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> > rejected by the verifier.  Actually it needs a bpf_perf_event_data
> > context so that's not an option IIUC.
>
> not a pmu expert but also no good ideas on my side.
>
> ...
>
> >
> > +BPF_CALL_4(bpf_read_raw_record, struct bpf_perf_event_data_kern *, ctx,
> > +        void *, buf, u32, size, u64, flags)
> > +{
> > +     struct perf_raw_record *raw = ctx->data->raw;
> > +     struct perf_raw_frag *frag;
> > +     u32 to_copy;
> > +
> > +     if (unlikely(flags & ~BPF_F_GET_RAW_RECORD_SIZE))
> > +             return -EINVAL;
> > +
> > +     if (unlikely(!raw))
> > +             return -ENOENT;
> > +
> > +     if (flags & BPF_F_GET_RAW_RECORD_SIZE)
> > +             return raw->size;
> > +
> > +     if (!buf || (size % sizeof(u32) != 0))
> > +             return -EINVAL;
> > +
> > +     frag = &raw->frag;
> > +     WARN_ON_ONCE(!perf_raw_frag_last(frag));
> > +
> > +     to_copy = min_t(u32, frag->size, size);
> > +     memcpy(buf, frag->data, to_copy);
> > +
> > +     return to_copy;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_read_raw_record_proto = {
> > +     .func           = bpf_read_raw_record,
> > +     .gpl_only       = true,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_CTX,
> > +     .arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
> > +     .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> > +     .arg4_type      = ARG_ANYTHING,
> > +};
>
> Patch lgtm but curious why allow the ARG_PTR_TO_MEM_OR_NULL from API
> side instead of just ARG_PTR_TO_MEM? Maybe, just to match the
> existing perf_event_read()? I acked it as I think matching existing
> API is likely good enough reason.

It can query the size of raw record using BPF_F_GET_RAW_RECORD_SIZE.
In that case it can pass NULL for the buffer (and 0 for the size).

Thanks,
Namhyung


>
> > +
> >  static const struct bpf_func_proto *
> >  pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> > @@ -1548,6 +1587,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >               return &bpf_read_branch_records_proto;
> >       case BPF_FUNC_get_attach_cookie:
> >               return &bpf_get_attach_cookie_proto_pe;
> > +     case BPF_FUNC_read_raw_record:
> > +             return &bpf_read_raw_record_proto;
> >       default:
> >               return bpf_tracing_func_proto(func_id, prog);
> >       }
> > --
> > 2.37.2.609.g9ff673ca1a-goog
> >
>
>
