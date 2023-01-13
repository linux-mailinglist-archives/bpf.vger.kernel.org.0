Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4966A64D
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjAMW6D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjAMW5o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:57:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760784F82;
        Fri, 13 Jan 2023 14:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7474962263;
        Fri, 13 Jan 2023 22:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8027C433F1;
        Fri, 13 Jan 2023 22:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673650651;
        bh=s/4KHihd3TlUX2HOfaEEQ08QQuS7t1/ev0yRVowTt6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DGjGwvtJaN5G7uhUFsJvOaNGmWV7xGVt1twaufKt9hqaVwISHvOuY1A1YQ8ujSHPP
         is7SOE+vUwAbCEDEp0uVXbFprJkWJ16wYVprF1KOURLesYTyTLvWB42F5DvWw5Ta5g
         0MUKvI8Z/tsa3/o6q7M6sQOzHegNntuteeM6ARpsLdwzGjPSVvXWRkSzGFHdMHgf0a
         I49KTiEr1cj4DlpNokQdMjP5J8Z5he/YAfA4wdFc/3CPVOJfEQY9rZt0UII1LVvNhk
         sfj9jDx0NjtZoDo/MIPEjEXHfF0FA4mQaJ9iS2za1+2yOBeNLgHmilAGtDb6JgjLP9
         +LCBDlFrlAUgQ==
Received: by mail-lj1-f175.google.com with SMTP id n5so23406718ljc.9;
        Fri, 13 Jan 2023 14:57:31 -0800 (PST)
X-Gm-Message-State: AFqh2kpi33jfWLsIAzTgpfXKlFxpuHKSIV4Ia5ZjcBXV+TNg0zXYA9SC
        gOWOfmMc73BcCirUu67pSqMhGCuMghFtJRZ3i0w=
X-Google-Smtp-Source: AMrXdXv8G0sgEozawpW9g+yaFV8GiBq+K4nZTXfp9pJxQp0J32W/yHPnyLvZF/QcX4uoppYlhDNQGY1L+ibkeMUASuY=
X-Received: by 2002:a2e:9382:0:b0:284:b05a:9e82 with SMTP id
 g2-20020a2e9382000000b00284b05a9e82mr1394658ljh.479.1673650649893; Fri, 13
 Jan 2023 14:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-4-namhyung@kernel.org>
 <CAPhsuW71GHAayZmGFfSrpCARiD3YEO1C8QBy1cc1ZEuSFJB=sA@mail.gmail.com> <CAM9d7ciPAocvOvspzfrq2hym-u2+Fbg2A6WJhOQqxwG7CGiuJg@mail.gmail.com>
In-Reply-To: <CAM9d7ciPAocvOvspzfrq2hym-u2+Fbg2A6WJhOQqxwG7CGiuJg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 14:57:17 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5xqgG=6VVGaaStHYRNAO=rB=mL7YALWN89r8Wf+0M5sA@mail.gmail.com>
Message-ID: <CAPhsuW5xqgG=6VVGaaStHYRNAO=rB=mL7YALWN89r8Wf+0M5sA@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf/core: Add perf_sample_save_raw_data() helper
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        x86@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 1:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Song,
>
> On Fri, Jan 13, 2023 at 1:01 PM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > When it saves the raw_data to the perf sample data, it needs to update
> > > the sample flags and the dynamic size.  To make sure this, add the
> > > perf_sample_save_raw_data() helper and convert all call sites.
> > >
> > > Cc: linux-s390@vger.kernel.org
> > > Cc: x86@kernel.org
> > > Cc: bpf@vger.kernel.org
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
>
> [SNIP]
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 0fba98b9cd65..133894ae5e30 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -7588,30 +7588,10 @@ void perf_prepare_sample(struct perf_event_header *header,
> > >         if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
> > >                 perf_sample_save_callchain(data, event, regs);
> > >
> > > -       if (sample_type & PERF_SAMPLE_RAW) {
> > > -               struct perf_raw_record *raw = data->raw;
> > > -               int size;
> > > -
> > > -               if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
> > > -                       struct perf_raw_frag *frag = &raw->frag;
> > > -                       u32 sum = 0;
> > > -
> > > -                       do {
> > > -                               sum += frag->size;
> > > -                               if (perf_raw_frag_last(frag))
> > > -                                       break;
> > > -                               frag = frag->next;
> > > -                       } while (1);
> > > -
> > > -                       size = round_up(sum + sizeof(u32), sizeof(u64));
> > > -                       raw->size = size - sizeof(u32);
> > > -                       frag->pad = raw->size - sum;
> > > -               } else {
> > > -                       size = sizeof(u64);
> > > -                       data->raw = NULL;
> > > -               }
> > > -
> > > -               data->dyn_size += size;
> > > +       if (filtered_sample_type & PERF_SAMPLE_RAW) {
> > > +               data->raw = NULL;
> > > +               data->dyn_size += sizeof(u64);
> > > +               data->sample_flags |= PERF_SAMPLE_RAW;
> > >         }
> >
> > I don't quite follow this change, and the commit log doesn't seem
> > to cover this part.
>
> It's for when the user requested RAW but no actual data.
> It assumes PMU drivers call perf_sample_save_raw_data()
> before perf_prepare_sample() if there's RAW data.
> So we can only handle the 'else' part in the original code.

Got it. Thanks for the explanation.

Song
