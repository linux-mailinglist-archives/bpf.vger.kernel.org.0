Return-Path: <bpf+bounces-16112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0227FCEA4
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513B3283475
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9479FE;
	Wed, 29 Nov 2023 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F43Cdyei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9129A19A6
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da04fb79246so7699313276.2
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237735; x=1701842535; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0G+iPFdqPEFrwKvYIt+aM1SI2CrgzPYcwp9sXOSF54=;
        b=F43Cdyei04AdOpfSQd3OpAJLSm9xhRahe1O9QqkF0mPs+iLhQVMaGKePv7pinYZ8Tt
         0wvo1siGlfX7V9OTI2E1LDcrKbupla3Oq1lkJ9v3JRvjB/+Z5gDI6OAfI7dgs+FN5cE6
         Hjx4ZL1f7OMt0sQXCWHzs+0jBc4NqNejl8NeWqOYRUlrJOu71IZ0zvvaojVqYF96RQUV
         fBz+l7xylyjOOwEaNhN8igDLxh1OHIortZ8drWSn4OsasC7ouRfbL1ihY0d2nc0kbL9J
         7Qb42/47N4NEToqDAXQRLXwX/AT3ivOJJ6+RvfdawBEMIyP2+qMNC69Fw5BO9I5kQPL9
         yahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237735; x=1701842535;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0G+iPFdqPEFrwKvYIt+aM1SI2CrgzPYcwp9sXOSF54=;
        b=sFPJ2k1OTPdYj/0f4Bks3LLXe79thLpWF6rNPb7sGsOQRUHmzoj5ZgdBa4lrn+geyj
         iYuwpsfwZ/8eM7+xTD8lg6CWKZJdSaj79DcIEqnEX5/52IjCoFF//raRbdKHOQ1fwzCk
         Qh5JXfSNODRYggOhIqy+002V8057exRKaPgL4rznlQHq2Soe4dEXKi3zSbUPCkjzZwtF
         pvjc4/f8PydmjcBCHDbF+rIb/cBu1H1xirBbneGpK1TGsHRzOsvnQ4AjuEUD3brGEFzk
         KdHxuYPW5Ej2NPlFZF3XZ5gMkkOPifcWuTpTUXxIcQh1yq4NlmObH6mzxXmJ+c+mxSjf
         q/9w==
X-Gm-Message-State: AOJu0YxrJetKEluiUc/mstQ6wUGrTQT5UYBj/OzQwvNwTaa6kVUBkf8l
	F/MfBhsEgcdobwGkRn2gX2XYpyTaQKNi
X-Google-Smtp-Source: AGHT+IF0ACoSYZCtsTHrbz5F11NIz13TQ5Pg2yk0VsMy0quHAj1RB3jL2FGMYTv/jpjjrYqF7QXw8dBKFGOB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:d114:0:b0:da3:ab41:304a with SMTP id
 i20-20020a25d114000000b00da3ab41304amr505879ybg.4.1701237734702; Tue, 28 Nov
 2023 22:02:14 -0800 (PST)
Date: Tue, 28 Nov 2023 22:01:57 -0800
Message-Id: <20231129060211.1890454-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 00/14] Clean up libperf cpumap's empty function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename and clean up the use of libperf CPU map functions particularly
focussing on perf_cpu_map__empty that may return true for maps
containing CPUs but also with an "any CPU"/dummy value.

perf_cpu_map__nr is also troubling in that iterating an empty CPU map
will yield the "any CPU"/dummy value. Reduce the appearance of some
calls to this by using the perf_cpu_map__for_each_cpu macro.

Ian Rogers (14):
  libperf cpumap: Rename perf_cpu_map__dummy_new
  libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
  libperf cpumap: Rename perf_cpu_map__empty
  libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
  libperf cpumap: Add for_each_cpu that skips the "any CPU" case
  libperf cpumap: Add any, empty and min helpers
  perf arm-spe/cs-etm: Directly iterate CPU maps
  perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
    use
  perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
  perf top: Avoid repeated function calls
  perf arm64 header: Remove unnecessary CPU map get and put
  perf stat: Remove duplicate cpus_map_matched function
  perf cpumap: Use perf_cpu_map__for_each_cpu when possible
  libperf cpumap: Document perf_cpu_map__nr's behavior

 .../perf/Documentation/examples/sampling.c    |  2 +-
 .../perf/Documentation/libperf-sampling.txt   |  2 +-
 tools/lib/perf/Documentation/libperf.txt      |  4 +-
 tools/lib/perf/cpumap.c                       | 92 +++++++++++++------
 tools/lib/perf/evlist.c                       |  6 +-
 tools/lib/perf/evsel.c                        |  2 +-
 tools/lib/perf/include/perf/cpumap.h          | 56 ++++++++++-
 tools/lib/perf/libperf.map                    | 10 +-
 tools/lib/perf/tests/test-cpumap.c            |  4 +-
 tools/lib/perf/tests/test-evlist.c            |  6 +-
 tools/lib/perf/tests/test-evsel.c             |  2 +-
 tools/perf/arch/arm/util/cs-etm.c             | 83 +++++++----------
 tools/perf/arch/arm64/util/arm-spe.c          |  4 +-
 tools/perf/arch/arm64/util/header.c           | 15 +--
 tools/perf/arch/x86/util/intel-bts.c          |  4 +-
 tools/perf/arch/x86/util/intel-pt.c           | 10 +-
 tools/perf/bench/epoll-ctl.c                  |  2 +-
 tools/perf/bench/epoll-wait.c                 |  2 +-
 tools/perf/bench/futex-hash.c                 |  2 +-
 tools/perf/bench/futex-lock-pi.c              |  2 +-
 tools/perf/bench/futex-requeue.c              |  2 +-
 tools/perf/bench/futex-wake-parallel.c        |  2 +-
 tools/perf/bench/futex-wake.c                 |  2 +-
 tools/perf/builtin-c2c.c                      |  6 +-
 tools/perf/builtin-ftrace.c                   |  2 +-
 tools/perf/builtin-record.c                   |  4 +-
 tools/perf/builtin-stat.c                     | 31 +------
 tools/perf/tests/bitmap.c                     | 13 +--
 tools/perf/tests/code-reading.c               |  2 +-
 tools/perf/tests/cpumap.c                     |  2 +-
 tools/perf/tests/keep-tracking.c              |  2 +-
 tools/perf/tests/mmap-basic.c                 |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  2 +-
 tools/perf/tests/perf-time-to-tsc.c           |  2 +-
 tools/perf/tests/sw-clock.c                   |  2 +-
 tools/perf/tests/switch-tracking.c            |  2 +-
 tools/perf/tests/task-exit.c                  |  2 +-
 tools/perf/tests/topology.c                   | 48 +++++-----
 tools/perf/util/auxtrace.c                    |  4 +-
 tools/perf/util/bpf_counter.c                 |  2 +-
 tools/perf/util/bpf_kwork.c                   | 16 ++--
 tools/perf/util/bpf_kwork_top.c               | 12 +--
 tools/perf/util/cpumap.c                      | 14 ++-
 tools/perf/util/cputopo.c                     |  2 +-
 tools/perf/util/evlist.c                      |  4 +-
 tools/perf/util/evsel.c                       |  2 +-
 tools/perf/util/perf_api_probe.c              |  4 +-
 tools/perf/util/record.c                      |  4 +-
 .../scripting-engines/trace-event-python.c    | 12 ++-
 tools/perf/util/session.c                     |  5 +-
 tools/perf/util/stat.c                        |  2 +-
 tools/perf/util/svghelper.c                   | 20 ++--
 tools/perf/util/top.c                         |  9 +-
 53 files changed, 296 insertions(+), 254 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog


