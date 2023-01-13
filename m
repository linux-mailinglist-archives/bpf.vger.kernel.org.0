Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0B66A4C2
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAMVHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 16:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAMVHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 16:07:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54412714B8;
        Fri, 13 Jan 2023 13:06:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04724B821FF;
        Fri, 13 Jan 2023 21:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A34AC433EF;
        Fri, 13 Jan 2023 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673644016;
        bh=a30n7ZWlIpTS3wZoDepJYx4lu30b9sERqyh3K9EcK+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eScDXkaN8fgrOhSjiQQilqRGPKsW+p4ZtZoTxv6+09v98NSYjqzfX+gIZKHosRl0Y
         /BJhZKltX8zolnklFmYkcuUCTqaDZfqU4wjawYsWTrjJLlzB1YOsLPaY6qezR502X1
         rUtqsrKl/AeYQ/GdpE24792ERlsq3175ura5rdWdlWejuhZxrP1e3rTP+Tg7JWL44z
         z/PkhT6ac5r1HjTBE1hnL53+oFeSySXogM1NxUQiYV7/tCwtgcJAKxzp/i22oraIh4
         DlpsjH+Qrq15ndza/1JpS5sTH3rHGaTUfR7OyNOdr8Jqt47BylS93NWx/OD6s+mW5k
         qIGPX+32VcDGg==
Received: by mail-lj1-f180.google.com with SMTP id g14so23673581ljh.10;
        Fri, 13 Jan 2023 13:06:56 -0800 (PST)
X-Gm-Message-State: AFqh2krKi20ptXI4l46K70X0qscSW4FZp2l+43jIDnkLXwBI8CSnRN2J
        qQ3KBQtSh6oxnIBHqdYW/wusrcOVMjymbitni5M=
X-Google-Smtp-Source: AMrXdXuIlwtj6aR8GxQuD0A3dAfBI60Y4NDSvA21cklDjx8YsJA1979CVc5nVYcWFCLPdtcCM4GNXh6DgrtG2OTCUgc=
X-Received: by 2002:a05:651c:11d0:b0:289:1305:680d with SMTP id
 z16-20020a05651c11d000b002891305680dmr484731ljo.421.1673644014573; Fri, 13
 Jan 2023 13:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-9-namhyung@kernel.org>
In-Reply-To: <20230112214015.1014857-9-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 13:06:42 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5LFGzVA5RV-x1gWxcvG7O5yUie8C+Z-+aNnzEncgZqiA@mail.gmail.com>
Message-ID: <CAPhsuW5LFGzVA5RV-x1gWxcvG7O5yUie8C+Z-+aNnzEncgZqiA@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf/core: Call perf_prepare_sample() before running BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> As BPF can access sample data, it needs to populate the data.  Also
> remove the logic to get the callchain specifically as it's covered by
> the perf_prepare_sample() now.
>
> Cc: Song Liu <song@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/events/core.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5c4f3fa3d2b7..af8365fb639a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10363,13 +10363,7 @@ static void bpf_overflow_handler(struct perf_event *event,
>         rcu_read_lock();
>         prog = READ_ONCE(event->prog);
>         if (prog) {
> -               if (prog->call_get_stack &&
> -                   (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> -                   !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
> -                       data->callchain = perf_callchain(event, regs);
> -                       data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> -               }
> -
> +               perf_prepare_sample(data, event, regs);
>                 ret = bpf_prog_run(prog, &ctx);
>         }
>         rcu_read_unlock();
> --
> 2.39.0.314.g84b9a713c41-goog
>
