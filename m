Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE28B6875DB
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 07:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjBBGZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 01:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBBGZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 01:25:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E99244B0
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 22:25:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso2963148wms.0
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvhT/RpeQOWF0mDCJ7HxpgWrM70bBIVO87o0QE28zuA=;
        b=VaIG5leaDDaYpzb6Ipl56FAORwfyB6MWFkOyZ1ChxC7WXAlp733VtahhjlXrawFNSN
         KVF+WPFRCWOcB5n6FEhrcdrAeXvhQqU5Dz+6gtCe4wCXj9jH9l5PtVLv5LGn5SY9irNK
         lbe3wqB95EI7G0qRzya30KeqcK55Xn+njrspPhEpcNuXPBvadO9t7Ww1uzDJFjIYanAC
         myp1sPxyVDgAJyO4IypCgWxkCzciBq12q5KKJ18prLj1au/rOc6L4bZ9wDTrhObOPOIb
         m2+/04NxGm09KLEXjp8aofn/FaA+BRFfSFwsE1+wKTrLh8FDcADjpjVZOyxHd/CnEX3W
         fy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvhT/RpeQOWF0mDCJ7HxpgWrM70bBIVO87o0QE28zuA=;
        b=MNSHpwHsKIJwKQUEz1+gu5CVumum1vU+O/PqC6Z99rBky3re+koaP+/kPrAqzRvAfe
         IlMXmoX/DxmaRcOBt1wjeBvG5PJLGSzs5ACXzKYfkGFzqU62FirM5OEMnciIQUCp6Z55
         W1ZOU2KtdYrAgKAfXVvctc0CU0ymyHEd/dY/KQc1U8HFJ5MUnpw3YsA99EYUfKmTJEkP
         kVq+zPtc7puaGNqgYJQtH1iWrF1kl1KH72TpsMtRODuBq/njkxztLa7XCU9hzBYJhmkx
         gJF+w2N1MGXnuBnLReK+lQ1eTyz5gQFp6OgLrwvJyUZfiu5oH/xOuTx9CetIDPdX6OoB
         1ZhA==
X-Gm-Message-State: AO0yUKUhuJEZejN3MGAJsoxodwirE2HqLYyLeLPZ/TqrxCngBj04kzOr
        IyZsFVZVPgqfBYjWV9FNzoM=
X-Google-Smtp-Source: AK7set9wssDyEhmjPz18GcWXjgx814OIoMiR8C4PYAxkYabH/w68eoC7Gs8A+C8KUtV0/aPCSBGDIA==
X-Received: by 2002:a05:600c:3492:b0:3da:acb1:2f09 with SMTP id a18-20020a05600c349200b003daacb12f09mr4246235wmq.19.1675319137123;
        Wed, 01 Feb 2023 22:25:37 -0800 (PST)
Received: from jondnuc ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003dc54344764sm4060548wmo.48.2023.02.01.22.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 22:25:36 -0800 (PST)
Date:   Thu, 2 Feb 2023 08:25:35 +0200
From:   Jon Doron <arilou@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, Jon Doron <jond@wiz.io>
Subject: Re: [PATCH bpf-next v1] libbpf: Add wakeup_events to creation options
Message-ID: <Y9tXX5nM78WbvPVY@jondnuc>
References: <20230201090009.114398-1-arilou@gmail.com>
 <Y9rEDDF7qqSs1wSs@krava>
 <CAEf4BzZNH_omrTUUO2M=tx2KD+hGaAAS611i69ih=eN7s2dzJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZNH_omrTUUO2M=tx2KD+hGaAAS611i69ih=eN7s2dzJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023, Andrii Nakryiko wrote:
>On Wed, Feb 1, 2023 at 11:57 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Wed, Feb 01, 2023 at 11:00:09AM +0200, Jon Doron wrote:
>> > From: Jon Doron <jond@wiz.io>
>> >
>> > Add option to set when the perf buffer should wake up, by default the
>> > perf buffer becomes signaled for every event that is being pushed to it.
>> >
>> > In case of a high throughput of events it will be more efficient to wake
>> > up only once you have X events ready to be read.
>> >
>> > So your application can wakeup once and drain the entire perf buffer.
>> >
>> > Signed-off-by: Jon Doron <jond@wiz.io>
>> > ---
>> >  tools/lib/bpf/libbpf.c | 4 ++--
>> >  tools/lib/bpf/libbpf.h | 1 +
>> >  2 files changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> > index eed5cec6f510..6b30ff13922b 100644
>> > --- a/tools/lib/bpf/libbpf.c
>> > +++ b/tools/lib/bpf/libbpf.c
>> > @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>> >       attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>> >       attr.type = PERF_TYPE_SOFTWARE;
>> >       attr.sample_type = PERF_SAMPLE_RAW;
>> > -     attr.sample_period = 1;
>> > -     attr.wakeup_events = 1;
>> > +     attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
>>
>> hm, but I think we still want every event.. setting sample_period to X
>> would store only every X-th bpf-output event, no?
>
>seems like benchs/bench_ringbufs.c sets both sample_period and
>wakeup_events, but it would be nice to make sure we do not lose events
>with such configuration.
>
>Let's add a selftest for this feature.
>

That's how it works, we wont be losing any events

>>
>> jirka
>>
>> > +     attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
>> >
>> >       p.attr = &attr;
>> >       p.sample_cb = sample_cb;
>> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> > index 8777ff21ea1d..2e4bdfc58c82 100644
>> > --- a/tools/lib/bpf/libbpf.h
>> > +++ b/tools/lib/bpf/libbpf.h
>> > @@ -1246,6 +1246,7 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>> >  /* common use perf buffer options */
>> >  struct perf_buffer_opts {
>> >       size_t sz;
>> > +     __u32 wakeup_events;
>> >  };
>> >  #define perf_buffer_opts__last_field sz
>
>you need to update perf_buffer_opts__last_field to wakeup_events as well
>
>

Done

>> >
>> > --
>> > 2.39.1
>> >
