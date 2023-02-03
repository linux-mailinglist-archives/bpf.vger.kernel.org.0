Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA668A4D1
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 22:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBCVle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 16:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCVld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 16:41:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0CC7696
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 13:41:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cw4so6396169edb.13
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 13:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4zJqCf5EZpxoxGUXmcofXotBYTtBSCXbdZZIkkPMT8=;
        b=GAqQ0n5a87Y+8y/um5oTm/VkylMcvdGe7jzP/lP0YnKhSJDA7ueWUsRtD0mDc59I0E
         gnZQPQ5vvmVjNBZ0Zby38UrE02UJ9X91e3Y3TzOuk4tqK2K6FT6M3+33MzqO0W4XHEtN
         8qooWcsQOFtKpx1x/Ztj0D0jVW3lclMfy1EjggPD/BAJzsMHXv391nxIR4Yh9m55uyyt
         HJZVooIQq8DVe9WSwnm31UhxyqQafZoH8wLdKWz5Vb9LhNJpQx7E7frSWTfw0/ulunm/
         7Y2XAqtQgN1h7Zp65/3rkLW2tvBGJY1Vy1bogDQfpmyI5CD2qHM6Jdd5ABOnBYtVzj8+
         XlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4zJqCf5EZpxoxGUXmcofXotBYTtBSCXbdZZIkkPMT8=;
        b=v5dPCU6X1g+THE4IDg5xcFTOsY21iaitdznp2Xne43+H+XwDs4jl4eL3FuYOJMQMru
         e2giF+h0bsRoLYcm1kfhVQGv/rEyecfUPeiQRPb588ZKDx/Ls+fFH4fYERXNz5yFLN38
         Oht9tY46QYevvX43v2W1zJOzFW3G1662f06V3zdmizHWjV1CYOgp1YindsA/kAf4/uQf
         rmjPMqK8tmcNM9o+TQjfxr1SaP9MzgI7ah1AJc/b28S7MpARAJ+DkD9Q36Qt9+xD+AeP
         rM+C/MqWWfeS9YkyBNs+BytVoVY5MUrZqpf/0qvQNFZCUR83SH6Dbpf2PrsignEx/qHl
         Xi4Q==
X-Gm-Message-State: AO0yUKXqj3wq1AS4KFMm8yboLL0m2u1iphNNCwAA6/dNVoPdDLkv1PIn
        FKQkHg7FXikd1BidIWqfks1cAkzGKCJPYXLAMWviu2Le
X-Google-Smtp-Source: AK7set+FZCXzjBsnOar+syGCy2IorfVEdKg2Etgjt6DvU+V5fR3+ZPE099Df7G3KIVHmlFSkN8clMAHqkBrU/p657Rc=
X-Received: by 2002:a50:9986:0:b0:4a0:b58b:7f85 with SMTP id
 m6-20020a509986000000b004a0b58b7f85mr3605209edb.60.1675460490854; Fri, 03 Feb
 2023 13:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20230202062549.632425-1-arilou@gmail.com> <CAEf4BzZE_icgcddkwVQW+0HRtHM=wRaHr3jqmkTJ92O86=6hjA@mail.gmail.com>
 <Y9y0THRh7zrO4fZL@jondnuc>
In-Reply-To: <Y9y0THRh7zrO4fZL@jondnuc>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Feb 2023 13:41:18 -0800
Message-ID: <CAEf4BzbeNr6Ax17VAwUROTbm2cO6t9t-9tck2J3S1p_9QwnD7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
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

On Thu, Feb 2, 2023 at 11:14 PM Jon Doron <arilou@gmail.com> wrote:
>
> On 02/02/2023, Andrii Nakryiko wrote:
> >On Wed, Feb 1, 2023 at 10:26 PM Jon Doron <arilou@gmail.com> wrote:
> >>
> >> From: Jon Doron <jond@wiz.io>
> >>
> >> Add option to set when the perf buffer should wake up, by default the
> >> perf buffer becomes signaled for every event that is being pushed to it.
> >>
> >> In case of a high throughput of events it will be more efficient to wake
> >> up only once you have X events ready to be read.
> >>
> >> So your application can wakeup once and drain the entire perf buffer.
> >>
> >> Signed-off-by: Jon Doron <jond@wiz.io>
> >> ---
> >>  tools/lib/bpf/libbpf.c | 4 ++--
> >>  tools/lib/bpf/libbpf.h | 3 ++-
> >>  2 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index eed5cec6f510..6b30ff13922b 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
> >>         attr.config = PERF_COUNT_SW_BPF_OUTPUT;
> >>         attr.type = PERF_TYPE_SOFTWARE;
> >>         attr.sample_type = PERF_SAMPLE_RAW;
> >> -       attr.sample_period = 1;
> >> -       attr.wakeup_events = 1;
> >> +       attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
> >> +       attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
> >
> >I suspect the case of
> >
> >LIBBPF_OPTS(perf_buffer_opts, opts);
> >
> >perf_buffer__new(...., &opts);
> >
> >is not handled correctly and you end up with sample_period == wakeup_events == 0
> >
> >Can you please add BPF selftests that's setting wakeup_events to zero
> >and separately to >1?
> >
>
> Hi Andrii,
>
> I'm not sure what we are testing, when you have sample_period ==
> wakeup_events == 0, it basically means to never wakeup, so let's say you
> would wait on the poll_fd infinitely it will never wake you up.
>
> When you have let's say wakeup_event != 0, you will wakeup after the
> ring buffer in the perf buffer has more events than wakeup_events.
>
> I do see your point that if someone is using the macro to build the opts
> they will end with something unexpected, would you like me to treat 0 as
> 1 in that case?

Yes, exactly, I think we should treat zero as 1 and write a test that
this happens. Otherwise it will be very confusing when someone use
perf_buffer_opts for some other future option, and then suddenly
starts getting no notification. If someone really needs wakeup == 0,
they have a fallback plan to use perf_buffer__new_raw_opts(), which is
probably justified for some very specific and advanced uses.

So yes, please add a test with few subtests where we test default opts
(wakeup_after == 1), and wakeup_after > 1.

>
> -- Jon.
>
> >>
> >>         p.attr = &attr;
> >>         p.sample_cb = sample_cb;
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index 8777ff21ea1d..e83c0a915dc7 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
> >>  /* common use perf buffer options */
> >>  struct perf_buffer_opts {
> >>         size_t sz;
> >> +       __u32 wakeup_events;
> >>  };
> >> -#define perf_buffer_opts__last_field sz
> >> +#define perf_buffer_opts__last_field wakeup_events
> >>
> >>  /**
> >>   * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
> >> --
> >> 2.39.1
> >>
