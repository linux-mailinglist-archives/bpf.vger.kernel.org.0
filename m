Return-Path: <bpf+bounces-76113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC4CA8447
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD8E349FB97
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B973590A7;
	Fri,  5 Dec 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgAYWGTB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwL7u6mi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A87358D03
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947996; cv=none; b=KIst5XCtJ3wRzWFRgDDVTwh+NxHpPK4qHCK+jf/Wuc2cv7ppW4Z8K/+0hrfsWjBBEuRSrqo+mC4bPaFjzc7IfC4EhMxqq3gC2vDYrUvKmka1sSkmhCeIdEjqojBPoXFbdy5Fh3w3Cp2XVjlezGHGmLDabPSOgL6uB6IDf1jC39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947996; c=relaxed/simple;
	bh=XauiueSthxZv5S64m5SA7Pi3kkqNL6pTxFdYw93Syz8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kT8uOhPrK1uD5uHvVwFfioX5nZ2nr/C8Wm4dnFqoo6YIwurOG3SRQ6vXeo0T4isFihC1pntg5PaldZ/ZNtMdtstmIhzg+m1GNZmVhLtsIynKIL7rfU6lQ0Y0UcqBgloF3F4WGoowNEyGc6A62Dp11eW3tSmdEbQviKzgJaffwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgAYWGTB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwL7u6mi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764947990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JN8chbEeq2bsTSFdT5b2cS/9xoqHR7/mRc8k/LohH10=;
	b=dgAYWGTB2PE0xI3NKgaWjFENUdMDr5p1uqtB1km5r5rjiMGpU5A7aMH2f22TuHs15R7W+t
	P+3l5rlz278Ro3AjJhyTtrMicuNEtydShkfledUxo/owWtUkkoFAFKhxnK7jD7elzrSm2I
	ONjyYsWrodBQjzHl81mbpgR+2yLGmnk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-yuk86of_PKOJ2E_AuU4Oqw-1; Fri, 05 Dec 2025 10:19:46 -0500
X-MC-Unique: yuk86of_PKOJ2E_AuU4Oqw-1
X-Mimecast-MFC-AGG-ID: yuk86of_PKOJ2E_AuU4Oqw_1764947985
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso23370825e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764947985; x=1765552785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JN8chbEeq2bsTSFdT5b2cS/9xoqHR7/mRc8k/LohH10=;
        b=GwL7u6mixNUWTGdJ8ZvBBwyPfYrsqTAo6uCWCXUv7U+eyu08FcQamgnnjCyC4S4rxY
         +x3VgSG+aqNSZFeWrYWT/MqwXBXfougxelAANlwje1aVFPsGMXb4nf1ZyCqeYMgogOQV
         +VkQRVevLsfcPuBZmoXn30PDi1qp2FOUbjDoAOibQW3FmdMje34FQTN7C5Tewd7U0NLr
         luP8a5sAiwnzdEo7wdfbVljR01HMWXFMW9m5sJC0GUoK/gPEyv8vrWs1WLh691YPCTqB
         d9IdoIly1ZRNU4uOeixMrVHZ35hPbimBKn1xCqCmyw1dIVkQyD0ZM/Pac9NisRpTWm29
         Qh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947985; x=1765552785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JN8chbEeq2bsTSFdT5b2cS/9xoqHR7/mRc8k/LohH10=;
        b=ArTnCZBue9OKy8gR+cudZb3eQmykqNTNnilMmlfbvD+2mLpkYqxks5rmIHdP+ppssp
         E0US+2NEVD/TYfvzoeSDmwXYUzh0+67WMEQAh4SwsBIn+M7mZkuJlBXGMsKBxJHot/XI
         G9tTO4fo97hNm3JAOFgRIVbrjeuALfNZNbC7SKYhBqsKs5rEmkFac/HwuTeDMVNwUNUw
         Ry2HAY/ocB9l/C8Rlk5JeG4u/7u0DtwtpJCl87biol/6LNmeWrqNDrR9tH2EqCku54wY
         MmBH73uMu+51GNbiZ2Ss75Gl36IXMzY5n0Hq2N4L5M9LyokmmDEFybvGcRv8JGcR094m
         sHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXvW7POzm7sClZXldYqtEdbc+kzJp/avuzoLMtSA9yctKEu2h/yL2vC0ypi9BYL6TIteKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1v1M1RyWK7gIZHVmtejYfGeLS9nH90ko9Shw3tVfcnr+me3S
	mmi1qHiuQah644qUr+Tz2ROUpgZop6RA38OGe139rtPIrqwOtG5P37nnc1fVoTK8wrUVmPByznn
	SKkIilC26uLCk79iYPWJEvYYfpIglymolf3PGa+Fw7deJsnPDA7QDnA==
X-Gm-Gg: ASbGnctTw6mJYEi1ogL3PD5DKnx4eX8OI7/uERSOLkR6n42mF/k9fUOdSgWTVciyvme
	7QwhjSedTEDTQHXZIVRDi8t/LNCdTsc6CTNlMXV6M1sMXSCYO4xplKmhRV7g+mzfe9mDnEP64XM
	/4gTzl/FAnZCMATpL4tEwwXK0wOeOF5/bf1Hc8R6TIRUSSqlMhtgK9pGXmKHuI4+A0vsODG9TM/
	yxkTfCpiz5QjXjPTC/T9Ml+GELRBSz3jAaCGjzyKokcvOn9LrsIZf73Nws91PrqCmbShGOV7PXh
	5v+PXg84EZvUmJyCSOyan0olDFSjALQgMIw9erUlSZLuvgLXBZ2VoQw6ID1/WbDaO2n4vT6/zRg
	PQYNGgi0i8wPw43uhyIvyhqbgrdA=
X-Received: by 2002:a05:600c:4ec6:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4792f39cbc9mr77767535e9.30.1764947985327;
        Fri, 05 Dec 2025 07:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW/YMCNNCMIKP+BoC5TxE+vqBK9oqoFa1ay2hBsAC8sn4J4ZLDr5BwVR5pnnT8zDnV2TbGhA==
X-Received: by 2002:a05:600c:4ec6:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4792f39cbc9mr77767305e9.30.1764947984891;
        Fri, 05 Dec 2025 07:19:44 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b021cd2sm74880785e9.1.2025.12.05.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:19:44 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
Date: Fri,  5 Dec 2025 17:19:21 +0200
Message-ID: <20251205151924.2250142-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        |  6 ++++--
 tools/tracing/rtla/src/common.h        |  2 ++
 tools/tracing/rtla/src/osnoise_hist.c  |  3 ---
 tools/tracing/rtla/src/osnoise_top.c   |  7 -------
 tools/tracing/rtla/src/timerlat.c      |  5 +----
 tools/tracing/rtla/src/timerlat_aa.c   |  1 -
 tools/tracing/rtla/src/timerlat_hist.c |  3 ---
 tools/tracing/rtla/src/timerlat_top.c  |  7 -------
 tools/tracing/rtla/src/timerlat_u.c    |  3 +--
 tools/tracing/rtla/src/utils.c         | 10 +---------
 10 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index b197037fc58b..38ee2ad21e65 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -4,11 +4,12 @@
 #include <pthread.h>
 #include <signal.h>
 #include <stdlib.h>
-#include <unistd.h>
+#include <sys/sysinfo.h>
 #include "common.h"
 
 struct trace_instance *trace_inst;
 int stop_tracing;
+int nr_cpus;
 
 static void stop_trace(int sig)
 {
@@ -55,7 +56,7 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 	}
 
 	if (!params->cpus) {
-		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+		for (i = 0; i < nr_cpus; i++)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
@@ -103,6 +104,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	bool stopped;
 	int retval;
 
+	nr_cpus = get_nprocs_conf();
 	params = ops->parse_args(argc, argv);
 	if (!params)
 		exit(1);
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 9ec2b7632c37..2765e2a9f85f 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -107,6 +107,8 @@ struct common_params {
 	struct timerlat_u_params user;
 };
 
+extern int nr_cpus;
+
 #define for_each_monitored_cpu(cpu, nr_cpus, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index ff8c231e47c4..0bed9717cef6 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -699,9 +699,6 @@ static struct osnoise_tool
 *osnoise_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 04c699bdd736..8fa0046f0136 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -232,12 +232,8 @@ osnoise_print_stats(struct osnoise_tool *top)
 {
 	struct osnoise_params *params = to_osnoise_params(top->params);
 	struct trace_instance *trace = &top->trace;
-	static int nr_cpus = -1;
 	int i;
 
-	if (nr_cpus == -1)
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
@@ -547,9 +543,6 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_top");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index df4f9bfe3433..7503e18b905c 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -108,7 +108,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 int timerlat_enable(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int retval, nr_cpus, i;
+	int retval, i;
 
 	if (params->dma_latency >= 0) {
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
@@ -124,8 +124,6 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 		}
 
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 		for_each_monitored_cpu(i, nr_cpus, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -213,7 +211,6 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
 void timerlat_free(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i;
 
 	timerlat_aa_destroy();
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 31e66ea2b144..5766d58709eb 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -1022,7 +1022,6 @@ void timerlat_aa_destroy(void)
  */
 int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_aa_context *taa_ctx;
 	int retval;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1fb471a787b7..37bb9b931c8c 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1077,9 +1077,6 @@ static struct osnoise_tool
 *timerlat_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("timerlat_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 29c2c1f717ed..8b15f4439c6c 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -443,15 +443,11 @@ timerlat_print_stats(struct osnoise_tool *top)
 	struct timerlat_params *params = to_timerlat_params(top->params);
 	struct trace_instance *trace = &top->trace;
 	struct timerlat_top_cpu summary;
-	static int nr_cpus = -1;
 	int i;
 
 	if (params->common.aa_only)
 		return;
 
-	if (nr_cpus == -1)
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
@@ -827,9 +823,6 @@ static struct osnoise_tool
 *timerlat_init_top(struct common_params *params)
 {
 	struct osnoise_tool *top;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	top = osnoise_init_tool("timerlat_top");
 	if (!top)
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index ce68e39d25fd..a569fe7f93aa 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -16,7 +16,7 @@
 #include <sys/wait.h>
 #include <sys/prctl.h>
 
-#include "utils.h"
+#include "common.h"
 #include "timerlat_u.h"
 
 /*
@@ -131,7 +131,6 @@ static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
  */
 void *timerlat_u_dispatcher(void *data)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_u_params *params = data;
 	char proc_name[128];
 	int procs_count = 0;
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9cf5a0098e9a..afb32d2431c3 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -18,7 +18,7 @@
 #include <sched.h>
 #include <stdio.h>
 
-#include "utils.h"
+#include "common.h"
 
 #define MAX_MSG_LENGTH	1024
 int config_debug;
@@ -118,14 +118,11 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 {
 	const char *p;
 	int end_cpu;
-	int nr_cpus;
 	int cpu;
 	int i;
 
 	CPU_ZERO(set);
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	for (p = cpu_list; *p; ) {
 		cpu = atoi(p);
 		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
@@ -552,7 +549,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 	unsigned int nr_states;
 	unsigned int state;
 	int disabled;
-	int nr_cpus;
 
 	nr_states = cpuidle_state_count(cpu);
 
@@ -560,7 +556,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 		return 0;
 
 	if (saved_cpu_idle_disable_state == NULL) {
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
 		if (!saved_cpu_idle_disable_state)
 			return -1;
@@ -637,13 +632,10 @@ int restore_cpu_idle_disable_state(unsigned int cpu)
 void free_cpu_idle_disable_states(void)
 {
 	int cpu;
-	int nr_cpus;
 
 	if (!saved_cpu_idle_disable_state)
 		return;
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		free(saved_cpu_idle_disable_state[cpu]);
 		saved_cpu_idle_disable_state[cpu] = NULL;
-- 
2.52.0


