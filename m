Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD865A2FCC
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiHZTWB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiHZTWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:22:00 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB482BD1C4;
        Fri, 26 Aug 2022 12:21:59 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11c5505dba2so3227540fac.13;
        Fri, 26 Aug 2022 12:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9Mtsf8bHADcXsmpT2IJ7HPB/pQKds1pL0AHVcqCIStc=;
        b=cmENxV6t64cmV6cBRxnLLTtChQqCKRodwQtDzqMwtZaEMlD8RjdgCLGS85CQ4MvqXa
         HpAHyZJPS/9WkAYlGHkce9f2B44I9edJ7EZfuxYZW63+GXZ8ZYG2bInHrzmOpMc4LJdm
         PZW7OTGJyTA349itbBnsM/NemiZ333Q7dBWoZGVOQkGKRxTndxWVV7RXJJcXo0fqQdyS
         tR5dwp/po4McmFReOCeQaSLq7kFnTaXOtP1bdOHh+D+xBExNXfCjPOBfaE9wmOe9ktTB
         rq/Ueq+7rTt+3rlryKqkv8nJLeX8x1kqgwBl5FN0U25EQEHTUwWXF/Cern7b39ZjSm3I
         EwUA==
X-Gm-Message-State: ACgBeo0yc5TNr+bte9Ly44xtv2Hm8x/zTqaicfmIgizjDX0ZNg5RqvAb
        mz8er7T7jrA/jefH6ruUPiRZVLhJZWfGKx1KQdk=
X-Google-Smtp-Source: AA6agR5eGUgPyBFPVu1HsfP6uCAZyM/tmCP9iIXGJCjvvi1qRj/HQmlcresZmNs8IlzuKwQKJPFhZ21gAD7nMQwNIuQ=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr2610720oaf.5.1661541719270; Fri, 26 Aug
 2022 12:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com> <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com> <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
In-Reply-To: <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 12:21:48 -0700
Message-ID: <CAM9d7cgUVg1Cv+0fs=Mc7OBTOHNJkMqWnm0SZ5R7xfm5peBNDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 11:09 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 26, 2022, at 9:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Aug 25, 2022 at 10:53 PM Song Liu <song@kernel.org> wrote:
> >>
> >> On Thu, Aug 25, 2022 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
> >>>> Actually, since we are on this, can we make it more generic, and handle
> >>>> all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
> >>>> like:
> >>>>
> >>>> long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
> >>>>
> >>>> WDYT Namhyung?
> >>>
> >>> Do you mean reading the whole sample data at once?
> >>> Then it needs to parse the sample data format properly
> >>> which is non trivial due to a number of variable length
> >>> fields like callchains and branch stack, etc.
> >>>
> >>> Also I'm afraid I might need event configuration info
> >>> other than sample data like attr.type, attr.config,
> >>> attr.sample_type and so on.
> >>>
> >>> Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?
> >>
> >> The user should have access to the perf_event_attr used to
> >> create the event. This is also available in ctx->event->attr.
> >
> > Do you mean from BPF?  I'd like to have a generic BPF program
> > that can handle various filtering according to the command line
> > arguments.  I'm not sure but it might do something differently
> > for each event based on the attr settings.
>
> Yeah, we can access perf_event_attr from BPF program. Note that
> the ctx for perf_event bpf program is struct bpf_perf_event_data_kern:
>
> SEC("perf_event")
> int perf_e(struct bpf_perf_event_data_kern *ctx)
> {
>         ...
> }
>
> struct bpf_perf_event_data_kern {
>         bpf_user_pt_regs_t *regs;
>         struct perf_sample_data *data;
>         struct perf_event *event;
> };

I didn't know that it's allowed to access the kernel data directly.
For some reason, I thought it should use fields in bpf_event_event_data
only, like sample_period and addr.  And the verifier will convert the
access to them according to pe_prog_convert_ctx_access().

>
> Alternatively, we can also have bpf user space configure the BPF
> program via a few knobs.
>
> And actually, we can just read ctx->data and get the raw record,
> right..?

If it's possible, sure, it'd be more powerful.

Thanks,
Namhyung
