Return-Path: <bpf+bounces-22198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB92F858C7A
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 02:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096EE1C20E33
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 01:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DB1CD1C;
	Sat, 17 Feb 2024 01:02:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888E1CA9F;
	Sat, 17 Feb 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131720; cv=none; b=hkKxnYsQebkJz++H4YMFKtyHyToSNM5kVZfgYF/8GRpxoIxbx5EMLUrrbcW6GA9AxLEXY0dCj0oQ2xT6vwb3fLAGov1C2cS8sAThW0cJTyNU84SsjXA8rf/arV9CkBIQalvr0kXlunBJrqvpfCzDr+tIk3rIOjtY7mHEpvHLbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131720; c=relaxed/simple;
	bh=Ur9DnGTk+ZxAXp4hkavwsrI3+zsDNEzwd5Hy1Ka8DZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJM5Sx5BOKtebIPHV7VqHXd3AyF4EiLnLDyIzj/UWPjLlMtmn842d0ocpd2TbgQIw6iKzl6iOiASmobR8uy2tMq1nZzwQ9SvOn6EGF6SVj3TatAzqX9HlmEOBGX8toOVUj/NcDKd0gmuqF6b9z+X81vUl4XilKrbX+3q/7F35Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso891621a91.3;
        Fri, 16 Feb 2024 17:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131718; x=1708736518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxV9TXapvOP0n0kKFZdsI+YFHX9bPXIO75I2+R39LPA=;
        b=Qk4Tr2T/Dk3vGKiJ4OggcjFXhd5QIbIl4ZKWQc01zFiJLAoaCJEUbl5lGht5DmEEwO
         1cydr3GdWTuBDoqU4n32R/EQSQ7DHGC0OWXfWcoLjVr5tI8XJWnCCYhU2SgY/5XHTTF3
         u881j/GbUYFLMwtr3ePKnHiEvSGpYAWTIptckuzrRPl+dt3h7vbgGPkWCxWGJsUUJtB+
         yftLj5FhlY2v+CCx5/DC8ztSgPfgg/yoW/WiM2fcq2VX5bQwL+xFVpqPBi44od+z1k0S
         X66ZutlAd4mJkFZf/oYolaLTcvwISPSa5xJ871vgs8v51vG9oj6bsbYUGrKQP1ljs/9Q
         ADQg==
X-Forwarded-Encrypted: i=1; AJvYcCXrbZPlf1/K8TyfJhGsutfwWXNqfUBo05jQ05Pvy9T2QhiRzfbzCvFP4FEy8No8SBhtJnq4YcBxXwX8rwbLfJI7hGv1MBPyx78DiIOCmDOGXGv9/8Q/RW/z/hvEj7nbnSXndnYKIAw3d2M8JDDpL/i+fjDYrHo4cqk5T0z250xiF78COg==
X-Gm-Message-State: AOJu0YxQhC6T6ouu5x7gYfRslqf3+YkGiNUsiEMPB2oLqcUXLpGjH3kn
	pFts31ve/ROG/STetEhcCq1Aq1JvHKEnT+DMCSl6K4qt+2TZ7YZr3ApXUcXEBCxiX3dRity9noW
	SAvtfjx/rTyoq3iQU3jGc9r2jB64=
X-Google-Smtp-Source: AGHT+IF5v/+3gC4nH5bATdgvlLOialDCQ0GdRjgrJgZ/lM9sOmlLU1KdtpxvP8Pmn+UdMiTzkE+KmyVV3n8csEKQn7U=
X-Received: by 2002:a17:90b:4ace:b0:299:3efe:8209 with SMTP id
 mh14-20020a17090b4ace00b002993efe8209mr2209448pjb.4.1708131717541; Fri, 16
 Feb 2024 17:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <20240202234057.2085863-4-irogers@google.com>
In-Reply-To: <20240202234057.2085863-4-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 17:01:45 -0800
Message-ID: <CAM9d7chPqFGEih7z7rp=eS5P30gSMvG=6fi=0QqT=EdfdMOH_A@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
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
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Rather than iterate all CPUs and see if they are in CPU maps, directly
> iterate the CPU map. Similarly make use of the intersect function
> taking care for when "any" CPU is specified. Switch
> perf_cpu_map__has_any_cpu_or_is_empty to more appropriate
> alternatives.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 114 ++++++++++++---------------
>  tools/perf/arch/arm64/util/arm-spe.c |   4 +-
>  2 files changed, 51 insertions(+), 67 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index 77e6663c1703..07be32d99805 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -197,38 +197,37 @@ static int cs_etm_validate_timestamp(struct auxtrac=
e_record *itr,
>  static int cs_etm_validate_config(struct auxtrace_record *itr,
>                                   struct evsel *evsel)
>  {
> -       int i, err =3D -EINVAL;
> +       int idx, err =3D 0;
>         struct perf_cpu_map *event_cpus =3D evsel->evlist->core.user_requ=
ested_cpus;
> -       struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_cpu=
s();
> -
> -       /* Set option of each CPU we have */
> -       for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> -               struct perf_cpu cpu =3D { .cpu =3D i, };
> +       struct perf_cpu_map *intersect_cpus;
> +       struct perf_cpu cpu;
>
> -               /*
> -                * In per-cpu case, do the validation for CPUs to work wi=
th.
> -                * In per-thread case, the CPU map is empty.  Since the t=
raced
> -                * program can run on any CPUs in this case, thus don't s=
kip
> -                * validation.
> -                */
> -               if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
> -                   !perf_cpu_map__has(event_cpus, cpu))
> -                       continue;
> +       /*
> +        * Set option of each CPU we have. In per-cpu case, do the valida=
tion
> +        * for CPUs to work with. In per-thread case, the CPU map has the=
 "any"
> +        * CPU value. Since the traced program can run on any CPUs in thi=
s case,
> +        * thus don't skip validation.
> +        */
> +       if (!perf_cpu_map__has_any_cpu(event_cpus)) {
> +               struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_on=
line_cpus();
>
> -               if (!perf_cpu_map__has(online_cpus, cpu))
> -                       continue;
> +               intersect_cpus =3D perf_cpu_map__intersect(event_cpus, on=
line_cpus);
> +               perf_cpu_map__put(online_cpus);
> +       } else {
> +               intersect_cpus =3D perf_cpu_map__new_online_cpus();
> +       }

Would it be ok if any of these operations fail?  I believe the
cpu map functions work well with NULL already.

Thanks,
Namhyung

>
> -               err =3D cs_etm_validate_context_id(itr, evsel, i);
> +       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> +               err =3D cs_etm_validate_context_id(itr, evsel, cpu.cpu);
>                 if (err)
> -                       goto out;
> -               err =3D cs_etm_validate_timestamp(itr, evsel, i);
> +                       break;
> +
> +               err =3D cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
>                 if (err)
> -                       goto out;
> +                       break;
>         }
>
> -       err =3D 0;
> -out:
> -       perf_cpu_map__put(online_cpus);
> +       perf_cpu_map__put(intersect_cpus);
>         return err;
>  }
>
> @@ -435,7 +434,7 @@ static int cs_etm_recording_options(struct auxtrace_r=
ecord *itr,
>          * Also the case of per-cpu mmaps, need the contextID in order to=
 be notified
>          * when a context switch happened.
>          */
> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>                 evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>                                            "timestamp", 1);
>                 evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> @@ -461,7 +460,7 @@ static int cs_etm_recording_options(struct auxtrace_r=
ecord *itr,
>         evsel->core.attr.sample_period =3D 1;
>
>         /* In per-cpu case, always need the time of mmap events etc */
> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
>                 evsel__set_sample_bit(evsel, TIME);
>
>         err =3D cs_etm_validate_config(itr, cs_etm_evsel);
> @@ -533,45 +532,31 @@ static size_t
>  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>                       struct evlist *evlist __maybe_unused)
>  {
> -       int i;
> +       int idx;
>         int etmv3 =3D 0, etmv4 =3D 0, ete =3D 0;
>         struct perf_cpu_map *event_cpus =3D evlist->core.user_requested_c=
pus;
> -       struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_cpu=
s();
> -
> -       /* cpu map is not empty, we have specific CPUs to work with */
> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> -               for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> -                       struct perf_cpu cpu =3D { .cpu =3D i, };
> +       struct perf_cpu_map *intersect_cpus;
> +       struct perf_cpu cpu;
>
> -                       if (!perf_cpu_map__has(event_cpus, cpu) ||
> -                           !perf_cpu_map__has(online_cpus, cpu))
> -                               continue;
> +       if (!perf_cpu_map__has_any_cpu(event_cpus)) {
> +               /* cpu map is not "any" CPU , we have specific CPUs to wo=
rk with */
> +               struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_on=
line_cpus();
>
> -                       if (cs_etm_is_ete(itr, i))
> -                               ete++;
> -                       else if (cs_etm_is_etmv4(itr, i))
> -                               etmv4++;
> -                       else
> -                               etmv3++;
> -               }
> +               intersect_cpus =3D perf_cpu_map__intersect(event_cpus, on=
line_cpus);
> +               perf_cpu_map__put(online_cpus);
>         } else {
> -               /* get configuration for all CPUs in the system */
> -               for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> -                       struct perf_cpu cpu =3D { .cpu =3D i, };
> -
> -                       if (!perf_cpu_map__has(online_cpus, cpu))
> -                               continue;
> -
> -                       if (cs_etm_is_ete(itr, i))
> -                               ete++;
> -                       else if (cs_etm_is_etmv4(itr, i))
> -                               etmv4++;
> -                       else
> -                               etmv3++;
> -               }
> +               /* Event can be "any" CPU so count all online CPUs. */
> +               intersect_cpus =3D perf_cpu_map__new_online_cpus();
>         }
> -
> -       perf_cpu_map__put(online_cpus);
> +       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> +               if (cs_etm_is_ete(itr, cpu.cpu))
> +                       ete++;
> +               else if (cs_etm_is_etmv4(itr, cpu.cpu))
> +                       etmv4++;
> +               else
> +                       etmv3++;
> +       }
> +       perf_cpu_map__put(intersect_cpus);
>
>         return (CS_ETM_HEADER_SIZE +
>                (ete   * CS_ETE_PRIV_SIZE) +
> @@ -813,16 +798,15 @@ static int cs_etm_info_fill(struct auxtrace_record =
*itr,
>         if (!session->evlist->core.nr_mmaps)
>                 return -EINVAL;
>
> -       /* If the cpu_map is empty all online CPUs are involved */
> -       if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> +       /* If the cpu_map has the "any" CPU all online CPUs are involved =
*/
> +       if (perf_cpu_map__has_any_cpu(event_cpus)) {
>                 cpu_map =3D online_cpus;
>         } else {
>                 /* Make sure all specified CPUs are online */
> -               for (i =3D 0; i < perf_cpu_map__nr(event_cpus); i++) {
> -                       struct perf_cpu cpu =3D { .cpu =3D i, };
> +               struct perf_cpu cpu;
>
> -                       if (perf_cpu_map__has(event_cpus, cpu) &&
> -                           !perf_cpu_map__has(online_cpus, cpu))
> +               perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
> +                       if (!perf_cpu_map__has(online_cpus, cpu))
>                                 return -EINVAL;
>                 }
>
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64=
/util/arm-spe.c
> index 51ccbfd3d246..0b52e67edb3b 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_=
record *itr,
>          * In the case of per-cpu mmaps, sample CPU for AUX event;
>          * also enable the timestamp tracing for samples correlation.
>          */
> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>                 evsel__set_sample_bit(arm_spe_evsel, CPU);
>                 evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
>                                            "ts_enable", 1);
> @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_=
record *itr,
>         tracking_evsel->core.attr.sample_period =3D 1;
>
>         /* In per-cpu case, always need the time of mmap events etc */
> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>                 evsel__set_sample_bit(tracking_evsel, TIME);
>                 evsel__set_sample_bit(tracking_evsel, CPU);
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

