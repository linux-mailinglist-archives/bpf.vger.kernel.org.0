Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817B66A4B4
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 22:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjAMVB5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 16:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjAMVBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 16:01:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50B44164C;
        Fri, 13 Jan 2023 13:01:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B2261F6D;
        Fri, 13 Jan 2023 21:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17D4C433EF;
        Fri, 13 Jan 2023 21:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673643698;
        bh=XjYPLJaT3KR8UfCRsn7ZqO0p/NzuDlzpBsbT6/lbX50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JnRpLeX/zzbpJeZ0g4/Wp3eorkFYBP9ywXWK+IwEfz30TDHCLsIHR8rWBxA+tmrpR
         UCIqdDgfsj/1G8pwJyODygp8GuljXX7YBO87TbOn4u8cFJ8DLowG1Bo+5Oy+gV6e4K
         y2sx7456RlcuQ8Kh+28mRe17FPEETDR7IV9TWvkPMsW1WTo29bLX+aLNvitTITNURD
         nj7fQRauwuTvQ/WMgYAO0r931eZnUeS5tTxeiUmkZQqML30eLGnJbccYEjSp2NkeIm
         pGMWZTzKeAWKkvi6zazrJ125GyLclZTI8AxKLyvS6ZbREBJBVYSWs6LKU09akkjvPe
         ZvFe6ubaGXImQ==
Received: by mail-lf1-f47.google.com with SMTP id j17so34801196lfr.3;
        Fri, 13 Jan 2023 13:01:38 -0800 (PST)
X-Gm-Message-State: AFqh2kqA7jNGYGn30lcGwbBUTLkxzBrTXtmEvvBTbUUXYo098qGthlCh
        /kwFOt1skR5LyQgEWkuitGgBTyJMICUj8FySMFI=
X-Google-Smtp-Source: AMrXdXu0AQ1CejJDQB1Ha12dgDJkYFpVpZVgZaVKqEX9YHnSxYx/LwcDB18gh51pVND3DS6eYIkawuC090NzqnufMz8=
X-Received: by 2002:a05:6512:2987:b0:4b5:8f03:a2b6 with SMTP id
 du7-20020a056512298700b004b58f03a2b6mr8848083lfb.643.1673643696772; Fri, 13
 Jan 2023 13:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-4-namhyung@kernel.org>
In-Reply-To: <20230112214015.1014857-4-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 13:01:24 -0800
X-Gmail-Original-Message-ID: <CAPhsuW71GHAayZmGFfSrpCARiD3YEO1C8QBy1cc1ZEuSFJB=sA@mail.gmail.com>
Message-ID: <CAPhsuW71GHAayZmGFfSrpCARiD3YEO1C8QBy1cc1ZEuSFJB=sA@mail.gmail.com>
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

On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it saves the raw_data to the perf sample data, it needs to update
> the sample flags and the dynamic size.  To make sure this, add the
> perf_sample_save_raw_data() helper and convert all call sites.
>
> Cc: linux-s390@vger.kernel.org
> Cc: x86@kernel.org
> Cc: bpf@vger.kernel.org
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/s390/kernel/perf_cpum_cf.c    |  4 +---
>  arch/s390/kernel/perf_pai_crypto.c |  4 +---
>  arch/s390/kernel/perf_pai_ext.c    |  4 +---
>  arch/x86/events/amd/ibs.c          |  3 +--
>  include/linux/perf_event.h         | 33 +++++++++++++++++++++++++-----
>  kernel/events/core.c               | 31 +++++-----------------------
>  kernel/trace/bpf_trace.c           |  6 ++----
>  7 files changed, 39 insertions(+), 46 deletions(-)
>
> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> index f043a7ff220b..aa38649c7c27 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -662,9 +662,7 @@ static int cfdiag_push_sample(struct perf_event *event,
>         if (event->attr.sample_type & PERF_SAMPLE_RAW) {
>                 raw.frag.size = cpuhw->usedss;
>                 raw.frag.data = cpuhw->stop;
> -               raw.size = raw.frag.size;
> -               data.raw = &raw;
> -               data.sample_flags |= PERF_SAMPLE_RAW;
> +               perf_sample_save_raw_data(&data, &raw);
>         }
>
>         overflow = perf_event_overflow(event, &data, &regs);
> diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
> index 985e243a2ed8..a7b339c4fd7c 100644
> --- a/arch/s390/kernel/perf_pai_crypto.c
> +++ b/arch/s390/kernel/perf_pai_crypto.c
> @@ -362,9 +362,7 @@ static int paicrypt_push_sample(void)
>         if (event->attr.sample_type & PERF_SAMPLE_RAW) {
>                 raw.frag.size = rawsize;
>                 raw.frag.data = cpump->save;
> -               raw.size = raw.frag.size;
> -               data.raw = &raw;
> -               data.sample_flags |= PERF_SAMPLE_RAW;
> +               perf_sample_save_raw_data(&data, &raw);
>         }
>
>         overflow = perf_event_overflow(event, &data, &regs);
> diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
> index 1138f57baae3..555597222bad 100644
> --- a/arch/s390/kernel/perf_pai_ext.c
> +++ b/arch/s390/kernel/perf_pai_ext.c
> @@ -451,9 +451,7 @@ static int paiext_push_sample(void)
>         if (event->attr.sample_type & PERF_SAMPLE_RAW) {
>                 raw.frag.size = rawsize;
>                 raw.frag.data = cpump->save;
> -               raw.size = raw.frag.size;
> -               data.raw = &raw;
> -               data.sample_flags |= PERF_SAMPLE_RAW;
> +               perf_sample_save_raw_data(&data, &raw);
>         }
>
>         overflow = perf_event_overflow(event, &data, &regs);
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 417c80bd3274..64582954b5f6 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1110,8 +1110,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>                                 .data = ibs_data.data,
>                         },
>                 };
> -               data.raw = &raw;
> -               data.sample_flags |= PERF_SAMPLE_RAW;
> +               perf_sample_save_raw_data(&data, &raw);
>         }
>
>         if (perf_ibs == &perf_ibs_op)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a9419608402b..569dfac5887f 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -95,6 +95,11 @@ struct perf_raw_record {
>         u32                             size;
>  };
>
> +static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
> +{
> +       return frag->pad < sizeof(u64);
> +}
> +
>  /*
>   * branch stack layout:
>   *  nr: number of taken branches stored in entries[]
> @@ -1182,6 +1187,29 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
>         data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
>  }
>
> +static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
> +                                            struct perf_raw_record *raw)
> +{
> +       struct perf_raw_frag *frag = &raw->frag;
> +       u32 sum = 0;
> +       int size;
> +
> +       do {
> +               sum += frag->size;
> +               if (perf_raw_frag_last(frag))
> +                       break;
> +               frag = frag->next;
> +       } while (1);
> +
> +       size = round_up(sum + sizeof(u32), sizeof(u64));
> +       raw->size = size - sizeof(u32);
> +       frag->pad = raw->size - sum;
> +
> +       data->raw = raw;
> +       data->dyn_size += size;
> +       data->sample_flags |= PERF_SAMPLE_RAW;
> +}
> +
>  /*
>   * Clear all bitfields in the perf_branch_entry.
>   * The to and from fields are not cleared because they are
> @@ -1690,11 +1718,6 @@ extern void perf_restore_debug_store(void);
>  static inline void perf_restore_debug_store(void)                      { }
>  #endif
>
> -static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
> -{
> -       return frag->pad < sizeof(u64);
> -}
> -
>  #define perf_output_put(handle, x) perf_output_copy((handle), &(x), sizeof(x))
>
>  struct perf_pmu_events_attr {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0fba98b9cd65..133894ae5e30 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7588,30 +7588,10 @@ void perf_prepare_sample(struct perf_event_header *header,
>         if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
>                 perf_sample_save_callchain(data, event, regs);
>
> -       if (sample_type & PERF_SAMPLE_RAW) {
> -               struct perf_raw_record *raw = data->raw;
> -               int size;
> -
> -               if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
> -                       struct perf_raw_frag *frag = &raw->frag;
> -                       u32 sum = 0;
> -
> -                       do {
> -                               sum += frag->size;
> -                               if (perf_raw_frag_last(frag))
> -                                       break;
> -                               frag = frag->next;
> -                       } while (1);
> -
> -                       size = round_up(sum + sizeof(u32), sizeof(u64));
> -                       raw->size = size - sizeof(u32);
> -                       frag->pad = raw->size - sum;
> -               } else {
> -                       size = sizeof(u64);
> -                       data->raw = NULL;
> -               }
> -
> -               data->dyn_size += size;
> +       if (filtered_sample_type & PERF_SAMPLE_RAW) {
> +               data->raw = NULL;
> +               data->dyn_size += sizeof(u64);
> +               data->sample_flags |= PERF_SAMPLE_RAW;
>         }

I don't quite follow this change, and the commit log doesn't seem
to cover this part.

>
>         if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> @@ -10127,8 +10107,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>         };
>
>         perf_sample_data_init(&data, 0, 0);
> -       data.raw = &raw;
> -       data.sample_flags |= PERF_SAMPLE_RAW;
> +       perf_sample_save_raw_data(&data, &raw);
>
>         perf_trace_buf_update(record, event_type);
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..ad37608afc35 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -687,8 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
>         }
>
>         perf_sample_data_init(sd, 0, 0);
> -       sd->raw = &raw;
> -       sd->sample_flags |= PERF_SAMPLE_RAW;
> +       perf_sample_save_raw_data(sd, &raw);
>
>         err = __bpf_perf_event_output(regs, map, flags, sd);
>
> @@ -746,8 +745,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>
>         perf_fetch_caller_regs(regs);
>         perf_sample_data_init(sd, 0, 0);
> -       sd->raw = &raw;
> -       sd->sample_flags |= PERF_SAMPLE_RAW;
> +       perf_sample_save_raw_data(sd, &raw);
>
>         ret = __bpf_perf_event_output(regs, map, flags, sd);
>  out:
> --
> 2.39.0.314.g84b9a713c41-goog
>
