Return-Path: <bpf+bounces-17085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54F80992E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377E828222F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659DB1FB4;
	Fri,  8 Dec 2023 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee3CTp94"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63291719;
	Thu,  7 Dec 2023 18:28:16 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b9b90f8708so1090067b6e.2;
        Thu, 07 Dec 2023 18:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702002496; x=1702607296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IzrTp4CVflWPKS8RfWxv0dB/to3ENLCGnIZ/8i2cW0k=;
        b=Ee3CTp9419g0D3S0i9PeoAx6AXAvoS1ERZ8jnbMT6zCkQY001Uh51Xd058cz/GJjRy
         80SvmtGj3F3QjoDefwRHRS2qgFLLbEwSHzYKHXS+4zDJ4xwR9+YzWoXV4Ds4rI7N9dZ3
         EHs9YnJPKZO5ZINmIHOENyqOvxUG3n876yQKKJNgy2AVOEpw79pJPV0UsiMfYMcmd6Q/
         Fb/d6Um7ucW09Jpa8vumcgPgiy2lwh0Xwlo3DLp2PwgKMB2hTskTJJwEE8Mq/N3Dyzg/
         JWRnvcfe5Z0/T35AEequumG10D69zMFFHLd6iSI0hcha+Qktnu2dhr+OyjFx9xOFqkTa
         DD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702002496; x=1702607296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzrTp4CVflWPKS8RfWxv0dB/to3ENLCGnIZ/8i2cW0k=;
        b=AlaxCbKbm/JQvX1C24V2qV8nqv7psxGWMvN5O+MYYDpzGysnrC1y2Mv354dtcXk++v
         cLkubwrhvbEJvqmC9trvVfPUtw3JnJC+PuNkXokvA6GAmF4b7X7fEdLzT+1sOFdnk+Fo
         t8bXykpkKQeifVu402g5p4wlUgBMAaJ6m1r4IxCxt56+RzD9QcPqT0av7bk9pRM0vEj6
         LXdR9SMinPrDPFTxkI54lBf32LOCExH/Pt6RcqUDN50OLhDs7+StGJADte6pwyeZ67bl
         ouxBiKXrV3oJjbmPEMwqrbPumpo7WzTftsgRA7DWTphrkvGh3TLVAYXxX8A9zUXc/Ui7
         0n9Q==
X-Gm-Message-State: AOJu0Yyqp++600DQmlv5edYCMB45QufTSYskYSfEHLxz1gnhHpNHaaaN
	Hx4phYUf1w6rF2rentdzrJU=
X-Google-Smtp-Source: AGHT+IE7v2bgMmvBcSyKkIr9h6uOw86foWCdYP04toRFeVg3xPkne7EtX6cp6VqBUS3/+LSg2c9KdQ==
X-Received: by 2002:a54:419a:0:b0:3b9:eb71:ee6f with SMTP id 26-20020a54419a000000b003b9eb71ee6fmr93857oiy.61.1702002495941;
        Thu, 07 Dec 2023 18:28:15 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:c5f1:ea67:a613:5fe])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006ce97bd5d04sm482330pfb.140.2023.12.07.18.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:28:15 -0800 (PST)
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
Subject: [PATCH] perf lock contention: Account contending locks too
Date: Thu,  7 Dec 2023 18:28:13 -0800
Message-ID: <20231208022813.219673-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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
 tools/perf/util/bpf_lock_contention.c         | 116 ++++++++++++++++++
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  16 +--
 tools/perf/util/bpf_skel/lock_data.h          |   7 ++
 3 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index e105245eb905..2476459bf2ef 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -178,6 +178,119 @@ int lock_contention_prepare(struct lock_contention *con)
 	return 0;
 }
 
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
@@ -187,6 +300,7 @@ int lock_contention_start(void)
 int lock_contention_stop(void)
 {
 	skel->bss->enabled = 0;
+	mark_end_timestamp();
 	return 0;
 }
 
@@ -300,6 +414,8 @@ int lock_contention_read(struct lock_contention *con)
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
2.43.0.472.g3155946c3a-goog


