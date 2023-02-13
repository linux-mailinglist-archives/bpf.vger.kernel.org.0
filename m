Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36357694083
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBMJPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBMJPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF813DD9
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id dr8so30064821ejc.12
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxC5geNftNz7pNhBaszDaSbuGagvhaLaeTShebpA0P0=;
        b=EQS/151uKrXGf2Q7Os27LLNDT0QP7R6p82NDLMKARSgLxZ/9kDH9cClGDtkJn7cTBU
         SHmLTvPJhBoz5RX/hQEIkKAFXD3vrL6v7B6Nh/rT/6KLuebFy/4Ut33GEGfQ+6QDZP38
         HbDsQtLS44oa2mvKxhxD3SIilxbuhiPwSaXtE537de3dP5NO5u6/dw1DR21oRJLyih2i
         u64iU7+9iRZibZMrtv1IAh++dIcXDu+No7axQsgU56cSHKK64+N04CXD0L2APpgGUSDc
         yP3AvQ1Ylau+w0qJbLxO4vGHwzctK5g84E7jULLS4qkMD+T4WOeiYMmbR74DXTYKr093
         ZTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxC5geNftNz7pNhBaszDaSbuGagvhaLaeTShebpA0P0=;
        b=IvqLKwex60+PAjKSES4AfD9hLNVqd/prppOwcPeHamNy9q3Ayu1QF+HuG32kxLDrha
         yHIrbgeEibs5Kv8QtkdlGMQuKQ9n7ECJPB1IkQ2PIWbPgMaB7pThtGhYtBnvHMcOQTQu
         ZRBqxjwu0/1fwLq94ppPjwJv1JpYPngmaQ0EanhybuKi3nKjjIYBUhdL8eNQfFZFeZIA
         r0wCqJFkupEeTYIKPTBRfYYue8c20LqXWrChuOxN8tDt2vnVC1oHw0OZn1nVLO95c4Et
         i1m5LlJQBbblOtpSdjRkj+N22a/WnZgkMcq0/jnw92vSehJDG+kYVc+UInpifDJOfiSc
         uBDA==
X-Gm-Message-State: AO0yUKUZw3rcgdpecvbkZ1DK9JBVKiR0GvAgNBULPNB1eQQEG6fyp1H+
        G0w643ulCpbDuIdLU6i7nRQR1TyASqVwHxHbndU=
X-Google-Smtp-Source: AK7set8ar6T7AltFRLrGCYlSM4TEhHC4AbC8uocZY9X0A8Sd5XQXy7K/bm32bc8GFcfICdeGQwoe6Q==
X-Received: by 2002:a17:906:29cb:b0:87f:5d0a:c610 with SMTP id y11-20020a17090629cb00b0087f5d0ac610mr23497222eje.32.1676279712344;
        Mon, 13 Feb 2023 01:15:12 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:12 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 3/7] selftest/bpf/benchs: enhance argp parsing
Date:   Mon, 13 Feb 2023 09:15:15 +0000
Message-Id: <20230213091519.1202813-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213091519.1202813-1-aspsk@isovalent.com>
References: <20230213091519.1202813-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To parse command line the bench utility uses the argp_parse() function. This
function takes as an argument a parent 'struct argp' structure which defines
common command line options and an array of children 'struct argp' structures
which defines additional command line options for particular benchmarks. This
implementation doesn't allow benchmarks to share option names, e.g., if two
benchmarks want to use, say, the --option option, then only one of them will
succeed (the first one encountered in the array).  This will be convenient if
same option names could be used in different benchmarks (with the same
semantics, e.g., --nr_loops=N).

Fix this by calling the argp_parse() function twice. The first call is the same
as it was before, with all children argps, and helps to find the benchmark name
and to print a combined help message if anything is wrong.  Given the name, we
can call the argp_parse the second time, but now the children array points only
to a correct benchmark thus always calling the correct parsers. (If there's no
a specific list of arguments, then only one call to argp_parse will be done.)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bench.c           | 44 ++++++++++++++-----
 tools/testing/selftests/bpf/bench.h           |  1 +
 .../bpf/benchs/bench_bloom_filter_map.c       |  5 +++
 .../selftests/bpf/benchs/bench_bpf_loop.c     |  1 +
 .../bpf/benchs/bench_local_storage.c          |  3 ++
 .../bench_local_storage_rcu_tasks_trace.c     |  1 +
 .../selftests/bpf/benchs/bench_ringbufs.c     |  4 ++
 .../selftests/bpf/benchs/bench_strncmp.c      |  2 +
 8 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index c1f20a147462..12c3b3ab84aa 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -287,10 +287,11 @@ static const struct argp_child bench_parsers[] = {
 	{},
 };
 
+/* Make pos_args global, so that we can run argp_parse twice, if necessary */
+static int pos_args;
+
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
-	static int pos_args;
-
 	switch (key) {
 	case 'v':
 		env.verbose = true;
@@ -359,7 +360,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	return 0;
 }
 
-static void parse_cmdline_args(int argc, char **argv)
+static void parse_cmdline_args_init(int argc, char **argv)
 {
 	static const struct argp argp = {
 		.options = opts,
@@ -369,9 +370,25 @@ static void parse_cmdline_args(int argc, char **argv)
 	};
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		exit(1);
-	if (!env.list && !env.bench_name) {
-		argp_help(&argp, stderr, ARGP_HELP_DOC, "bench");
-		exit(1);
+}
+
+static void parse_cmdline_args_final(int argc, char **argv)
+{
+	struct argp_child bench_parsers[2] = {};
+	const struct argp argp = {
+		.options = opts,
+		.parser = parse_arg,
+		.doc = argp_program_doc,
+		.children = bench_parsers,
+	};
+
+	/* Parse arguments the second time with the correct set of parsers */
+	if (bench->argp) {
+		bench_parsers[0].argp = bench->argp;
+		bench_parsers[0].header = bench->name;
+		pos_args = 0;
+		if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
+			exit(1);
 	}
 }
 
@@ -531,15 +548,14 @@ static const struct bench *benchs[] = {
 	&bench_local_storage_tasks_trace,
 };
 
-static void setup_benchmark()
+static void find_benchmark(void)
 {
-	int i, err;
+	int i;
 
 	if (!env.bench_name) {
 		fprintf(stderr, "benchmark name is not specified\n");
 		exit(1);
 	}
-
 	for (i = 0; i < ARRAY_SIZE(benchs); i++) {
 		if (strcmp(benchs[i]->name, env.bench_name) == 0) {
 			bench = benchs[i];
@@ -550,6 +566,11 @@ static void setup_benchmark()
 		fprintf(stderr, "benchmark '%s' not found\n", env.bench_name);
 		exit(1);
 	}
+}
+
+static void setup_benchmark(void)
+{
+	int i, err;
 
 	printf("Setting up benchmark '%s'...\n", bench->name);
 
@@ -621,7 +642,7 @@ static void collect_measurements(long delta_ns) {
 
 int main(int argc, char **argv)
 {
-	parse_cmdline_args(argc, argv);
+	parse_cmdline_args_init(argc, argv);
 
 	if (env.list) {
 		int i;
@@ -633,6 +654,9 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	find_benchmark();
+	parse_cmdline_args_final(argc, argv);
+
 	setup_benchmark();
 
 	setup_timer();
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index d748255877e2..3c8afa0131a3 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -47,6 +47,7 @@ struct bench_res {
 
 struct bench {
 	const char *name;
+	const struct argp *argp;
 	void (*validate)(void);
 	void (*setup)(void);
 	void *(*producer_thread)(void *ctx);
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 5bcb8a8cdeb2..7c8ccc108313 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -428,6 +428,7 @@ static void *consumer(void *input)
 
 const struct bench bench_bloom_lookup = {
 	.name = "bloom-lookup",
+	.argp = &bench_bloom_map_argp,
 	.validate = validate,
 	.setup = bloom_lookup_setup,
 	.producer_thread = producer,
@@ -439,6 +440,7 @@ const struct bench bench_bloom_lookup = {
 
 const struct bench bench_bloom_update = {
 	.name = "bloom-update",
+	.argp = &bench_bloom_map_argp,
 	.validate = validate,
 	.setup = bloom_update_setup,
 	.producer_thread = producer,
@@ -450,6 +452,7 @@ const struct bench bench_bloom_update = {
 
 const struct bench bench_bloom_false_positive = {
 	.name = "bloom-false-positive",
+	.argp = &bench_bloom_map_argp,
 	.validate = validate,
 	.setup = false_positive_setup,
 	.producer_thread = producer,
@@ -461,6 +464,7 @@ const struct bench bench_bloom_false_positive = {
 
 const struct bench bench_hashmap_without_bloom = {
 	.name = "hashmap-without-bloom",
+	.argp = &bench_bloom_map_argp,
 	.validate = validate,
 	.setup = hashmap_no_bloom_setup,
 	.producer_thread = producer,
@@ -472,6 +476,7 @@ const struct bench bench_hashmap_without_bloom = {
 
 const struct bench bench_hashmap_with_bloom = {
 	.name = "hashmap-with-bloom",
+	.argp = &bench_bloom_map_argp,
 	.validate = validate,
 	.setup = hashmap_with_bloom_setup,
 	.producer_thread = producer,
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
index d0a6572bfab6..d8a0394e10b1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
@@ -95,6 +95,7 @@ static void setup(void)
 
 const struct bench bench_bpf_loop = {
 	.name = "bpf-loop",
+	.argp = &bench_bpf_loop_argp,
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage.c b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
index 5a378c84e81f..d4b2817306d4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -255,6 +255,7 @@ static void *producer(void *input)
  */
 const struct bench bench_local_storage_cache_seq_get = {
 	.name = "local-storage-cache-seq-get",
+	.argp = &bench_local_storage_argp,
 	.validate = validate,
 	.setup = local_storage_cache_get_setup,
 	.producer_thread = producer,
@@ -266,6 +267,7 @@ const struct bench bench_local_storage_cache_seq_get = {
 
 const struct bench bench_local_storage_cache_interleaved_get = {
 	.name = "local-storage-cache-int-get",
+	.argp = &bench_local_storage_argp,
 	.validate = validate,
 	.setup = local_storage_cache_get_interleaved_setup,
 	.producer_thread = producer,
@@ -277,6 +279,7 @@ const struct bench bench_local_storage_cache_interleaved_get = {
 
 const struct bench bench_local_storage_cache_hashmap_control = {
 	.name = "local-storage-cache-hashmap-control",
+	.argp = &bench_local_storage_argp,
 	.validate = validate,
 	.setup = hashmap_setup,
 	.producer_thread = producer,
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
index 43f109d93130..4f9401ecf09c 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
@@ -271,6 +271,7 @@ static void report_final(struct bench_res res[], int res_cnt)
  */
 const struct bench bench_local_storage_tasks_trace = {
 	.name = "local-storage-tasks-trace",
+	.argp = &bench_local_storage_rcu_tasks_trace_argp,
 	.validate = validate,
 	.setup = local_storage_tasks_trace_setup,
 	.producer_thread = producer,
diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index c2554f9695ff..fc91fdac4faa 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -518,6 +518,7 @@ static void *perfbuf_custom_consumer(void *input)
 
 const struct bench bench_rb_libbpf = {
 	.name = "rb-libbpf",
+	.argp = &bench_ringbufs_argp,
 	.validate = bufs_validate,
 	.setup = ringbuf_libbpf_setup,
 	.producer_thread = bufs_sample_producer,
@@ -529,6 +530,7 @@ const struct bench bench_rb_libbpf = {
 
 const struct bench bench_rb_custom = {
 	.name = "rb-custom",
+	.argp = &bench_ringbufs_argp,
 	.validate = bufs_validate,
 	.setup = ringbuf_custom_setup,
 	.producer_thread = bufs_sample_producer,
@@ -540,6 +542,7 @@ const struct bench bench_rb_custom = {
 
 const struct bench bench_pb_libbpf = {
 	.name = "pb-libbpf",
+	.argp = &bench_ringbufs_argp,
 	.validate = bufs_validate,
 	.setup = perfbuf_libbpf_setup,
 	.producer_thread = bufs_sample_producer,
@@ -551,6 +554,7 @@ const struct bench bench_pb_libbpf = {
 
 const struct bench bench_pb_custom = {
 	.name = "pb-custom",
+	.argp = &bench_ringbufs_argp,
 	.validate = bufs_validate,
 	.setup = perfbuf_libbpf_setup,
 	.producer_thread = bufs_sample_producer,
diff --git a/tools/testing/selftests/bpf/benchs/bench_strncmp.c b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
index 494b591c0289..d3fad2ba6916 100644
--- a/tools/testing/selftests/bpf/benchs/bench_strncmp.c
+++ b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
@@ -140,6 +140,7 @@ static void strncmp_measure(struct bench_res *res)
 
 const struct bench bench_strncmp_no_helper = {
 	.name = "strncmp-no-helper",
+	.argp = &bench_strncmp_argp,
 	.validate = strncmp_validate,
 	.setup = strncmp_no_helper_setup,
 	.producer_thread = strncmp_producer,
@@ -151,6 +152,7 @@ const struct bench bench_strncmp_no_helper = {
 
 const struct bench bench_strncmp_helper = {
 	.name = "strncmp-helper",
+	.argp = &bench_strncmp_argp,
 	.validate = strncmp_validate,
 	.setup = strncmp_helper_setup,
 	.producer_thread = strncmp_producer,
-- 
2.34.1

