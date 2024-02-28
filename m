Return-Path: <bpf+bounces-22840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2842286A805
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 06:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FF81F25A91
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 05:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668FA21115;
	Wed, 28 Feb 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZL1DB1C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81791EEFC;
	Wed, 28 Feb 2024 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098418; cv=none; b=Fm67iPeZnAY7o1/ncRIbcFHJXHzkLASUPuLU0t1N/HLre0KwVFi03dM4usVWAU24aecLM8+vF0aPrFKPmnE4KacytpAxwhckN5l4WfBW5WonEzll6P3c1cHiUJPz6LdxG6KiwNKPc/YsteRdyY+g82QeLePkJMod2swLz3W1kgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098418; c=relaxed/simple;
	bh=SG51VYH9JEUGEW6hnzOW/IFg0lpQP3pfUJCNA/WYd58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oB+hsXFT8hj/DE11RCDFihAjSBSmE8B4CpOV6GD//kdWwsCVOB6adbbZ8KK3GOop9qu0mLWvuKKLvHSs9FUodVexLxQ08/R2zUarL2a4UTMj8+u8qq5pHlVGGLUTyT3dEoKxO0Xok4fBTBKwpcO77DkdYF9ZLkVE3I1yeUi6oZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZL1DB1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0067AC433F1;
	Wed, 28 Feb 2024 05:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709098417;
	bh=SG51VYH9JEUGEW6hnzOW/IFg0lpQP3pfUJCNA/WYd58=;
	h=From:To:Cc:Subject:Date:From;
	b=HZL1DB1CnQH4Q3Vc5pionsBT0KLxSYcuTOGSZA6/0MHpfcQRvefBX6K9FMqDg2SVC
	 MBpJjwuoTu0DK9Owt6CghzhCd2SDrFwlLG+Hbql/pnhQIC7vCW5Xg1wRd5Q75TpYrb
	 giCUPqCLpKN4DNEHQNKfIVbSyMTx8eQh2feiQGAeo9ih9rxYmQdJwo3dCsESjqjRMS
	 9s7ecG2rUzj6cjdkLdJmN+yNnHk6u7/kAxdI++c8q7E6/Xneq7vcrSzfhGREc+DFL0
	 fA3CYcUB1ylQfQgCuguezZKgDb0Yim55orJ8KqREnGfYzB7bZ6QU9v37CkYQfViVSn
	 W+EDNzx3d8nVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2] perf lock contention: Account contending locks too
Date: Tue, 27 Feb 2024 21:33:35 -0800
Message-ID: <20240228053335.312776-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it accounts the contention using delta between timestamps in
lock:contention_begin and lock:contention_end tracepoints.  But it means
the lock should see the both events during the monitoring period.

Actually there are 4 cases that happen with the monitoring:

                monitoring period
            /                       \
            |                       |
 1:  B------+-----------------------+--------E
 2:    B----+-------------E         |
 3:         |           B-----------+----E
 4:         |     B-------------E   |
            |                       |
            t0                      t1

where B and E mean contention BEGIN and END, respectively.  So it only
accounts the case 4 for now.  It seems there's no way to handle the case
1.  The case 2 might be handled if it saved the timestamp (t0), but it
lacks the information from the B notably the flags which shows the lock
types.  Also it could be a nested lock which it currently ignores.  So
I think we should ignore the case 2.

However we can handle the case 3 if we save the timestamp (t1) at the
end of the period.  And then it can iterate the map entries in the
userspace and update the lock stat accordinly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2: add a comment on mark_end_timestamp  (Ian)

 tools/perf/util/bpf_lock_contention.c         | 120 ++++++++++++++++++
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  16 ++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 3 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 31ff19afc20c..9af76c6b2543 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -179,6 +179,123 @@ int lock_contention_prepare(struct lock_contention *con)
 	return 0;
 }
 
+/*
+ * Run the BPF program directly using BPF_PROG_TEST_RUN to update the end
+ * timestamp in ktime so that it can calculate delta easily.
+ */
+static void mark_end_timestamp(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+	int prog_fd = bpf_program__fd(skel->progs.end_timestamp);
+
+	bpf_prog_test_run_opts(prog_fd, &opts);
+}
+
+static void update_lock_stat(int map_fd, int pid, u64 end_ts,
+			     enum lock_aggr_mode aggr_mode,
+			     struct tstamp_data *ts_data)
+{
+	u64 delta;
+	struct contention_key stat_key = {};
+	struct contention_data stat_data;
+
+	if (ts_data->timestamp >= end_ts)
+		return;
+
+	delta = end_ts - ts_data->timestamp;
+
+	switch (aggr_mode) {
+	case LOCK_AGGR_CALLER:
+		stat_key.stack_id = ts_data->stack_id;
+		break;
+	case LOCK_AGGR_TASK:
+		stat_key.pid = pid;
+		break;
+	case LOCK_AGGR_ADDR:
+		stat_key.lock_addr_or_cgroup = ts_data->lock;
+		break;
+	case LOCK_AGGR_CGROUP:
+		/* TODO */
+		return;
+	default:
+		return;
+	}
+
+	if (bpf_map_lookup_elem(map_fd, &stat_key, &stat_data) < 0)
+		return;
+
+	stat_data.total_time += delta;
+	stat_data.count++;
+
+	if (delta > stat_data.max_time)
+		stat_data.max_time = delta;
+	if (delta < stat_data.min_time)
+		stat_data.min_time = delta;
+
+	bpf_map_update_elem(map_fd, &stat_key, &stat_data, BPF_EXIST);
+}
+
+/*
+ * Account entries in the tstamp map (which didn't see the corresponding
+ * lock:contention_end tracepoint) using end_ts.
+ */
+static void account_end_timestamp(struct lock_contention *con)
+{
+	int ts_fd, stat_fd;
+	int *prev_key, key;
+	u64 end_ts = skel->bss->end_ts;
+	int total_cpus;
+	enum lock_aggr_mode aggr_mode = con->aggr_mode;
+	struct tstamp_data ts_data, *cpu_data;
+
+	/* Iterate per-task tstamp map (key = TID) */
+	ts_fd = bpf_map__fd(skel->maps.tstamp);
+	stat_fd = bpf_map__fd(skel->maps.lock_stat);
+
+	prev_key = NULL;
+	while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
+		if (bpf_map_lookup_elem(ts_fd, &key, &ts_data) == 0) {
+			int pid = key;
+
+			if (aggr_mode == LOCK_AGGR_TASK && con->owner)
+				pid = ts_data.flags;
+
+			update_lock_stat(stat_fd, pid, end_ts, aggr_mode,
+					 &ts_data);
+		}
+
+		prev_key = &key;
+	}
+
+	/* Now it'll check per-cpu tstamp map which doesn't have TID. */
+	if (aggr_mode == LOCK_AGGR_TASK || aggr_mode == LOCK_AGGR_CGROUP)
+		return;
+
+	total_cpus = cpu__max_cpu().cpu;
+	ts_fd = bpf_map__fd(skel->maps.tstamp_cpu);
+
+	cpu_data = calloc(total_cpus, sizeof(*cpu_data));
+	if (cpu_data == NULL)
+		return;
+
+	prev_key = NULL;
+	while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
+		if (bpf_map_lookup_elem(ts_fd, &key, cpu_data) < 0)
+			goto next;
+
+		for (int i = 0; i < total_cpus; i++) {
+			update_lock_stat(stat_fd, -1, end_ts, aggr_mode,
+					 &cpu_data[i]);
+		}
+
+next:
+		prev_key = &key;
+	}
+	free(cpu_data);
+}
+
 int lock_contention_start(void)
 {
 	skel->bss->enabled = 1;
@@ -188,6 +305,7 @@ int lock_contention_start(void)
 int lock_contention_stop(void)
 {
 	skel->bss->enabled = 0;
+	mark_end_timestamp();
 	return 0;
 }
 
@@ -301,6 +419,8 @@ int lock_contention_read(struct lock_contention *con)
 	if (stack_trace == NULL)
 		return -1;
 
+	account_end_timestamp(con);
+
 	if (con->aggr_mode == LOCK_AGGR_TASK) {
 		struct thread *idle = __machine__findnew_thread(machine,
 								/*pid=*/0,
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 95cd8414f6ef..fb54bd38e7d0 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -19,13 +19,6 @@
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
 
-struct tstamp_data {
-	__u64 timestamp;
-	__u64 lock;
-	__u32 flags;
-	__s32 stack_id;
-};
-
 /* callstack storage  */
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
@@ -140,6 +133,8 @@ int perf_subsys_id = -1;
 /* determine the key of lock stat */
 int aggr_mode;
 
+__u64 end_ts;
+
 /* error stat */
 int task_fail;
 int stack_fail;
@@ -559,4 +554,11 @@ int BPF_PROG(collect_lock_syms)
 	return 0;
 }
 
+SEC("raw_tp/bpf_test_finish")
+int BPF_PROG(end_timestamp)
+{
+	end_ts = bpf_ktime_get_ns();
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 08482daf61be..36af11faad03 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,13 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+struct tstamp_data {
+	u64 timestamp;
+	u64 lock;
+	u32 flags;
+	u32 stack_id;
+};
+
 struct contention_key {
 	u32 stack_id;
 	u32 pid;
-- 
2.44.0.rc1.240.g4c46232300-goog


