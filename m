Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4891466A581
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjAMV4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 16:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAMV4t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 16:56:49 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21798892CD;
        Fri, 13 Jan 2023 13:56:49 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id q141so8201821vkb.13;
        Fri, 13 Jan 2023 13:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cn5WaIR2kYHfvSAn6aGjThopDJINdcdLaEEO7lYUz7s=;
        b=jt3l9jzeq4haX5c4B8Vtb7v7kpt2w3BctPHaRmBcSCqTdwF2h7ZilY696eylJx0Rr8
         o3SOOgmAjWnGtJij2Q9aEmERh656Liz2UYVxM0hHkSVoRm/VYnOEW5A2JpMRc7ajkEuc
         YIlFevLxxUnEUr3hnygom6EziZUX16lDj687SlSdrJnmF9oE6FSqrqVyZFw167N2kWtu
         KMc+wluMwt3aDeY/wmmIiluO7nK+Vf54T1MQ35qjsWOU/zVlrFaPkvRmqvghmOgDPbVy
         HdewqsS+u9zIOHgqxVw41FOO8zkPDB+fMDE+oukXJA4UrvO0J3RiIhEEka2Nd08ZNls0
         SrSw==
X-Gm-Message-State: AFqh2kqfewquwT0J+AtyW+WXNpcii1DOwoqitYFxMj0UH4UsK+Dref0d
        PJR6vlZIbcW3qmpUVfZ/+lALfrxvNiC21MWFmoF+pDwg
X-Google-Smtp-Source: AMrXdXsyz01JvYnrA7ongeX2V/NY8FwJtxhNN6Gq7WoTmKfST4Yz2gOETp14D6rsA56A9zPBSZXYdfUuKmK5T9r+8Z4=
X-Received: by 2002:a05:6122:d9e:b0:3d5:3ee8:6603 with SMTP id
 bc30-20020a0561220d9e00b003d53ee86603mr9014889vkb.7.1673647008141; Fri, 13
 Jan 2023 13:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-4-namhyung@kernel.org>
 <CAPhsuW71GHAayZmGFfSrpCARiD3YEO1C8QBy1cc1ZEuSFJB=sA@mail.gmail.com>
In-Reply-To: <CAPhsuW71GHAayZmGFfSrpCARiD3YEO1C8QBy1cc1ZEuSFJB=sA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 13 Jan 2023 13:56:36 -0800
Message-ID: <CAM9d7ciPAocvOvspzfrq2hym-u2+Fbg2A6WJhOQqxwG7CGiuJg@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf/core: Add perf_sample_save_raw_data() helper
To:     Song Liu <song@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        x86@kernel.org, bpf@vger.kernel.org
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

Hi Song,

On Fri, Jan 13, 2023 at 1:01 PM Song Liu <song@kernel.org> wrote:
>
> On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When it saves the raw_data to the perf sample data, it needs to update
> > the sample flags and the dynamic size.  To make sure this, add the
> > perf_sample_save_raw_data() helper and convert all call sites.
> >
> > Cc: linux-s390@vger.kernel.org
> > Cc: x86@kernel.org
> > Cc: bpf@vger.kernel.org
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---

[SNIP]
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 0fba98b9cd65..133894ae5e30 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7588,30 +7588,10 @@ void perf_prepare_sample(struct perf_event_header *header,
> >         if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
> >                 perf_sample_save_callchain(data, event, regs);
> >
> > -       if (sample_type & PERF_SAMPLE_RAW) {
> > -               struct perf_raw_record *raw = data->raw;
> > -               int size;
> > -
> > -               if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
> > -                       struct perf_raw_frag *frag = &raw->frag;
> > -                       u32 sum = 0;
> > -
> > -                       do {
> > -                               sum += frag->size;
> > -                               if (perf_raw_frag_last(frag))
> > -                                       break;
> > -                               frag = frag->next;
> > -                       } while (1);
> > -
> > -                       size = round_up(sum + sizeof(u32), sizeof(u64));
> > -                       raw->size = size - sizeof(u32);
> > -                       frag->pad = raw->size - sum;
> > -               } else {
> > -                       size = sizeof(u64);
> > -                       data->raw = NULL;
> > -               }
> > -
> > -               data->dyn_size += size;
> > +       if (filtered_sample_type & PERF_SAMPLE_RAW) {
> > +               data->raw = NULL;
> > +               data->dyn_size += sizeof(u64);
> > +               data->sample_flags |= PERF_SAMPLE_RAW;
> >         }
>
> I don't quite follow this change, and the commit log doesn't seem
> to cover this part.

It's for when the user requested RAW but no actual data.
It assumes PMU drivers call perf_sample_save_raw_data()
before perf_prepare_sample() if there's RAW data.
So we can only handle the 'else' part in the original code.

Thanks,
Namhyung
