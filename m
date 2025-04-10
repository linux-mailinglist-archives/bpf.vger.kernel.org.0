Return-Path: <bpf+bounces-55685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D209A84B36
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D8319E5F44
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED028CF47;
	Thu, 10 Apr 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAtJe1sx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266928C5D7
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306630; cv=none; b=P3SuT/BxMHL6KJfhYTHFJWkZ6ZzAgrxU9ZFfoNK9hpP2QPLDDKx3zJqgCtRPXBiLSArAHNcvEQ91Yb6+j909mwmCMzgAg28Em+LIp0sZGvA6xdIe9hlMJ/KwGt5lZQ2QrELudrBqiaDAzebLIvzXA75vnkv/8p1o2wDwGfPktrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306630; c=relaxed/simple;
	bh=+ixP1qHJBFjj59ZtGOMdYOK7HgE7wWblrGVYMQO0l7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C/fyD3rfRN1pIP0UHeB3jdj3Dn8pmCXKprQjEvl0YOXtxySr/DGqUHb283rpw3UJgGLReOh9QQYx+JotMzeKm8WIQTeGOBrsvZ9VjkIdY2+84xT1vRIqeO6a4aIV1MH2Hbea7m5HYoRrwClQgrB6XOY+fprFq/dOv5m2tb+9eNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAtJe1sx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so962287a91.2
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306627; x=1744911427; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckBZYcyyJUN9FjcUaUL5/ekJZ+dJKWbrJB0EF0qu50A=;
        b=UAtJe1sxMef7RiCPyfLSDNtLGATsM0Zgoa/S3eZypn5bvgWP9IVrPzgfcWy2BYVeQB
         BlRF0eCcVLGWKv3Mu4bJd3xc6vR5pr1ywEl9dRYsHMcEO3XyKYAbdtJWMHBDvZC7YVtC
         cuYNxqOJi6f+GoeZcPHNtr4P2qAJbVNqOi+ygO7OENKW3VJ/wEP6zFGrNiX0hGxlt8Lp
         OkD37m1uD1vWLniDg5qzj9rna+fRRZ86dCRD5CdgDhj2AIEwtJSeRMW5CQinVeue77hZ
         gHqBMmp56Am7HrXl8z+PXRkBQaM/6w90Jccz7SdEf8zCCu9G8VxZXYt0VDuankWRITSo
         vjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306627; x=1744911427;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckBZYcyyJUN9FjcUaUL5/ekJZ+dJKWbrJB0EF0qu50A=;
        b=A+vQy+Rpo1dyktkXv8PfwvUA9dGXrohN1oMBBrOPZF4CjGIJI8lULH8TUBacUUyyhg
         pfSY2imxLiWVXTbMJXqedXGWXgta2w7dxXjPISK8ivhH0aPv0N2Fv+ObZCUzVTt3Buvi
         QeIi9nMSrkaZIVUXO4EQamN+erVxNungbczx7eO/PsVjYhxzNGadhMMiccSgISyOTFLv
         6/QZAK1xAmBW6bUnt/EzhOzzb1pFtyQPRM/zf7Ug2KJScQI4q2dS8mr8ofVfDLtjGbml
         /WG14q34hEDVIimu4NH81HfA+VoWPE+HVlN0P9CCFkAAO2+6WLe3/6yNguGZxit4yU9t
         +JOg==
X-Forwarded-Encrypted: i=1; AJvYcCUo5ZM90HMxo1vnJWuP7ktm+wzHufMA4GhsuTw3r9DxyP9FXr8v3DiKGMpbh23HmkZslOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrzNddOM7THjwlyuANRG3in1R6Rzq8qkqbjlLe02Jd7JAuq9A3
	JumGeHs9iAnOKOes0+R5SFyiV7DfRsNgymhRt6ld+P0E+likT/p6ge3BWQQYMEn6mSWfbTl23pk
	gSUzOJA==
X-Google-Smtp-Source: AGHT+IG1qOFPzSDf9Ewl3xwJO7ONlzQPJXL9CVsc0lXzOmGKPKFYYwMJamiZf+cuyQopWHvr1ogG7wLUF1hJ
X-Received: from pjbsd3.prod.google.com ([2002:a17:90b:5143:b0:2ea:3a1b:f493])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a46:b0:2ee:af31:a7bd
 with SMTP id 98e67ed59e1d1-30718b547a9mr5165280a91.5.1744306627554; Thu, 10
 Apr 2025 10:37:07 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:31 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-13-irogers@google.com>
Subject: [PATCH v2 12/12] perf thread_map: Remove uid options
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
index 2e1f14bc8461..8a7ec845a611 100644
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
2.49.0.604.gff1f9ca942-goog


