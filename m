Return-Path: <bpf+bounces-5761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33607600E4
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E18281369
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2210971;
	Mon, 24 Jul 2023 21:09:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C91107B7
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:09:32 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA010FA
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:09:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63d10da0f26so2868986d6.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690232970; x=1690837770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4R7OXxyA6++6H908qvwT/4xVlAoInx/mRJrgLvZp3I=;
        b=7VPLC3FM4ARsMPpxFByktScwoRDHY1+O3k6ji1oMHXcyc6BWzJO2kc65fqEz/njpKS
         1e7OlV2JEjMDqg5/b/8JhzaVftGznHjCljWM27BrP56UMgo4L8DdTIELZGyd7UD9rWPk
         qQbnqI5NpI7yY40RMK0+86Sbiiv6BJBD6PmxYo61TZv00unQD3dW63wIjlZ4uU5YLag4
         6T0PNkCCqQKY3fRRiocbDQLEC+UAeiYQ8kf5hL3Z5wM+rOMs1zhoGu6GcqpFEj1KU9Dh
         YSpeA+8GtomB9U/LAI/r00dP87tOUdSYkkqZmSXVpqurgoIAKEF3A5KjksJiib/fhSTg
         muAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690232970; x=1690837770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4R7OXxyA6++6H908qvwT/4xVlAoInx/mRJrgLvZp3I=;
        b=K0ucWrGlHIwb6WAXzYhv03ODGFwwxIdyaKfA385lUWbLAjxgvPcUc49atvmWTfI9nm
         6XagDnIEqCIUDF2WsyZSofDsZrlGKgSFoigH1QHhNjq4FDfMF8E/pyo/RjqPeIku6IG6
         lx/qG6ePSESopaHQGheMcEaII4+OJF3su6g6m/Owds8ZNyrhyMC8gWrqh21ph40yhSTv
         hKv06qsqAgRYaAGw6K2nhicXFCzOinf5cg4fmRTjKcejDe9DpYTA+I0WhQKO4WMRSCTO
         7tEf6KEWGqGUDe2eUQ50ft04UY94oGkD46zghej9FW4C28/QH5zrwZLLqf7FkEcCwv75
         kLSA==
X-Gm-Message-State: ABy/qLZWXH5vOhjoXHrmxuB1n6S3iybYuo/k2VqocfeWssfy+TLInv9m
	PR9rbWhVsKSi1VA++VBB9sxciw6x/OIAPsjlGg7vrw==
X-Google-Smtp-Source: APBJJlEVIiJyEgN+QVsm2PLjyvD1Ou20SgK8rwynWuqyeHMek9W1M6VLm3dl9IiVVE8IhJUcTcukic+uVZi3kHIPE+c=
X-Received: by 2002:a05:6214:11b0:b0:63c:fac8:ec0b with SMTP id
 u16-20020a05621411b000b0063cfac8ec0bmr786313qvv.39.1690232970451; Mon, 24 Jul
 2023 14:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <20230724201247.748146-2-irogers@google.com>
In-Reply-To: <20230724201247.748146-2-irogers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 24 Jul 2023 14:09:19 -0700
Message-ID: <CAKwvOdnNgd9QgvrR5H2rL8eb1Qc--ELCcOie8Bv=xTFqg9Zh-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf stat: Avoid uninitialized use of perf_stat_config
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> perf_event__read_stat_config will assign values based on number of
> tags and tag values. Initialize the structs to zero before they are
> assigned so that no uninitialized values can be seen.
>
> This potential error was reported by GCC with LTO enabled.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/stat.c | 2 +-
>  tools/perf/util/stat.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
> index 500974040fe3..706780fb5695 100644
> --- a/tools/perf/tests/stat.c
> +++ b/tools/perf/tests/stat.c
> @@ -27,7 +27,7 @@ static int process_stat_config_event(struct perf_tool *=
tool __maybe_unused,
>                                      struct machine *machine __maybe_unus=
ed)
>  {
>         struct perf_record_stat_config *config =3D &event->stat_config;
> -       struct perf_stat_config stat_config;
> +       struct perf_stat_config stat_config =3D {};

^ how did this code ever work?

1. stat_config is not initialized
2. perf_event__read_stat_config maybe assigns to &stat_config->__val
3. process_stat_config_event() tests other members of stat_config

I hope I've missed something obvious.


Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  #define HAS(term, val) \
>         has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 967e583392c7..ec3506042217 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -729,7 +729,7 @@ size_t perf_event__fprintf_stat_round(union perf_even=
t *event, FILE *fp)
>
>  size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp=
)
>  {
> -       struct perf_stat_config sc;
> +       struct perf_stat_config sc =3D {};
>         size_t ret;
>
>         perf_event__read_stat_config(&sc, &event->stat_config);
> --
> 2.41.0.487.g6d72f3e995-goog
>


--=20
Thanks,
~Nick Desaulniers

