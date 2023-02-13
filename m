Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75199694085
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBMJPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBMJPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:17 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B29BAD31
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gr7so30134907ejb.5
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIDy0D5x3arSrtg+23jK97O7SKNSvQY4XwJ1aont5pE=;
        b=Ys6eVEfnuQiGyDuk8A/sKqXmXtZVlAdeUNV+pIXJQzk1gEib8D5qh+D9y1Yo9aHhlm
         HKuAEu++OsA90bCNShWBm/qYv/8S8Nn+mNUERqfBWMilFifKTzLowuGKJVapCtpOhbVj
         K8PzDaXKhnHXx0uEflB12C1GQPuzjGxpI0uuhD4S4MhAkjpAh2MnQLtvUNa8qVLIydFi
         Ou0+iRF9o5DojCOaVWJeNnbyUfbn1MTdpfMGdAzRI+D4mKhh9tWmKtcN/y4S3mGSqLF6
         C5cfcrsYqwZCW7AYkncTW0JkJAEpk6dE4iIH2M2OkmH40nndDnDBiM7RyYoRRupY4TvI
         LfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIDy0D5x3arSrtg+23jK97O7SKNSvQY4XwJ1aont5pE=;
        b=NMhp7drlpyMHREFk6v43LM5Yw1D555SsfozoENyzdWPkmwqcxvAAW6ykaIEegH9298
         RkCJ3HPgz/ZtTevFR4xoH6JQ3kt46wmw5+mpIpcbG7hlg073HSkK+DJTLrRhRkDhdxT4
         nH1g3HtuswseNIoKjhYENpOKxN/tEOrLK1C27AwG9LK6i9vnUw76/WGzYBmP+x2rvZg5
         50lrYvQLLx7Y4aTfxaH0jeA4j+4HTvlWGX09N3J+g88DkidXiKZ4CvmZ5MLjNCq6Il5X
         SxpwovFnd3XH04PMHiOhbon6aK31SJH/k0FswuW0ug2K+KwTHUGmGuZoFl1u2AAzsm1F
         /o2A==
X-Gm-Message-State: AO0yUKWl+gUL1WwXt90jRg90X3zlL56QlplIXuLOdo905JrVbTnKdKNk
        7iC00uvogHv4GVfb4pRjbRKL/cKUECiXbZqwjWw=
X-Google-Smtp-Source: AK7set8Tf5xIJCyev9gSjYNA9fZaCTSGBMjgBDo3+T7eLKrPrZLt5/23Zzn+5lQD7RoCNLFuZqqUPA==
X-Received: by 2002:a17:907:62a7:b0:8b1:ff:7588 with SMTP id nd39-20020a17090762a700b008b100ff7588mr5959721ejc.13.1676279713843;
        Mon, 13 Feb 2023 01:15:13 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:13 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 5/7] selftest/bpf/benchs: make quiet option common
Date:   Mon, 13 Feb 2023 09:15:17 +0000
Message-Id: <20230213091519.1202813-6-aspsk@isovalent.com>
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

The "local-storage-tasks-trace" benchmark has a `--quiet` option. Move it to
the list of common options, so that the main code and other benchmarks can use
(new) env.quiet variable. Patch the run_bench_local_storage_rcu_tasks_trace.sh
helper script accordingly.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bench.c               |  5 +++++
 tools/testing/selftests/bpf/bench.h               |  1 +
 .../benchs/bench_local_storage_rcu_tasks_trace.c  | 15 +--------------
 .../run_bench_local_storage_rcu_tasks_trace.sh    |  2 +-
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 12c3b3ab84aa..23c24c346130 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -16,6 +16,7 @@ struct env env = {
 	.warmup_sec = 1,
 	.duration_sec = 5,
 	.affinity = false,
+	.quiet = false,
 	.consumer_cnt = 1,
 	.producer_cnt = 1,
 };
@@ -262,6 +263,7 @@ static const struct argp_option opts[] = {
 	{ "consumers", 'c', "NUM", 0, "Number of consumer threads"},
 	{ "verbose", 'v', NULL, 0, "Verbose debug output"},
 	{ "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
+	{ "quiet", 'q', NULL, 0, "Be more quiet"},
 	{ "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
 	  "Set of CPUs for producer threads; implies --affinity"},
 	{ "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
@@ -330,6 +332,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'a':
 		env.affinity = true;
 		break;
+	case 'q':
+		env.quiet = true;
+		break;
 	case ARG_PROD_AFFINITY_SET:
 		env.affinity = true;
 		if (parse_num_list(arg, &env.prod_cpus.cpus,
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 3c8afa0131a3..402729c6a3ac 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -24,6 +24,7 @@ struct env {
 	bool verbose;
 	bool list;
 	bool affinity;
+	bool quiet;
 	int consumer_cnt;
 	int producer_cnt;
 	struct cpu_set prod_cpus;
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
index 4f9401ecf09c..d5eb5587f2aa 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
@@ -12,17 +12,14 @@
 static struct {
 	__u32 nr_procs;
 	__u32 kthread_pid;
-	bool quiet;
 } args = {
 	.nr_procs = 1000,
 	.kthread_pid = 0,
-	.quiet = false,
 };
 
 enum {
 	ARG_NR_PROCS = 7000,
 	ARG_KTHREAD_PID = 7001,
-	ARG_QUIET = 7002,
 };
 
 static const struct argp_option opts[] = {
@@ -30,8 +27,6 @@ static const struct argp_option opts[] = {
 		"Set number of user processes to spin up"},
 	{ "kthread_pid", ARG_KTHREAD_PID, "PID", 0,
 		"Pid of rcu_tasks_trace kthread for ticks tracking"},
-	{ "quiet", ARG_QUIET, "{0,1}", 0,
-		"If true, don't report progress"},
 	{},
 };
 
@@ -56,14 +51,6 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		}
 		args.kthread_pid = ret;
 		break;
-	case ARG_QUIET:
-		ret = strtol(arg, NULL, 10);
-		if (ret < 0 || ret > 1) {
-			fprintf(stderr, "invalid quiet %ld\n", ret);
-			argp_usage(state);
-		}
-		args.quiet = ret;
-		break;
 break;
 	default:
 		return ARGP_ERR_UNKNOWN;
@@ -230,7 +217,7 @@ static void report_progress(int iter, struct bench_res *res, long delta_ns)
 		exit(1);
 	}
 
-	if (args.quiet)
+	if (env.quiet)
 		return;
 
 	printf("Iter %d\t avg tasks_trace grace period latency\t%lf ns\n",
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
index 5dac1f02892c..3e8a969f2096 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
@@ -8,4 +8,4 @@ if [ -z $kthread_pid ]; then
 	exit 1
 fi
 
-./bench --nr_procs 15000 --kthread_pid $kthread_pid -d 600 --quiet 1 local-storage-tasks-trace
+./bench --nr_procs 15000 --kthread_pid $kthread_pid -d 600 --quiet local-storage-tasks-trace
-- 
2.34.1

