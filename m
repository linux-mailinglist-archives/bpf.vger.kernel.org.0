Return-Path: <bpf+bounces-2484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8372DB17
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643962811C9
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A7567D;
	Tue, 13 Jun 2023 07:37:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76115669
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 07:37:15 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE31A7;
	Tue, 13 Jun 2023 00:37:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QgL3k3bHcz4f3mnb;
	Tue, 13 Jun 2023 15:37:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3X7OdHIhkfcdhLg--.52188S8;
	Tue, 13 Jun 2023 15:37:08 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH bpf-next v6 4/5] selftests/bpf: Set the default value of consumer_cnt as 0
Date: Tue, 13 Jun 2023 16:09:20 +0800
Message-Id: <20230613080921.1623219-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230613080921.1623219-1-houtao@huaweicloud.com>
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3X7OdHIhkfcdhLg--.52188S8
X-Coremail-Antispam: 1UD129KBjvAXoWfCF45XFW7JFW5uw13XF4UXFb_yoW5Xr45uo
	ZxCws0q3W2gw17Xrn3J3WkCr1fuFWDAF95Xw4UWF1Yya40vw1Yga4xCw4fJ340vFWfKw1I
	qFyvqwn3K348WFn7n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Considering that only bench_ringbufs.c supports consumer, just set the
default value of consumer_cnt as 0. After that, update the validity
check of consumer_cnt, remove unused consumer_thread code snippets and
set consumer_cnt as 1 in run_bench_ringbufs.sh accordingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bench.c           |  2 +-
 .../bpf/benchs/bench_bloom_filter_map.c       | 14 ++--------
 .../benchs/bench_bpf_hashmap_full_update.c    | 10 ++-----
 .../bpf/benchs/bench_bpf_hashmap_lookup.c     | 10 ++-----
 .../selftests/bpf/benchs/bench_bpf_loop.c     | 10 ++-----
 .../selftests/bpf/benchs/bench_count.c        | 12 ---------
 .../bpf/benchs/bench_local_storage.c          | 12 ++-------
 .../bpf/benchs/bench_local_storage_create.c   |  8 +-----
 .../bench_local_storage_rcu_tasks_trace.c     | 10 ++-----
 .../selftests/bpf/benchs/bench_rename.c       | 15 ++---------
 .../selftests/bpf/benchs/bench_ringbufs.c     |  2 +-
 .../selftests/bpf/benchs/bench_strncmp.c      | 11 ++------
 .../selftests/bpf/benchs/bench_trigger.c      | 21 ++-------------
 .../bpf/benchs/run_bench_ringbufs.sh          | 26 ++++++++++---------
 14 files changed, 35 insertions(+), 128 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 56f1c166a57b..41fe5a82b88b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -17,7 +17,7 @@ struct env env = {
 	.duration_sec = 5,
 	.affinity = false,
 	.quiet = false,
-	.consumer_cnt = 1,
+	.consumer_cnt = 0,
 	.producer_cnt = 1,
 };
 
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 7c8ccc108313..e289dd1a14ee 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -107,9 +107,9 @@ const struct argp bench_bloom_map_argp = {
 
 static void validate(void)
 {
-	if (env.consumer_cnt != 1) {
+	if (env.consumer_cnt != 0) {
 		fprintf(stderr,
-			"The bloom filter benchmarks do not support multi-consumer use\n");
+			"The bloom filter benchmarks do not support consumer\n");
 		exit(1);
 	}
 }
@@ -421,18 +421,12 @@ static void measure(struct bench_res *res)
 	last_false_hits = total_false_hits;
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 const struct bench bench_bloom_lookup = {
 	.name = "bloom-lookup",
 	.argp = &bench_bloom_map_argp,
 	.validate = validate,
 	.setup = bloom_lookup_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -444,7 +438,6 @@ const struct bench bench_bloom_update = {
 	.validate = validate,
 	.setup = bloom_update_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -456,7 +449,6 @@ const struct bench bench_bloom_false_positive = {
 	.validate = validate,
 	.setup = false_positive_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = false_hits_report_progress,
 	.report_final = false_hits_report_final,
@@ -468,7 +460,6 @@ const struct bench bench_hashmap_without_bloom = {
 	.validate = validate,
 	.setup = hashmap_no_bloom_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -480,7 +471,6 @@ const struct bench bench_hashmap_with_bloom = {
 	.validate = validate,
 	.setup = hashmap_with_bloom_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
index 75abe8137b6c..ee1dc12c5e5e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
@@ -14,8 +14,8 @@ static struct ctx {
 
 static void validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 }
@@ -30,11 +30,6 @@ static void *producer(void *input)
 	return NULL;
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 static void measure(struct bench_res *res)
 {
 }
@@ -88,7 +83,6 @@ const struct bench bench_bpf_hashmap_full_update = {
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = NULL,
 	.report_final = hashmap_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
index 8dbb02f75cff..279ff1b8b5b2 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
@@ -113,8 +113,8 @@ const struct argp bench_hashmap_lookup_argp = {
 
 static void validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 
@@ -134,11 +134,6 @@ static void *producer(void *input)
 	return NULL;
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 static void measure(struct bench_res *res)
 {
 }
@@ -276,7 +271,6 @@ const struct bench bench_bpf_hashmap_lookup = {
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = NULL,
 	.report_final = hashmap_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
index d8a0394e10b1..a705cfb2bccc 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
@@ -47,8 +47,8 @@ const struct argp bench_bpf_loop_argp = {
 
 static void validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 }
@@ -62,11 +62,6 @@ static void *producer(void *input)
 	return NULL;
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 static void measure(struct bench_res *res)
 {
 	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
@@ -99,7 +94,6 @@ const struct bench bench_bpf_loop = {
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = ops_report_progress,
 	.report_final = ops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_count.c b/tools/testing/selftests/bpf/benchs/bench_count.c
index 3768945ad08e..ba89ed3936b7 100644
--- a/tools/testing/selftests/bpf/benchs/bench_count.c
+++ b/tools/testing/selftests/bpf/benchs/bench_count.c
@@ -18,11 +18,6 @@ static void *count_global_producer(void *input)
 	return NULL;
 }
 
-static void *count_global_consumer(void *input)
-{
-	return NULL;
-}
-
 static void count_global_measure(struct bench_res *res)
 {
 	struct count_global_ctx *ctx = &count_global_ctx;
@@ -56,11 +51,6 @@ static void *count_local_producer(void *input)
 	return NULL;
 }
 
-static void *count_local_consumer(void *input)
-{
-	return NULL;
-}
-
 static void count_local_measure(struct bench_res *res)
 {
 	struct count_local_ctx *ctx = &count_local_ctx;
@@ -74,7 +64,6 @@ static void count_local_measure(struct bench_res *res)
 const struct bench bench_count_global = {
 	.name = "count-global",
 	.producer_thread = count_global_producer,
-	.consumer_thread = count_global_consumer,
 	.measure = count_global_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -84,7 +73,6 @@ const struct bench bench_count_local = {
 	.name = "count-local",
 	.setup = count_local_setup,
 	.producer_thread = count_local_producer,
-	.consumer_thread = count_local_consumer,
 	.measure = count_local_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage.c b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
index d4b2817306d4..452499428ceb 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -74,8 +74,8 @@ static void validate(void)
 		fprintf(stderr, "benchmark doesn't support multi-producer!\n");
 		exit(1);
 	}
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 
@@ -230,11 +230,6 @@ static inline void trigger_bpf_program(void)
 	syscall(__NR_getpgid);
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 static void *producer(void *input)
 {
 	while (true)
@@ -259,7 +254,6 @@ const struct bench bench_local_storage_cache_seq_get = {
 	.validate = validate,
 	.setup = local_storage_cache_get_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = local_storage_report_progress,
 	.report_final = local_storage_report_final,
@@ -271,7 +265,6 @@ const struct bench bench_local_storage_cache_interleaved_get = {
 	.validate = validate,
 	.setup = local_storage_cache_get_interleaved_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = local_storage_report_progress,
 	.report_final = local_storage_report_final,
@@ -283,7 +276,6 @@ const struct bench bench_local_storage_cache_hashmap_control = {
 	.validate = validate,
 	.setup = hashmap_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = local_storage_report_progress,
 	.report_final = local_storage_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index cff703f90e95..b36de42ee4d9 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -71,7 +71,7 @@ const struct argp bench_local_storage_create_argp = {
 
 static void validate(void)
 {
-	if (env.consumer_cnt > 1) {
+	if (env.consumer_cnt != 0) {
 		fprintf(stderr,
 			"local-storage-create benchmark does not need consumer\n");
 		exit(1);
@@ -143,11 +143,6 @@ static void measure(struct bench_res *res)
 	res->drops = atomic_swap(&skel->bss->kmalloc_cnts, 0);
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 static void *sk_producer(void *input)
 {
 	struct thread *t = &threads[(long)(input)];
@@ -257,7 +252,6 @@ const struct bench bench_local_storage_create = {
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = report_progress,
 	.report_final = report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
index d5eb5587f2aa..edf0b00418c1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
@@ -72,8 +72,8 @@ static void validate(void)
 		fprintf(stderr, "benchmark doesn't support multi-producer!\n");
 		exit(1);
 	}
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 
@@ -197,11 +197,6 @@ static void measure(struct bench_res *res)
 	ctx.prev_kthread_stime = ticks;
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 static void *producer(void *input)
 {
 	while (true)
@@ -262,7 +257,6 @@ const struct bench bench_local_storage_tasks_trace = {
 	.validate = validate,
 	.setup = local_storage_tasks_trace_setup,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = report_progress,
 	.report_final = report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_rename.c b/tools/testing/selftests/bpf/benchs/bench_rename.c
index 3c203b6d6a6e..bf66893c7a33 100644
--- a/tools/testing/selftests/bpf/benchs/bench_rename.c
+++ b/tools/testing/selftests/bpf/benchs/bench_rename.c
@@ -17,8 +17,8 @@ static void validate(void)
 		fprintf(stderr, "benchmark doesn't support multi-producer!\n");
 		exit(1);
 	}
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 }
@@ -106,17 +106,11 @@ static void setup_fexit(void)
 	attach_bpf(ctx.skel->progs.prog5);
 }
 
-static void *consumer(void *input)
-{
-	return NULL;
-}
-
 const struct bench bench_rename_base = {
 	.name = "rename-base",
 	.validate = validate,
 	.setup = setup_base,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -127,7 +121,6 @@ const struct bench bench_rename_kprobe = {
 	.validate = validate,
 	.setup = setup_kprobe,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -138,7 +131,6 @@ const struct bench bench_rename_kretprobe = {
 	.validate = validate,
 	.setup = setup_kretprobe,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -149,7 +141,6 @@ const struct bench bench_rename_rawtp = {
 	.validate = validate,
 	.setup = setup_rawtp,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -160,7 +151,6 @@ const struct bench bench_rename_fentry = {
 	.validate = validate,
 	.setup = setup_fentry,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -171,7 +161,6 @@ const struct bench bench_rename_fexit = {
 	.validate = validate,
 	.setup = setup_fexit,
 	.producer_thread = producer,
-	.consumer_thread = consumer,
 	.measure = measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index fc91fdac4faa..3ca14ad36607 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -96,7 +96,7 @@ static inline void bufs_trigger_batch(void)
 static void bufs_validate(void)
 {
 	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "rb-libbpf benchmark doesn't support multi-consumer!\n");
+		fprintf(stderr, "rb-libbpf benchmark needs one consumer!\n");
 		exit(1);
 	}
 
diff --git a/tools/testing/selftests/bpf/benchs/bench_strncmp.c b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
index d3fad2ba6916..a5e1428fd7a0 100644
--- a/tools/testing/selftests/bpf/benchs/bench_strncmp.c
+++ b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
@@ -50,8 +50,8 @@ const struct argp bench_strncmp_argp = {
 
 static void strncmp_validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "strncmp benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "strncmp benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 }
@@ -128,11 +128,6 @@ static void *strncmp_producer(void *ctx)
 	return NULL;
 }
 
-static void *strncmp_consumer(void *ctx)
-{
-	return NULL;
-}
-
 static void strncmp_measure(struct bench_res *res)
 {
 	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
@@ -144,7 +139,6 @@ const struct bench bench_strncmp_no_helper = {
 	.validate = strncmp_validate,
 	.setup = strncmp_no_helper_setup,
 	.producer_thread = strncmp_producer,
-	.consumer_thread = strncmp_consumer,
 	.measure = strncmp_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -156,7 +150,6 @@ const struct bench bench_strncmp_helper = {
 	.validate = strncmp_validate,
 	.setup = strncmp_helper_setup,
 	.producer_thread = strncmp_producer,
-	.consumer_thread = strncmp_consumer,
 	.measure = strncmp_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 0c481de2833d..dbd362771d6a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -13,8 +13,8 @@ static struct counter base_hits;
 
 static void trigger_validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
 		exit(1);
 	}
 }
@@ -103,11 +103,6 @@ static void trigger_fmodret_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
 }
 
-static void *trigger_consumer(void *input)
-{
-	return NULL;
-}
-
 /* make sure call is not inlined and not avoided by compiler, so __weak and
  * inline asm volatile in the body of the function
  *
@@ -205,7 +200,6 @@ const struct bench bench_trig_base = {
 	.name = "trig-base",
 	.validate = trigger_validate,
 	.producer_thread = trigger_base_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_base_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -216,7 +210,6 @@ const struct bench bench_trig_tp = {
 	.validate = trigger_validate,
 	.setup = trigger_tp_setup,
 	.producer_thread = trigger_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -227,7 +220,6 @@ const struct bench bench_trig_rawtp = {
 	.validate = trigger_validate,
 	.setup = trigger_rawtp_setup,
 	.producer_thread = trigger_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -238,7 +230,6 @@ const struct bench bench_trig_kprobe = {
 	.validate = trigger_validate,
 	.setup = trigger_kprobe_setup,
 	.producer_thread = trigger_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -249,7 +240,6 @@ const struct bench bench_trig_fentry = {
 	.validate = trigger_validate,
 	.setup = trigger_fentry_setup,
 	.producer_thread = trigger_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -260,7 +250,6 @@ const struct bench bench_trig_fentry_sleep = {
 	.validate = trigger_validate,
 	.setup = trigger_fentry_sleep_setup,
 	.producer_thread = trigger_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -271,7 +260,6 @@ const struct bench bench_trig_fmodret = {
 	.validate = trigger_validate,
 	.setup = trigger_fmodret_setup,
 	.producer_thread = trigger_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -281,7 +269,6 @@ const struct bench bench_trig_uprobe_base = {
 	.name = "trig-uprobe-base",
 	.setup = NULL, /* no uprobe/uretprobe is attached */
 	.producer_thread = uprobe_base_producer,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_base_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -291,7 +278,6 @@ const struct bench bench_trig_uprobe_with_nop = {
 	.name = "trig-uprobe-with-nop",
 	.setup = uprobe_setup_with_nop,
 	.producer_thread = uprobe_producer_with_nop,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -301,7 +287,6 @@ const struct bench bench_trig_uretprobe_with_nop = {
 	.name = "trig-uretprobe-with-nop",
 	.setup = uretprobe_setup_with_nop,
 	.producer_thread = uprobe_producer_with_nop,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -311,7 +296,6 @@ const struct bench bench_trig_uprobe_without_nop = {
 	.name = "trig-uprobe-without-nop",
 	.setup = uprobe_setup_without_nop,
 	.producer_thread = uprobe_producer_without_nop,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
@@ -321,7 +305,6 @@ const struct bench bench_trig_uretprobe_without_nop = {
 	.name = "trig-uretprobe-without-nop",
 	.setup = uretprobe_setup_without_nop,
 	.producer_thread = uprobe_producer_without_nop,
-	.consumer_thread = trigger_consumer,
 	.measure = trigger_measure,
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index ada028aa9007..91e3567962ff 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -4,46 +4,48 @@ source ./benchs/run_common.sh
 
 set -eufo pipefail
 
+RUN_RB_BENCH="$RUN_BENCH -c1"
+
 header "Single-producer, parallel producer"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
-	summarize $b "$($RUN_BENCH $b)"
+	summarize $b "$($RUN_RB_BENCH $b)"
 done
 
 header "Single-producer, parallel producer, sampled notification"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
-	summarize $b "$($RUN_BENCH --rb-sampled $b)"
+	summarize $b "$($RUN_RB_BENCH --rb-sampled $b)"
 done
 
 header "Single-producer, back-to-back mode"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
-	summarize $b "$($RUN_BENCH --rb-b2b $b)"
-	summarize $b-sampled "$($RUN_BENCH --rb-sampled --rb-b2b $b)"
+	summarize $b "$($RUN_RB_BENCH --rb-b2b $b)"
+	summarize $b-sampled "$($RUN_RB_BENCH --rb-sampled --rb-b2b $b)"
 done
 
 header "Ringbuf back-to-back, effect of sample rate"
 for b in 1 5 10 25 50 100 250 500 1000 2000 3000; do
-	summarize "rb-sampled-$b" "$($RUN_BENCH --rb-b2b --rb-batch-cnt $b --rb-sampled --rb-sample-rate $b rb-custom)"
+	summarize "rb-sampled-$b" "$($RUN_RB_BENCH --rb-b2b --rb-batch-cnt $b --rb-sampled --rb-sample-rate $b rb-custom)"
 done
 header "Perfbuf back-to-back, effect of sample rate"
 for b in 1 5 10 25 50 100 250 500 1000 2000 3000; do
-	summarize "pb-sampled-$b" "$($RUN_BENCH --rb-b2b --rb-batch-cnt $b --rb-sampled --rb-sample-rate $b pb-custom)"
+	summarize "pb-sampled-$b" "$($RUN_RB_BENCH --rb-b2b --rb-batch-cnt $b --rb-sampled --rb-sample-rate $b pb-custom)"
 done
 
 header "Ringbuf back-to-back, reserve+commit vs output"
-summarize "reserve" "$($RUN_BENCH --rb-b2b                 rb-custom)"
-summarize "output"  "$($RUN_BENCH --rb-b2b --rb-use-output rb-custom)"
+summarize "reserve" "$($RUN_RB_BENCH --rb-b2b                 rb-custom)"
+summarize "output"  "$($RUN_RB_BENCH --rb-b2b --rb-use-output rb-custom)"
 
 header "Ringbuf sampled, reserve+commit vs output"
-summarize "reserve-sampled" "$($RUN_BENCH --rb-sampled                 rb-custom)"
-summarize "output-sampled"  "$($RUN_BENCH --rb-sampled --rb-use-output rb-custom)"
+summarize "reserve-sampled" "$($RUN_RB_BENCH --rb-sampled                 rb-custom)"
+summarize "output-sampled"  "$($RUN_RB_BENCH --rb-sampled --rb-use-output rb-custom)"
 
 header "Single-producer, consumer/producer competing on the same CPU, low batch count"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
-	summarize $b "$($RUN_BENCH --rb-batch-cnt 1 --rb-sample-rate 1 --prod-affinity 0 --cons-affinity 0 $b)"
+	summarize $b "$($RUN_RB_BENCH --rb-batch-cnt 1 --rb-sample-rate 1 --prod-affinity 0 --cons-affinity 0 $b)"
 done
 
 header "Ringbuf, multi-producer contention"
 for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
-	summarize "rb-libbpf nr_prod $b" "$($RUN_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
+	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
 done
 
-- 
2.29.2


