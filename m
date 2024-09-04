Return-Path: <bpf+bounces-38875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2295D96BC9F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F081F249E2
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1801DA0E1;
	Wed,  4 Sep 2024 12:41:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8011D933F;
	Wed,  4 Sep 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453681; cv=none; b=HGyTzsJj5Lh25J+dCnNbWI6cghnCKNM64uxNHy0avOdIlJMK0LUpS5c3/sdKC1kPS57MrjH+YK7sPtTRzW/Vfupot87LJ/RbbODIy36w50bC3MnBnnBd/p2IRWqE7MMMgIBE9RKotxy5mois4qw01c4A6ZvQBJSai23kB66Ar1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453681; c=relaxed/simple;
	bh=lowLeyR+xHlrAnHD2nZ4ZaPMu2OSE8aIfuH/DrqDVPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbKtPKIuVmccWABezXrMHYN7ydtAWWUY3IqVyw/2D8brF7JayOhougnbld9Hqd+5tbIG75xLSNVcHSW0yf19NpkROnrwJkp5mJipsFKLSvx4UBs0mUwJu8mvBBYhLBcLcNPyg9Kpw/oWUi2BJkb0tckWO0CRGKm5CkM84v6NdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzMY81yjFz4f3jHj;
	Wed,  4 Sep 2024 20:41:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 47C9C1A1337;
	Wed,  4 Sep 2024 20:41:15 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with SMTP id Syh0CgCHvGFdVdhmhod9AQ--.48162S3;
	Wed, 04 Sep 2024 20:41:15 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH -next 1/2] perf stat: Support inherit events during fork() for bperf
Date: Wed,  4 Sep 2024 12:31:02 +0000
Message-Id: <20240904123103.732507-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904123103.732507-1-wutengda@huaweicloud.com>
References: <20240904123103.732507-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHvGFdVdhmhod9AQ--.48162S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1kGFW7Gw18AF1Dtr4kXrb_yoW3Jry3pF
	s5C34vk3yFg3y7Cwn8Xw4kGryfAryfu3y5WFn3K3ySyF1kJr93Ka1xKFW5t3W3Wr4DCFyS
	qF12kw4UG3ykX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

bperf has a nice ability to share PMUs, but it still does not support
inherit events during fork(), resulting in some deviations in its stat
results compared with perf.

perf stat result:
  $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop

   Performance counter stats for './perf test -w sqrtloop':

       2,316,038,116      cycles
       2,859,350,725      instructions                     #    1.23  insn per cycle

         1.009603637 seconds time elapsed

         1.004196000 seconds user
         0.003950000 seconds sys

bperf stat result:
  $ ./perf stat --bpf-counters -e cycles,instructions -- ./perf test -w sqrtloop

   Performance counter stats for './perf test -w sqrtloop':

          18,762,093      cycles
          23,487,766      instructions                     #    1.25  insn per cycle

         1.008913769 seconds time elapsed

         1.003248000 seconds user
         0.004069000 seconds sys

In order to support event inheritance, two new bpf programs are added
to monitor the fork and exit of tasks respectively. When a task is
created, add it to the filter map to enable counting, and reuse the
`accum_key` of its parent task to count together with the parent task.
When a task exits, remove it from the filter map to disable counting.

After support:
  $ ./perf stat --bpf-counters -e cycles,instructions -- ./perf test -w sqrtloop

   Performance counter stats for './perf test -w sqrtloop':

       2,316,543,537      cycles
       2,859,677,779      instructions                     #    1.23  insn per cycle

         1.009566332 seconds time elapsed

         1.004414000 seconds user
         0.003545000 seconds sys

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/bpf_counter.c                 |  9 +--
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 75 +++++++++++++++++--
 tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
 3 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 7a8af60e0f51..e07ff04b934f 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -529,9 +529,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	/* set up reading map */
 	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
 				 filter_entry_cnt);
-	/* set up follower filter based on target */
-	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
-				 filter_entry_cnt);
 	err = bperf_follower_bpf__load(evsel->follower_skel);
 	if (err) {
 		pr_err("Failed to load follower skeleton\n");
@@ -543,6 +540,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	for (i = 0; i < filter_entry_cnt; i++) {
 		int filter_map_fd;
 		__u32 key;
+		struct bperf_filter_value fval = { i, 0 };
 
 		if (filter_type == BPERF_FILTER_PID ||
 		    filter_type == BPERF_FILTER_TGID)
@@ -553,10 +551,11 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 			break;
 
 		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
-		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
+		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
 	}
 
 	evsel->follower_skel->bss->type = filter_type;
+	evsel->follower_skel->bss->init_filter_entries = filter_entry_cnt;
 
 	err = bperf_follower_bpf__attach(evsel->follower_skel);
 
@@ -623,7 +622,7 @@ static int bperf__read(struct evsel *evsel)
 	bperf_sync_counters(evsel);
 	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
 
-	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
+	for (i = 0; i < skel->bss->init_filter_entries; i++) {
 		struct perf_cpu entry;
 		__u32 cpu;
 
diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index f193998530d4..59fab421526a 100644
--- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -5,6 +5,8 @@
 #include <bpf/bpf_tracing.h>
 #include "bperf_u.h"
 
+#define MAX_ENTRIES 102400
+
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(__u32));
@@ -22,25 +24,29 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bperf_filter_value));
+	__uint(max_entries, MAX_ENTRIES);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
 } filter SEC(".maps");
 
 enum bperf_filter_type type = 0;
 int enabled = 0;
+__u32 init_filter_entries = 0;
 
 SEC("fexit/XXX")
 int BPF_PROG(fexit_XXX)
 {
 	struct bpf_perf_event_value *diff_val, *accum_val;
 	__u32 filter_key, zero = 0;
-	__u32 *accum_key;
+	__u32 accum_key;
+	struct bperf_filter_value *fval;
 
 	if (!enabled)
 		return 0;
 
 	switch (type) {
 	case BPERF_FILTER_GLOBAL:
-		accum_key = &zero;
+		accum_key = zero;
 		goto do_add;
 	case BPERF_FILTER_CPU:
 		filter_key = bpf_get_smp_processor_id();
@@ -55,16 +61,20 @@ int BPF_PROG(fexit_XXX)
 		return 0;
 	}
 
-	accum_key = bpf_map_lookup_elem(&filter, &filter_key);
-	if (!accum_key)
+	fval = bpf_map_lookup_elem(&filter, &filter_key);
+	if (!fval)
 		return 0;
 
+	accum_key = fval->accum_key;
+	if (fval->exited)
+		bpf_map_delete_elem(&filter, &filter_key);
+
 do_add:
 	diff_val = bpf_map_lookup_elem(&diff_readings, &zero);
 	if (!diff_val)
 		return 0;
 
-	accum_val = bpf_map_lookup_elem(&accum_readings, accum_key);
+	accum_val = bpf_map_lookup_elem(&accum_readings, &accum_key);
 	if (!accum_val)
 		return 0;
 
@@ -75,4 +85,57 @@ int BPF_PROG(fexit_XXX)
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(on_newtask, struct task_struct *task, __u64 clone_flags)
+{
+	__u32 parent_pid, child_pid;
+	struct bperf_filter_value *parent_fval;
+	struct bperf_filter_value child_fval = { 0 };
+
+	if (!enabled)
+		return 0;
+
+	if (type != BPERF_FILTER_PID && type != BPERF_FILTER_TGID)
+		return 0;
+
+	parent_pid = bpf_get_current_pid_tgid() >> 32;
+	child_pid = task->pid;
+
+	/* Check if the current task is one of the target tasks to be counted */
+	parent_fval = bpf_map_lookup_elem(&filter, &parent_pid);
+	if (!parent_fval)
+		return 0;
+
+	/* Start counting for the new task by adding it into filter map,
+	 * inherit the accum key of its parent task so that they can be
+	 * counted together.
+	 */
+	child_fval.accum_key = parent_fval->accum_key;
+	child_fval.exited = 0;
+	bpf_map_update_elem(&filter, &child_pid, &child_fval, BPF_NOEXIST);
+
+	return 0;
+}
+
+SEC("tp_btf/sched_process_exit")
+int BPF_PROG(on_exittask, struct task_struct *task)
+{
+	__u32 pid;
+	struct bperf_filter_value *fval;
+
+	if (!enabled)
+		return 0;
+
+	if (type != BPERF_FILTER_PID && type != BPERF_FILTER_TGID)
+		return 0;
+
+	/* Stop counting for this task by removing it from filter map */
+	pid = task->pid;
+	fval = bpf_map_lookup_elem(&filter, &pid);
+	if (fval)
+		fval->exited = 1;
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/bpf_skel/bperf_u.h b/tools/perf/util/bpf_skel/bperf_u.h
index 1ce0c2c905c1..4a4a753980be 100644
--- a/tools/perf/util/bpf_skel/bperf_u.h
+++ b/tools/perf/util/bpf_skel/bperf_u.h
@@ -11,4 +11,9 @@ enum bperf_filter_type {
 	BPERF_FILTER_TGID,
 };
 
+struct bperf_filter_value {
+	__u32 accum_key;
+	__u8 exited;
+};
+
 #endif /* __BPERF_STAT_U_H */
-- 
2.34.1


