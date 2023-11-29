Return-Path: <bpf+bounces-16113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C25747FCEA6
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C957E1C20932
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F15D26B;
	Wed, 29 Nov 2023 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kX7c6gCv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234DF19B1
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cdde93973aso83917367b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237737; x=1701842537; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6thajjQRkz+HkHW7D3sSCmpzEeB477d5Mr+y0iQJVzs=;
        b=kX7c6gCvFHw5an55jNpK+MCu0n06UnFZxpirz/t1R5a+0/qU6FHchFYK0P3WAbTCNe
         7jCpy0TUz3XvRTvuxNSDzEe6NHfQvoroF07Bf2C49yGQuXLSvgmYoLKq0qeXUYC3cEgD
         niQMAV1yT7yxf9enxT5SYiFJwaJx8O81E1dJfadtGep4iH6fMzCC5zfduJBLOH0te26/
         eqiqV62q0rHdJj3IQCVbYLlhxcO3Sl5b2kChwLyJx9Cyd79ycy6KwxoMbH27JBFNvY9T
         3M4kxZX/x2AHpOHW3yYE1ehG4/zjlra1zTcMRZlrBaTbzPUPC/lOJ6BXBcpdvkZkmCR5
         GYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237737; x=1701842537;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6thajjQRkz+HkHW7D3sSCmpzEeB477d5Mr+y0iQJVzs=;
        b=W2ZIecAC0uPxQgW0b19q7FwDs8GdP21c+5QRaDFII09anUFhqY8k/38Ga4/XZVbQxb
         sLumlVN+srXakES1wG9/KXobkZs6McL3apA6hjRQdmWP98IPeKFc9AK060y07IXJKuzg
         XjYrRN2He0yPOytJYMU6tgl4o9tROAfPWwXSCMwVSE4BxY3W543Fr/z4vkji4DDfOr/o
         uEAwRsE75/EfCHdM1JdgNl4mxStE7HgnUt/bcIm1hQ08I3Gsx43f70Gq4hab4Fnd0Dd/
         8HcRMKPD7alATV7j0lNeC745kfbdNSqQNWrwDVEC6iNMFjkDgM/7NyjabVYLHtZmfta5
         Jy+Q==
X-Gm-Message-State: AOJu0Yxq81WPTyU/9bh1T8EUDdDB5Ubms0WftNeZHjgGRyjcdZ7T/EUo
	fJd1Wu95WYnVl1123ocaCakIqKTDdqQZ
X-Google-Smtp-Source: AGHT+IHStCf02eR5Z7G2oMb+qjaqd+bye5wyKkPORIP+SdC4EPzelKmD6TjLiarOMrn6W9b9mIBoWBllGFGX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e8a:b0:5ce:dff:f7a1 with SMTP id
 eu10-20020a05690c2e8a00b005ce0dfff7a1mr482531ywb.9.1701237737183; Tue, 28 Nov
 2023 22:02:17 -0800 (PST)
Date: Tue, 28 Nov 2023 22:01:58 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 01/14] libperf cpumap: Rename perf_cpu_map__dummy_new
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

Rename perf_cpu_map__dummy_new to perf_cpu_map__new_any_cpu to better
indicate this is creating a CPU map for the perf_event_open "any" CPU
case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt | 2 +-
 tools/lib/perf/cpumap.c                  | 4 ++--
 tools/lib/perf/evsel.c                   | 2 +-
 tools/lib/perf/include/perf/cpumap.h     | 4 ++--
 tools/lib/perf/libperf.map               | 2 +-
 tools/lib/perf/tests/test-cpumap.c       | 2 +-
 tools/lib/perf/tests/test-evlist.c       | 2 +-
 tools/perf/tests/cpumap.c                | 2 +-
 tools/perf/tests/sw-clock.c              | 2 +-
 tools/perf/tests/task-exit.c             | 2 +-
 tools/perf/util/evlist.c                 | 2 +-
 tools/perf/util/evsel.c                  | 2 +-
 12 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index a8f1a237931b..a256a26598b0 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -37,7 +37,7 @@ SYNOPSIS
 
   struct perf_cpu_map;
 
-  struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+  struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
   struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
   struct perf_cpu_map *perf_cpu_map__read(FILE *file);
   struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 2a5a29217374..2bd6aba3d8c9 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -27,7 +27,7 @@ struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 	return result;
 }
 
-struct perf_cpu_map *perf_cpu_map__dummy_new(void)
+struct perf_cpu_map *perf_cpu_map__new_any_cpu(void)
 {
 	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
 
@@ -271,7 +271,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
 	else
-		cpus = perf_cpu_map__dummy_new();
+		cpus = perf_cpu_map__new_any_cpu();
 invalid:
 	free(tmp_cpus);
 out:
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8b51b008a81f..c07160953224 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -120,7 +120,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		static struct perf_cpu_map *empty_cpu_map;
 
 		if (empty_cpu_map == NULL) {
-			empty_cpu_map = perf_cpu_map__dummy_new();
+			empty_cpu_map = perf_cpu_map__new_any_cpu();
 			if (empty_cpu_map == NULL)
 				return -ENOMEM;
 		}
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index e38d859a384d..d0bf218ada11 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -19,9 +19,9 @@ struct perf_cache {
 struct perf_cpu_map;
 
 /**
- * perf_cpu_map__dummy_new - a map with a singular "any CPU"/dummy -1 value.
+ * perf_cpu_map__new_any_cpu - a map with a singular "any CPU"/dummy -1 value.
  */
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 190b56ae923a..a8ff64baea3e 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -1,7 +1,7 @@
 LIBPERF_0.0.1 {
 	global:
 		libperf_init;
-		perf_cpu_map__dummy_new;
+		perf_cpu_map__new_any_cpu;
 		perf_cpu_map__default_new;
 		perf_cpu_map__get;
 		perf_cpu_map__put;
diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
index 87b0510a556f..2c359bdb951e 100644
--- a/tools/lib/perf/tests/test-cpumap.c
+++ b/tools/lib/perf/tests/test-cpumap.c
@@ -21,7 +21,7 @@ int test_cpumap(int argc, char **argv)
 
 	libperf_init(libperf_print);
 
-	cpus = perf_cpu_map__dummy_new();
+	cpus = perf_cpu_map__new_any_cpu();
 	if (!cpus)
 		return -1;
 
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index ed616fc19b4f..ab63878bacb9 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -261,7 +261,7 @@ static int test_mmap_thread(void)
 	threads = perf_thread_map__new_dummy();
 	__T("failed to create threads", threads);
 
-	cpus = perf_cpu_map__dummy_new();
+	cpus = perf_cpu_map__new_any_cpu();
 	__T("failed to create cpus", cpus);
 
 	perf_thread_map__set_pid(threads, 0, pid);
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 7730fc2ab40b..bd8e396f3e57 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -213,7 +213,7 @@ static int test__cpu_map_intersect(struct test_suite *test __maybe_unused,
 
 static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_cpu_map *any = perf_cpu_map__dummy_new();
+	struct perf_cpu_map *any = perf_cpu_map__new_any_cpu();
 	struct perf_cpu_map *one = perf_cpu_map__new("1");
 	struct perf_cpu_map *two = perf_cpu_map__new("2");
 	struct perf_cpu_map *empty = perf_cpu_map__intersect(one, two);
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 4d7493fa0105..290716783ac6 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -62,7 +62,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	}
 	evlist__add(evlist, evsel);
 
-	cpus = perf_cpu_map__dummy_new();
+	cpus = perf_cpu_map__new_any_cpu();
 	threads = thread_map__new_by_tid(getpid());
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 968dddde6dda..d33d0952025c 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -70,7 +70,7 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	 * evlist__prepare_workload we'll fill in the only thread
 	 * we're monitoring, the one forked there.
 	 */
-	cpus = perf_cpu_map__dummy_new();
+	cpus = perf_cpu_map__new_any_cpu();
 	threads = thread_map__new_by_tid(-1);
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e36da58522ef..ff7f85ded89d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1056,7 +1056,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 		return -1;
 
 	if (target__uses_dummy_map(target))
-		cpus = perf_cpu_map__dummy_new();
+		cpus = perf_cpu_map__new_any_cpu();
 	else
 		cpus = perf_cpu_map__new(target->cpu_list);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a5da74e3a517..76ef3ab488a2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1801,7 +1801,7 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	if (cpus == NULL) {
 		if (empty_cpu_map == NULL) {
-			empty_cpu_map = perf_cpu_map__dummy_new();
+			empty_cpu_map = perf_cpu_map__new_any_cpu();
 			if (empty_cpu_map == NULL)
 				return -ENOMEM;
 		}
-- 
2.43.0.rc1.413.gea7ed67945-goog


