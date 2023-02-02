Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DE688A0A
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 23:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBBWvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 17:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBBWvO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 17:51:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4486B9B9
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 14:51:13 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lu11so10505307ejb.3
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhfPQgWkra+ouhQM9sE4tJ0WvFyRYCN09gOz+FO7Yoo=;
        b=W2KWfzjcM1kGu5TaNIdsZZ+XxQIr0z05+NBWMI+3wyWx2EHaMVImzqw4EiT3DGJhtX
         WkJBCZ/MZOgm8XB1ay2ascXSsqUNyorKHYgC+HU2j8s2pOcwRp5N5BS4OwFeoz3UOvWm
         sE/GbHzTipqTNTrT/sKZ1y8DV46S8lSVw/IjYJuKGgpEpwzwzoXJt845DgV4NXRvlQib
         pD5WBBXzI3O3A8FBzkOZeo6L4bcZiEygx7xwDj4g+1dQJEyyZLStgem2/UaVQGcKC7oZ
         iyNzjnIrkccpVS3ZJb+kU84DIVLsYV1d2/2XqW4hPNZ7MvDBhMZ7bkTWIh4KNjBxe+ta
         GIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhfPQgWkra+ouhQM9sE4tJ0WvFyRYCN09gOz+FO7Yoo=;
        b=x6HTXihFyoK2sdeA1o4V+2fFsdAYa1FP9zojTC0iHseMEtev1ngm1TaHj6wCLyrtWh
         NEltc4lshzzzH+/M/sAHG/HWY9MOfljCvjobfeSBwR08/M1ewg9qyqqQBpbMzO3Rw+aA
         2bkbW+LwduwqKXyWzBTsBhfOlKr1ZlXD2Df9O0VJH8vPTh+sg2rkqmOgT+3peuFo7b6x
         8uQOpTbEOr0OsImRkQCjM/9ujpsFgjgoADBa1aJv6NNUBrBdHoREmtU1I5kqFiJoBOrL
         dpTUZFGvoCAskcrB4UCu3GuzUdM+r5tkVDjSnOfwUGnEgHg7qkD2J3DsCjvDS37nbAIh
         xXBQ==
X-Gm-Message-State: AO0yUKUd6MT7D6+X6mf/B5mzPvhb2Bf3UatgBcMKJfwaZH2+3tEN+lq+
        qWuEDYhqtIpDMlK9YCCT2weXp0taeEO5LhRISMxhCsktUfk=
X-Google-Smtp-Source: AK7set8OigSRZ9H6Olr8+qbYJjvgo0M4mikluvgN9slu0JueuV1h0GWDOm9suC9dMCWuRCBEDbVHR0G6e0kdkWO6siM=
X-Received: by 2002:a17:906:2bdb:b0:878:6f08:39ec with SMTP id
 n27-20020a1709062bdb00b008786f0839ecmr2511674ejg.233.1675378271764; Thu, 02
 Feb 2023 14:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20230202062549.632425-1-arilou@gmail.com>
In-Reply-To: <20230202062549.632425-1-arilou@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Feb 2023 14:50:59 -0800
Message-ID: <CAEf4BzZE_icgcddkwVQW+0HRtHM=wRaHr3jqmkTJ92O86=6hjA@mail.gmail.com>
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

On Wed, Feb 1, 2023 at 10:26 PM Jon Doron <arilou@gmail.com> wrote:
>
> From: Jon Doron <jond@wiz.io>
>
> Add option to set when the perf buffer should wake up, by default the
> perf buffer becomes signaled for every event that is being pushed to it.
>
> In case of a high throughput of events it will be more efficient to wake
> up only once you have X events ready to be read.
>
> So your application can wakeup once and drain the entire perf buffer.
>
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  tools/lib/bpf/libbpf.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..6b30ff13922b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>         attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>         attr.type = PERF_TYPE_SOFTWARE;
>         attr.sample_type = PERF_SAMPLE_RAW;
> -       attr.sample_period = 1;
> -       attr.wakeup_events = 1;
> +       attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
> +       attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);

I suspect the case of

LIBBPF_OPTS(perf_buffer_opts, opts);

perf_buffer__new(...., &opts);

is not handled correctly and you end up with sample_period == wakeup_events == 0

Can you please add BPF selftests that's setting wakeup_events to zero
and separately to >1?

>
>         p.attr = &attr;
>         p.sample_cb = sample_cb;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8777ff21ea1d..e83c0a915dc7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>  /* common use perf buffer options */
>  struct perf_buffer_opts {
>         size_t sz;
> +       __u32 wakeup_events;
>  };
> -#define perf_buffer_opts__last_field sz
> +#define perf_buffer_opts__last_field wakeup_events
>
>  /**
>   * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
> --
> 2.39.1
>
