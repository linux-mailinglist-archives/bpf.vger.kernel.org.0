Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66F267ED3E
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjA0SP4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjA0SP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:15:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AFA7F6AB
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:16 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw4so339271edb.13
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UdC6iL1WXgPlBjfSFCUng9yr2/8HZEfENJqnmw7pYg=;
        b=tsRbHNkJXvutjD/9ArbF+64gQlT32In5jJ465w0826cfQNroc7rleT54fTSJXl8u+U
         DMciOTpDyz27TcNQ7flg5ShQLUfGAgof6Khn3FtccNg/h5/i5VwbGMlNpZ65wfkniqh/
         Y7TZ6C1bST7LAxnMJuugvDj7+//RYyOzWZA9loj/iuEfwCrruNLtOhiMXvTPQlxGMEPC
         1xmEMnq5lrvhBqiAdmjn3aIUqX7VRPFT0gjICc5woV83JnabaCdlHN49QHX60tL1jlLb
         Nxp1K3JQxrrt5Vn8y9EiFkOHWLa9Sa6cp/LM/SepMC5fhBfvIT+nefJvxeVmiVeCcSWH
         MSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UdC6iL1WXgPlBjfSFCUng9yr2/8HZEfENJqnmw7pYg=;
        b=UqyTX3W09D7KkIP8buY6YKOW6lPy7vh0DUniAI3aeYvljCzIMgCKXTFOuqQaXzgTiT
         un18t6TajeY9zIzG7V32v47gXQcwQWrpYFv/YeorEBa0Gn5nHFWoUtDyEv7Zr5JCvmeU
         YR8I+GsJ9j75zq/MYdjLW7ZxFlWCUhrEH5pCg/vPnIZIfWM6o0UaC+Zrb+e8GZxqv/lH
         PH1OYvrp3zhztukTtoWj1ynTGjzOnxawwp5QNZ7xWdy8g22j8xM40ZZqtgsSGLz3vgZN
         fu/8gXKv48gGZGc2x4em5CtYTVElsKmSB7Ld6qUYTSkFV8lps1VSOMuG9rK+iq2epQE8
         JL0A==
X-Gm-Message-State: AFqh2krBAPAm6NJRyKWOCXhPhoHhML/5K1u2X1SeffhzuxI+CGw9KOMU
        3iOFgM3DrFCUCOlpfdvr6HCCGhwlfdjWqrEE4wY=
X-Google-Smtp-Source: AMrXdXs0SHh7jQC3JZJxwPbOag380CWtfYk3oYFi1AB69i5WmxA+dDahoidBDTeOknZCegDT67y3Uw==
X-Received: by 2002:a05:6402:28c7:b0:47e:f535:e9a0 with SMTP id ef7-20020a05640228c700b0047ef535e9a0mr44845028edb.24.1674843287940;
        Fri, 27 Jan 2023 10:14:47 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm2639651edr.28.2023.01.27.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:14:47 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 4/6] selftest/bpf/benchs: make quiet option common
Date:   Fri, 27 Jan 2023 18:14:55 +0000
Message-Id: <20230127181457.21389-5-aspsk@isovalent.com>
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

The "local-storage-tasks-trace" benchmark has a `--quiet` option. Move it to
the list of common options, so that the main code and other benchmarks can use
(now global) env.quiet as well.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bench.c               | 15 +++++++++++++++
 tools/testing/selftests/bpf/bench.h               |  1 +
 .../benchs/bench_local_storage_rcu_tasks_trace.c  | 14 +-------------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ba93f1b268e1..42bf41a9385e 100644
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
@@ -257,6 +258,7 @@ static const struct argp_option opts[] = {
 	{ "consumers", 'c', "NUM", 0, "Number of consumer threads"},
 	{ "verbose", 'v', NULL, 0, "Verbose debug output"},
 	{ "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
+	{ "quiet", 'q', "{0,1}", OPTION_ARG_OPTIONAL, "If true, be quiet"},
 	{ "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
 	  "Set of CPUs for producer threads; implies --affinity"},
 	{ "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
@@ -286,6 +288,7 @@ static int pos_args;
 
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
+	long ret;
 
 	switch (key) {
 	case 'v':
@@ -325,6 +328,18 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'a':
 		env.affinity = true;
 		break;
+	case 'q':
+		if (!arg) {
+			env.quiet = true;
+		} else {
+			ret = strtol(arg, NULL, 10);
+			if (ret < 0 || ret > 1) {
+				fprintf(stderr, "invalid quiet %ld\n", ret);
+				argp_usage(state);
+			}
+			env.quiet = ret;
+		}
+		break;
 	case ARG_PROD_AFFINITY_SET:
 		env.affinity = true;
 		if (parse_num_list(arg, &env.prod_cpus.cpus,
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 316ba0589bf7..e322654b5e8a 100644
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
index bcbcb8b90c61..51d4b1a690f9 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
@@ -12,11 +12,9 @@
 static struct {
 	__u32 nr_procs;
 	__u32 kthread_pid;
-	bool quiet;
 } args = {
 	.nr_procs = 1000,
 	.kthread_pid = 0,
-	.quiet = false,
 };
 
 static const struct argp_option opts[] = {
@@ -24,8 +22,6 @@ static const struct argp_option opts[] = {
 		"Set number of user processes to spin up"},
 	{ "kthread_pid", ARG_KTHREAD_PID, "PID", 0,
 		"Pid of rcu_tasks_trace kthread for ticks tracking"},
-	{ "quiet", ARG_QUIET, "{0,1}", 0,
-		"If true, don't report progress"},
 	{},
 };
 
@@ -50,14 +46,6 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
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
@@ -224,7 +212,7 @@ static void report_progress(int iter, struct bench_res *res, long delta_ns)
 		exit(1);
 	}
 
-	if (args.quiet)
+	if (env.quiet)
 		return;
 
 	printf("Iter %d\t avg tasks_trace grace period latency\t%lf ns\n",
-- 
2.34.1

