Return-Path: <bpf+bounces-59674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BDFACE3F3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BC417A6F2
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CA22F76B;
	Wed,  4 Jun 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDEbAm5I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45722F74A
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059179; cv=none; b=snBNz4zzM2O1VvREvmNbZQX8XCEVrL8ZZHeuhdMwAiOOc1DD/wgUwXWMhmvNZzXJT01qdBtlL7p74LobxL2sLsqIqQRDQa7BPoD6sWBPygvoINS3PbrBuVJsBpVG5QvJ69YEMN/5kpFYfk2BI+Gw/QXWWZHKtKqkUHL/0llO5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059179; c=relaxed/simple;
	bh=wZK+we/hMcP+LapTxOBOp7OwL1VcwIn5OCn/9I5QRgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SOaYl+KV8+dp+Pef3eu2VN5MgXKBstc8gv0QNxeA46SuYknSMnDj6mcMBKGZAw2FoHGgT/iJBcwKmniJ75I16QtAr2FigWK+jT0whFf9IXWCR1pxJGW4NiqX3aPl0L2CFz0yvaoFBzlTR6Q+gh8dSFf7tCOoChQcxsUVUPxiLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDEbAm5I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2349fe994a9so501485ad.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059177; x=1749663977; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INWoFAyj0eyA0CoTLK03m3e2rQOzGxqm2qpqJgTA5nM=;
        b=bDEbAm5I2ez2kzCV3snMXewyiTKCclf1SVaYbz5zjEZFVvNwCY6/CIfgUnbM55Yy9l
         ocWhS6pX5dxc6yl6ECT3iHi27jW2ArfghOUPALg+hj6UBj4WJSDZV2XXQ6tbEufVLJVK
         tyZbDR6xPgAn2fib2BRSwTULSv/T8zt96Ya+yudF65IxyKnAYRU0xXBa2YCvtVao/g5t
         AWXuUY9w9AZc+dCjSDbSZJeomqxSXuNTH3zQg+xfPfWVX+zW70NkNMF+LtgC8/VOsuSH
         T5xapQ5588pAr/SWtX93O5ip6o683UkgbA0k9dJ9pDPMy43liGTxSzzG3cDTGN/I3h5E
         4Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059177; x=1749663977;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INWoFAyj0eyA0CoTLK03m3e2rQOzGxqm2qpqJgTA5nM=;
        b=ncF/8KyTqY8xqNPHuEej6hwt32zYL2YEZWvS12Amehqil1UWi8WPA2aCLnWP4ZnKcc
         yffPfU4NxP5vK542yY7pP3FDe7e29A0HHBpWye9fzWq9nnroie54FRzdzGFjpIDY+VsN
         bwCAHH3P0ZWg8qmu4XK/iYeWRSMjkC45Om1FZcYyq7RRiX28SjPIn8sHkKbxRVj7l+sn
         3kNt35cQxV01SWrYRs//zfRSIiLyPng46lmC/DMSGI3LwdnMjwwUoIJLhcIv6xjWh7Ld
         Cz0kJ2OYVeI0Zgk7tOq7FyR0x/iMpLec2I2IGvSr4zpEYNd4lQN34O7ekI1xRxcAzq0F
         WiOg==
X-Forwarded-Encrypted: i=1; AJvYcCUCJoKHtraElLEk5QC6AvOxX08WDbhOOem15kJ4d7L4PUoCA8wGaX1oBtVplvY4MhOJRV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZSu1xhboGjg2tbuxhE7qgb2ZfCLSwb6QJjGv0/nvITHn8xrT
	HtJlxEshT4I32fJnINOpgsuXCzrBuDJI28uBOvqHE9T89q+Fb8nv5FuXipBHS8427g2yjERMuuj
	za+nh1vA5ig==
X-Google-Smtp-Source: AGHT+IHf/o2yJ5U0aWyNBeTVAzHPKBxWcj2Zisq53jKHEVdYVi5j58GMSdeOjE+nsD91miCc3aK5+1l+S40a
X-Received: from pgbcq12.prod.google.com ([2002:a05:6a02:408c:b0:b2c:4d7e:b626])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c4:b0:235:f70:fd44
 with SMTP id d9443c01a7336-235e115029cmr52934475ad.21.1749059176707; Wed, 04
 Jun 2025 10:46:16 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:44 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-11-irogers@google.com>
Subject: [PATCH v4 10/10] perf thread_map: Remove uid options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now the target doesn't have a uid, it is handled through BPF filters,
remove the uid options to thread_map creation. Tidy up the functions
used in tests to avoid passing unused arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event-times.c             |  4 +--
 tools/perf/tests/keep-tracking.c           |  2 +-
 tools/perf/tests/mmap-basic.c              |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/tests/perf-time-to-tsc.c        |  2 +-
 tools/perf/tests/switch-tracking.c         |  2 +-
 tools/perf/tests/thread-map.c              |  2 +-
 tools/perf/util/evlist.c                   |  2 +-
 tools/perf/util/python.c                   | 10 +++----
 tools/perf/util/thread_map.c               | 32 ++--------------------
 tools/perf/util/thread_map.h               |  6 ++--
 12 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 2148024b4f4a..ae3b98bb42cf 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -62,7 +62,7 @@ static int attach__current_disabled(struct evlist *evlist)
 
 	pr_debug("attaching to current thread as disabled\n");
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
 		return -1;
@@ -88,7 +88,7 @@ static int attach__current_enabled(struct evlist *evlist)
 
 	pr_debug("attaching to current thread as enabled\n");
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (threads == NULL) {
 		pr_debug("failed to call thread_map__new\n");
 		return -1;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 5a3b2bed07f3..eafb49eb0b56 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -78,7 +78,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 	int found, err = -1;
 	const char *comm;
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	CHECK_NOT_NULL__(threads);
 
 	cpus = perf_cpu_map__new_online_cpus();
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index bd2106628b34..04b547c6bdbe 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -46,7 +46,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	char sbuf[STRERR_BUFSIZE];
 	struct mmap *md;
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
 		return -1;
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index fb114118c876..3644d6f52c07 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -28,7 +28,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	cpu_set_t cpu_set;
-	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
+	struct perf_thread_map *threads = thread_map__new_by_tid(getpid());
 	char sbuf[STRERR_BUFSIZE];
 	char errbuf[BUFSIZ];
 
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 131b62271bfa..b54cbe5f1808 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -20,7 +20,7 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 	int err = TEST_FAIL, fd;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
-	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
+	struct perf_thread_map *threads = thread_map__new_by_tid(getpid());
 	char sbuf[STRERR_BUFSIZE];
 	char errbuf[BUFSIZ];
 
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d3e40fa5482c..d4437410c99f 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -90,7 +90,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	struct mmap *md;
 
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	CHECK_NOT_NULL__(threads);
 
 	cpus = perf_cpu_map__new_online_cpus();
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 6b3aac283c37..5be294014d3b 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -351,7 +351,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	const char *comm;
 	int err = -1;
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (!threads) {
 		pr_debug("thread_map__new failed!\n");
 		goto out_err;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 1fe521466bf4..54209592168d 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -115,7 +115,7 @@ static int test__thread_map_remove(struct test_suite *test __maybe_unused, int s
 	TEST_ASSERT_VAL("failed to allocate map string",
 			asprintf(&str, "%d,%d", getpid(), getppid()) >= 0);
 
-	threads = thread_map__new_str(str, NULL, 0, false);
+	threads = thread_map__new_str(str, /*tid=*/NULL, /*all_threads=*/false);
 	free(str);
 
 	TEST_ASSERT_VAL("failed to allocate thread_map",
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index bed91bc88510..5664ebf6bbc6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1006,7 +1006,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	 * per-thread data. thread_map__new_str will call
 	 * thread_map__new_all_cpus to enumerate all threads.
 	 */
-	threads = thread_map__new_str(target->pid, target->tid, UINT_MAX, all_threads);
+	threads = thread_map__new_str(target->pid, target->tid, all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 321c333877fa..82666bcd2eda 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -566,14 +566,14 @@ struct pyrf_thread_map {
 static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
 				 PyObject *args, PyObject *kwargs)
 {
-	static char *kwlist[] = { "pid", "tid", "uid", NULL };
-	int pid = -1, tid = -1, uid = UINT_MAX;
+	static char *kwlist[] = { "pid", "tid", NULL };
+	int pid = -1, tid = -1;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|iii",
-					 kwlist, &pid, &tid, &uid))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ii",
+					 kwlist, &pid, &tid))
 		return -1;
 
-	pthreads->threads = thread_map__new(pid, tid, uid);
+	pthreads->threads = thread_map__new(pid, tid);
 	if (pthreads->threads == NULL)
 		return -1;
 	return 0;
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index b5f12390c355..ca193c1374ed 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -72,7 +72,7 @@ struct perf_thread_map *thread_map__new_by_tid(pid_t tid)
 	return threads;
 }
 
-static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
+static struct perf_thread_map *thread_map__new_all_cpus(void)
 {
 	DIR *proc;
 	int max_threads = 32, items, i;
@@ -98,15 +98,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 		if (*end) /* only interested in proper numerical dirents */
 			continue;
 
-		snprintf(path, sizeof(path), "/proc/%s", dirent->d_name);
-
-		if (uid != UINT_MAX) {
-			struct stat st;
-
-			if (stat(path, &st) != 0 || st.st_uid != uid)
-				continue;
-		}
-
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
 		if (items <= 0) {
@@ -157,24 +148,11 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	goto out_closedir;
 }
 
-struct perf_thread_map *thread_map__new_all_cpus(void)
-{
-	return __thread_map__new_all_cpus(UINT_MAX);
-}
-
-struct perf_thread_map *thread_map__new_by_uid(uid_t uid)
-{
-	return __thread_map__new_all_cpus(uid);
-}
-
-struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
+struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid)
 {
 	if (pid != -1)
 		return thread_map__new_by_pid(pid);
 
-	if (tid == -1 && uid != UINT_MAX)
-		return thread_map__new_by_uid(uid);
-
 	return thread_map__new_by_tid(tid);
 }
 
@@ -289,15 +267,11 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 	goto out;
 }
 
-struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid,
-				       uid_t uid, bool all_threads)
+struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid, bool all_threads)
 {
 	if (pid)
 		return thread_map__new_by_pid_str(pid);
 
-	if (!tid && uid != UINT_MAX)
-		return thread_map__new_by_uid(uid);
-
 	if (all_threads)
 		return thread_map__new_all_cpus();
 
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 00ec05fc1656..fc16d87f32fb 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -11,13 +11,11 @@ struct perf_record_thread_map;
 struct perf_thread_map *thread_map__new_dummy(void);
 struct perf_thread_map *thread_map__new_by_pid(pid_t pid);
 struct perf_thread_map *thread_map__new_by_tid(pid_t tid);
-struct perf_thread_map *thread_map__new_by_uid(uid_t uid);
-struct perf_thread_map *thread_map__new_all_cpus(void);
-struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
+struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid);
 struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event);
 
 struct perf_thread_map *thread_map__new_str(const char *pid,
-		const char *tid, uid_t uid, bool all_threads);
+		const char *tid, bool all_threads);
 
 struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


