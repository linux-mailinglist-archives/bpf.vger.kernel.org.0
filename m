Return-Path: <bpf+bounces-56747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E11A9D457
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6A04C815F
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BF25CC75;
	Fri, 25 Apr 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZyxdf6v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34725DB15
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617245; cv=none; b=A3D6hPDhn3puga1i4MFL6pP/yOFkPOm+Eh+SaTATaUr8XpdxTS51T7BTDLdj3LjrrHyTAn3GXd/UealfxzwRpXBjDo/9s9F7OcyvZCjs4UHPq6WZPqsCwKf8UGwiDAChMhLlAHjZ7BkQ86jF+DImkUCMrPBOWSa/zrDrB2b+wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617245; c=relaxed/simple;
	bh=civL0ptmakP58BNTG6qRL/WfDNW9+VMZdvD44UQo1N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AeAPb3PkOIsmkWwZahN1AjnA2w8uu+eUnqquNeFSif6L1mXmcTz4Px/LRd6KgekkKuNAO9CZJwkUXOe0DQPd8iBHASQrQpQor2SLbIlkR0rgF7ubrMLuz2imyy5x9lLNO+uVRsy5hX5WhWf8zspwb9ARK3KKlRPkXz5/fOJ0590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZyxdf6v; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73720b253fcso2321423b3a.2
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617242; x=1746222042; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PD/2gZzkdXqRjrGcRCMV5rPK+HPN6vuWAJ5aTNU/fMM=;
        b=FZyxdf6vIfEcVTxzWPLDxtB/ss62ZbMaPY2EO74jLnfNzg1DDlsj0TzYY0eWgcS0O0
         34U2bPtfXzFadLZSTDto9UqDc57O4a4S8yZ8iN2HXr/aVH8AGnzCp99bb3cZT927kP0y
         bHaBmjFyTSi7BFhOoeivehYOrraMaoaQoEQBLltjaEAQVkIQR1tXB9s0rwBlPCdMcS+e
         05Udm+ZGOOcGboOzABIdoN4g+wNFBe0nesHLEZ+mrw7NBEm/yT6QYQ5copaeHgH12dt5
         lj7HcF1RAhuNaFJPwqxsu4bK6SWGsTaUsa+4HEfPCkuXStgUOw7Nr2Py9V1V0pvdFYNp
         TC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617242; x=1746222042;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD/2gZzkdXqRjrGcRCMV5rPK+HPN6vuWAJ5aTNU/fMM=;
        b=NzNLbUMvF+ivtziv0vDaGrxWPbh3779pyPSecr7mJcSbKwT5rKVKtpSnfOUMjpc+WU
         YrYZxal/qKQU7KnpiqO+sa1aB7EehXuHk7zR//Kqjk3lvVi3rAydsarP4+qqEd3OiuBS
         FWDjHAR+VDB36pW2hGYdC9j+Hr35hGk4BwV9DBVKuY28xal/cvJA4xojSbnxXDDezl6Z
         tVPWRKJ1BZ3hDsQInaeoRCvMaorhR+0P5h2dfe9FE+E84dRBEq0AAT4NtnC+TJ4a/yGZ
         0sMJbPBAkhJWiurcVtghGhaHWHtSSN0Ut0StzOe8cUGO+K9HMfUBTToV1gc3zocDATa7
         lQGg==
X-Forwarded-Encrypted: i=1; AJvYcCUEWUHoAmBl+MvEv3vPKBodKHOKlU9h4N3/Ac3GiIaN+BpyT8yjKiBNAGzBAhgVngxsxlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjvrpEOt+VFZUIWikaiG+f2/9zXho1FHIcWr+ahHJm+uAflft
	5E/5czXGQivm90O1Cm30OWQzmLM5jIuRke1hnI3L0qsLeEoXYaTCZ6O8OrlBxiTEd1CxiH2Uql2
	/jr667A==
X-Google-Smtp-Source: AGHT+IFCtEhRCBjDW2a8s4jRDfOQsUoZ7gsKizv5ygUaW1sjDqLjtvAoq2pOpHphbv7xIzozUy8B6xlFSZN6
X-Received: from pgbee7.prod.google.com ([2002:a05:6a02:4587:b0:b16:7375:98d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8c:b0:1f5:8e04:f186
 with SMTP id adf61e73a8af0-2045b9c0068mr5774268637.35.1745617242379; Fri, 25
 Apr 2025 14:40:42 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:08 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-11-irogers@google.com>
Subject: [PATCH v3 10/10] perf thread_map: Remove uid options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
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
index 8df3f9d9ffd2..96f880c922d1 100644
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
index 86b11ffc09b7..ba9e69b5acba 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1005,7 +1005,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	 * per-thread data. thread_map__new_str will call
 	 * thread_map__new_all_cpus to enumerate all threads.
 	 */
-	threads = thread_map__new_str(target->pid, target->tid, UINT_MAX, all_threads);
+	threads = thread_map__new_str(target->pid, target->tid, all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f3c05da25b4a..56f8ae4cebf7 100644
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
2.49.0.850.g28803427d3-goog


