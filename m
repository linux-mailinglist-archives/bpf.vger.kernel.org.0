Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E173664CFF
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 21:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjAJUGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 15:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjAJUGN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 15:06:13 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1C11800;
        Tue, 10 Jan 2023 12:06:12 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id d10so6944179ilc.12;
        Tue, 10 Jan 2023 12:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyKV/IytE5L3JlZxm80nPUoeIMqTlPyGJhm6uaeKye4=;
        b=SO6Y3r2pEYh4JUq90D9MdojmOGskMAkXevbyi/rZei4anwaRTsdefooRlL1WkM5TR+
         yH3zM3LTVzwXX8voBNr8NcNjfLpFV1OnBsoph1HZECxAomFdYpScDcak9SWlGdLjEb7H
         LWXFvTdxMv5dd2OJkKOQIuK2tmkUTpMuFokUoIKCcnkbfOqInzvSn/dXVoOcGz9QvMHH
         MaM/kkwBGUnNqNrx3sLTsTepjSFJO04ncR/cBtFFI6/m3ZNoVi+5uDA0bjmhB4/4Dk69
         LGULGi2g3PFzSQt/fQp8mJuKQUqs0rDVgKmf1qs9P8oFOxCNVPlee4f5BoELccTv9SDD
         u/DA==
X-Gm-Message-State: AFqh2kpIhGvVH0GSpsSHqmVbe45UvIjEWwYZmDUiRysZ+2epOhIuyYU0
        hCVLuYqrcvoEvx4xBiCQ06POll/XATYzeL+F7kE=
X-Google-Smtp-Source: AMrXdXt/+/adN2gKCvNbXg4gfavl2nxb2JhYEEKLba753rvVOiBRlbf09CD51deqIAzFQcnlp35Rfu98VmNH5ckGtDI=
X-Received: by 2002:a92:d605:0:b0:304:b8db:82d8 with SMTP id
 w5-20020a92d605000000b00304b8db82d8mr4832855ilm.25.1673381172207; Tue, 10 Jan
 2023 12:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20221229204101.1099430-1-namhyung@kernel.org> <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net> <Y7x3RUd67smv3EFQ@google.com>
In-Reply-To: <Y7x3RUd67smv3EFQ@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Jan 2023 12:06:00 -0800
Message-ID: <CAM9d7ciVZCHk0YqpobfR+t0FPN_-tpnLgNbN981=EygkM_riDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in perf_prepare_sample()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 9, 2023 at 12:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Peter,
>
> On Mon, Jan 09, 2023 at 01:14:31PM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 29, 2022 at 12:41:00PM -0800, Namhyung Kim wrote:
> >
> > So I like the general idea; I just think it's turned into a bit of a
> > mess. That is code is already overly branchy which is known to hurt
> > performance, we should really try and not make it worse than absolutely
> > needed.
>
> Agreed.
>
> >
> > >  kernel/events/core.c | 86 ++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 63 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index eacc3702654d..70bff8a04583 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -7582,14 +7582,21 @@ void perf_prepare_sample(struct perf_event_header *header,
> > >     filtered_sample_type = sample_type & ~data->sample_flags;
> > >     __perf_event_header__init_id(header, data, event, filtered_sample_type);
> > >
> > > -   if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
> > > -           data->ip = perf_instruction_pointer(regs);
> > > +   if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> > > +           /* attr.sample_type may not have PERF_SAMPLE_IP */
> >
> > Right, but that shouldn't matter, IIRC its OK to have more bits set in
> > data->sample_flags than we have set in attr.sample_type. It just means
> > we have data available for sample types we're (possibly) not using.
> >
> > That is, I think you can simply write this like:
> >
> > > +           if (!(data->sample_flags & PERF_SAMPLE_IP)) {
> > > +                   data->ip = perf_instruction_pointer(regs);
> > > +                   data->sample_flags |= PERF_SAMPLE_IP;
> > > +           }
> > > +   }
> >
> >       if (filtered_sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> >               data->ip = perf_instruction_pointer(regs);
> >               data->sample_flags |= PERF_SAMPLE_IP);
> >       }
> >
> >       ...
> >
> >       if (filtered_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
> >               data->code_page_size = perf_get_page_size(data->ip);
> >               data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
> >       }
> >
> > Then after a single perf_prepare_sample() run we have:
> >
> >   pre                 |       post
> >   ----------------------------------------
> >   0                   |       0
> >   IP                  |       IP
> >   CODE_PAGE_SIZE      |       IP|CODE_PAGE_SIZE
> >   IP|CODE_PAGE_SIZE   |       IP|CODE_PAGE_SIZE
> >
> > So while data->sample_flags will have an extra bit set in the 3rd case,
> > that will not affect perf_sample_outout() which only looks at data->type
> > (== attr.sample_type).
> >
> > And since data->sample_flags will have both bits set, a second run will
> > filter out both and avoid the extra work (except doing that will mess up
> > the branch predictors).
>
> Yeah, it'd be better to check filtered_sample_type in the first place.
>
> Btw, I was thinking about a hypothetical scenario that IP set by a PMU
> driver not from the regs.  In this case, having CODE_PAGE_SIZE will
> overwrite the IP.  I don't think we need to worry about that for now
> since PMU drivers updates the regs (using set_linear_ip).  But it seems
> like a possible scenario for something like PEBS or IBS.

Another example, but in this case it's real, is ADDR.  We cannot update
the data->addr just because filtered_sample_type has PHYS_ADDR or
DATA_PAGE_SIZE as it'd lose the original value.

Other than that, I'll update the other paths to minimized the branches.

Thanks,
Namhyung
