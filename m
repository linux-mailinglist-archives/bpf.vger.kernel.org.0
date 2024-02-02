Return-Path: <bpf+bounces-21108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50671847D41
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FC11F291D1
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A9512D752;
	Fri,  2 Feb 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RelY/ddO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60C12C801
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917273; cv=none; b=WenfA6DaiLhN+UOw4puIb9v32nacSHvh5OB3adRVxjnMVNku5zXq5MbSCc715wyGmzuA7rlr1OA38OmbYZqVLVPo3Qbj41rg3aUjjAOXrcmoQX9ZK9LAzoWBMrHAq8AiLnxYYEzSUG53EK1v8NV+R56o5oFp0D3ZrBqcUjgSUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917273; c=relaxed/simple;
	bh=MMnuh1Oc8aQIK4NgPRT+2TknlqEUkEHoJeYCwVzCcjI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=lHm1enk+ZVuEVSqbfQ/vdWX+Hia7ax9btfUrzrPrmXG0sFIPXSxb17gjPVD1pfGxNj0EwNDE8GzIwrmp6ddCpyMMZ0MtsB5eIZtfLZ8fczh8xqPm7w64AlxBUdCj/DHqeLGwBrTl/1SHOCW7E4pwGa/Ri5/g0PUdtml3huouCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RelY/ddO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6bad01539so3525957276.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917269; x=1707522069; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGn7q3AR6sBJnuW0w7X+aFdd8u9EK+5apJ+BcUW3hYQ=;
        b=RelY/ddOhKc1+BmeSxPyTBj+bqIGPOtpzXzfuW+1LK++0ycq4is/vC5KhNDldKi4SW
         MBNk7bzIv1GsR8vj/a0/k5IrQLl7nK5BkgnkbwEx7lI4jVtJWiPC70uj0A1LFsS+TThm
         tUd43kdOtxmYGLDldWDKqwu5vROtwM/T+gBik3pyPaLvOZLWoOc0JNaWA7RiXY8EZndY
         lUyxTR5aLOYgq5JPmD+INa/VVA508/0wB1mwl83WiO5IVddC+wPJNOeWnTrehfEj8ktl
         jp9xAp8/btUWmk09/vn1nso/03+LIrM6CSX6gvhqwNzkTftuN+WMZGw1g5I4dEbgAAHd
         gkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917269; x=1707522069;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGn7q3AR6sBJnuW0w7X+aFdd8u9EK+5apJ+BcUW3hYQ=;
        b=aCrs6V8Apq44r3SZgw/Xrs54A8evu+jYbDL/+OUC4FqleYPpiIg7QH4brwnjeOlW9u
         OeedqSdB+1FtvRv291ZTX/QF36ORt3/u/YQJNyiXCF4sE62ddaFC5BzZeYbb5VvoP6vV
         Bz4uKG6Yx3VI/AkOpVFpRDchMn861FHY5Y2uvM5qe2dckgg6N1r03gsAzVjMYOgOd/9O
         dMLgWrdt2Hv2InOz6YiiMmySOHTKDLoWACsS3pOa/nO3c1o3oB4cRV2PaDu0PavXvIzJ
         g5gKMpUjyZGjRFuC4TIRV/+KKpQdpnKfzfTSoDCFgiPAYPCeTcHBV/XK8Kg7yBDYIDB3
         rAdw==
X-Gm-Message-State: AOJu0Yxa4OL41mP97sGxcf5I3Jyzqvuj5BJ18outXHnDtki3bhpIxFkk
	dO5a6Dx14swEWhZPrxOr4Fq05AWoWaqSEzRpdmudNQW3V/U4yduj3pUJqHJz3pavyEd6mrxDB6e
	9GBGfvw==
X-Google-Smtp-Source: AGHT+IHylMNHjoaYXoYqqOOZFoFT4X3A3hWj7pDcXfX2BSwpZDbVFcOqv6wqndJbEhdaoK213X6R34ETA+tx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b0d:b0:dc6:ee66:da6b with SMTP
 id eh13-20020a0569021b0d00b00dc6ee66da6bmr100341ybb.7.1706917269595; Fri, 02
 Feb 2024 15:41:09 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:49 -0800
Message-Id: <20240202234057.2085863-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 0/8] Clean up libperf cpumap's empty function
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

v3: Address handling of "any" is arm-spe/cs-etm patch.
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

 tools/lib/perf/cpumap.c                       |  33 ++++-
 tools/lib/perf/include/perf/cpumap.h          |  16 +++
 tools/lib/perf/libperf.map                    |   4 +
 tools/perf/arch/arm/util/cs-etm.c             | 114 ++++++++----------
 tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
 tools/perf/arch/arm64/util/header.c           |  13 +-
 tools/perf/arch/x86/util/intel-bts.c          |   4 +-
 tools/perf/arch/x86/util/intel-pt.c           |  10 +-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-stat.c                     |  31 +----
 tools/perf/tests/bitmap.c                     |  13 +-
 tools/perf/tests/topology.c                   |  46 +++----
 tools/perf/util/auxtrace.c                    |   4 +-
 tools/perf/util/bpf_kwork.c                   |  16 +--
 tools/perf/util/bpf_kwork_top.c               |  12 +-
 tools/perf/util/cpumap.c                      |  12 +-
 tools/perf/util/record.c                      |   2 +-
 .../scripting-engines/trace-event-python.c    |  12 +-
 tools/perf/util/session.c                     |   5 +-
 tools/perf/util/stat.c                        |   2 +-
 tools/perf/util/svghelper.c                   |  20 ++-
 21 files changed, 192 insertions(+), 187 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


