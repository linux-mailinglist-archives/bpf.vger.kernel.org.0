Return-Path: <bpf+bounces-18537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1481B95A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32BF1C25B7A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7016D6DA;
	Thu, 21 Dec 2023 14:14:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B23608D
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwsqV0vpsz4f3jql
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:13:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 83AAC1A0603
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:13:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhAkSIRl5A8DEQ--.16750S5;
	Thu, 21 Dec 2023 22:13:59 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 1/2] selftests/bpf: Move bench specific metrics into union of structs
Date: Thu, 21 Dec 2023 22:15:00 +0800
Message-Id: <20231221141501.3588586-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231221141501.3588586-1-houtao@huaweicloud.com>
References: <20231221141501.3588586-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhAkSIRl5A8DEQ--.16750S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWfJw17uw15ZFW7Kry3Jwb_yoWxGFWxpa
	n2934Dtr4jyFn7Xws7Cr4DW3y3Arn7XFW5WFy7C34xZF47JFyfur4xKFW8tFnxZFZYqF4a
	vanxtwnYqw4UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-TmDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Various benchmarks define its specific metrics in bench_res. This not
only bloats the size of bench_res, but also make the code that tries to
reuse the space hard to follow.

So move benchmark specific metrics into stand-alone structs and pack
these structs into a union to reduce the size of bench_res.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bench.c               |  9 +++++----
 tools/testing/selftests/bpf/bench.h               | 15 ++++++++++++---
 .../testing/selftests/bpf/benchs/bench_htab_mem.c | 10 +++++-----
 .../benchs/bench_local_storage_rcu_tasks_trace.c  | 10 +++++-----
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 73ce11b0547d..4832cd4b1c3d 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -88,9 +88,10 @@ grace_period_latency_basic_stats(struct bench_res res[], int res_cnt, struct bas
 	memset(gp_stat, 0, sizeof(struct basic_stats));
 
 	for (i = 0; i < res_cnt; i++)
-		gp_stat->mean += res[i].gp_ns / 1000.0 / (double)res[i].gp_ct / (0.0 + res_cnt);
+		gp_stat->mean += res[i].rcu.gp_ns / 1000.0 / (double)res[i].rcu.gp_ct /
+				 (0.0 + res_cnt);
 
-#define IT_MEAN_DIFF (res[i].gp_ns / 1000.0 / (double)res[i].gp_ct - gp_stat->mean)
+#define IT_MEAN_DIFF (res[i].rcu.gp_ns / 1000.0 / (double)res[i].rcu.gp_ct - gp_stat->mean)
 	if (res_cnt > 1) {
 		for (i = 0; i < res_cnt; i++)
 			gp_stat->stddev += (IT_MEAN_DIFF * IT_MEAN_DIFF) / (res_cnt - 1.0);
@@ -106,9 +107,9 @@ grace_period_ticks_basic_stats(struct bench_res res[], int res_cnt, struct basic
 
 	memset(gp_stat, 0, sizeof(struct basic_stats));
 	for (i = 0; i < res_cnt; i++)
-		gp_stat->mean += res[i].stime / (double)res[i].gp_ct / (0.0 + res_cnt);
+		gp_stat->mean += res[i].rcu.stime / (double)res[i].rcu.gp_ct / (0.0 + res_cnt);
 
-#define IT_MEAN_DIFF (res[i].stime / (double)res[i].gp_ct - gp_stat->mean)
+#define IT_MEAN_DIFF (res[i].rcu.stime / (double)res[i].rcu.gp_ct - gp_stat->mean)
 	if (res_cnt > 1) {
 		for (i = 0; i < res_cnt; i++)
 			gp_stat->stddev += (IT_MEAN_DIFF * IT_MEAN_DIFF) / (res_cnt - 1.0);
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 68180d8f8558..a6fcf111221f 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -42,9 +42,18 @@ struct bench_res {
 	long drops;
 	long false_hits;
 	long important_hits;
-	unsigned long gp_ns;
-	unsigned long gp_ct;
-	unsigned int stime;
+
+	/* benchmark specific metrics */
+	union {
+		struct {
+			unsigned long bytes;
+		} htab;
+		struct {
+			unsigned long gp_ns;
+			unsigned long gp_ct;
+			unsigned int stime;
+		} rcu;
+	};
 };
 
 struct bench {
diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 9146d3f414d2..2f37826332ed 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -293,7 +293,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 static void htab_mem_measure(struct bench_res *res)
 {
 	res->hits = atomic_swap(&ctx.skel->bss->op_cnt, 0) / env.producer_cnt;
-	htab_mem_read_mem_cgrp_file("memory.current", &res->gp_ct);
+	htab_mem_read_mem_cgrp_file("memory.current", &res->htab.bytes);
 }
 
 static void htab_mem_report_progress(int iter, struct bench_res *res, long delta_ns)
@@ -301,7 +301,7 @@ static void htab_mem_report_progress(int iter, struct bench_res *res, long delta
 	double loop, mem;
 
 	loop = res->hits / 1000.0 / (delta_ns / 1000000000.0);
-	mem = res->gp_ct / 1048576.0;
+	mem = res->htab.bytes / 1048576.0;
 	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
 	printf("per-prod-op %7.2lfk/s, memory usage %7.2lfMiB\n", loop, mem);
 }
@@ -315,15 +315,15 @@ static void htab_mem_report_final(struct bench_res res[], int res_cnt)
 
 	for (i = 0; i < res_cnt; i++) {
 		loop_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
-		mem_mean += res[i].gp_ct / 1048576.0 / (0.0 + res_cnt);
+		mem_mean += res[i].htab.bytes / 1048576.0 / (0.0 + res_cnt);
 	}
 	if (res_cnt > 1)  {
 		for (i = 0; i < res_cnt; i++) {
 			loop_stddev += (loop_mean - res[i].hits / 1000.0) *
 				       (loop_mean - res[i].hits / 1000.0) /
 				       (res_cnt - 1.0);
-			mem_stddev += (mem_mean - res[i].gp_ct / 1048576.0) *
-				      (mem_mean - res[i].gp_ct / 1048576.0) /
+			mem_stddev += (mem_mean - res[i].htab.bytes / 1048576.0) *
+				      (mem_mean - res[i].htab.bytes / 1048576.0) /
 				      (res_cnt - 1.0);
 		}
 		loop_stddev = sqrt(loop_stddev);
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
index edf0b00418c1..4842f4f2bbea 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
@@ -190,10 +190,10 @@ static void measure(struct bench_res *res)
 {
 	long ticks;
 
-	res->gp_ct = atomic_swap(&ctx.skel->bss->gp_hits, 0);
-	res->gp_ns = atomic_swap(&ctx.skel->bss->gp_times, 0);
+	res->rcu.gp_ct = atomic_swap(&ctx.skel->bss->gp_hits, 0);
+	res->rcu.gp_ns = atomic_swap(&ctx.skel->bss->gp_times, 0);
 	ticks = kthread_pid_ticks();
-	res->stime = ticks - ctx.prev_kthread_stime;
+	res->rcu.stime = ticks - ctx.prev_kthread_stime;
 	ctx.prev_kthread_stime = ticks;
 }
 
@@ -216,9 +216,9 @@ static void report_progress(int iter, struct bench_res *res, long delta_ns)
 		return;
 
 	printf("Iter %d\t avg tasks_trace grace period latency\t%lf ns\n",
-	       iter, res->gp_ns / (double)res->gp_ct);
+	       iter, res->rcu.gp_ns / (double)res->rcu.gp_ct);
 	printf("Iter %d\t avg ticks per tasks_trace grace period\t%lf\n",
-	       iter, res->stime / (double)res->gp_ct);
+	       iter, res->rcu.stime / (double)res->rcu.gp_ct);
 }
 
 static void report_final(struct bench_res res[], int res_cnt)
-- 
2.29.2


