Return-Path: <bpf+bounces-70426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF4BBE9CB
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017601899F2A
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5841F416B;
	Mon,  6 Oct 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIqqsOPr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CB1E1DF2
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767516; cv=none; b=H6PNLgGzNZ1L7fWWKEXQ3K3iehecp1HagYKGyPxMZe8ExZFI9LQ+OuZCOk46hNJzLU9gzrKeln2K9VLyI10ch7vyiASBTYEODAN6xnVOWyQX40awK/P43NObHHUlFN3iSbzjKJF7squ154L5dgIpZHTkjMFJW9R6bAI0gL3j2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767516; c=relaxed/simple;
	bh=UCustgtecwlBM6ztXEcDA3DNfiRgPGhRlNblePFRA8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2x/6w7vltvsTVgxjz7fOqLvC7qJwBm2D1duJ5VAllq8pa9Avs8P3fH2j9uuK7haU5AaBKYIO/4g2XZVBw2I+DsrEnidtjGhRj6RNoPi9UBNwn1ezPM5EyxKXKHfS8jA4KC9pM9fyBtvXbTZ15MguC2ti9oYY91H65VXbkLJ038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIqqsOPr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so474335ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759767513; x=1760372313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU0TtrguK7qk4A0QfKZeTDhq/oEex6e4b8DUTkSJDr4=;
        b=RIqqsOPrB6yY3YdruKckPTXXIEeQVrETNi+0eVEvLJiAxGJJN25Z1H5VbhsWhtQ4EW
         1fAZ6JberLYWphXdqrvDmDb4iGiv9PB+vCfWSsGLO3EBdIx+9d1bM/5mmYvBzbnyCRYs
         TtZGTgvO/w6e0tRxn/DNC0EotcO9bPJnlMPo2mxDpiSDJc4EW9MgbswsMq41WTtbNNJO
         Mpj6T407rIF9YasdiONAqlszwkK6U8akK7ThybvckoyPK8y8SZV65dqLRzr+/p0/V6KT
         JZN3cMwj3Ab5bUtI4CKhiiccIB7mmEAXQHuwD298xBU0g843s5jdMd4wOroHvfCHEtwd
         S9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767513; x=1760372313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU0TtrguK7qk4A0QfKZeTDhq/oEex6e4b8DUTkSJDr4=;
        b=v/Pqz+dOdeJWwCd6IQ704tQCururaKsWwBhwYrdLk2qwME8kxpoRz9u51SmUKlDxTg
         W16fO9nNhpibrGVs14ZnW+AgWmRU9BGoTQm8Jl0CF+ImNtwB0wduEcCNES3J9I3u8Fk8
         6gxRRvugt2lNJ5wLGrpG4wYaS4c41/26zIPqO40lPAI1p4B+DFpCNfPZoazCUjLsuz8G
         6ienq5sK4hjFaL1o/5UYVJ+NbTcaw2duJFF6Bg1UZxyezCGzEynYGeEBuAw4q1UT9Yr4
         egjvlsOQRoVY7hxHWz732opFZITo6KsMxza+xUJiQr6fi0mM39Y0jMR8ecQE8DnICEu2
         0RIA==
X-Gm-Message-State: AOJu0YyoLx6FSopMzcoHJpyyJ5mwLV3weGtzB+D4dCxSP1FSbKyLYLCr
	Ckt+B5T8sqfsGsUdZYr3ROFJpQN3LbFBkiycXmw8tq/58ePCq4BaUHto39MC71hwgP8dvYZ65J9
	yhDdFnIs3Py7OpO8jwZFJ7vt5j2cXIQfqOUHgbDPQ
X-Gm-Gg: ASbGncskGqi6VxFi6cd1We7YPOcfKuxeMDO6oNBJ7Axukm+ol6vRHs7lvKwRv9KsvDL
	yju43sV1aNQ4OtDHE8o3s3tpO+Vk911ZWpn/N8gLqAMpTn9KdL2gFexzyJaUtikTpwiKfCV98Py
	6GImkXMjETvoRofkRZY4pF7A5qR9wpZvJ9Zr9WPdMwqpYM5++uY5lxWkxTBpkJdh2VO0DQfcSFW
	GMfE2kW3Dmt1bs5f2NWcSVNweI5Rd36PY9fIaB2B52PA2nBiHV/dQkOMPQDUp36JBQIar2D+cMs
	P70=
X-Google-Smtp-Source: AGHT+IFh7FR1cqOA0BL2c4ebW6PsrAWsAq/qT+J6YRO2XmDX0dV6b1csiJGP+whB+SIlqKH5Jf+OIZEhYM8Cw2+s8WQ=
X-Received: by 2002:a17:902:ebd2:b0:274:506d:7fea with SMTP id
 d9443c01a7336-28eabe75c15mr5405225ad.5.1759767513116; Mon, 06 Oct 2025
 09:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001181229.1010340-1-irogers@google.com> <20251001181229.1010340-2-irogers@google.com>
In-Reply-To: <20251001181229.1010340-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 09:18:22 -0700
X-Gm-Features: AS18NWB6SllOYuhP7SJZEuNqp_-G3MWb6oWLLffENpykCOYe6rvFtj_-k9a6qMI
Message-ID: <CAP-5=fVHetc8DqdqxURJm_VtaH6apJKoyVOSpfQrE2ntkEa+4g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing hybrid
To: Thomas Falcon <thomas.falcon@intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Howard Chu <howardchu95@gmail.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:12=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Don't open evsels on all CPUs, open them just on the CPUs they
> support. This avoids opening say an e-core event on a p-core and
> getting a failure - achieve this by getting rid of the "all_cpu_map".
>
> In install_pe functions don't use the cpu_map_idx as a CPU number,
> translate the cpu_map_idx, which is a dense index into the cpu_map
> skipping holes at the beginning, to a proper CPU number.
>
> Before:
> ```
> $ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>    <not supported>      cpu_atom/cycles/
>        566,270,672      cpu_core/cycles/
>    <not supported>      cpu_atom/instructions/
>        572,792,836      cpu_core/instructions/           #    1.01  insn =
per cycle
>
>        1.001595384 seconds time elapsed
> ```
>
> After:
> ```
> $ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>        443,299,201      cpu_atom/cycles/
>      1,233,919,737      cpu_core/cycles/
>        213,634,112      cpu_atom/instructions/           #    0.48  insn =
per cycle
>      2,758,965,527      cpu_core/instructions/           #    2.24  insn =
per cycle
>
>        1.001699485 seconds time elapsed
> ```
>
> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs=
 with BPF")
> Signed-off-by: Ian Rogers <irogers@google.com>

+Thomas Falcon

I think it'd be nice to get this quite major fix for
--bpf-counters/bperf for hybrid architectures into v6.18 and stable
builds. Thomas would it be possible for you to give a Tested-by tag
using the reproduction in the commit message?

Thanks,
Ian

> ---
>  tools/perf/util/bpf_counter.c        | 26 ++++++++++----------------
>  tools/perf/util/bpf_counter_cgroup.c |  3 ++-
>  2 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.=
c
> index 1c6cb5ea077e..ca5d01b9017d 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -336,6 +336,7 @@ static int bpf_program_profiler__install_pe(struct ev=
sel *evsel, int cpu_map_idx
>  {
>         struct bpf_prog_profiler_bpf *skel;
>         struct bpf_counter *counter;
> +       int cpu =3D perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
>         int ret;
>
>         list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> @@ -343,7 +344,7 @@ static int bpf_program_profiler__install_pe(struct ev=
sel *evsel, int cpu_map_idx
>                 assert(skel !=3D NULL);
>
>                 ret =3D bpf_map_update_elem(bpf_map__fd(skel->maps.events=
),
> -                                         &cpu_map_idx, &fd, BPF_ANY);
> +                                         &cpu, &fd, BPF_ANY);
>                 if (ret)
>                         return ret;
>         }
> @@ -451,7 +452,6 @@ static int bperf_check_target(struct evsel *evsel,
>         return 0;
>  }
>
> -static struct perf_cpu_map *all_cpu_map;
>  static __u32 filter_entry_cnt;
>
>  static int bperf_reload_leader_program(struct evsel *evsel, int attr_map=
_fd,
> @@ -495,7 +495,7 @@ static int bperf_reload_leader_program(struct evsel *=
evsel, int attr_map_fd,
>          * following evsel__open_per_cpu call
>          */
>         evsel->leader_skel =3D skel;
> -       evsel__open_per_cpu(evsel, all_cpu_map, -1);
> +       evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
>
>  out:
>         bperf_leader_bpf__destroy(skel);
> @@ -533,12 +533,6 @@ static int bperf__load(struct evsel *evsel, struct t=
arget *target)
>         if (bperf_check_target(evsel, target, &filter_type, &filter_entry=
_cnt))
>                 return -1;
>
> -       if (!all_cpu_map) {
> -               all_cpu_map =3D perf_cpu_map__new_online_cpus();
> -               if (!all_cpu_map)
> -                       return -1;
> -       }
> -
>         evsel->bperf_leader_prog_fd =3D -1;
>         evsel->bperf_leader_link_fd =3D -1;
>
> @@ -656,9 +650,10 @@ static int bperf__load(struct evsel *evsel, struct t=
arget *target)
>  static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int f=
d)
>  {
>         struct bperf_leader_bpf *skel =3D evsel->leader_skel;
> +       int cpu =3D perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
>
>         return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> -                                  &cpu_map_idx, &fd, BPF_ANY);
> +                                  &cpu, &fd, BPF_ANY);
>  }
>
>  /*
> @@ -667,13 +662,12 @@ static int bperf__install_pe(struct evsel *evsel, i=
nt cpu_map_idx, int fd)
>   */
>  static int bperf_sync_counters(struct evsel *evsel)
>  {
> -       int num_cpu, i, cpu;
> +       struct perf_cpu cpu;
> +       int idx;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus)
> +               bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu.cp=
u);
>
> -       num_cpu =3D perf_cpu_map__nr(all_cpu_map);
> -       for (i =3D 0; i < num_cpu; i++) {
> -               cpu =3D perf_cpu_map__cpu(all_cpu_map, i).cpu;
> -               bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
> -       }
>         return 0;
>  }
>
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_c=
ounter_cgroup.c
> index ed6a29b106b4..690be3ce3e11 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -186,7 +186,8 @@ static int bperf_cgrp__load(struct evsel *evsel,
>  }
>
>  static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
> -                                 int cpu __maybe_unused, int fd __maybe_=
unused)
> +                                 int cpu_map_idx __maybe_unused,
> +                                 int fd __maybe_unused)
>  {
>         /* nothing to do */
>         return 0;
> --
> 2.51.0.618.g983fd99d29-goog
>

