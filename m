Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE916969EB
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 17:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjBNQl3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 11:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBNQl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 11:41:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D12B2A1
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 08:41:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r18so11373271wmq.5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVEVZPx0K3ZOcm8VgbJ77zWaJWVs4WHPzqQwX9jExfU=;
        b=FYBQbwR3oOM1QbI57RCqMbveqZ8gYey9bS5JB17GDW5lSZn+K+WPL2yfzSyxyzzWPG
         kMY2xEYvNsFc6t0i93QQEKaAQk5eBu8K4AvVfv34PNTF/zNo6GGzUOuS1zjohLmRGM6j
         AarqS97tRd3NwufRRVLLekhI7bwdedlHLTDpPWBLm2YFSnk3+S9yRi9ty4AGW1MZSrGY
         fKFPVOPREUh5TTG7Vy4rIbbytTXaZsrbqbxDieSfhGk+ooTQlNffwldJdVhwFdqePewt
         OEW/mSvVFXI2eCR4/7ukgwtyZGLlhXQ4iU4FHMxdiX3gTHFgeQ7C/GNSq6zuTyGBC4vg
         svVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVEVZPx0K3ZOcm8VgbJ77zWaJWVs4WHPzqQwX9jExfU=;
        b=rF4roqpKy+fx4EZZMhEZjJroPN2dSwuJiH2icSaahpyBOTQ0AEGofKYInsqKCyOQf3
         nZMJmfiGKYrJ+Qt7AlOohGWGJUYiUP1RYU6pIsSHcwMZjz+51E19V9KoceYTjHsME1Hp
         HLjfh4FvsYwZ7Qx4leWnVWexMA6kWHCGuimJCrL9wg3w4zWKVkDyEQ7vWG6pyww0Xae1
         xcAu2YMUxXOZC0mH+ApdFXmX5UGSzGxIywpsgu9o7R9Am4tTHdisIVa3cuLc0BtEolDP
         yQl2ER+4or9zuuoPTqHNKtUGel1ljcw7iWTMgvXWwrTw/D68LpKkucSXXQtjli1uorwn
         mbTw==
X-Gm-Message-State: AO0yUKWuJnl7uoq1E5w3W3dUMkr7D4qev3W4GOEbRRRFrqdRr9CzfKrp
        2MhYM55vLC/Ab26aBtV7icBu789avY34dzlul8PXOQ==
X-Google-Smtp-Source: AK7set+m/D6oq+FxwDf17S592BJEibi99RpP2MpAg9c+81twvi+rqernjlbr+zMOrHh2ZFANu4b7C4yovxkXcM7AwfA=
X-Received: by 2002:a7b:cdf0:0:b0:3db:1d5e:699 with SMTP id
 p16-20020a7bcdf0000000b003db1d5e0699mr11361wmj.195.1676392860546; Tue, 14 Feb
 2023 08:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20230214050452.26390-1-namhyung@kernel.org> <20230214050452.26390-5-namhyung@kernel.org>
In-Reply-To: <20230214050452.26390-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Feb 2023 08:40:48 -0800
Message-ID: <CAP-5=fWV+VCheBocBpXg-jRHr+vkNnKWbH4Rjma9imQRJpis+w@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf record: Record dropped sample count
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it uses bpf filters, event might drop some samples.  It'd be nice
> if it can report how many samples it lost.  As LOST_SAMPLES event can
> carry the similar information, let's use it for bpf filters.
>
> To indicate it's from BPF filters, add a new misc flag for that and
> do not display cpu load warnings.

Can you potentially have lost samples from being too slow to drain the
ring buffer and dropped samples because of BPF? Is it possible to
distinguish lost and dropped with this approach?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c  | 37 ++++++++++++++++++++++--------------
>  tools/perf/util/bpf-filter.c |  7 +++++++
>  tools/perf/util/bpf-filter.h |  5 +++++
>  tools/perf/util/session.c    |  3 ++-
>  4 files changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index c81047a78f3e..3201d1a1ea1f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1869,24 +1869,16 @@ record__switch_output(struct record *rec, bool at_exit)
>         return fd;
>  }
>
> -static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
> +static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>                                         struct perf_record_lost_samples *lost,
> -                                       int cpu_idx, int thread_idx)
> +                                       int cpu_idx, int thread_idx, u64 lost_count,
> +                                       u16 misc_flag)
>  {
> -       struct perf_counts_values count;
>         struct perf_sample_id *sid;
>         struct perf_sample sample = {};
>         int id_hdr_size;
>
> -       if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
> -               pr_err("read LOST count failed\n");
> -               return;
> -       }
> -
> -       if (count.lost == 0)
> -               return;
> -
> -       lost->lost = count.lost;
> +       lost->lost = lost_count;
>         if (evsel->core.ids) {
>                 sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
>                 sample.id = sid->id;
> @@ -1895,6 +1887,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
>         id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
>                                                        evsel->core.attr.sample_type, &sample);
>         lost->header.size = sizeof(*lost) + id_hdr_size;
> +       lost->header.misc = misc_flag;
>         record__write(rec, NULL, lost, lost->header.size);
>  }
>
> @@ -1918,6 +1911,7 @@ static void record__read_lost_samples(struct record *rec)
>
>         evlist__for_each_entry(session->evlist, evsel) {
>                 struct xyarray *xy = evsel->core.sample_id;
> +               u64 lost_count;
>
>                 if (xy == NULL || evsel->core.fd == NULL)
>                         continue;
> @@ -1929,12 +1923,27 @@ static void record__read_lost_samples(struct record *rec)
>
>                 for (int x = 0; x < xyarray__max_x(xy); x++) {
>                         for (int y = 0; y < xyarray__max_y(xy); y++) {
> -                               __record__read_lost_samples(rec, evsel, lost, x, y);
> +                               struct perf_counts_values count;
> +
> +                               if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
> +                                       pr_err("read LOST count failed\n");
> +                                       goto out;
> +                               }
> +
> +                               if (count.lost) {
> +                                       __record__save_lost_samples(rec, evsel, lost,
> +                                                                   x, y, count.lost, 0);
> +                               }
>                         }
>                 }
> +
> +               lost_count = perf_bpf_filter__lost_count(evsel);
> +               if (lost_count)
> +                       __record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> +                                                   PERF_RECORD_MISC_LOST_SAMPLES_BPF);
>         }
> +out:
>         free(lost);
> -
>  }
>
>  static volatile sig_atomic_t workload_exec_errno;
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index f47420cf81c9..11fb391c92e9 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -76,6 +76,13 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
>         return 0;
>  }
>
> +u64 perf_bpf_filter__lost_count(struct evsel *evsel)
> +{
> +       struct sample_filter_bpf *skel = evsel->bpf_skel;
> +
> +       return skel ? skel->bss->dropped : 0;
> +}
> +
>  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
>                                                        enum perf_bpf_filter_op op,
>                                                        unsigned long val)
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> index 6077930073f9..36b44c8188ab 100644
> --- a/tools/perf/util/bpf-filter.h
> +++ b/tools/perf/util/bpf-filter.h
> @@ -22,6 +22,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
>  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
>  int perf_bpf_filter__prepare(struct evsel *evsel);
>  int perf_bpf_filter__destroy(struct evsel *evsel);
> +u64 perf_bpf_filter__lost_count(struct evsel *evsel);
>
>  #else /* !HAVE_BPF_SKEL */
>
> @@ -38,5 +39,9 @@ static inline int perf_bpf_filter__destroy(struct evsel *evsel)
>  {
>         return -ENOSYS;
>  }
> +static inline u64 perf_bpf_filter__lost_count(struct evsel *evsel)
> +{
> +       return 0;
> +}
>  #endif /* HAVE_BPF_SKEL*/
>  #endif /* PERF_UTIL_BPF_FILTER_H */
> \ No newline at end of file
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 749d5b5c135b..7d8d057d1772 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1582,7 +1582,8 @@ static int machines__deliver_event(struct machines *machines,
>                         evlist->stats.total_lost += event->lost.lost;
>                 return tool->lost(tool, event, sample, machine);
>         case PERF_RECORD_LOST_SAMPLES:
> -               if (tool->lost_samples == perf_event__process_lost_samples)
> +               if (tool->lost_samples == perf_event__process_lost_samples &&
> +                   !(event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF))
>                         evlist->stats.total_lost_samples += event->lost_samples.lost;
>                 return tool->lost_samples(tool, event, sample, machine);
>         case PERF_RECORD_READ:
> --
> 2.39.1.581.gbfd45094c4-goog
>
