Return-Path: <bpf+bounces-17437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E280DAED
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3229281FC6
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DE52F86;
	Mon, 11 Dec 2023 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1GmjbJK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B8F1
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:31:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so547e87.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702323074; x=1702927874; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sgNxcjw7P+8fi9zVgDXmPIjagPVi6zMUykPuiY0M04=;
        b=j1GmjbJKhtP+V5tbyQmKzAPpJyEncVLe6FXOZ47pDA1fSMzOTQb4QLAbIORjZdL2ir
         HnBoQit68W92921RlR9nsaSMSML6n0mNWW4tidGejYxjjkNredL7DzUkveIXTUkRtxsg
         inlBgBugaBlfaBVTKVKcBiUBjKEHFIJCztoSFsmfFNw8evJzlNO6Qy+5Hr8/htFw5Fux
         VROBRrp0QpBT89gTELvFND5lVLhTxETZImUvTN4oELUA/xioIpGAX2V2vfhDwcEbnrVS
         b75vseWCABt01hMpzAsGkI6PCaGn6mAIRlLdqNUYq3/o8l/XgMb6yx35rjaX7OYnppzH
         QV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323074; x=1702927874;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sgNxcjw7P+8fi9zVgDXmPIjagPVi6zMUykPuiY0M04=;
        b=bkaMsvP0yDckLlPBmG10TplUykSHuMC7sWQ7/o6hKBR0WHDYvDPt6Cq9GP6rgJmU5Y
         eJU8suI1HWHaubh52XSQJicPRm46QOhRkt6bLBl44k2ybjWSGXn2PSuaZVTr0a+dokgF
         yeW5gGNyGYmvuTETXmY5GiSOYSzAq0XHULTm2oJ52JjpAir4A3NTJuwyal3wuKtrk+uK
         icI/Ay04tfZgb9Ox022aOq5MPWUCZN5Q646+u3h1MhAHjc27BPf27XGgrMcr+rNy8jVK
         5yPogkhKi9MUazBArhT9zx6nQremHmt0Bi3dY1OlUrlpX0BvSPtNDv5E1kT5EJmy1yNk
         Uqnw==
X-Gm-Message-State: AOJu0YwRagF/zQlFcoI1nkjV9Rnm6gwGycGQbHKffSNuJZgOw1ckBYvK
	deSQbnO3EmyHEDuiLQgMRpUm+QqmcIpRMIqB4Nd9/g==
X-Google-Smtp-Source: AGHT+IGHIHVL8mtiiV66WwuL/HKcGNWLy+tFyog9pfoWDplCSqIdLSP0ovOkK7KBJhMzLWlZHlnhsRTh8nXsW6qSfcg=
X-Received: by 2002:a19:5e4e:0:b0:50c:2114:82d6 with SMTP id
 z14-20020a195e4e000000b0050c211482d6mr185962lfi.4.1702323073787; Mon, 11 Dec
 2023 11:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Dec 2023 11:31:02 -0800
Message-ID: <CAP-5=fV=zGDU3N093gFVosnmxLtO9n=hb4vfoZtPn3E3HfLvfw@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Clean up libperf cpumap's empty function
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
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

On Tue, Nov 28, 2023 at 10:02=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Rename and clean up the use of libperf CPU map functions particularly
> focussing on perf_cpu_map__empty that may return true for maps
> containing CPUs but also with an "any CPU"/dummy value.
>
> perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> will yield the "any CPU"/dummy value. Reduce the appearance of some
> calls to this by using the perf_cpu_map__for_each_cpu macro.
>
> Ian Rogers (14):
>   libperf cpumap: Rename perf_cpu_map__dummy_new
>   libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
>   libperf cpumap: Rename perf_cpu_map__empty
>   libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
>   libperf cpumap: Add for_each_cpu that skips the "any CPU" case
>   libperf cpumap: Add any, empty and min helpers
>   perf arm-spe/cs-etm: Directly iterate CPU maps
>   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
>     use
>   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
>   perf top: Avoid repeated function calls
>   perf arm64 header: Remove unnecessary CPU map get and put
>   perf stat: Remove duplicate cpus_map_matched function
>   perf cpumap: Use perf_cpu_map__for_each_cpu when possible
>   libperf cpumap: Document perf_cpu_map__nr's behavior

Ping. Thanks,
Ian

>  .../perf/Documentation/examples/sampling.c    |  2 +-
>  .../perf/Documentation/libperf-sampling.txt   |  2 +-
>  tools/lib/perf/Documentation/libperf.txt      |  4 +-
>  tools/lib/perf/cpumap.c                       | 92 +++++++++++++------
>  tools/lib/perf/evlist.c                       |  6 +-
>  tools/lib/perf/evsel.c                        |  2 +-
>  tools/lib/perf/include/perf/cpumap.h          | 56 ++++++++++-
>  tools/lib/perf/libperf.map                    | 10 +-
>  tools/lib/perf/tests/test-cpumap.c            |  4 +-
>  tools/lib/perf/tests/test-evlist.c            |  6 +-
>  tools/lib/perf/tests/test-evsel.c             |  2 +-
>  tools/perf/arch/arm/util/cs-etm.c             | 83 +++++++----------
>  tools/perf/arch/arm64/util/arm-spe.c          |  4 +-
>  tools/perf/arch/arm64/util/header.c           | 15 +--
>  tools/perf/arch/x86/util/intel-bts.c          |  4 +-
>  tools/perf/arch/x86/util/intel-pt.c           | 10 +-
>  tools/perf/bench/epoll-ctl.c                  |  2 +-
>  tools/perf/bench/epoll-wait.c                 |  2 +-
>  tools/perf/bench/futex-hash.c                 |  2 +-
>  tools/perf/bench/futex-lock-pi.c              |  2 +-
>  tools/perf/bench/futex-requeue.c              |  2 +-
>  tools/perf/bench/futex-wake-parallel.c        |  2 +-
>  tools/perf/bench/futex-wake.c                 |  2 +-
>  tools/perf/builtin-c2c.c                      |  6 +-
>  tools/perf/builtin-ftrace.c                   |  2 +-
>  tools/perf/builtin-record.c                   |  4 +-
>  tools/perf/builtin-stat.c                     | 31 +------
>  tools/perf/tests/bitmap.c                     | 13 +--
>  tools/perf/tests/code-reading.c               |  2 +-
>  tools/perf/tests/cpumap.c                     |  2 +-
>  tools/perf/tests/keep-tracking.c              |  2 +-
>  tools/perf/tests/mmap-basic.c                 |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c    |  2 +-
>  tools/perf/tests/perf-time-to-tsc.c           |  2 +-
>  tools/perf/tests/sw-clock.c                   |  2 +-
>  tools/perf/tests/switch-tracking.c            |  2 +-
>  tools/perf/tests/task-exit.c                  |  2 +-
>  tools/perf/tests/topology.c                   | 48 +++++-----
>  tools/perf/util/auxtrace.c                    |  4 +-
>  tools/perf/util/bpf_counter.c                 |  2 +-
>  tools/perf/util/bpf_kwork.c                   | 16 ++--
>  tools/perf/util/bpf_kwork_top.c               | 12 +--
>  tools/perf/util/cpumap.c                      | 14 ++-
>  tools/perf/util/cputopo.c                     |  2 +-
>  tools/perf/util/evlist.c                      |  4 +-
>  tools/perf/util/evsel.c                       |  2 +-
>  tools/perf/util/perf_api_probe.c              |  4 +-
>  tools/perf/util/record.c                      |  4 +-
>  .../scripting-engines/trace-event-python.c    | 12 ++-
>  tools/perf/util/session.c                     |  5 +-
>  tools/perf/util/stat.c                        |  2 +-
>  tools/perf/util/svghelper.c                   | 20 ++--
>  tools/perf/util/top.c                         |  9 +-
>  53 files changed, 296 insertions(+), 254 deletions(-)
>
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>

