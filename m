Return-Path: <bpf+bounces-69446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E3B96AB0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8122E202C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA426A0DB;
	Tue, 23 Sep 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJJcSOU9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C14264A7F
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642787; cv=none; b=bPYLL3YV6yYsXmKsIdTbHho+0h44jpbfLZ/CrNI4QK4CJtVXfTGVWBrIbDLBN25GH5tpCAWocQ0M1Sp+GEXRDvkOzCa3k7V6VSCdR9GGN8j6PK6K7zCRo71jm1cgMGe31YHMroRJZ+jwwe77vRlJGVDibA9K3KWQSU3fBEuNHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642787; c=relaxed/simple;
	bh=z+uFfbT2+V0VN1QUBUBVU7Yf0yCZy6rUsLod9G1TZRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oSV+X75IW7axGA88jpSblwCzavZ7yeZ7RH6801OEib6d8fkkxOxFqy2/OfyZfadmNa3RaCPuexCfZEFPOkNgk0f9682G2bFidEp74p1SbZZF39uv+stjJd2XhfYdmMmH973lR3gFawpPr0QiCKZQ2UwP28X0vj38cwu2nfqL85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJJcSOU9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681645b7b6so218365ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758642785; x=1759247585; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2P4DLa291UN5dMIrJwLdZEHxEo+piJsQetYJAPBjZk=;
        b=OJJcSOU98RU4rsrPHI3eyZgynatz+5P6KZ8ax1EVUp5/iSCyyf5X/eci9Vl2YObDhp
         27Z1IqJkUxRs2vuNsD+QXazaMot7qlk9IJntc8lLsRpqflequS7yvJYEe/d9sJyYEEmq
         In5v13gaBf7xP9u57stnAsFwV6J0gsLCqSY0EbeZFFvhOiRnAWtr0lQL+xIDjM9UliFs
         S2u5JmS5Sz1/HcA8b76tRu454ZsR87mwhdEaK7QjbV0DE1HknRrXmSkNcgZYxtqQkyZf
         eb4ku7UIQmB18YxneGxnjogX/Gj6D19rwVVpzwIwCvLWR7lcPogh0fgG/okabS50Y88Z
         wPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642785; x=1759247585;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2P4DLa291UN5dMIrJwLdZEHxEo+piJsQetYJAPBjZk=;
        b=vA9KrGyXgDitKPGkH/1WhXz3FH46v4Ajj5mE2y5mfOGGqQNPy9AxJbSgOj22MApg0e
         gtjAaCklpBWYCrkj1Nwah5IIY82qfSOOxSpR6cBnx/h6u1CKCDhPWO5MhA4g6mR/TJaB
         ISsoMWYz108klKtjX0M/F4chaAuedU5j1nPSMKurAK3NtitFVzkgOBmreETipz38eA1P
         ACriVJtNuPiNbpugwsBZr8EQLWknyTc3ugXIH3quI/uOIw3DzIqDWf1KZ02nfL4v4ece
         MDXaVzEmPUKl8apJXCTGbsfe7NosEMVlTSjs6YMKFnZrnYRRv1cmT5aAvwbeDJ/V16hA
         HKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTTScnth3h5EPI/g59YwQ9aV0cY6Lcf4XrqyDRgEj8x5XS9HZivUNeWv4rT7P0Gf/ceJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4ysDMR+8Xzn81SxM0xzHoIByoCrd2F31DCkibessVlWpJLMC
	LHFcHoL9diMKwjVlF4csAODp/xT87APDmkOWVzzt2b+AlBDyChR4ee7zc+4M7zHxOTCsz4yzV59
	R9rjVkhUkiwUNFkNdlL0899IwGPUkNJItv/lAb0YK
X-Gm-Gg: ASbGncusWzMcuzlGMSVth0f+JK3W0Gay1sYf0gHbBVsqjqPxqJ7vsjsNPIIF2VL4u2k
	CKCLPui3CCF2h5kmQe7uoy83vUC7Q8uHihQ8+I9Eq4oCUlZIGH8Otnj/ZOIJngqHJCccHqvGtiE
	8dCmkEK4azA0NW82T8+cY1RK38tEKvw0tmAtFQcjC6L/eEI8ElcfJK4Gpr0CUgD0aFaSpXtp7ah
	jyWs+FQb4u1sHQFA60QEFzfv0a5h24TZ1KW2A==
X-Google-Smtp-Source: AGHT+IG70m5QoiJJvuwAcevMWtg86TUItbecWmuxDqdihU/rHXvTVdXNsMfLpfuUdu+Ffaj4A8H5JLTcJWzV4vzsyGo=
X-Received: by 2002:a17:902:e5c5:b0:274:506d:7fea with SMTP id
 d9443c01a7336-27ebcbcc1b2mr357055ad.5.1758642784825; Tue, 23 Sep 2025
 08:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com> <20250923041844.400164-23-irogers@google.com>
In-Reply-To: <20250923041844.400164-23-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Sep 2025 08:52:53 -0700
X-Gm-Features: AS18NWABI_j0UfirBS1qDjfAYkIAHiJq_Fz6ZmvM95S5kAUNEw1x-M1-JJ3_Amg
Message-ID: <CAP-5=fUvDoyMW2pu-f4-Qoxr6RX_k2+NZ4STmeSDQRFyhvN89g@mail.gmail.com>
Subject: Re: [PATCH v5 22/25] perf test parse-events: Remove cpu PMU requirement
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:19=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In the event parse string, switch "cpu" to "default_core" and then
> rewrite this to the first core PMU name prior to parsing. This enables
> testing with a PMU on hybrid x86 and other systems that don't use
> "cpu" for the core PMU name. The name "default_core" is already used
> by jevents. Update test expectations to match.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This introduces a test failure on Intel hybrid that I'll fix in v6.
Previously the failing tests weren't run and the test expectation was
that, with a PMU or without a PMU, an event would be opened on all
PMUs - which isn't true if the PMU is specified.

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 141 ++++++++++++++------------------
>  1 file changed, 63 insertions(+), 78 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index d0f1e05139ac..4f197f34621b 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -646,19 +646,22 @@ static int test__checkevent_list(struct evlist *evl=
ist)
>  static int test__checkevent_pmu_name(struct evlist *evlist)
>  {
>         struct evsel *evsel =3D evlist__first(evlist);
> +       struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
> +       char buf[256];
>
> -       /* cpu/config=3D1,name=3Dkrava/u */
> +       /* default_core/config=3D1,name=3Dkrava/u */
>         TEST_ASSERT_VAL("wrong number of entries", 2 =3D=3D evlist->core.=
nr_entries);
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
>         TEST_ASSERT_VAL("wrong config", 1 =3D=3D evsel->core.attr.config)=
;
>         TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
>
> -       /* cpu/config=3D2/u" */
> +       /* default_core/config=3D2/u" */
>         evsel =3D evsel__next(evsel);
>         TEST_ASSERT_VAL("wrong number of entries", 2 =3D=3D evlist->core.=
nr_entries);
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
>         TEST_ASSERT_VAL("wrong config", 2 =3D=3D evsel->core.attr.config)=
;
> -       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=
=3D2/u"));
> +       snprintf(buf, sizeof(buf), "%s/config=3D2/u", core_pmu->name);
> +       TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, buf));
>
>         return TEST_OK;
>  }
> @@ -667,7 +670,7 @@ static int test__checkevent_pmu_partial_time_callgrap=
h(struct evlist *evlist)
>  {
>         struct evsel *evsel =3D evlist__first(evlist);
>
> -       /* cpu/config=3D1,call-graph=3Dfp,time,period=3D100000/ */
> +       /* default_core/config=3D1,call-graph=3Dfp,time,period=3D100000/ =
*/
>         TEST_ASSERT_VAL("wrong number of entries", 2 =3D=3D evlist->core.=
nr_entries);
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
>         TEST_ASSERT_VAL("wrong config", 1 =3D=3D evsel->core.attr.config)=
;
> @@ -679,7 +682,7 @@ static int test__checkevent_pmu_partial_time_callgrap=
h(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel))=
;
>         TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.a=
ttr.sample_type));
>
> -       /* cpu/config=3D2,call-graph=3Dno,time=3D0,period=3D2000/ */
> +       /* default_core/config=3D2,call-graph=3Dno,time=3D0,period=3D2000=
/ */
>         evsel =3D evsel__next(evsel);
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
>         TEST_ASSERT_VAL("wrong config", 2 =3D=3D evsel->core.attr.config)=
;
> @@ -702,7 +705,8 @@ static int test__checkevent_pmu_events(struct evlist =
*evlist)
>
>         evlist__for_each_entry(evlist, evsel) {
>                 TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel-=
>core.attr.type ||
> -                                             strcmp(evsel->pmu->name, "c=
pu"));
> +                               !strncmp(evsel__name(evsel), evsel->pmu->=
name,
> +                                        strlen(evsel->pmu->name)));
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> @@ -735,7 +739,7 @@ static int test__checkevent_pmu_events_mix(struct evl=
ist *evlist)
>                 TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned)=
;
>                 TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.excl=
usive);
>         }
> -       /* cpu/pmu-event/u*/
> +       /* default_core/pmu-event/u*/
>         evsel =3D evsel__next(evsel);
>         TEST_ASSERT_VAL("wrong type", evsel__find_pmu(evsel)->is_core);
>         TEST_ASSERT_VAL("wrong exclude_user",
> @@ -1570,14 +1574,9 @@ static int test__checkevent_config_cache(struct ev=
list *evlist)
>         return test__checkevent_genhw(evlist);
>  }
>
> -static bool test__pmu_cpu_valid(void)
> +static bool test__pmu_default_core_event_valid(void)
>  {
> -       return !!perf_pmus__find("cpu");
> -}
> -
> -static bool test__pmu_cpu_event_valid(void)
> -{
> -       struct perf_pmu *pmu =3D perf_pmus__find("cpu");
> +       struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>
>         if (!pmu)
>                 return false;
> @@ -2103,26 +2102,23 @@ static const struct evlist_test test__events[] =
=3D {
>
>  static const struct evlist_test test__events_pmu[] =3D {
>         {
> -               .name  =3D "cpu/config=3D10,config1=3D1,config2=3D3,perio=
d=3D1000/u",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/config=3D10,config1=3D1,config2=
=3D3,period=3D1000/u",
>                 .check =3D test__checkevent_pmu,
>                 /* 0 */
>         },
>         {
> -               .name  =3D "cpu/config=3D1,name=3Dkrava/u,cpu/config=3D2/=
u",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/config=3D1,name=3Dkrava/u,defaul=
t_core/config=3D2/u",
>                 .check =3D test__checkevent_pmu_name,
>                 /* 1 */
>         },
>         {
> -               .name  =3D "cpu/config=3D1,call-graph=3Dfp,time,period=3D=
100000/,cpu/config=3D2,call-graph=3Dno,time=3D0,period=3D2000/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/config=3D1,call-graph=3Dfp,time,=
period=3D100000/,default_core/config=3D2,call-graph=3Dno,time=3D0,period=3D=
2000/",
>                 .check =3D test__checkevent_pmu_partial_time_callgraph,
>                 /* 2 */
>         },
>         {
> -               .name  =3D "cpu/name=3D'COMPLEX_CYCLES_NAME:orig=3Dcycles=
,desc=3Dchip-clock-ticks',period=3D0x1,event=3D0x2/ukp",
> -               .valid =3D test__pmu_cpu_event_valid,
> +               .name  =3D "default_core/name=3D'COMPLEX_CYCLES_NAME:orig=
=3Dcycles,desc=3Dchip-clock-ticks',period=3D0x1,event=3D0x2/ukp",
> +               .valid =3D test__pmu_default_core_event_valid,
>                 .check =3D test__checkevent_complex_name,
>                 /* 3 */
>         },
> @@ -2137,158 +2133,132 @@ static const struct evlist_test test__events_pm=
u[] =3D {
>                 /* 5 */
>         },
>         {
> -               .name  =3D "cpu/L1-dcache-load-miss/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/L1-dcache-load-miss/",
>                 .check =3D test__checkevent_genhw,
>                 /* 6 */
>         },
>         {
> -               .name  =3D "cpu/L1-dcache-load-miss/kp",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/L1-dcache-load-miss/kp",
>                 .check =3D test__checkevent_genhw_modifier,
>                 /* 7 */
>         },
>         {
> -               .name  =3D "cpu/L1-dcache-misses,name=3Dcachepmu/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/L1-dcache-misses,name=3Dcachepmu=
/",
>                 .check =3D test__checkevent_config_cache,
>                 /* 8 */
>         },
>         {
> -               .name  =3D "cpu/instructions/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/",
>                 .check =3D test__checkevent_symbolic_name,
>                 /* 9 */
>         },
>         {
> -               .name  =3D "cpu/cycles,period=3D100000,config2/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/cycles,period=3D100000,config2/"=
,
>                 .check =3D test__checkevent_symbolic_name_config,
>                 /* 0 */
>         },
>         {
> -               .name  =3D "cpu/instructions/h",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/h",
>                 .check =3D test__checkevent_symbolic_name_modifier,
>                 /* 1 */
>         },
>         {
> -               .name  =3D "cpu/instructions/G",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/G",
>                 .check =3D test__checkevent_exclude_host_modifier,
>                 /* 2 */
>         },
>         {
> -               .name  =3D "cpu/instructions/H",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/H",
>                 .check =3D test__checkevent_exclude_guest_modifier,
>                 /* 3 */
>         },
>         {
> -               .name  =3D "{cpu/instructions/k,cpu/cycles/upp}",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/instructions/k,default_core/cyc=
les/upp}",
>                 .check =3D test__group1,
>                 /* 4 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/u,cpu/instructions/kp}:p",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/u,default_core/instructi=
ons/kp}:p",
>                 .check =3D test__group4,
>                 /* 5 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/,cpu/cache-misses/G}:H",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/,default_core/cache-miss=
es/G}:H",
>                 .check =3D test__group_gh1,
>                 /* 6 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/,cpu/cache-misses/H}:G",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/,default_core/cache-miss=
es/H}:G",
>                 .check =3D test__group_gh2,
>                 /* 7 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:u",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/G,default_core/cache-mis=
ses/H}:u",
>                 .check =3D test__group_gh3,
>                 /* 8 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:uG",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/G,default_core/cache-mis=
ses/H}:uG",
>                 .check =3D test__group_gh4,
>                 /* 9 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-mis=
ses/}:S",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/,default_core/cache-miss=
es/,default_core/branch-misses/}:S",
>                 .check =3D test__leader_sample1,
>                 /* 0 */
>         },
>         {
> -               .name  =3D "{cpu/instructions/,cpu/branch-misses/}:Su",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/instructions/,default_core/bran=
ch-misses/}:Su",
>                 .check =3D test__leader_sample2,
>                 /* 1 */
>         },
>         {
> -               .name  =3D "cpu/instructions/uDp",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/uDp",
>                 .check =3D test__checkevent_pinned_modifier,
>                 /* 2 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-mis=
ses/}:D",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/,default_core/cache-miss=
es/,default_core/branch-misses/}:D",
>                 .check =3D test__pinned_group,
>                 /* 3 */
>         },
>         {
> -               .name  =3D "cpu/instructions/I",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/I",
>                 .check =3D test__checkevent_exclude_idle_modifier,
>                 /* 4 */
>         },
>         {
> -               .name  =3D "cpu/instructions/kIG",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/kIG",
>                 .check =3D test__checkevent_exclude_idle_modifier_1,
>                 /* 5 */
>         },
>         {
> -               .name  =3D "cpu/cycles/u",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/cycles/u",
>                 .check =3D test__sym_event_slash,
>                 /* 6 */
>         },
>         {
> -               .name  =3D "cpu/cycles/k",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/cycles/k",
>                 .check =3D test__sym_event_dc,
>                 /* 7 */
>         },
>         {
> -               .name  =3D "cpu/instructions/uep",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/instructions/uep",
>                 .check =3D test__checkevent_exclusive_modifier,
>                 /* 8 */
>         },
>         {
> -               .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-mis=
ses/}:e",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "{default_core/cycles/,default_core/cache-miss=
es/,default_core/branch-misses/}:e",
>                 .check =3D test__exclusive_group,
>                 /* 9 */
>         },
>         {
> -               .name  =3D "cpu/cycles,name=3Dname/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/cycles,name=3Dname/",
>                 .check =3D test__term_equal_term,
>                 /* 0 */
>         },
>         {
> -               .name  =3D "cpu/cycles,name=3Dl1d/",
> -               .valid =3D test__pmu_cpu_valid,
> +               .name  =3D "default_core/cycles,name=3Dl1d/",
>                 .check =3D test__term_equal_legacy,
>                 /* 1 */
>         },
> @@ -2378,15 +2348,30 @@ static int combine_test_results(int existing, int=
 latest)
>  static int test_events(const struct evlist_test *events, int cnt)
>  {
>         int ret =3D TEST_OK;
> +       struct perf_pmu *core_pmu =3D perf_pmus__find_core_pmu();
>
>         for (int i =3D 0; i < cnt; i++) {
> -               const struct evlist_test *e =3D &events[i];
> +               struct evlist_test e =3D events[i];
>                 int test_ret;
> +               const char *pos =3D e.name;
> +               char buf[1024], *buf_pos =3D buf, *end;
> +
> +               while ((end =3D strstr(pos, "default_core"))) {
> +                       size_t len =3D end - pos;
> +
> +                       strncpy(buf_pos, pos, len);
> +                       pos =3D end + 12;
> +                       buf_pos +=3D len;
> +                       strcpy(buf_pos, core_pmu->name);
> +                       buf_pos +=3D strlen(core_pmu->name);
> +               }
> +               strcpy(buf_pos, pos);
>
> -               pr_debug("running test %d '%s'\n", i, e->name);
> -               test_ret =3D test_event(e);
> +               e.name =3D buf;
> +               pr_debug("running test %d '%s'\n", i, e.name);
> +               test_ret =3D test_event(&e);
>                 if (test_ret !=3D TEST_OK) {
> -                       pr_debug("Event test failure: test %d '%s'", i, e=
->name);
> +                       pr_debug("Event test failure: test %d '%s'", i, e=
.name);
>                         ret =3D combine_test_results(ret, test_ret);
>                 }
>         }
> --
> 2.51.0.534.gc79095c0ca-goog
>

