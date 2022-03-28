Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99AE4EA20A
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbiC1U4H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiC1U4F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 16:56:05 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9A674F0
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 13:54:23 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id q85so8686501vkq.4
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43hk8/Rw4z01LCcqTsH+6mefQsfmUhIYxjOwJf2drRU=;
        b=hLxJt3z9utJ3Uo3vXalGW/Bt3OtfvP877YBOtHA7cro7T0KF1AMBWq3M79X70C99zY
         9qQ4pATcIJhHHQHhA4oXAKu5PbglJVKL+iAXssF9Cvttx9GQn+mViWAf9GPUDfEzBQuS
         0WmnRpeTLk5jr0lmN7BF/ZMWahsVbFCz7faNJn+tbL/Agxcdmo29GupqMmKAF+lDyU71
         4vdoE5O7mzFNhynhGFNUGCqP8ajcJtRNwumcJ91rRtSGRYGD7gpNRV30emCOrGpgnFc1
         xPTXeHyKITEcYPQvLROlht/WTrcZQFbmBfJNVVsQJrKjCLfnZPLDWTrwKgn26qMmstsi
         iC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43hk8/Rw4z01LCcqTsH+6mefQsfmUhIYxjOwJf2drRU=;
        b=cToaRQDfkYryZulqar7c8QoVyxbGSySlXXg1mvvUVBACuac4aCCBA3QnJGjEOCWI8W
         dUKYWm16Y9IrwQ6qrqSS8K3mZoYZ5x0pooBAfvRYdC4yxLIKtUkmtSnCiC7TrU5FmqEp
         6U2fJ1THRgBU9h11Y64QAEvsn/157L/n0pb+UHonIIMweOOpQ4arbNyZSG2fMXOKHXE5
         VZ9EE4270q0bBqeKY8QnSLSJDVZcNc3WmWMtwH+c+AxNrsjvMFsNp6498xXWHFeHN9OD
         w3vbBi/tRBcnoTry+Gb0abadUa/wFTU8sNoRdEdd/Or3je3omR/DmrQSoHGZt78r28b1
         Z0lQ==
X-Gm-Message-State: AOAM533MER5e+yrFSsI5Hsf/R3o///HMGl0CCVDR6ghAR/gfZ/q10RWf
        xhODIpOFGXQJUGnFcF/ugOdWPBVhoF5je5HMQIDHFw==
X-Google-Smtp-Source: ABdhPJyTW9Pbx62C22oC1YD+zYurOg0MAs61ljKl+7+tR+UHAUJd3RvGDA0GVNe6EgwOzow0Jm6Y087gK3FjvbiZSso=
X-Received: by 2002:ac5:c961:0:b0:33f:4c03:df44 with SMTP id
 t1-20020ac5c961000000b0033f4c03df44mr14296195vkm.19.1648500857749; Mon, 28
 Mar 2022 13:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220328062414.1893550-1-irogers@google.com> <20220328062414.1893550-4-irogers@google.com>
 <YkIaYq2alnNUiIfr@kernel.org>
In-Reply-To: <YkIaYq2alnNUiIfr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 28 Mar 2022 13:54:06 -0700
Message-ID: <CAP-5=fVfYtu=wcfUQEzwuJMhxexi3d8hVqF5QFLkj_FWPHLK5Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf cpumap: Add intersect function.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 28, 2022 at 1:28 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Mar 27, 2022 at 11:24:12PM -0700, Ian Rogers escreveu:
> > The merge function gives the union of two cpu maps. Add an intersect
> > function which will be used in the next change.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c              | 38 ++++++++++++++++++++++++++++
> >  tools/lib/perf/include/perf/cpumap.h |  2 ++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 953bc50b0e41..56b4d213039f 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -393,3 +393,41 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >       perf_cpu_map__put(orig);
> >       return merged;
> >  }
> > +
> > +struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
> > +                                          struct perf_cpu_map *other)
> > +{
> > +     struct perf_cpu *tmp_cpus;
> > +     int tmp_len;
> > +     int i, j, k;
> > +     struct perf_cpu_map *merged = NULL;
> > +
> > +     if (perf_cpu_map__is_subset(other, orig))
> > +             return orig;
> > +     if (perf_cpu_map__is_subset(orig, other)) {
> > +             perf_cpu_map__put(orig);
>
> Why this put(orig)?

As with merge, if orig isn't returned then it is put.

> > +             return perf_cpu_map__get(other);
>
> And why the get here and not on the first if?

The first argument orig is either put or returned while the second may
be returned only if the reference count is incremented. We could
change the API for merge and intersect to put both arguments, or to
not put either argument.

Thanks,
Ian

> > +     }
> > +
> > +     tmp_len = max(orig->nr, other->nr);
> > +     tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> > +     if (!tmp_cpus)
> > +             return NULL;
> > +
> > +     i = j = k = 0;
> > +     while (i < orig->nr && j < other->nr) {
> > +             if (orig->map[i].cpu < other->map[j].cpu)
> > +                     i++;
> > +             else if (orig->map[i].cpu > other->map[j].cpu)
> > +                     j++;
> > +             else {
> > +                     j++;
> > +                     tmp_cpus[k++] = orig->map[i++];
> > +             }
> > +     }
> > +     if (k)
> > +             merged = cpu_map__trim_new(k, tmp_cpus);
> > +     free(tmp_cpus);
> > +     perf_cpu_map__put(orig);
> > +     return merged;
> > +}
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> > index 4a2edbdb5e2b..a2a7216c0b78 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -19,6 +19,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >                                                    struct perf_cpu_map *other);
> > +LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
> > +                                                      struct perf_cpu_map *other);
> >  LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
> >  LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
> >  LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
> > --
> > 2.35.1.1021.g381101b075-goog
>
> --
>
> - Arnaldo
