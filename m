Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC167ED3F
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjA0SP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjA0SP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:15:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F787177
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id n6so2827938edo.9
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAnF66GqnHDThXgNxRl7zxxyYBLiayHFrzNuPtMq5KE=;
        b=RcehqYsp1yiaNV2VzRob+8IkNsFDEEcvyEKYBrkjiBe9o5wCEBrVkJBtmw+JBlLYA3
         Gqej3BhdPNQ9YFmNLOFxz1XgjJsH/xRTg2anyiKp1BU7HhC+2EAJvUOFnG4+vqLOtKtP
         ShrMwK0DOF+sZZyZDw+ki4EMzWPNecroYm5fxsiMMKAe8XKq1RvKful0jUvgI0FKTxJf
         U4TTICE6orsTiGfSAHpAilGaQs0O9y9z9L97G56NalhdLRw1eOS1zOqFyRvCNFdnLo08
         L+dSLN3rzRpJjRSGODQbEfnjOiPuvV3dajLzgjQmPj63Rvltf2IZbHi7L8vAc1E04AUf
         EVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAnF66GqnHDThXgNxRl7zxxyYBLiayHFrzNuPtMq5KE=;
        b=SZ+uY3kW/TJtim17HFt8kHVWpycY8P2oaAS+iWs0L2wFBz+++t3+NGwFlZ/azF66cq
         WvgvHcwgomGJZ7Vb4xDaItfAGNOHyfapwFsMBLCETv0XmLm5s/+MPjy/xCTEkRFQstmI
         l6A5gZKrF405nLQTyAFOQ1NXsD0Yp6c2zUzP3mFvL8sUSFT+RFszEzEk2ZJ1vC5jwQhJ
         3yWuwz7wjnk9+qZl7TNvfGPjdCt4iYSB2D7TrFVA43r0HmWkglq0+2NwiM74Pr3a/HHu
         NRFJNwCIxhZvZ8wTB05SPQywLKuKY78j9DNDftdN8beaSJdAy50cCflb2XGPKxQurCTM
         Keiw==
X-Gm-Message-State: AO0yUKVF+p7XJprdH899/3zgI9GTCvBJGSBKxHXiM05ww8VWrrnniM7L
        ox4VsMmpC1Sv6MywSwdqFwKkveBC6LtXCrZ9IPE=
X-Google-Smtp-Source: AK7set+vbCdfYRjB86w0npguS+2quGe0zY9jjKutfJcuq0KvMSHJXDmhRkYDCUIcVQMLIe4KGXizNw==
X-Received: by 2002:a50:cb87:0:b0:4a0:e0f0:b2e5 with SMTP id k7-20020a50cb87000000b004a0e0f0b2e5mr6638028edi.6.1674843287238;
        Fri, 27 Jan 2023 10:14:47 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm2639651edr.28.2023.01.27.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:14:46 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 3/6] selftest/bpf/benchs: enhance argp parsing
Date:   Fri, 27 Jan 2023 18:14:54 +0000
Message-Id: <20230127181457.21389-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127181457.21389-1-aspsk@isovalent.com>
References: <20230127181457.21389-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
we could use the same option names in different benchmarks (with the same
semantics, e.g., --nr_loops=N).

Fix this by calling the argp_parse() function twice. The first call is needed
to find the benchmark name. Given the name, we can patch the list of argp
children to only include the correct list of option. This way the right parser
will be executed. (If there's no a specific list of arguments, then only one
call is enough.) As was mentioned above, arguments with same names should have
the same semantics (which means in this case "taking a parameter or not"), but
can have different description and will have different parsers.

As we now can share option names, this also makes sense to share the option ids.
Previously every benchmark defined a separate enum, like

    enum {
           ARG_SMTH = 9000,
           ARG_SMTH_ELSE = 9001,
    };

These ids were later used to distinguish between command line options:

    static const struct argp_option opts[] = {
            { "smth", ARG_SMTH, "SMTH", 0,
                    "Set number of smth to configure smth"},
            { "smth_else", ARG_SMTH_ELSE, "SMTH_ELSE", 0,
                    "Set number of smth_else to configure smth else"},
            ...

Move arguments id definitions to bench.h such that they are visible to every
benchmark (and such that there's no need to grep if this number is defined
already or not).

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bench.c           | 98 +++++++++++++++++--
 tools/testing/selftests/bpf/bench.h           | 20 ++++
 .../bpf/benchs/bench_bloom_filter_map.c       |  6 --
 .../selftests/bpf/benchs/bench_bpf_loop.c     |  4 -
 .../bpf/benchs/bench_local_storage.c          |  5 -
 .../bench_local_storage_rcu_tasks_trace.c     |  6 --
 .../selftests/bpf/benchs/bench_ringbufs.c     |  8 --
 .../selftests/bpf/benchs/bench_strncmp.c      |  4 -
 8 files changed, 110 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index c1f20a147462..ba93f1b268e1 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -249,11 +249,6 @@ const char argp_program_doc[] =
 "    # run 'count-local' with 16 producer and 8 consumer thread, pinned to CPUs\n"
 "    benchmark -p16 -c8 -a count-local\n";
 
-enum {
-	ARG_PROD_AFFINITY_SET = 1000,
-	ARG_CONS_AFFINITY_SET = 1001,
-};
-
 static const struct argp_option opts[] = {
 	{ "list", 'l', NULL, 0, "List available benchmarks"},
 	{ "duration", 'd', "SEC", 0, "Duration of benchmark, seconds"},
@@ -276,7 +271,7 @@ extern struct argp bench_local_storage_argp;
 extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
 
-static const struct argp_child bench_parsers[] = {
+static struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
 	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
 	{ &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
@@ -287,9 +282,10 @@ static const struct argp_child bench_parsers[] = {
 	{},
 };
 
+static int pos_args;
+
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
-	static int pos_args;
 
 	switch (key) {
 	case 'v':
@@ -359,6 +355,69 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	return 0;
 }
 
+struct argp *bench_name_to_argp(const char *bench_name)
+{
+
+#define _SCMP(NAME) (!strcmp(bench_name, NAME))
+
+	if (_SCMP("bloom-lookup") ||
+	    _SCMP("bloom-update") ||
+	    _SCMP("bloom-false-positive") ||
+	    _SCMP("hashmap-without-bloom") ||
+	    _SCMP("hashmap-with-bloom"))
+		return &bench_bloom_map_argp;
+
+	if (_SCMP("rb-libbpf") ||
+	    _SCMP("rb-custom") ||
+	    _SCMP("pb-libbpf") ||
+	    _SCMP("pb-custom"))
+		return &bench_ringbufs_argp;
+
+	if (_SCMP("local-storage-cache-seq-get") ||
+	    _SCMP("local-storage-cache-int-get") ||
+	    _SCMP("local-storage-cache-hashmap-control"))
+		return &bench_local_storage_argp;
+
+	if (_SCMP("local-storage-tasks-trace"))
+		return &bench_local_storage_rcu_tasks_trace_argp;
+
+	if (_SCMP("strncmp-no-helper") ||
+	    _SCMP("strncmp-helper"))
+		return &bench_strncmp_argp;
+
+	if (_SCMP("bpf-loop"))
+		return &bench_bpf_loop_argp;
+
+	/* no extra arguments */
+	if (_SCMP("count-global") ||
+	    _SCMP("count-local") ||
+	    _SCMP("rename-base") ||
+	    _SCMP("rename-kprobe") ||
+	    _SCMP("rename-kretprobe") ||
+	    _SCMP("rename-rawtp") ||
+	    _SCMP("rename-fentry") ||
+	    _SCMP("rename-fexit") ||
+	    _SCMP("trig-base") ||
+	    _SCMP("trig-tp") ||
+	    _SCMP("trig-rawtp") ||
+	    _SCMP("trig-kprobe") ||
+	    _SCMP("trig-fentry") ||
+	    _SCMP("trig-fentry-sleep") ||
+	    _SCMP("trig-fmodret") ||
+	    _SCMP("trig-uprobe-base") ||
+	    _SCMP("trig-uprobe-with-nop") ||
+	    _SCMP("trig-uretprobe-with-nop") ||
+	    _SCMP("trig-uprobe-without-nop") ||
+	    _SCMP("trig-uretprobe-without-nop") ||
+	    _SCMP("bpf-hashmap-full-update"))
+		return NULL;
+
+#undef _SCMP
+
+	fprintf(stderr, "%s: bench %s is unknown\n", __func__, bench_name);
+	exit(1);
+}
+
 static void parse_cmdline_args(int argc, char **argv)
 {
 	static const struct argp argp = {
@@ -367,12 +426,35 @@ static void parse_cmdline_args(int argc, char **argv)
 		.doc = argp_program_doc,
 		.children = bench_parsers,
 	};
+	static struct argp *bench_argp;
+
+	/* Parse args for the first time to get bench name */
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		exit(1);
-	if (!env.list && !env.bench_name) {
+
+	if (env.list)
+		return;
+
+	if (!env.bench_name) {
 		argp_help(&argp, stderr, ARGP_HELP_DOC, "bench");
 		exit(1);
 	}
+
+	/* Now check if there are custom options available. If not, then
+	 * everything is done, if yes, then we need to patch bench_parsers
+	 * so that bench_parsers[0] points to the right 'struct argp', and
+	 * bench_parsers[1] terminates the list.
+	 */
+	bench_argp = bench_name_to_argp(env.bench_name);
+	if (bench_argp) {
+		bench_parsers[0].argp = bench_argp;
+		bench_parsers[0].header = env.bench_name;
+		memset(&bench_parsers[1], 0, sizeof(bench_parsers[1]));
+
+		pos_args = 0;
+		if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
+			exit(1);
+	}
 }
 
 static void collect_measurements(long delta_ns);
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index d748255877e2..316ba0589bf7 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -101,3 +101,23 @@ static inline long atomic_swap(long *value, long n)
 {
 	return __atomic_exchange_n(value, n, __ATOMIC_RELAXED);
 }
+
+enum {
+	ARG_PROD_AFFINITY_SET = 1000,
+	ARG_CONS_AFFINITY_SET,
+	ARG_RB_BACK2BACK,
+	ARG_RB_USE_OUTPUT,
+	ARG_RB_BATCH_CNT,
+	ARG_RB_SAMPLED,
+	ARG_RB_SAMPLE_RATE,
+	ARG_NR_ENTRIES,
+	ARG_NR_HASH_FUNCS,
+	ARG_VALUE_SIZE,
+	ARG_NR_LOOPS,
+	ARG_CMP_STR_LEN,
+	ARG_NR_MAPS,
+	ARG_HASHMAP_NR_KEYS_USED,
+	ARG_NR_PROCS,
+	ARG_KTHREAD_PID,
+	ARG_QUIET,
+};
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 5bcb8a8cdeb2..bef8999d4a9e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -45,12 +45,6 @@ static struct {
 	.value_size = 8,
 };
 
-enum {
-	ARG_NR_ENTRIES = 3000,
-	ARG_NR_HASH_FUNCS = 3001,
-	ARG_VALUE_SIZE = 3002,
-};
-
 static const struct argp_option opts[] = {
 	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
 		"Set number of expected unique entries in the bloom filter"},
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
index d0a6572bfab6..47630a9a0a4b 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
@@ -16,10 +16,6 @@ static struct {
 	.nr_loops = 10,
 };
 
-enum {
-	ARG_NR_LOOPS = 4000,
-};
-
 static const struct argp_option opts[] = {
 	{ "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
 		"Set number of loops for the bpf_loop helper"},
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage.c b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
index 5a378c84e81f..dd19ddf24fde 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -17,11 +17,6 @@ static struct {
 	.hashmap_nr_keys_used = 1000,
 };
 
-enum {
-	ARG_NR_MAPS = 6000,
-	ARG_HASHMAP_NR_KEYS_USED = 6001,
-};
-
 static const struct argp_option opts[] = {
 	{ "nr_maps", ARG_NR_MAPS, "NR_MAPS", 0,
 		"Set number of local_storage maps"},
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
index 43f109d93130..bcbcb8b90c61 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
@@ -19,12 +19,6 @@ static struct {
 	.quiet = false,
 };
 
-enum {
-	ARG_NR_PROCS = 7000,
-	ARG_KTHREAD_PID = 7001,
-	ARG_QUIET = 7002,
-};
-
 static const struct argp_option opts[] = {
 	{ "nr_procs", ARG_NR_PROCS, "NR_PROCS", 0,
 		"Set number of user processes to spin up"},
diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index c2554f9695ff..b31ae31d1fea 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -29,14 +29,6 @@ static struct {
 	.perfbuf_sz = 128,
 };
 
-enum {
-	ARG_RB_BACK2BACK = 2000,
-	ARG_RB_USE_OUTPUT = 2001,
-	ARG_RB_BATCH_CNT = 2002,
-	ARG_RB_SAMPLED = 2003,
-	ARG_RB_SAMPLE_RATE = 2004,
-};
-
 static const struct argp_option opts[] = {
 	{ "rb-b2b", ARG_RB_BACK2BACK, NULL, 0, "Back-to-back mode"},
 	{ "rb-use-output", ARG_RB_USE_OUTPUT, NULL, 0, "Use bpf_ringbuf_output() instead of bpf_ringbuf_reserve()"},
diff --git a/tools/testing/selftests/bpf/benchs/bench_strncmp.c b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
index 494b591c0289..e7d48a65511b 100644
--- a/tools/testing/selftests/bpf/benchs/bench_strncmp.c
+++ b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
@@ -14,10 +14,6 @@ static struct strncmp_args {
 	.cmp_str_len = 32,
 };
 
-enum {
-	ARG_CMP_STR_LEN = 5000,
-};
-
 static const struct argp_option opts[] = {
 	{ "cmp-str-len", ARG_CMP_STR_LEN, "CMP_STR_LEN", 0,
 	  "Set the length of compared string" },
-- 
2.34.1

