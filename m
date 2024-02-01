Return-Path: <bpf+bounces-20904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A0845031
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1F21F22959
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED43BB43;
	Thu,  1 Feb 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enEd3XZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64B3B199
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761371; cv=none; b=mV15Fdt08JZfaNFyOlrLL8Mz52k/CqlR+LYnoa64bV7GTyI1pLmZHHr+0a4GSp1Wqkvzj/lqhGqN7liZclO0BNS8r3Ojyii4OPCAZ9Cgw/t3hUtBdPckLXZHTwUUv6TqI9Di3xR/hPHmp/wuD7dhMDWX6kQmZkc6V/WD9D+wA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761371; c=relaxed/simple;
	bh=6TkGB5DEMxk29IoHd6iWubxchoiv7soE0QNIxx4qk8E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tQyVZb2xSvbIN3PPUlZcdIOtYPZOWcd0J6CrShXjaBRNKawNLlL5TFEWxEu3PDuZCvvXMQOdMROedFJMq0r0TgDGqJ0chO82+VQ5D8vHjG8mr7ADTIEToRkAngQ6jdJ/Tj2dO/AUVC5hTlOo7Xe97CwHoBCbiT8+PhoS8UKYWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enEd3XZY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040aaa4e79so8794657b3.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761368; x=1707366168; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m0WlzH05D9HaEJ5XU0c1LIE+ZN2b2kci6XhDjYk8zIo=;
        b=enEd3XZYkaFuRppd8TnmXUghY1TPG4OqtVUIaHfknMiM6UXp1mT8fISFoD2DBUIxLO
         KXmtJjwvTm38QIIeot2Zc5izC7i8KdYcReSQ2HFGhTtxkT7dS0f0toHLtpxvjRzioRk2
         IaWcbN1F2v2bsgOCOS1noc+fReuwovqyhej0+aVjE/kTx7VajHwqLjn0L8AklPWzzfc2
         Eb6auxYSVqObCIyhSfsI37M19MUmD+MkyR9y6UCJZ9Khe9/Sb126r8MHrAVQHwwhSj63
         nfd9nF4mKSJwezefZNMqJazYLrHMRgVU7Z0/HKR4YGHgSXPSnVK0E42gdbiiqzaH6BO8
         V5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761368; x=1707366168;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0WlzH05D9HaEJ5XU0c1LIE+ZN2b2kci6XhDjYk8zIo=;
        b=aX43L+8y6lz/cw9zlWggQ+DAJsli/blmtjGVdW8WrVLxCJ6VyHbbOg9kwotDzdsoRN
         roz2ybZGihJGfh+dqG5NUdRkL5JXvxqaBOgtyxf5icoCDnW4NHcNzNlrtf6sjbJL1vUU
         1w0cF+YpTGWt96ZNUMFuQ6+XJr41pLp9AVEvuBem8bMCYEwen7Yah3bCccCMgwxGweeP
         oMrHgNdS+CkF0VZpQjvoVoE59o4qV+9SCSbHj5JkpDskFQm8sIqVrawC8Fir+BHZWZB/
         Vnacg6NEnNa7+yWG6uE0zyME/p7N7eEpl0LkujjvBQd5z0b4DlUYwVRutbyRZzeSpR4z
         XNBQ==
X-Gm-Message-State: AOJu0YxJmK+yETerlJxg5zhTDZuHg+pz4WLlDmUcxw7ymU5v2oRsxhGJ
	qXRCY/TCO66ixiRsXfXqMJELXtJ3DbSOQD9IJylEJu0Uqmjyq07HDVq4InBAXULX0lm2wZOu4YL
	MR4Sw9A==
X-Google-Smtp-Source: AGHT+IGQgcTYw1K+FmbJAzUR4XeFVo5wWmx8EVJsduZhl4fdoIB+cbLQS2aaHpH8Tiq6d5CO/xNU9EN7lzK6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:6902:161e:b0:dc2:2ace:860 with SMTP id
 bw30-20020a056902161e00b00dc22ace0860mr143929ybb.2.1706761368685; Wed, 31 Jan
 2024 20:22:48 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:28 -0800
Message-Id: <20240201042236.1538928-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 0/8] Clean up libperf cpumap's empty function
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

v2: 6 patches were merged by Arnaldo. New patch added ensure empty
    maps are allocated as NULL (suggested by James Clark). Hopefully a
    fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".

Ian Rogers (8):
  libperf cpumap: Add any, empty and min helpers
  libperf cpumap: Ensure empty cpumap is NULL from alloc
  perf arm-spe/cs-etm: Directly iterate CPU maps
  perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
    use
  perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
  perf arm64 header: Remove unnecessary CPU map get and put
  perf stat: Remove duplicate cpus_map_matched function
  perf cpumap: Use perf_cpu_map__for_each_cpu when possible

 tools/lib/perf/cpumap.c                       | 33 +++++++-
 tools/lib/perf/include/perf/cpumap.h          | 16 ++++
 tools/lib/perf/libperf.map                    |  4 +
 tools/perf/arch/arm/util/cs-etm.c             | 77 ++++++++-----------
 tools/perf/arch/arm64/util/arm-spe.c          |  4 +-
 tools/perf/arch/arm64/util/header.c           | 13 +---
 tools/perf/arch/x86/util/intel-bts.c          |  4 +-
 tools/perf/arch/x86/util/intel-pt.c           | 10 +--
 tools/perf/builtin-c2c.c                      |  6 +-
 tools/perf/builtin-stat.c                     | 31 ++------
 tools/perf/tests/bitmap.c                     | 13 ++--
 tools/perf/tests/topology.c                   | 46 +++++------
 tools/perf/util/auxtrace.c                    |  4 +-
 tools/perf/util/bpf_kwork.c                   | 16 ++--
 tools/perf/util/bpf_kwork_top.c               | 12 +--
 tools/perf/util/cpumap.c                      | 12 ++-
 tools/perf/util/record.c                      |  2 +-
 .../scripting-engines/trace-event-python.c    | 12 +--
 tools/perf/util/session.c                     |  5 +-
 tools/perf/util/stat.c                        |  2 +-
 tools/perf/util/svghelper.c                   | 20 +++--
 21 files changed, 175 insertions(+), 167 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


