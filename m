Return-Path: <bpf+bounces-12867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B807D175E
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831CF28268C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3924A17;
	Fri, 20 Oct 2023 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkrMbFRA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0060249F6;
	Fri, 20 Oct 2023 20:47:47 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70229D65;
	Fri, 20 Oct 2023 13:47:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6be840283ceso1163189b3a.3;
        Fri, 20 Oct 2023 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697834866; x=1698439666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOImYZdSx2m0PGY/kvmONhOIa9TTLkTXQlBLoR0LTq8=;
        b=fkrMbFRAqI1vUZkgOdAfiRdTiQsPUmyzXLXgcCkkysEYDVYfxsQiuUKYLRxgFP1vbe
         q6+swc7mnpxFDxy07AzB8DNQa38AHMj1rbW8BndpdRWnyQ1r52OQJ1/0huFeae1+riq7
         eqQesvQvSe0+X65qgaUTpQCUkkPmiN46/Grsy7rj/umcjGQAOV/8OicMXwO2L6fEROcv
         R7evtYgSeoNgVJvaBBfCcQSZBC7dwVoaNnRNVNupAUB2APAch6mGjYxU98FCZhArLUhX
         tdRrLQ1pnClr7j0w0fDyOtO5cHnFItv9Na4366M4cugbGgNqXIhwMv9H8fFJwdXRHa5m
         Enqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697834866; x=1698439666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOImYZdSx2m0PGY/kvmONhOIa9TTLkTXQlBLoR0LTq8=;
        b=N1gCvrqjVfR4Q+g/QIr8XcXhqdVjJZtPqTWCMqdKhlXr+kI7YgHTUgHvt+tnhhLRMA
         1sXKpN+mXVgxLubwC9PQ0e7r0b6BNxYQHHmzu7YvLEvxWqHhtketc1NTuFQYWJMc0Bgn
         xYQuiaEp2yd6BvaYn/WTHbkVfzJtEnsAlzwv2SypqIYG+jVR3AajNe47PXMzUQ+PJDW3
         Ut21pPNTGjm+JfTXpBLCXGwFIKBROlY+qTRiMG2ZDqbVOS8BINrGeTgpcGTycokJd34s
         OENRhAWu9uR58DpAe/Kj9onSrILmbics07ddf32+WOeOZTD+8JjraeHHZMBKztObaxVb
         ABmw==
X-Gm-Message-State: AOJu0YzJIPF3ZLRBAul+jgyC4v2hkU13Ftcp0Z7QeNe/RWE7jxfBDhwP
	P7m0GC4Fk0myCyh5zlm0H47hYHMdxrU=
X-Google-Smtp-Source: AGHT+IE6l3rYdCDPQTlPePjtB6GIowh3BYRmShPbEGbnsFP08KqWR8o5JZih7EBMhmrqdM2tdB4dcA==
X-Received: by 2002:a05:6a21:7989:b0:17b:8404:96d8 with SMTP id bh9-20020a056a21798900b0017b840496d8mr3002343pzc.41.1697834865589;
        Fri, 20 Oct 2023 13:47:45 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:17e0:7ea9:fbc6:4c7d])
        by smtp.gmail.com with ESMTPSA id r25-20020aa79639000000b00694f14a784bsm1971183pfg.52.2023.10.20.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:47:45 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH v3 3/3] perf lock contention: Use per-cpu array map for spinlocks
Date: Fri, 20 Oct 2023 13:47:41 -0700
Message-ID: <20231020204741.1869520-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231020204741.1869520-1-namhyung@kernel.org>
References: <20231020204741.1869520-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently lock contention timestamp is maintained in a hash map keyed by
pid.  That means it needs to get and release a map element (which is
proctected by spinlock!) on each contention begin and end pair.  This
can impact on performance if there are a lot of contention (usually from
spinlocks).

It used to go with task local storage but it had an issue on memory
allocation in some critical paths.  Although it's addressed in recent
kernels IIUC, the tool should support old kernels too.  So it cannot
simply switch to the task local storage at least for now.

As spinlocks create lots of contention and they disabled preemption
during the spinning, it can use per-cpu array to keep the timestamp to
avoid overhead in hashmap update and delete.

In contention_begin, it's easy to check the lock types since it can see
the flags.  But contention_end cannot see it.  So let's try to per-cpu
array first (unconditionally) if it has an active element (lock != 0).
Then it should be used and per-task tstamp map should not be used until
the per-cpu array element is cleared which means nested spinlock
contention (if any) was finished and it nows see (the outer) lock.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 89 +++++++++++++++----
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 69d31fd77cd0..95cd8414f6ef 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -42,6 +42,14 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } tstamp SEC(".maps");
 
+/* maintain per-CPU timestamp at the beginning of contention */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct tstamp_data));
+	__uint(max_entries, 1);
+} tstamp_cpu SEC(".maps");
+
 /* actual lock contention statistics */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -311,34 +319,57 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
 	return 0;
 }
 
-SEC("tp_btf/contention_begin")
-int contention_begin(u64 *ctx)
+static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 {
 	__u32 pid;
 	struct tstamp_data *pelem;
 
-	if (!enabled || !can_record(ctx))
-		return 0;
+	/* Use per-cpu array map for spinlock and rwlock */
+	if (flags == (LCB_F_SPIN | LCB_F_READ) || flags == LCB_F_SPIN ||
+	    flags == (LCB_F_SPIN | LCB_F_WRITE)) {
+		__u32 idx = 0;
+
+		pelem = bpf_map_lookup_elem(&tstamp_cpu, &idx);
+		/* Do not update the element for nested locks */
+		if (pelem && pelem->lock)
+			pelem = NULL;
+		return pelem;
+	}
 
 	pid = bpf_get_current_pid_tgid();
 	pelem = bpf_map_lookup_elem(&tstamp, &pid);
+	/* Do not update the element for nested locks */
 	if (pelem && pelem->lock)
-		return 0;
+		return NULL;
 
 	if (pelem == NULL) {
 		struct tstamp_data zero = {};
 
 		if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST) < 0) {
 			__sync_fetch_and_add(&task_fail, 1);
-			return 0;
+			return NULL;
 		}
 
 		pelem = bpf_map_lookup_elem(&tstamp, &pid);
 		if (pelem == NULL) {
 			__sync_fetch_and_add(&task_fail, 1);
-			return 0;
+			return NULL;
 		}
 	}
+	return pelem;
+}
+
+SEC("tp_btf/contention_begin")
+int contention_begin(u64 *ctx)
+{
+	struct tstamp_data *pelem;
+
+	if (!enabled || !can_record(ctx))
+		return 0;
+
+	pelem = get_tstamp_elem(ctx[1]);
+	if (pelem == NULL)
+		return 0;
 
 	pelem->timestamp = bpf_ktime_get_ns();
 	pelem->lock = (__u64)ctx[0];
@@ -377,24 +408,42 @@ int contention_begin(u64 *ctx)
 SEC("tp_btf/contention_end")
 int contention_end(u64 *ctx)
 {
-	__u32 pid;
+	__u32 pid = 0, idx = 0;
 	struct tstamp_data *pelem;
 	struct contention_key key = {};
 	struct contention_data *data;
 	__u64 duration;
+	bool need_delete = false;
 
 	if (!enabled)
 		return 0;
 
-	pid = bpf_get_current_pid_tgid();
-	pelem = bpf_map_lookup_elem(&tstamp, &pid);
-	if (!pelem || pelem->lock != ctx[0])
-		return 0;
+	/*
+	 * For spinlock and rwlock, it needs to get the timestamp for the
+	 * per-cpu map.  However, contention_end does not have the flags
+	 * so it cannot know whether it reads percpu or hash map.
+	 *
+	 * Try per-cpu map first and check if there's active contention.
+	 * If it is, do not read hash map because it cannot go to sleeping
+	 * locks before releasing the spinning locks.
+	 */
+	pelem = bpf_map_lookup_elem(&tstamp_cpu, &idx);
+	if (pelem && pelem->lock) {
+		if (pelem->lock != ctx[0])
+			return 0;
+	} else {
+		pid = bpf_get_current_pid_tgid();
+		pelem = bpf_map_lookup_elem(&tstamp, &pid);
+		if (!pelem || pelem->lock != ctx[0])
+			return 0;
+		need_delete = true;
+	}
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 	if ((__s64)duration < 0) {
 		pelem->lock = 0;
-		bpf_map_delete_elem(&tstamp, &pid);
+		if (need_delete)
+			bpf_map_delete_elem(&tstamp, &pid);
 		__sync_fetch_and_add(&time_fail, 1);
 		return 0;
 	}
@@ -406,8 +455,11 @@ int contention_end(u64 *ctx)
 	case LOCK_AGGR_TASK:
 		if (lock_owner)
 			key.pid = pelem->flags;
-		else
+		else {
+			if (!need_delete)
+				pid = bpf_get_current_pid_tgid();
 			key.pid = pid;
+		}
 		if (needs_callstack)
 			key.stack_id = pelem->stack_id;
 		break;
@@ -428,7 +480,8 @@ int contention_end(u64 *ctx)
 	if (!data) {
 		if (data_map_full) {
 			pelem->lock = 0;
-			bpf_map_delete_elem(&tstamp, &pid);
+			if (need_delete)
+				bpf_map_delete_elem(&tstamp, &pid);
 			__sync_fetch_and_add(&data_fail, 1);
 			return 0;
 		}
@@ -452,7 +505,8 @@ int contention_end(u64 *ctx)
 			__sync_fetch_and_add(&data_fail, 1);
 		}
 		pelem->lock = 0;
-		bpf_map_delete_elem(&tstamp, &pid);
+		if (need_delete)
+			bpf_map_delete_elem(&tstamp, &pid);
 		return 0;
 	}
 
@@ -466,7 +520,8 @@ int contention_end(u64 *ctx)
 		data->min_time = duration;
 
 	pelem->lock = 0;
-	bpf_map_delete_elem(&tstamp, &pid);
+	if (need_delete)
+		bpf_map_delete_elem(&tstamp, &pid);
 	return 0;
 }
 
-- 
2.42.0.655.g421f12c284-goog


