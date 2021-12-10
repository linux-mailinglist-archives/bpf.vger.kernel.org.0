Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB447024F
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhLJOFP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 09:05:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15725 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhLJOFO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 09:05:14 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9XYv5d4qzZd0m;
        Fri, 10 Dec 2021 21:58:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 22:01:36 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: fix checkpatch error on empty function parameter
Date:   Fri, 10 Dec 2021 22:16:50 +0800
Message-ID: <20211210141652.877186-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210141652.877186-1-houtao1@huawei.com>
References: <20211210141652.877186-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix checkpatch error: "ERROR: Bad function definition - void foo()
should probably be void foo(void)". Most replacements are done by
the following command:

  sed -i 's#\([a-z]\)()$#\1(void)#g' testing/selftests/bpf/benchs/*.c

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bench.c           |  2 +-
 tools/testing/selftests/bpf/bench.h           |  9 +++----
 .../selftests/bpf/benchs/bench_count.c        |  2 +-
 .../selftests/bpf/benchs/bench_rename.c       | 16 ++++++-------
 .../selftests/bpf/benchs/bench_ringbufs.c     | 14 +++++------
 .../selftests/bpf/benchs/bench_trigger.c      | 24 +++++++++----------
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d6082b97a56..ffe5752f3324 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -39,7 +39,7 @@ static int bump_memlock_rlimit(void)
 	return setrlimit(RLIMIT_MEMLOCK, &rlim_new);
 }
 
-void setup_libbpf()
+void setup_libbpf(void)
 {
 	int err;
 
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 50785503756b..fb3e213df3dc 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -38,8 +38,8 @@ struct bench_res {
 
 struct bench {
 	const char *name;
-	void (*validate)();
-	void (*setup)();
+	void (*validate)(void);
+	void (*setup)(void);
 	void *(*producer_thread)(void *ctx);
 	void *(*consumer_thread)(void *ctx);
 	void (*measure)(struct bench_res* res);
@@ -54,7 +54,7 @@ struct counter {
 extern struct env env;
 extern const struct bench *bench;
 
-void setup_libbpf();
+void setup_libbpf(void);
 void hits_drops_report_progress(int iter, struct bench_res *res, long delta_ns);
 void hits_drops_report_final(struct bench_res res[], int res_cnt);
 void false_hits_report_progress(int iter, struct bench_res *res, long delta_ns);
@@ -62,7 +62,8 @@ void false_hits_report_final(struct bench_res res[], int res_cnt);
 void ops_report_progress(int iter, struct bench_res *res, long delta_ns);
 void ops_report_final(struct bench_res res[], int res_cnt);
 
-static inline __u64 get_time_ns() {
+static inline __u64 get_time_ns(void)
+{
 	struct timespec t;
 
 	clock_gettime(CLOCK_MONOTONIC, &t);
diff --git a/tools/testing/selftests/bpf/benchs/bench_count.c b/tools/testing/selftests/bpf/benchs/bench_count.c
index befba7a82643..078972ce208e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_count.c
+++ b/tools/testing/selftests/bpf/benchs/bench_count.c
@@ -36,7 +36,7 @@ static struct count_local_ctx {
 	struct counter *hits;
 } count_local_ctx;
 
-static void count_local_setup()
+static void count_local_setup(void)
 {
 	struct count_local_ctx *ctx = &count_local_ctx;
 
diff --git a/tools/testing/selftests/bpf/benchs/bench_rename.c b/tools/testing/selftests/bpf/benchs/bench_rename.c
index c7ec114eca56..3c203b6d6a6e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_rename.c
+++ b/tools/testing/selftests/bpf/benchs/bench_rename.c
@@ -11,7 +11,7 @@ static struct ctx {
 	int fd;
 } ctx;
 
-static void validate()
+static void validate(void)
 {
 	if (env.producer_cnt != 1) {
 		fprintf(stderr, "benchmark doesn't support multi-producer!\n");
@@ -43,7 +43,7 @@ static void measure(struct bench_res *res)
 	res->hits = atomic_swap(&ctx.hits.value, 0);
 }
 
-static void setup_ctx()
+static void setup_ctx(void)
 {
 	setup_libbpf();
 
@@ -71,36 +71,36 @@ static void attach_bpf(struct bpf_program *prog)
 	}
 }
 
-static void setup_base()
+static void setup_base(void)
 {
 	setup_ctx();
 }
 
-static void setup_kprobe()
+static void setup_kprobe(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.prog1);
 }
 
-static void setup_kretprobe()
+static void setup_kretprobe(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.prog2);
 }
 
-static void setup_rawtp()
+static void setup_rawtp(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.prog3);
 }
 
-static void setup_fentry()
+static void setup_fentry(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.prog4);
 }
 
-static void setup_fexit()
+static void setup_fexit(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.prog5);
diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index 52d4a2f91dbd..da8593b3494a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -88,12 +88,12 @@ const struct argp bench_ringbufs_argp = {
 
 static struct counter buf_hits;
 
-static inline void bufs_trigger_batch()
+static inline void bufs_trigger_batch(void)
 {
 	(void)syscall(__NR_getpgid);
 }
 
-static void bufs_validate()
+static void bufs_validate(void)
 {
 	if (env.consumer_cnt != 1) {
 		fprintf(stderr, "rb-libbpf benchmark doesn't support multi-consumer!\n");
@@ -132,7 +132,7 @@ static void ringbuf_libbpf_measure(struct bench_res *res)
 	res->drops = atomic_swap(&ctx->skel->bss->dropped, 0);
 }
 
-static struct ringbuf_bench *ringbuf_setup_skeleton()
+static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 {
 	struct ringbuf_bench *skel;
 
@@ -167,7 +167,7 @@ static int buf_process_sample(void *ctx, void *data, size_t len)
 	return 0;
 }
 
-static void ringbuf_libbpf_setup()
+static void ringbuf_libbpf_setup(void)
 {
 	struct ringbuf_libbpf_ctx *ctx = &ringbuf_libbpf_ctx;
 	struct bpf_link *link;
@@ -223,7 +223,7 @@ static void ringbuf_custom_measure(struct bench_res *res)
 	res->drops = atomic_swap(&ctx->skel->bss->dropped, 0);
 }
 
-static void ringbuf_custom_setup()
+static void ringbuf_custom_setup(void)
 {
 	struct ringbuf_custom_ctx *ctx = &ringbuf_custom_ctx;
 	const size_t page_size = getpagesize();
@@ -352,7 +352,7 @@ static void perfbuf_measure(struct bench_res *res)
 	res->drops = atomic_swap(&ctx->skel->bss->dropped, 0);
 }
 
-static struct perfbuf_bench *perfbuf_setup_skeleton()
+static struct perfbuf_bench *perfbuf_setup_skeleton(void)
 {
 	struct perfbuf_bench *skel;
 
@@ -390,7 +390,7 @@ perfbuf_process_sample_raw(void *input_ctx, int cpu,
 	return LIBBPF_PERF_EVENT_CONT;
 }
 
-static void perfbuf_libbpf_setup()
+static void perfbuf_libbpf_setup(void)
 {
 	struct perfbuf_libbpf_ctx *ctx = &perfbuf_libbpf_ctx;
 	struct perf_event_attr attr;
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 049a5ad56f65..7f957c55a3ca 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -11,7 +11,7 @@ static struct trigger_ctx {
 
 static struct counter base_hits;
 
-static void trigger_validate()
+static void trigger_validate(void)
 {
 	if (env.consumer_cnt != 1) {
 		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
@@ -45,7 +45,7 @@ static void trigger_measure(struct bench_res *res)
 	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
 }
 
-static void setup_ctx()
+static void setup_ctx(void)
 {
 	setup_libbpf();
 
@@ -67,37 +67,37 @@ static void attach_bpf(struct bpf_program *prog)
 	}
 }
 
-static void trigger_tp_setup()
+static void trigger_tp_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_tp);
 }
 
-static void trigger_rawtp_setup()
+static void trigger_rawtp_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_raw_tp);
 }
 
-static void trigger_kprobe_setup()
+static void trigger_kprobe_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_kprobe);
 }
 
-static void trigger_fentry_setup()
+static void trigger_fentry_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
-static void trigger_fentry_sleep_setup()
+static void trigger_fentry_sleep_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry_sleep);
 }
 
-static void trigger_fmodret_setup()
+static void trigger_fmodret_setup(void)
 {
 	setup_ctx();
 	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
@@ -183,22 +183,22 @@ static void usetup(bool use_retprobe, bool use_nop)
 	ctx.skel->links.bench_trigger_uprobe = link;
 }
 
-static void uprobe_setup_with_nop()
+static void uprobe_setup_with_nop(void)
 {
 	usetup(false, true);
 }
 
-static void uretprobe_setup_with_nop()
+static void uretprobe_setup_with_nop(void)
 {
 	usetup(true, true);
 }
 
-static void uprobe_setup_without_nop()
+static void uprobe_setup_without_nop(void)
 {
 	usetup(false, false);
 }
 
-static void uretprobe_setup_without_nop()
+static void uretprobe_setup_without_nop(void)
 {
 	usetup(true, false);
 }
-- 
2.29.2

