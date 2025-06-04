Return-Path: <bpf+bounces-59673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073FACE3F1
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F903A2484
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4D1FDA69;
	Wed,  4 Jun 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBvfOl4I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D122A4FE
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059177; cv=none; b=PwQMYKy7CtOVrCzSQtdLDmBQrcxUJcmVqIFUnCo0DCn5ayPpHbiq1ZnycxkfijkQaUkEmSEKWMTmMi2C+xl5FbFKw4FejMzqHHyIkvq92UA/qTEM79EzKfg1yhxNfrlq03tY+Pm7ezJf5oHR0kF53DEKtKpDnOAutPtYCdBSQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059177; c=relaxed/simple;
	bh=8UV4w91JqgpYZ207NgqO7SC2753UshA65VF2bcTJhFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JTfhjyc/4nN4pD1TeLnD/H1P2t219KxSXkEub4NPnjVm8FX7M0Azfbt8fR0/BvJs8WQCs4iUptrux+q/IVXABMVtpN9smg/F0bWJeTTJculL7ywjEnGBTxmU2Ntz9Rq+XnVYF82SLu1SCt6Qlfno9RAqRApKAfRZ73zyChbZQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBvfOl4I; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e4fe0c08so20684a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059175; x=1749663975; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/MZvKkzjhaHk9oHd4qdgkJl4s3RS0c1LOc60+L67is=;
        b=fBvfOl4I+F7/Pda8BfpIOfLJncfwpAr1g2ox+3oHSb6+qCfzSnWD+Ka089PQMJ05Dc
         NaSdEAfgdQHaerwN3SJ0/P/FBd6sP/TGq5tRK7LbtOnsT6yrISiK+vdKNz1XtGbVgUGh
         dDaePH/jsqwgW/FsX4or4BiSao+Q+Ye571Q3ptdAqql83A0TMUf6t0hu/b7BcGmGp2Mm
         19zlt7BLUALb3Ga2Vw47YdYMWUU+5Hz1DuHevRMKlsJObXELMaUVcAI4l/p8+LL3b2NA
         qvFxJxe7oZ+MOmjFnKUX+qUfncs+GnVxu6SaADMmfoEpKKEbE3yBnqdcbd3ZLR3MMW2J
         mxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059175; x=1749663975;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/MZvKkzjhaHk9oHd4qdgkJl4s3RS0c1LOc60+L67is=;
        b=PFZu+hq/NbbqeZ7RI/2G2oK7wLbUF34MGMvfSgXUTKSBcRPyOvNn/ybp9mGDmp4E5F
         xr+oA/6dmx3s+h1wom72oQoxsPArscOpnEhB7Uw6UaQqYecr+SaHcA48jIEzArzZ6W8g
         ibXFBZ4YqTeBUFAdwc3Z/TajlZMJO2jLKR7UJDXPGaDPgWLaVHdXyzi0vTnAH1Twhmeu
         NCRc5Pu1wh8kEbHRiMpOE7spgsed2lLuYETXcd3I0pz8+3f8ZxLKpAQ3KN3TLutn2KgL
         CvjgeODFgSC5ICeYBB4p+e7oUeea1qPfwMVAm/Om/EoJDUXBCRSTqrOlPjfn6ETmRK+Q
         X38Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+OO0cBi4RtGF2IWHjkNMzisp2KUgzVDXsBRzWFkmvpy6xhrZsdESSjWoSSvRWdo8Zu18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpBfdhGLDuEktZV9b+YdwKoQnbVkhpTZB+RKIPNi62e2REUNb
	tRdfYLJMr9+Sg3LOPRc30EOnErkUFdnqzp/AQjtW3By+vUYq7f4BeY+LlONXPp5lDan+XNlo7/6
	1rn6HDbLITg==
X-Google-Smtp-Source: AGHT+IF9XwhFQR2h1jmFzhoM4cI9mY/FF1ErAZpNkpgMPuH3dhK72GK9RcSuXbYZsCAYAGJzsMK+g/2Wzm9U
X-Received: from pjdn4.prod.google.com ([2002:a17:90a:2c84:b0:313:1c10:3595])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35d1:b0:311:9c1f:8522
 with SMTP id 98e67ed59e1d1-31310fff12dmr4930443a91.10.1749059174777; Wed, 04
 Jun 2025 10:46:14 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:43 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-10-irogers@google.com>
Subject: [PATCH v4 09/10] perf target: Remove uid from target
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

Gathering threads with a uid by scanning /proc is inherently racy
leading to perf_event_open failures that quit perf. All users of the
functionality now use BPF filters, so remove uid and uid_str from
target.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c                 |  1 -
 tools/perf/builtin-kvm.c                    |  2 -
 tools/perf/builtin-stat.c                   |  4 +-
 tools/perf/builtin-trace.c                  |  1 -
 tools/perf/tests/backward-ring-buffer.c     |  1 -
 tools/perf/tests/event-times.c              |  4 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  1 -
 tools/perf/tests/perf-record.c              |  1 -
 tools/perf/tests/task-exit.c                |  1 -
 tools/perf/util/bpf-filter.c                |  2 +-
 tools/perf/util/evlist.c                    |  3 +-
 tools/perf/util/target.c                    | 46 +--------------------
 tools/perf/util/target.h                    | 12 +-----
 13 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index bba36ebc2aa7..3a253a1b9f45 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1663,7 +1663,6 @@ int cmd_ftrace(int argc, const char **argv)
 	int (*cmd_func)(struct perf_ftrace *) = NULL;
 	struct perf_ftrace ftrace = {
 		.tracer = DEFAULT_TRACER,
-		.target = { .uid = UINT_MAX, },
 	};
 	const struct option common_options[] = {
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 67fd2b006b0b..d75bd3684980 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1871,8 +1871,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	kvm->opts.user_interval = 1;
 	kvm->opts.mmap_pages = 512;
 	kvm->opts.target.uses_mmap = false;
-	kvm->opts.target.uid_str = NULL;
-	kvm->opts.target.uid = UINT_MAX;
 
 	symbol__init(NULL);
 	disable_buildid_cache();
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bf0e5e12d992..50fc53adb7e4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -108,9 +108,7 @@ static struct parse_events_option_args parse_events_option_args = {
 
 static bool all_counters_use_bpf = true;
 
-static struct target target = {
-	.uid	= UINT_MAX,
-};
+static struct target target;
 
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4bb062b96f51..bf9b5d0630d3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5399,7 +5399,6 @@ int cmd_trace(int argc, const char **argv)
 	struct trace trace = {
 		.opts = {
 			.target = {
-				.uid	   = UINT_MAX,
 				.uses_mmap = true,
 			},
 			.user_freq     = UINT_MAX,
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 79a980b1e786..c5e7999f2817 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -91,7 +91,6 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	struct parse_events_error parse_error;
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.freq	      = 0,
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index deefe5003bfc..2148024b4f4a 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -17,9 +17,7 @@
 static int attach__enable_on_exec(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__last(evlist);
-	struct target target = {
-		.uid = UINT_MAX,
-	};
+	struct target target = {};
 	const char *argv[] = { "true", NULL, };
 	char sbuf[STRERR_BUFSIZE];
 	int err;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 0ef4ba7c1571..2a139d2781a8 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -28,7 +28,6 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 {
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.no_buffering = true,
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0958c7c8995f..0b3c37e66871 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -45,7 +45,6 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 {
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.no_buffering = true,
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 8e328bbd509d..4053ff2813bb 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -46,7 +46,6 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	struct evsel *evsel;
 	struct evlist *evlist;
 	struct target target = {
-		.uid		= UINT_MAX,
 		.uses_mmap	= true,
 	};
 	const char *argv[] = { "true", NULL };
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 92e2f054b45e..d0e013eeb0f7 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -450,7 +450,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
-	bool needs_idx_hash = !target__has_cpu(target) && !target->uid_str;
+	bool needs_idx_hash = !target__has_cpu(target);
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dcd1130502df..bed91bc88510 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1006,8 +1006,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	 * per-thread data. thread_map__new_str will call
 	 * thread_map__new_all_cpus to enumerate all threads.
 	 */
-	threads = thread_map__new_str(target->pid, target->tid, target->uid,
-				      all_threads);
+	threads = thread_map__new_str(target->pid, target->tid, UINT_MAX, all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index f3ad59ccfa99..8cf71bea295a 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -28,20 +28,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__PID_OVERRIDE_CPU;
 	}
 
-	/* UID and PID are mutually exclusive */
-	if (target->tid && target->uid_str) {
-		target->uid_str = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__PID_OVERRIDE_UID;
-	}
-
-	/* UID and CPU are mutually exclusive */
-	if (target->uid_str && target->cpu_list) {
-		target->cpu_list = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__UID_OVERRIDE_CPU;
-	}
-
 	/* PID and SYSTEM are mutually exclusive */
 	if (target->tid && target->system_wide) {
 		target->system_wide = false;
@@ -49,13 +35,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__PID_OVERRIDE_SYSTEM;
 	}
 
-	/* UID and SYSTEM are mutually exclusive */
-	if (target->uid_str && target->system_wide) {
-		target->system_wide = false;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__UID_OVERRIDE_SYSTEM;
-	}
-
 	/* BPF and CPU are mutually exclusive */
 	if (target->bpf_str && target->cpu_list) {
 		target->cpu_list = NULL;
@@ -70,13 +49,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__BPF_OVERRIDE_PID;
 	}
 
-	/* BPF and UID are mutually exclusive */
-	if (target->bpf_str && target->uid_str) {
-		target->uid_str = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__BPF_OVERRIDE_UID;
-	}
-
 	/* BPF and THREADS are mutually exclusive */
 	if (target->bpf_str && target->per_thread) {
 		target->per_thread = false;
@@ -124,31 +96,19 @@ uid_t parse_uid(const char *str)
 	return result->pw_uid;
 }
 
-enum target_errno target__parse_uid(struct target *target)
-{
-	target->uid = parse_uid(target->uid_str);
-
-	return target->uid != UINT_MAX ? TARGET_ERRNO__SUCCESS : TARGET_ERRNO__INVALID_UID;
-}
-
 /*
  * This must have a same ordering as the enum target_errno.
  */
 static const char *target__error_str[] = {
 	"PID/TID switch overriding CPU",
-	"PID/TID switch overriding UID",
-	"UID switch overriding CPU",
 	"PID/TID switch overriding SYSTEM",
-	"UID switch overriding SYSTEM",
 	"SYSTEM/CPU switch overriding PER-THREAD",
 	"BPF switch overriding CPU",
 	"BPF switch overriding PID/TID",
-	"BPF switch overriding UID",
 	"BPF switch overriding THREAD",
-	"Invalid User: %s",
 };
 
-int target__strerror(struct target *target, int errnum,
+int target__strerror(struct target *target __maybe_unused, int errnum,
 			  char *buf, size_t buflen)
 {
 	int idx;
@@ -173,10 +133,6 @@ int target__strerror(struct target *target, int errnum,
 		snprintf(buf, buflen, "%s", msg);
 		break;
 
-	case TARGET_ERRNO__INVALID_UID:
-		snprintf(buf, buflen, msg, target->uid_str);
-		break;
-
 	default:
 		/* cannot reach here */
 		break;
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index e082bda990fb..84ebb9c940c6 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -9,9 +9,7 @@ struct target {
 	const char   *pid;
 	const char   *tid;
 	const char   *cpu_list;
-	const char   *uid_str;
 	const char   *bpf_str;
-	uid_t	     uid;
 	bool	     system_wide;
 	bool	     uses_mmap;
 	bool	     default_per_cpu;
@@ -36,32 +34,24 @@ enum target_errno {
 
 	/* for target__validate() */
 	TARGET_ERRNO__PID_OVERRIDE_CPU	= __TARGET_ERRNO__START,
-	TARGET_ERRNO__PID_OVERRIDE_UID,
-	TARGET_ERRNO__UID_OVERRIDE_CPU,
 	TARGET_ERRNO__PID_OVERRIDE_SYSTEM,
-	TARGET_ERRNO__UID_OVERRIDE_SYSTEM,
 	TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD,
 	TARGET_ERRNO__BPF_OVERRIDE_CPU,
 	TARGET_ERRNO__BPF_OVERRIDE_PID,
-	TARGET_ERRNO__BPF_OVERRIDE_UID,
 	TARGET_ERRNO__BPF_OVERRIDE_THREAD,
 
-	/* for target__parse_uid() */
-	TARGET_ERRNO__INVALID_UID,
-
 	__TARGET_ERRNO__END,
 };
 
 enum target_errno target__validate(struct target *target);
 
 uid_t parse_uid(const char *str);
-enum target_errno target__parse_uid(struct target *target);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
 static inline bool target__has_task(struct target *target)
 {
-	return target->tid || target->pid || target->uid_str;
+	return target->tid || target->pid;
 }
 
 static inline bool target__has_cpu(struct target *target)
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


