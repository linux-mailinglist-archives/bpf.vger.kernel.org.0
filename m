Return-Path: <bpf+bounces-20961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09106845A3C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860A81F29F50
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECFA5F491;
	Thu,  1 Feb 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIA7Zmft"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9305F478
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797505; cv=none; b=n3AE2dFy/gN5/7Xt62wqt5sgLAuPm54WHNbU2J0cLzXOIqYp+zsEaPMka+2aS/gJLXXlaewuq2IyFOx7JpB2CEnGnZjoWxO8NeOMivbp0m7ehcQbdSio6t8TjUkD3UW4/G5PwGb8pnNUrmdRRUDTYAvDCZj2Dp/aOgNo3t9EPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797505; c=relaxed/simple;
	bh=urTC8c/x4GjOmh3DyV8iK3vfUq7I4Kdkr8Ip1YAlpbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpbUHgXAqb/spuck1yA15L/lzVsZceUMKqpBJRwFQhF//jl3hOuO5TGj3jO3Cr/GosHQ7N8iAGlMrADWCoK9vSQbtRS/XduiIRoUAJkRUkjc4JsSIaMGvcuJdRtRFlizIl8rH/OynYymlhLPghIHB3nq2HK50IlGCNYeReEocLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIA7Zmft; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d5ce88b51cso202435ad.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706797503; x=1707402303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oik3gsH7UCRMxBdMG02de4OGV898umiHRSHwrLUdZI=;
        b=vIA7ZmftqW1QTWmyWPq9JEbOmBVd8wve5m8oPT7SROsE3310AomOg28ZHVHk/uYyOO
         R5uzmYW5fsNgdv9qw7AlmlBltH76NW+N6kjoamqTj2lcS25gOPFZ5pICobcfAsGeauMF
         mqkQ9V9kJ8MxLkYEbKieEz8GJD+AVFt6A3J+tpmMnj+KOQ7ID9aCY6SYImXgAQz40psM
         gDELNuES+y1I1SZda7P+mJmH8Co7iQrHKsH6PTP2ZADsiRFWFewKIuS1Yh15sMw3858m
         ova2xsQDxokCUNlX5eOYK0ZDaAyOt4vEcxMKEx1yQtq2FS2v9ru2WkBxQu+xMX+HPsCh
         HTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706797503; x=1707402303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oik3gsH7UCRMxBdMG02de4OGV898umiHRSHwrLUdZI=;
        b=LgSgTNKzUTSUXXpVI/vRYTc9cuOz3nusVyC0Zu1on1HSMZynQD3aWWAt5tdp5Cc/0m
         BH7xDHJmAthMkJjFkvaVDZVEQ8wogp8Ov8DkZJUKZURO1EH7qGudJcbrmbicUTK+ptN8
         eJl9+9U/VXvZ53LjVkW6FwCGq1SlWimK2qr2IQHXlFOOS5yD+s4M5SooiwZp7DSm4Hzm
         HAXinA7Uzb3uErlVxS8Nl4qypBagdFaF2jfTCbDJCRF2EcWSVVcMNkaRlLu5UQl7oP4P
         IKDZiT1zUHhBpobs6VfhRA/zet7m34b2RpiqbwhwUZ2+3WDjULqgGN8yKQ+rvHnMtK2r
         UH9g==
X-Gm-Message-State: AOJu0Ywgm89j9vX/7oyS71GswYhMv7rtkB9A1aF7IcqbBDHF2RPQ1rcc
	iNT1qKlRntdHWEhKwKPcr0dKrf36L6mRevqN5vkg/poxAZE9PWN1fx60kbOdi7i33fMzR1EYXYN
	1lliGKFD224IhXU400h+SjL9JvEUAHpJymsrg
X-Google-Smtp-Source: AGHT+IHI1zkSF24WGgfobv3gzLaErXwwm+tRmNbiHxBAsTDDC816FuOmnpUy05KzuzVXoUjvif2HUxanJbXCQ6xr+OI=
X-Received: by 2002:a17:903:41cb:b0:1d8:fc6f:e1da with SMTP id
 u11-20020a17090341cb00b001d8fc6fe1damr245879ple.2.1706797502666; Thu, 01 Feb
 2024 06:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com> <20240201042236.1538928-4-irogers@google.com>
 <9d177173-c66f-a0d3-ba4d-2261f8663fce@arm.com>
In-Reply-To: <9d177173-c66f-a0d3-ba4d-2261f8663fce@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Feb 2024 06:24:51 -0800
Message-ID: <CAP-5=fVDjOfM8rZStYJCFPcTD3uhJDNSf_=JrkwYjFrnoOLC=w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:25=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
>
>
> On 01/02/2024 04:22, Ian Rogers wrote:
> > Rather than iterate all CPUs and see if they are in CPU maps, directly
> > iterate the CPU map. Similarly make use of the intersect
> > function. Switch perf_cpu_map__has_any_cpu_or_is_empty to more
> > appropriate alternatives.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c    | 77 ++++++++++++----------------
> >  tools/perf/arch/arm64/util/arm-spe.c |  4 +-
> >  2 files changed, 34 insertions(+), 47 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/ut=
il/cs-etm.c
> > index 77e6663c1703..f4378ba0b8d6 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -197,38 +197,32 @@ static int cs_etm_validate_timestamp(struct auxtr=
ace_record *itr,
> >  static int cs_etm_validate_config(struct auxtrace_record *itr,
> >                                 struct evsel *evsel)
> >  {
> > -     int i, err =3D -EINVAL;
> > +     int idx, err =3D -EINVAL;
> >       struct perf_cpu_map *event_cpus =3D evsel->evlist->core.user_requ=
ested_cpus;
> >       struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_cpu=
s();
> > +     struct perf_cpu_map *intersect_cpus =3D perf_cpu_map__intersect(e=
vent_cpus, online_cpus);
>
> Hi Ian,
>
> This has the same issue as V1. 'any' intersect 'online' =3D=3D empty. Now=
 no
> validation happens anymore. For this to be the same as it used to be,
> validation has to happen on _all_ cores when event_cpus =3D=3D -1. So it
> needs to be 'any' intersect 'online' =3D=3D 'online'.
>
> Same issue below with cs_etm_info_priv_size()

Thanks James, sorry for the churn. I'll work on that for v3.

Ian

> Thanks
> James
>
> > +     struct perf_cpu cpu;
> >
> > -     /* Set option of each CPU we have */
> > -     for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> > -             struct perf_cpu cpu =3D { .cpu =3D i, };
> > -
> > -             /*
> > -              * In per-cpu case, do the validation for CPUs to work wi=
th.
> > -              * In per-thread case, the CPU map is empty.  Since the t=
raced
> > -              * program can run on any CPUs in this case, thus don't s=
kip
> > -              * validation.
> > -              */
> > -             if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
> > -                 !perf_cpu_map__has(event_cpus, cpu))
> > -                     continue;
> > -
> > -             if (!perf_cpu_map__has(online_cpus, cpu))
> > -                     continue;
> > +     perf_cpu_map__put(online_cpus);
> >
> > -             err =3D cs_etm_validate_context_id(itr, evsel, i);
> > +     /*
> > +      * Set option of each CPU we have. In per-cpu case, do the valida=
tion
> > +      * for CPUs to work with.  In per-thread case, the CPU map is emp=
ty.
> > +      * Since the traced program can run on any CPUs in this case, thu=
s don't
> > +      * skip validation.
> > +      */
> > +     perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> > +             err =3D cs_etm_validate_context_id(itr, evsel, cpu.cpu);
> >               if (err)
> >                       goto out;
> > -             err =3D cs_etm_validate_timestamp(itr, evsel, i);
> > +             err =3D cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
> >               if (err)
> >                       goto out;
> >       }
> >
> >       err =3D 0;
> >  out:
> > -     perf_cpu_map__put(online_cpus);
> > +     perf_cpu_map__put(intersect_cpus);
> >       return err;
> >  }
> >
> > @@ -435,7 +429,7 @@ static int cs_etm_recording_options(struct auxtrace=
_record *itr,
> >        * Also the case of per-cpu mmaps, need the contextID in order to=
 be notified
> >        * when a context switch happened.
> >        */
> > -     if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> > +     if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >               evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> >                                          "timestamp", 1);
> >               evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> > @@ -461,7 +455,7 @@ static int cs_etm_recording_options(struct auxtrace=
_record *itr,
> >       evsel->core.attr.sample_period =3D 1;
> >
> >       /* In per-cpu case, always need the time of mmap events etc */
> > -     if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> > +     if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
> >               evsel__set_sample_bit(evsel, TIME);
> >
> >       err =3D cs_etm_validate_config(itr, cs_etm_evsel);
> > @@ -533,38 +527,32 @@ static size_t
> >  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> >                     struct evlist *evlist __maybe_unused)
> >  {
> > -     int i;
> > +     int idx;
> >       int etmv3 =3D 0, etmv4 =3D 0, ete =3D 0;
> >       struct perf_cpu_map *event_cpus =3D evlist->core.user_requested_c=
pus;
> >       struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_cpu=
s();
> > +     struct perf_cpu cpu;
> >
> >       /* cpu map is not empty, we have specific CPUs to work with */
> > -     if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> > -             for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> > -                     struct perf_cpu cpu =3D { .cpu =3D i, };
> > -
> > -                     if (!perf_cpu_map__has(event_cpus, cpu) ||
> > -                         !perf_cpu_map__has(online_cpus, cpu))
> > -                             continue;
> > +     if (!perf_cpu_map__is_empty(event_cpus)) {
> > +             struct perf_cpu_map *intersect_cpus =3D
> > +                     perf_cpu_map__intersect(event_cpus, online_cpus);
> >
> > -                     if (cs_etm_is_ete(itr, i))
> > +             perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_c=
pus) {
> > +                     if (cs_etm_is_ete(itr, cpu.cpu))
> >                               ete++;
> > -                     else if (cs_etm_is_etmv4(itr, i))
> > +                     else if (cs_etm_is_etmv4(itr, cpu.cpu))
> >                               etmv4++;
> >                       else
> >                               etmv3++;
> >               }
> > +             perf_cpu_map__put(intersect_cpus);
> >       } else {
> >               /* get configuration for all CPUs in the system */
> > -             for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> > -                     struct perf_cpu cpu =3D { .cpu =3D i, };
> > -
> > -                     if (!perf_cpu_map__has(online_cpus, cpu))
> > -                             continue;
> > -
> > -                     if (cs_etm_is_ete(itr, i))
> > +             perf_cpu_map__for_each_cpu(cpu, idx, online_cpus) {
> > +                     if (cs_etm_is_ete(itr, cpu.cpu))
> >                               ete++;
> > -                     else if (cs_etm_is_etmv4(itr, i))
> > +                     else if (cs_etm_is_etmv4(itr, cpu.cpu))
> >                               etmv4++;
> >                       else
> >                               etmv3++;
> > @@ -814,15 +802,14 @@ static int cs_etm_info_fill(struct auxtrace_recor=
d *itr,
> >               return -EINVAL;
> >
> >       /* If the cpu_map is empty all online CPUs are involved */
> > -     if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> > +     if (perf_cpu_map__is_empty(event_cpus)) {
> >               cpu_map =3D online_cpus;
> >       } else {
> >               /* Make sure all specified CPUs are online */
> > -             for (i =3D 0; i < perf_cpu_map__nr(event_cpus); i++) {
> > -                     struct perf_cpu cpu =3D { .cpu =3D i, };
> > +             struct perf_cpu cpu;
> >
> > -                     if (perf_cpu_map__has(event_cpus, cpu) &&
> > -                         !perf_cpu_map__has(online_cpus, cpu))
> > +             perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
> > +                     if (!perf_cpu_map__has(online_cpus, cpu))
> >                               return -EINVAL;
> >               }
> >
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm=
64/util/arm-spe.c
> > index 51ccbfd3d246..0b52e67edb3b 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrac=
e_record *itr,
> >        * In the case of per-cpu mmaps, sample CPU for AUX event;
> >        * also enable the timestamp tracing for samples correlation.
> >        */
> > -     if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> > +     if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >               evsel__set_sample_bit(arm_spe_evsel, CPU);
> >               evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
> >                                          "ts_enable", 1);
> > @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrac=
e_record *itr,
> >       tracking_evsel->core.attr.sample_period =3D 1;
> >
> >       /* In per-cpu case, always need the time of mmap events etc */
> > -     if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> > +     if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >               evsel__set_sample_bit(tracking_evsel, TIME);
> >               evsel__set_sample_bit(tracking_evsel, CPU);
> >

