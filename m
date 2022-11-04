Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD8C61909D
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 07:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKDGDR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDGDP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 02:03:15 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F42181;
        Thu,  3 Nov 2022 23:03:13 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso2165549otr.9;
        Thu, 03 Nov 2022 23:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loC6w0/i5CbAGUlQZBIMeNBQ+tlvwl3vVB+h9k8NGcM=;
        b=dP7MW26p0wwpCA83sinsV6MQZLMiNF2uNUVwh0FjPkXSFAiUw2eWbT/uRgadpw9JzX
         DNHc86MkLFov9ctJQP6QqHZdxY2J34uCEU77bbpO8gAYx+H0seXcZKVUXXI/SQPa8kDT
         AHn51j3fel/guFI7Alvi4WY1e8nzbjcjt/j04/i1JDhfFBAlFZ+9f9NMM4EmkiysGxYG
         /sFDninFvJ5OAe14c5TDl2intD91Cnqinv9SQpJ7d3Eh2a8nRKsKDQGvPOeLVk/pVyJC
         5hEUr4CAjpi/wX+ToOZtg+s/d5Rc1IkmdbxDNFl2EnDoWoBIZWrDblHIc6b8FRi0xMa+
         x0cw==
X-Gm-Message-State: ACrzQf2Xj8gN9gmHgcZvNVPkvF1GsUVRwazPyEh+NhAyBlTJFeoHOhyK
        9gjsxD3tcUv83sWFF2zd9+m9N/6c4ZDMKBG4o2zinFVM
X-Google-Smtp-Source: AMsMyM4bn6uSw/2awV0vJqKDAmmzvk4us1xVi7uoHenl1cpbKds5aWEL607Utk0fRuHoJTaLZlYzkwhb7jZWljDpkZw=
X-Received: by 2002:a05:6830:1219:b0:66c:2b26:b164 with SMTP id
 r25-20020a056830121900b0066c2b26b164mr17127010otp.206.1667541792518; Thu, 03
 Nov 2022 23:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-2-namhyung@kernel.org>
 <Y2Du5/Iolphxcbv2@krava>
In-Reply-To: <Y2Du5/Iolphxcbv2@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Nov 2022 23:03:01 -0700
Message-ID: <CAM9d7cheyGK9oK+SdoDxqwLuPLkAO5TrNrwJ4x1F4BrfMVzh+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] perf/core: Prepare sample data before
 calling BPF
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

On Tue, Nov 1, 2022 at 3:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Oct 31, 2022 at 10:23:38PM -0700, Namhyung Kim wrote:
> > To allow bpf overflow handler to access the perf sample data, it needs to
> > prepare missing but requested data before calling the handler.
> >
> > I'm taking a conservative approach to allow a list of sample formats only
> > instead of allowing them all.  For now, IP and ADDR data are allowed and
> > I think it's good enough to build and verify general BPF-based sample
> > filters for perf events.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/events/core.c | 40 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index aefc1e08e015..519f30c33a24 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7329,8 +7329,10 @@ void perf_prepare_sample(struct perf_event_header *header,
> >       filtered_sample_type = sample_type & ~data->sample_flags;
> >       __perf_event_header__init_id(header, data, event, filtered_sample_type);
> >
> > -     if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
> > -             data->ip = perf_instruction_pointer(regs);
> > +     if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> > +             if (filtered_sample_type & PERF_SAMPLE_IP)
> > +                     data->ip = perf_instruction_pointer(regs);
> > +     }
> >
> >       if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> >               int size = 1;
> > @@ -10006,6 +10008,32 @@ static void perf_event_free_filter(struct perf_event *event)
> >  }
> >
> >  #ifdef CONFIG_BPF_SYSCALL
> > +static void bpf_prepare_sample(struct bpf_prog *prog,
> > +                            struct perf_event *event,
> > +                            struct perf_sample_data *data,
> > +                            struct pt_regs *regs)
> > +{
> > +     u64 filtered_sample_type;
> > +
> > +     filtered_sample_type = event->attr.sample_type & ~data->sample_flags;
>
> could we add the same comment in here as is in perf_prepare_sample
>
>         /*
>          * Clear the sample flags that have already been done by the
>          * PMU driver.
>          */
>
> it took me while to recall while we set addr to 0 in here ;-)

Sorry about that! :)  I'll add the comment.

Thanks,
Namhyung


>
> > +
> > +     if (prog->call_get_stack &&
> > +         (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)) {
> > +             data->callchain = perf_callchain(event, regs);
> > +             data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> > +     }
> > +
> > +     if (filtered_sample_type & PERF_SAMPLE_IP) {
> > +             data->ip = perf_instruction_pointer(regs);
> > +             data->sample_flags |= PERF_SAMPLE_IP;
> > +     }
> > +
> > +     if (filtered_sample_type & PERF_SAMPLE_ADDR) {
> > +             data->addr = 0;
> > +             data->sample_flags |= PERF_SAMPLE_ADDR;
> > +     }
> > +}
> > +
> >  static void bpf_overflow_handler(struct perf_event *event,
> >                                struct perf_sample_data *data,
> >                                struct pt_regs *regs)
> > @@ -10023,13 +10051,7 @@ static void bpf_overflow_handler(struct perf_event *event,
> >       rcu_read_lock();
> >       prog = READ_ONCE(event->prog);
> >       if (prog) {
> > -             if (prog->call_get_stack &&
> > -                 (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> > -                 !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
> > -                     data->callchain = perf_callchain(event, regs);
> > -                     data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> > -             }
> > -
> > +             bpf_prepare_sample(prog, event, data, regs);
> >               ret = bpf_prog_run(prog, &ctx);
> >       }
> >       rcu_read_unlock();
> > --
> > 2.38.1.273.g43a17bfeac-goog
> >
