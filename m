Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E55A2046
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 07:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiHZFW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 01:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZFW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 01:22:27 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACED2B621;
        Thu, 25 Aug 2022 22:22:24 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r10so799735oie.1;
        Thu, 25 Aug 2022 22:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dcQ7tHEk6A4NG/f0IrJN35BtaVDu5euhRodW0KjfFhQ=;
        b=qyD+VciCIni97gnrM1ES2Ngjj1zOkJYuQ+QmEX6+hPj3f6CBIC6TK5ESd3dIiz7LTA
         zbWIGRKE1b/6HYBPTOPYj4v2QZ4lUvCwlGxAG9g/t+3pCSZxXbdBpfhvNmY63JNcqZ04
         fN0/mbS9Uzu0cWpZLf/ZJeE63sNZhRJjP1rBnPMpHYwh9kkxM6Vm0gI5pturvOaqAOKz
         aPyx435pJiUH8uaiSsLowG6ZVW+c3sV5o5DN3xintX32wFIf/plFqZ3pZPzaGBNOzMEB
         N0ZYBliQ9NWYSFYJ+iUjbSQzg2ER5YqTJzDGV0v3N461sIOgq2YB4DJrP4EAuVpNCYWc
         +ifg==
X-Gm-Message-State: ACgBeo3gejO1MMuz80SlJyFf0AfHjZK8depRDobEVeJCwwGxfd8j6E7d
        B+c4H7HJwigUjXDa9uJ/UDEJ6LPn7EGOwV3Vg2PC1HpX
X-Google-Smtp-Source: AA6agR6AT8uD1gM87aThwAmsPqjO8xyTQXvujTgAg9PRgYnDYfKf70NH3Tr9zoh8+UpejG9uwBcfK8jdY6vbR1Ezww8=
X-Received: by 2002:aca:ba86:0:b0:33a:c6f7:3001 with SMTP id
 k128-20020acaba86000000b0033ac6f73001mr953755oif.5.1661491343139; Thu, 25 Aug
 2022 22:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
In-Reply-To: <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 Aug 2022 22:22:14 -0700
Message-ID: <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 25, 2022, at 4:03 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 3:08 PM Song Liu <songliubraving@fb.com> wrote:
> >>
> >>
> >>
> >>> On Aug 25, 2022, at 2:33 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> >>>> + *     Description
> >>>> + *             For an eBPF program attached to a perf event, retrieve the
> >>>> + *             raw record associated to *ctx* and store it in the buffer
> >>>> + *             pointed by *buf* up to size *size* bytes.
> >>>> + *     Return
> >>>> + *             On success, number of bytes written to *buf*. On error, a
> >>>> + *             negative value.
> >>>> + *
> >>>> + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
> >>>> + *             instead return the number of bytes required to store the raw
> >>>> + *             record. If this flag is set, *buf* may be NULL.
> >>>
> >>> It looks pretty ugly from a usability standpoint to have one helper
> >>> doing completely different things and returning two different values
> >>> based on BPF_F_GET_RAW_RECORD_SIZE.
> >>
> >> Yeah, I had the same thought when I first looked at it. But that's the
> >> exact syntax with bpf_read_branch_records(). Well, we still have time
> >> to fix the new helper..
> >>
> >>>
> >>> I'm not sure what's best, but I have two alternative proposals:
> >>>
> >>> 1. Add two helpers: one to get perf record information (and size will
> >>> be one of them). Something like bpf_perf_record_query(ctx, flags)
> >>> where you pass perf ctx and what kind of information you want to read
> >>> (through flags), and u64 return result returns that (see
> >>> bpf_ringbuf_query() for such approach). And then have separate helper
> >>> to read data.
> >>>
> >>> 2. Keep one helper, but specify that it always returns record size,
> >>> even if user specified smaller size to read. And then allow passing
> >>> buf==NULL && size==0. So passing NULL, 0 -- you get record size.
> >>> Passing non-NULL buf -- you read data.
> >>
> >> AFAICT, this is also confusing.
> >>
> >
> > this is analogous to snprintf() behavior, so not that new and
> > surprising when you think about it. But if query + read makes more
> > sense, then it's fine by me
>
> Given the name discussion (the other email), I now like one API better.
>
> Actually, since we are on this, can we make it more generic, and handle
> all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
> like:
>
> long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
>
> WDYT Namhyung?

Do you mean reading the whole sample data at once?
Then it needs to parse the sample data format properly
which is non trivial due to a number of variable length
fields like callchains and branch stack, etc.

Also I'm afraid I might need event configuration info
other than sample data like attr.type, attr.config,
attr.sample_type and so on.

Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?

>
> Another idea is to add another parameter, so that we can pick which
> PERF_SAMPLE_* to output via bpf_perf_event_read_sample().
>
> I think this will cover all cases with sample perf_event. Thoughts?

Yeah, I like this more and it looks easier to use.

Thanks,
Namhyung
