Return-Path: <bpf+bounces-39011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40A96D7F3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05031C2301F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E019AD87;
	Thu,  5 Sep 2024 12:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB119ADA4;
	Thu,  5 Sep 2024 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538221; cv=none; b=m3s/P9oaiRMjARdOItECZRFa16aT87HhusHTbYPtiAATMSNkaF6h+HNaxiTOkFWBNoFbl+akDwg7nEO4Od1jlMdx3nTPigtpOgMwNdsbSHL92F4U/sG2WKFetJ80Y22kNwx2zhjJf2IeN+gxXYUi1Fo5H7lB9+V81twYiRoONd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538221; c=relaxed/simple;
	bh=G8AMZuaY5Ms6FfOJIWN2aoW5yJlHTpoxI2Qqg6rw1q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozdi60+VuIQacFROkA/GtdK05VMYnefLxcQebUvIlTHKgp6LldU+vB4QreOJCCaZL09pxa5p2B9/FgMtfk1GT09CS/b+dXDP6BJT6lndFqgm2yz1OzisApK/FKi3X+IKnn2idg30i7Zce8a2wrHGQSZL+UsqlGjiaELok459LrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wzypv130Hz4f3lgM;
	Thu,  5 Sep 2024 20:09:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 109201A1526;
	Thu,  5 Sep 2024 20:10:15 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with SMTP id cCh0CgBXgi6In9lmBpPPAQ--.58346S3;
	Thu, 05 Sep 2024 20:10:14 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH -next v2 1/2] perf stat: Support inherit events during fork() for bperf
Date: Thu,  5 Sep 2024 11:59:17 +0000
Message-Id: <20240905115918.772234-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905115918.772234-1-wutengda@huaweicloud.com>
References: <20240905115918.772234-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXgi6In9lmBpPPAQ--.58346S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1kGFW7Gw18AF1Dtr4kXrb_yoWfJF1fpF
	s8C34vkrWFq3y7Wwn8Xw4kCr1Sv34xu3y5Wrn5K3yftF1kJr93Ka4xKFW8ta13Wr4DCFyS
	qF1j9w4UJ3yDX3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
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
 tools/perf/util/bpf_counter.c                 | 32 +++++++--
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 70 +++++++++++++++++--
 tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
 3 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 7a8af60e0f51..94aa46f50052 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -394,6 +394,7 @@ static int bperf_check_target(struct evsel *evsel,
 }
 
 static	struct perf_cpu_map *all_cpu_map;
+static __u32 filter_entry_cnt;
 
 static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 				       struct perf_event_attr_map_entry *entry)
@@ -444,12 +445,31 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	return err;
 }
 
+/* Attach programs on demand according to filter types to reduce overhead */
+static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
+					 enum bperf_filter_type filter_type)
+{
+	struct bpf_link *link;
+	int err = 0;
+
+	if (filter_type == BPERF_FILTER_PID ||
+	    filter_type == BPERF_FILTER_TGID)
+		err = bperf_follower_bpf__attach(skel);
+	else {
+		link = bpf_program__attach(skel->progs.fexit_XXX);
+		if (IS_ERR(link))
+			err = PTR_ERR(link);
+	}
+
+	return err;
+}
+
 static int bperf__load(struct evsel *evsel, struct target *target)
 {
 	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
 	int attr_map_fd, diff_map_fd = -1, err;
 	enum bperf_filter_type filter_type;
-	__u32 filter_entry_cnt, i;
+	__u32 i;
 
 	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
 		return -1;
@@ -529,9 +549,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	/* set up reading map */
 	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
 				 filter_entry_cnt);
-	/* set up follower filter based on target */
-	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
-				 filter_entry_cnt);
 	err = bperf_follower_bpf__load(evsel->follower_skel);
 	if (err) {
 		pr_err("Failed to load follower skeleton\n");
@@ -543,6 +560,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	for (i = 0; i < filter_entry_cnt; i++) {
 		int filter_map_fd;
 		__u32 key;
+		struct bperf_filter_value fval = { i, 0 };
 
 		if (filter_type == BPERF_FILTER_PID ||
 		    filter_type == BPERF_FILTER_TGID)
@@ -553,12 +571,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 			break;
 
 		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
-		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
+		bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
 	}
 
 	evsel->follower_skel->bss->type = filter_type;
 
-	err = bperf_follower_bpf__attach(evsel->follower_skel);
+	err = bperf_attach_follower_program(evsel->follower_skel, filter_type);
 
 out:
 	if (err && evsel->bperf_leader_link_fd >= 0)
@@ -623,7 +641,7 @@ static int bperf__read(struct evsel *evsel)
 	bperf_sync_counters(evsel);
 	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
 
-	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
+	for (i = 0; i < filter_entry_cnt; i++) {
 		struct perf_cpu entry;
 		__u32 cpu;
 
diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index f193998530d4..32b944f28776 100644
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
@@ -22,7 +24,9 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bperf_filter_value));
+	__uint(max_entries, MAX_ENTRIES);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
 } filter SEC(".maps");
 
 enum bperf_filter_type type = 0;
@@ -33,14 +37,15 @@ int BPF_PROG(fexit_XXX)
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
@@ -55,16 +60,20 @@ int BPF_PROG(fexit_XXX)
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
 
@@ -75,4 +84,53 @@ int BPF_PROG(fexit_XXX)
 	return 0;
 }
 
+/* The program is only used for PID or TGID filter types. */
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
+/* The program is only used for PID or TGID filter types. */
+SEC("tp_btf/sched_process_exit")
+int BPF_PROG(on_exittask, struct task_struct *task)
+{
+	__u32 pid;
+	struct bperf_filter_value *fval;
+
+	if (!enabled)
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


