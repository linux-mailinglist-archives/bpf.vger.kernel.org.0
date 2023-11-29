Return-Path: <bpf+bounces-16118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C67FCEB0
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552781C210C6
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82991E577;
	Wed, 29 Nov 2023 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8F3/jBS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C901BCF
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d032ab478fso47665247b3.0
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237749; x=1701842549; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKpplEK/d17CHcbqAj9G9D9QvSt6Rl/kdbFVrBTbVJE=;
        b=r8F3/jBSyyKMVrpC9Hj8PeyFnViEY4aP9iji/6hoW8nwhIQ2Y5C+IygZ3PS3AsmkXp
         UJ+YGJ+HYj3zd4bF9BNnW4PVCqdQfZgbm2iP3HngZR5Fk5AagGgCvOmmhR/uU4/g8uRR
         Pp647zAa4QbJ0uB7CPO6cn0EsqAykWQn+H98jGOQp6qzU5zo+aXYA1k31BkGPvPviYBb
         Gr5LvP46omEIi1m97hCtcpjXoRnwRKsX3R8dfYU+fEHcei1rFx+jQdwBOpJwIogD2sI4
         sJ561UJus7eNwWlSwCpjPEezoLYxhBkreEWTHVVjpLK8jODMfQ94TJ+zz3n2XMfRGgpg
         ZpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237749; x=1701842549;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKpplEK/d17CHcbqAj9G9D9QvSt6Rl/kdbFVrBTbVJE=;
        b=LoCzHN7wjvQDtNnhBQolNpdlEU7PUahu/DwfXXAo1NY0mcsUhR7JObgnxyrAzsKxu8
         h3SEdMFT4JdF2dbj3Hp2f+2YhYw9KaXuuEY8SBihAvvrvw63ba6SF9+Duz5X8KiXrPkX
         dw117oNBP2TcHcQGdhPCEGIIBvoAevvgrsG5kq8aGDR4ALYEq0N0uBPiD7kt8+xEC7RT
         iOU3aAyi26IA/4Hw7AuEx4W/t0wnYa5Uljo5RsmOn/Je43oFNEjYa/tEE8fzYjA35T9Y
         Vje2bMYXfh+Uxn41TqqydHHijjnuWCIsUGrxeA3z4Notqj/ITJuuFhALMJxSm0VkMeyq
         Ac3A==
X-Gm-Message-State: AOJu0YxVn2vZap8w6UwrjmAj/O7i0EDPM8o7RGz9nXoGkLk+3Q4lyAQz
	EfcQOSb5P9WaBrItjnGVaetVM9XM0rkU
X-Google-Smtp-Source: AGHT+IEN+gAwFsf4MSRmBYmw9rtmwPFX3A/a9Ww3oOkFZ/AmBgDB+5vxiQ7AVxAvJsCiACy2MQaf8zl4pEkT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:fd3:b0:5cc:41c1:606 with SMTP id
 dg19-20020a05690c0fd300b005cc41c10606mr691036ywb.6.1701237749390; Tue, 28 Nov
 2023 22:02:29 -0800 (PST)
Date: Tue, 28 Nov 2023 22:02:03 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 06/14] libperf cpumap: Add any, empty and min helpers
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

Additional helpers to better replace
perf_cpu_map__has_any_cpu_or_is_empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 27 +++++++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h | 16 ++++++++++++++++
 tools/lib/perf/libperf.map           |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 49fc98e16514..7403819da8fd 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -316,6 +316,19 @@ bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
 	return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
 }
 
+bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
+{
+	if (!map)
+		return true;
+
+	return __perf_cpu_map__nr(map) == 1 && __perf_cpu_map__cpu(map, 0).cpu == -1;
+}
+
+bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
+{
+	return map == NULL;
+}
+
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 {
 	int low, high;
@@ -372,6 +385,20 @@ bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
 	return map && __perf_cpu_map__cpu(map, 0).cpu == -1;
 }
 
+struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
+{
+	struct perf_cpu cpu, result = {
+		.cpu = -1
+	};
+	int idx;
+
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
+		result = cpu;
+		break;
+	}
+	return result;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index dbe0a7352b64..523e4348fc96 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -50,6 +50,22 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
  * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
  */
 LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__is_any_cpu_or_is_empty - is map either empty or the "any CPU"/dummy value.
+ */
+LIBPERF_API bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__is_empty - does the map contain no values and it doesn't
+ *                          contain the special "any CPU"/dummy value.
+ */
+LIBPERF_API bool perf_cpu_map__is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__min - the minimum CPU value or -1 if empty or just the "any CPU"/dummy value.
+ */
+LIBPERF_API struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__max - the maximum CPU value or -1 if empty or just the "any CPU"/dummy value.
+ */
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 10b3f3722642..2aa79b696032 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -10,6 +10,10 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__has_any_cpu_or_is_empty;
+		perf_cpu_map__is_any_cpu_or_is_empty;
+		perf_cpu_map__is_empty;
+		perf_cpu_map__has_any_cpu;
+		perf_cpu_map__min;
 		perf_cpu_map__max;
 		perf_cpu_map__has;
 		perf_thread_map__new_array;
-- 
2.43.0.rc1.413.gea7ed67945-goog


