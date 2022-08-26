Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF285A2080
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiHZFx2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZFxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 01:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE204D0762;
        Thu, 25 Aug 2022 22:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2E761982;
        Fri, 26 Aug 2022 05:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29DBC433D7;
        Fri, 26 Aug 2022 05:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661493202;
        bh=R4FIJTfK5BiXshJ8j5B3MsFnPhCrQXJMHxLvbBW+/z4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KmZvjY6ikSzn7lPBKetcxAOrQPXQyjZIx36hNrTJhovdLiwgEOUzSHkd9B9OKj+v0
         zgjPY7sOvlCUpzgIm63O276vB5Dwsb22rXotnIUWRhVWwYisfDkT1HTFwaQ3eX70aW
         KVXyFSypWN6riV8YSbs4X0qxdrgH0sC0SKf9UEqeWHcRTX80iJkbkxyA946Ca40WSn
         G/BAsZpYIpP4mh3kusPDxn8zYvZM3J2peV3EVhcJDgJJmIFOguTS4Q5dDRb2Vfu5yg
         QQtrEniSh60DkfaQJdDzvHm8tOY+G/jUYSA71bDYk+WZPWKWVLMpR9uUIOE4tsLozN
         QAFn6r8TP2TZA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-33dba2693d0so10909737b3.12;
        Thu, 25 Aug 2022 22:53:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo02mga5t78SidZI30TT3+CPnrBbyQmUGem6rryVPzhq68LJgvld
        DPVgv1FSzbdRansU/KOIc4is0P2//vZ3mYNEyl0=
X-Google-Smtp-Source: AA6agR7gOaZjs09UmPPNpKm1NS4oraRvce3kHiygNJeUNU9HmN2KZtckn/Yb498983PO2QNnsgsyHBbq7EsQKUYXG4s=
X-Received: by 2002:a81:63c3:0:b0:323:ce27:4e4d with SMTP id
 x186-20020a8163c3000000b00323ce274e4dmr7280253ywb.472.1661493201690; Thu, 25
 Aug 2022 22:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com> <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
In-Reply-To: <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Aug 2022 22:53:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
Message-ID: <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
> >
> >
> >
> > > On Aug 25, 2022, at 4:03 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 3:08 PM Song Liu <songliubraving@fb.com> wrote:
> > >>
> > >>
> > >>
> > >>> On Aug 25, 2022, at 2:33 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >>>
> > >>> On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>>> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> > >>>> + *     Description
> > >>>> + *             For an eBPF program attached to a perf event, retrieve the
> > >>>> + *             raw record associated to *ctx* and store it in the buffer
> > >>>> + *             pointed by *buf* up to size *size* bytes.
> > >>>> + *     Return
> > >>>> + *             On success, number of bytes written to *buf*. On error, a
> > >>>> + *             negative value.
> > >>>> + *
> > >>>> + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
> > >>>> + *             instead return the number of bytes required to store the raw
> > >>>> + *             record. If this flag is set, *buf* may be NULL.
> > >>>
> > >>> It looks pretty ugly from a usability standpoint to have one helper
> > >>> doing completely different things and returning two different values
> > >>> based on BPF_F_GET_RAW_RECORD_SIZE.
> > >>
> > >> Yeah, I had the same thought when I first looked at it. But that's the
> > >> exact syntax with bpf_read_branch_records(). Well, we still have time
> > >> to fix the new helper..
> > >>
> > >>>
> > >>> I'm not sure what's best, but I have two alternative proposals:
> > >>>
> > >>> 1. Add two helpers: one to get perf record information (and size will
> > >>> be one of them). Something like bpf_perf_record_query(ctx, flags)
> > >>> where you pass perf ctx and what kind of information you want to read
> > >>> (through flags), and u64 return result returns that (see
> > >>> bpf_ringbuf_query() for such approach). And then have separate helper
> > >>> to read data.
> > >>>
> > >>> 2. Keep one helper, but specify that it always returns record size,
> > >>> even if user specified smaller size to read. And then allow passing
> > >>> buf==NULL && size==0. So passing NULL, 0 -- you get record size.
> > >>> Passing non-NULL buf -- you read data.
> > >>
> > >> AFAICT, this is also confusing.
> > >>
> > >
> > > this is analogous to snprintf() behavior, so not that new and
> > > surprising when you think about it. But if query + read makes more
> > > sense, then it's fine by me
> >
> > Given the name discussion (the other email), I now like one API better.
> >
> > Actually, since we are on this, can we make it more generic, and handle
> > all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
> > like:
> >
> > long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
> >
> > WDYT Namhyung?
>
> Do you mean reading the whole sample data at once?
> Then it needs to parse the sample data format properly
> which is non trivial due to a number of variable length
> fields like callchains and branch stack, etc.
>
> Also I'm afraid I might need event configuration info
> other than sample data like attr.type, attr.config,
> attr.sample_type and so on.
>
> Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?

The user should have access to the perf_event_attr used to
create the event. This is also available in ctx->event->attr.

Would this work?

Thanks,
Song

>
> >
> > Another idea is to add another parameter, so that we can pick which
> > PERF_SAMPLE_* to output via bpf_perf_event_read_sample().
> >
> > I think this will cover all cases with sample perf_event. Thoughts?
>
> Yeah, I like this more and it looks easier to use.
