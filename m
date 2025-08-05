Return-Path: <bpf+bounces-65044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F772B1B0C2
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3613BBFE7
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB03259CAF;
	Tue,  5 Aug 2025 09:15:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE317BA9;
	Tue,  5 Aug 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385340; cv=none; b=ghZnXZkFgqNwUP6G8U9qsxTd8eJTwPi1z7Qi/i+hsAjZpKCxgu5idUw9/0l+Lgc8B2Tsxh2b4xZgrriw+TRBfr6vNecpNRrF2lo7rIrC/gJh/3vKidrfgWMWMPqkjdDIh5d5HXKWBLn1IYA7erHOQo/EYmdKVId4K7S/t+FVcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385340; c=relaxed/simple;
	bh=S6dKJxiTaqdOiQtBxDGtUtVXtOXqpL01A0rDv4D8Rw0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PIJqZQwyb8EVVrag62NKZf/QsrycCClBFbWxNMJTBPuvBncAw0OcOk5zlFJqwdVmADQChmNvK1bAChnTMaelKLrQl7oDBxKcoOpTaPamev/d8SCI7y4xfDPfIefpiBMaaKD2ob944oQQjXjHoCFTdM7qUk5pDlRUeoR8XTduk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-707389a2fe3so52695676d6.2;
        Tue, 05 Aug 2025 02:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754385335; x=1754990135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei3RjK5hWW12RcvseJZoBYQJluVxBB4OIkFSZhC5m6M=;
        b=oaM2cihVLnPP2K5A4lBjUyJKMRxIu3+mQgjhIvLHpDp2LVV9sNCuvs9PUEdkmLZeow
         jhlGypk7ugDtXuMnbbiqufOnTeCH2YT1UBjM0TrE1gh8/LIXsszfrpdjsZ2pD4kt9Mq7
         RUBjhoW9gmMfrimpmVnhg91KmftB4f0naRYP/VbU6zsKSKHwqSjgAiWirl9dF5asMyFP
         rnRhjHfwgiWe7XQh1bP+1FwXPf/u5qj0vjXRhsFaLH5IBTh2UQQpZR6dCMRqL9meEivm
         N8DpWbLd4nQV58a5cxgupQK3dmN9ljOfR4BZ6c2DJhkM5k9WOCQBRqaT18+Ywr3FQWZh
         fJMw==
X-Forwarded-Encrypted: i=1; AJvYcCUOy4vO7zp2hwounIdASD7EP767q7elBfZ7IQZtkSLWmKQOiTRfX9qtKEpgcd+PPSRK8AaNcVNV0erKbB9r@vger.kernel.org, AJvYcCUaBjnjgvfxpFD55XDr8rx0GhMnwvTlhS2EihnzgEI2AT0sD4ozySZm4IScXzWFTG6jj6L1aaB2ESfqYsRYQQLCURQs@vger.kernel.org, AJvYcCWvM+E+TlsirTCrxxVHgQPs9lT+fmy3n4688TqiiiTW1pop61r3GC1+APtwJp4D6+v1g1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VVU+6wtkE+KS1s/ZCfM+GoPBiV14lXflOK/UYkzkeD4C5sCb
	3BMAy7vuT6scb1t+sRgQVBzNUNAJlctqeyuaT7JBx395t18nr6kQkJiO
X-Gm-Gg: ASbGnctgFUui4AQ9lMHYJwiRG9t5ubO6IpejVc4FE2CUN73qDRs68N17PM/1nl3wkEZ
	IwgkZyx7FVo2YTv5jF37LQCj1J7l9Kcz/XV6BZcR5UmS1cgRwUKKMadFWjcwppuKP0acFyDneZ4
	FxE+odJnIyVUx/DX2gTKgTAJcVKG6MV7+8LKQtBs+Sxy1Pez0xJ5D/jsDFVt+LI78UcZ1biyBcy
	CFVODIF0DOw2w78N9EyNNxb8TZpkw/mdtGHTL8qnQ+VuPWaRLL1fMsTYAC3OrSdZgUYEWYriq5l
	75XmyLJmqumN/vbJCR5vfHI6U0C4l4rVpJKvn4SHTh0kXEiOKdEegO9TGZXBzqb/aihx9CTmonG
	mYmVtSl/L+9EziIbaYnyPMLR51RTgVSclympz
X-Google-Smtp-Source: AGHT+IGYtpm+sGRxrV2FLaDbHENPzO0lL53L7XESlriQTj0DEjczUrrQjhjVv/Lm3pewg18ks4FCsA==
X-Received: by 2002:a05:6214:4015:b0:707:39f7:c607 with SMTP id 6a1803df08f44-70935f34eb9mr203257006d6.7.1754385334726;
        Tue, 05 Aug 2025 02:15:34 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca363fesm68610156d6.31.2025.08.05.02.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:15:33 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: crwood@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3] tools/rtla: Consolidate common parameters into shared structure
Date: Tue,  5 Aug 2025 12:12:13 +0300
Message-ID: <20250805091336.2061216-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timerlat_params and osnoise_params structures contain 15 identical
fields.

Introduce a new header common.h and define a common_params structure to
consolidate shared fields, reduce code duplication, and enhance
maintainability.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
Changes since v2:
- As per Crystal's recommendation, moved common_params into common.h.

Changes since v1:
- Rebase on top of recent changes
- Address Tomas's comments
- Don't change already not common members: trace_output, runtime

---
 tools/tracing/rtla/src/common.h        |  30 +++++++
 tools/tracing/rtla/src/osnoise.c       |  20 ++---
 tools/tracing/rtla/src/osnoise.h       |  19 +----
 tools/tracing/rtla/src/osnoise_hist.c  |  92 ++++++++++----------
 tools/tracing/rtla/src/osnoise_top.c   |  80 ++++++++---------
 tools/tracing/rtla/src/timerlat.c      |  24 +++---
 tools/tracing/rtla/src/timerlat.h      |  18 +---
 tools/tracing/rtla/src/timerlat_bpf.c  |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c | 113 +++++++++++++------------
 tools/tracing/rtla/src/timerlat_top.c  | 105 +++++++++++------------
 10 files changed, 253 insertions(+), 252 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.h

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
new file mode 100644
index 000000000000..0a44cfaa7c0b
--- /dev/null
+++ b/tools/tracing/rtla/src/common.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "utils.h"
+
+/*
+ * common_params - Parameters shared between timerlat_params and osnoise_params
+ */
+struct common_params {
+	/* trace configuration */
+	char			*cpus;
+	cpu_set_t		monitored_cpus;
+	struct trace_events	*events;
+	int			buffer_size;
+
+	/* Timing parameters */
+	int			warmup;
+	long long		stop_us;
+	long long		stop_total_us;
+	int			sleep_time;
+	int			duration;
+
+	/* Scheduling parameters */
+	int			set_sched;
+	struct sched_attr	sched_param;
+	int			cgroup;
+	char			*cgroup_name;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
+};
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 2dc3e4539e99..06ae7437c2c7 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1127,10 +1127,10 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 {
 	int retval;
 
-	if (!params->sleep_time)
-		params->sleep_time = 1;
+	if (!params->common.sleep_time)
+		params->common.sleep_time = 1;
 
-	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
 	if (retval) {
 		err_msg("Failed to apply CPUs config\n");
 		goto out_err;
@@ -1151,13 +1151,13 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	retval = osnoise_set_stop_us(tool->context, params->common.stop_us);
 	if (retval) {
 		err_msg("Failed to set stop us\n");
 		goto out_err;
 	}
 
-	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	retval = osnoise_set_stop_total_us(tool->context, params->common.stop_total_us);
 	if (retval) {
 		err_msg("Failed to set stop total us\n");
 		goto out_err;
@@ -1169,14 +1169,14 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	if (params->hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
-					   &params->hk_cpu_set);
+	if (params->common.hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
+					   &params->common.hk_cpu_set);
 		if (retval == -1) {
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
-	} else if (params->cpus) {
+	} else if (params->common.cpus) {
 		/*
 		 * Even if the user do not set a house-keeping CPU, try to
 		 * move rtla to a CPU set different to the one where the user
@@ -1184,7 +1184,7 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		 *
 		 * No need to check results as this is an automatic attempt.
 		 */
-		auto_house_keeping(&params->monitored_cpus);
+		auto_house_keeping(&params->common.monitored_cpus);
 	}
 
 	retval = osnoise_set_workload(tool->context, true);
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index ac1c99910744..0386bb50ffa1 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #pragma once
 
-#include "utils.h"
+#include "common.h"
 #include "trace.h"
 
 enum osnoise_mode {
@@ -10,26 +10,11 @@ enum osnoise_mode {
 };
 
 struct osnoise_params {
-	/* Common params */
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
+	struct common_params	common;
 	char			*trace_output;
-	char			*cgroup_name;
 	unsigned long long	runtime;
 	unsigned long long	period;
 	long long		threshold;
-	long long		stop_us;
-	long long		stop_total_us;
-	int			sleep_time;
-	int			duration;
-	int			set_sched;
-	int			cgroup;
-	int			hk_cpus;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
-	int			warmup;
-	int			buffer_size;
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8d579bcee709..3fb9bb553498 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -243,7 +243,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -274,7 +274,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -288,7 +288,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -303,7 +303,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -321,7 +321,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -357,7 +357,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 					 bucket * data->bucket_size);
 
 		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 				continue;
 
 			if (!data->hist[cpu].count)
@@ -395,7 +395,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -537,7 +537,7 @@ static struct osnoise_params
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 
 			/* set sample threshold to 1 */
 			params->threshold = 1;
@@ -552,27 +552,27 @@ static struct osnoise_params
 				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				osnoise_hist_usage("\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				osnoise_hist_usage("Invalid -D duration\n");
 			break;
 		case 'e':
@@ -582,10 +582,10 @@ static struct osnoise_params
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
+			if (params->common.events)
+				tevent->next = params->common.events;
 
-			params->events = tevent;
+			params->common.events = tevent;
 			break;
 		case 'E':
 			params->entries = get_llong_from_str(optarg);
@@ -597,8 +597,8 @@ static struct osnoise_params
 			osnoise_hist_usage(NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
@@ -610,10 +610,10 @@ static struct osnoise_params
 				osnoise_hist_usage("Period longer than 10 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				osnoise_hist_usage("Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
@@ -621,10 +621,10 @@ static struct osnoise_params
 				osnoise_hist_usage("Runtime shorter than 100 us\n");
 			break;
 		case 's':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'S':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 'T':
 			params->threshold = get_llong_from_str(optarg);
@@ -653,8 +653,8 @@ static struct osnoise_params
 			params->with_zeros = 1;
 			break;
 		case '4': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -664,8 +664,8 @@ static struct osnoise_params
 			}
 			break;
 		case '5': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -675,10 +675,10 @@ static struct osnoise_params
 			}
 			break;
 		case '6':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '7':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		default:
 			osnoise_hist_usage("Invalid option");
@@ -755,9 +755,9 @@ static void
 osnoise_hist_set_signals(struct osnoise_params *params)
 {
 	signal(SIGINT, stop_hist);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_hist);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -798,16 +798,16 @@ int osnoise_hist_main(int argc, char *argv[])
 	if (retval)
 		goto out_destroy;
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("osnoise/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup) {
-		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+	if (params->common.cgroup) {
+		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -821,14 +821,14 @@ int osnoise_hist_main(int argc, char *argv[])
 			goto out_free;
 		}
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_hist;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_hist;
 		}
@@ -845,9 +845,9 @@ int osnoise_hist_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	trace_instance_start(trace);
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 		if (stop_tracing)
 			goto out_hist;
 
@@ -868,7 +868,7 @@ int osnoise_hist_main(int argc, char *argv[])
 	osnoise_hist_set_signals(params);
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		retval = tracefs_iterate_raw_events(trace->tep,
 						    trace->inst,
@@ -899,8 +899,8 @@ int osnoise_hist_main(int argc, char *argv[])
 	}
 
 out_hist:
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	osnoise_free_histogram(tool->data);
 out_destroy:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2c12780c8aa9..ad5daa8210aa 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -238,7 +238,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *top)
 	osnoise_top_header(top);
 
 	for (i = 0; i < nr_cpus; i++) {
-		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 			continue;
 		osnoise_top_print(top, i);
 	}
@@ -377,7 +377,7 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 
 			/* set sample threshold to 1 */
 			params->threshold = 1;
@@ -387,27 +387,27 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
@@ -417,9 +417,9 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
-			params->events = tevent;
+			if (params->common.events)
+				tevent->next = params->common.events;
+			params->common.events = tevent;
 
 			break;
 		case 'h':
@@ -427,8 +427,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			osnoise_top_usage(params, NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
@@ -440,10 +440,10 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage(params, "Period longer than 10 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				osnoise_top_usage(params, "Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 'q':
 			params->quiet = 1;
@@ -454,10 +454,10 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
 			break;
 		case 's':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'S':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
@@ -474,8 +474,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = get_llong_from_str(optarg);
 			break;
 		case '0': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -485,8 +485,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			}
 			break;
 		case '1': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -496,10 +496,10 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			}
 			break;
 		case '2':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '3':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
@@ -583,9 +583,9 @@ static void stop_top(int sig)
 static void osnoise_top_set_signals(struct osnoise_params *params)
 {
 	signal(SIGINT, stop_top);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_top);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -622,16 +622,16 @@ int osnoise_top_main(int argc, char **argv)
 		goto out_free;
 	}
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("osnoise/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup) {
-		retval = set_comm_cgroup("osnoise/", params->cgroup_name);
+	if (params->common.cgroup) {
+		retval = set_comm_cgroup("osnoise/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -645,14 +645,14 @@ int osnoise_top_main(int argc, char **argv)
 			goto out_free;
 		}
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_top;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_top;
 		}
@@ -669,9 +669,9 @@ int osnoise_top_main(int argc, char **argv)
 		trace_instance_start(&record->trace);
 	trace_instance_start(trace);
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 		if (stop_tracing)
 			goto out_top;
 
@@ -692,7 +692,7 @@ int osnoise_top_main(int argc, char **argv)
 	osnoise_top_set_signals(params);
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		retval = tracefs_iterate_raw_events(trace->tep,
 						    trace->inst,
@@ -725,8 +725,8 @@ int osnoise_top_main(int argc, char **argv)
 	}
 
 out_top:
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 63d6d43eafff..0b2f03e1e612 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -26,18 +26,18 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval, i;
 
-	if (!params->sleep_time)
-		params->sleep_time = 1;
+	if (!params->common.sleep_time)
+		params->common.sleep_time = 1;
 
-	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
 	if (retval) {
 		err_msg("Failed to apply CPUs config\n");
 		goto out_err;
 	}
 
-	if (!params->cpus) {
+	if (!params->common.cpus) {
 		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
-			CPU_SET(i, &params->monitored_cpus);
+			CPU_SET(i, &params->common.monitored_cpus);
 	}
 
 	if (params->mode != TRACING_MODE_BPF) {
@@ -45,13 +45,13 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		 * In tracefs and mixed mode, timerlat tracer handles stopping
 		 * on threshold
 		 */
-		retval = osnoise_set_stop_us(tool->context, params->stop_us);
+		retval = osnoise_set_stop_us(tool->context, params->common.stop_us);
 		if (retval) {
 			err_msg("Failed to set stop us\n");
 			goto out_err;
 		}
 
-		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+		retval = osnoise_set_stop_total_us(tool->context, params->common.stop_total_us);
 		if (retval) {
 			err_msg("Failed to set stop total us\n");
 			goto out_err;
@@ -75,14 +75,14 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		goto out_err;
 	}
 
-	if (params->hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
-					   &params->hk_cpu_set);
+	if (params->common.hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
+					   &params->common.hk_cpu_set);
 		if (retval == -1) {
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
-	} else if (params->cpus) {
+	} else if (params->common.cpus) {
 		/*
 		 * Even if the user do not set a house-keeping CPU, try to
 		 * move rtla to a CPU set different to the one where the user
@@ -90,7 +90,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		 *
 		 * No need to check results as this is an automatic attempt.
 		 */
-		auto_house_keeping(&params->monitored_cpus);
+		auto_house_keeping(&params->common.monitored_cpus);
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index bc55ed04fc96..dd9e0f05bdad 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -20,33 +20,17 @@ enum timerlat_tracing_mode {
 };
 
 struct timerlat_params {
-	/* Common params */
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*cgroup_name;
-	unsigned long long	runtime;
-	long long		stop_us;
-	long long		stop_total_us;
+	struct common_params	common;
 	long long		timerlat_period_us;
 	long long		print_stack;
-	int			sleep_time;
 	int			output_divisor;
-	int			duration;
-	int			set_sched;
 	int			dma_latency;
 	int			no_aa;
 	int			dump_tasks;
-	int			cgroup;
-	int			hk_cpus;
 	int			user_workload;
 	int			kernel_workload;
 	int			user_data;
-	int			warmup;
-	int			buffer_size;
 	int			deepest_idle_state;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
 	enum timerlat_tracing_mode mode;
 
 	struct actions threshold_actions;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 1666215dd687..a6c77ac55e00 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -23,8 +23,8 @@ int timerlat_bpf_init(struct timerlat_params *params)
 	/* Pass common options */
 	bpf->rodata->output_divisor = params->output_divisor;
 	bpf->rodata->entries = params->entries;
-	bpf->rodata->irq_threshold = params->stop_us;
-	bpf->rodata->thread_threshold = params->stop_total_us;
+	bpf->rodata->irq_threshold = params->common.stop_us;
+	bpf->rodata->thread_threshold = params->common.stop_total_us;
 	bpf->rodata->aa_only = params->aa_only;
 
 	if (params->entries != 0) {
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9baea1b251ed..a3de644f2b75 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -303,7 +303,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -357,7 +357,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -381,7 +381,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -411,7 +411,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -441,7 +441,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -488,7 +488,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_user = ~0;
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -636,7 +636,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 					 bucket * data->bucket_size);
 
 		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 				continue;
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -676,7 +676,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -867,8 +867,8 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -878,19 +878,19 @@ static struct timerlat_params
 
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				timerlat_hist_usage("\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'b':
@@ -902,8 +902,8 @@ static struct timerlat_params
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				timerlat_hist_usage("Invalid -D duration\n");
 			break;
 		case 'e':
@@ -913,10 +913,10 @@ static struct timerlat_params
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
+			if (params->common.events)
+				tevent->next = params->common.events;
 
-			params->events = tevent;
+			params->common.events = tevent;
 			break;
 		case 'E':
 			params->entries = get_llong_from_str(optarg);
@@ -928,15 +928,15 @@ static struct timerlat_params
 			timerlat_hist_usage(NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case 'i':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
 			params->kernel_workload = 1;
@@ -950,16 +950,16 @@ static struct timerlat_params
 				timerlat_hist_usage("Period longer than 1 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				timerlat_hist_usage("Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
 			break;
 		case 'T':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
@@ -997,8 +997,8 @@ static struct timerlat_params
 			params->with_zeros = 1;
 			break;
 		case '6': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -1008,8 +1008,8 @@ static struct timerlat_params
 			}
 			break;
 		case '7': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -1032,10 +1032,10 @@ static struct timerlat_params
 			params->dump_tasks = 1;
 			break;
 		case '\2':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '\3':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		case '\4':
 			params->deepest_idle_state = get_llong_from_str(optarg);
@@ -1076,7 +1076,7 @@ static struct timerlat_params
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
 	 */
-	if (!params->stop_us && !params->stop_total_us)
+	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
 	if (params->kernel_workload && params->user_workload)
@@ -1167,9 +1167,9 @@ static void
 timerlat_hist_set_signals(struct timerlat_params *params)
 {
 	signal(SIGINT, stop_hist);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_hist);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -1235,16 +1235,16 @@ int timerlat_hist_main(int argc, char *argv[])
 		goto out_free;
 	}
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("timerlat/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup && !params->user_workload) {
-		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+	if (params->common.cgroup && !params->user_workload) {
+		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -1268,7 +1268,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -1291,14 +1291,14 @@ int timerlat_hist_main(int argc, char *argv[])
 		params->threshold_actions.trace_output_inst = record->trace.inst;
 		params->end_actions.trace_output_inst = record->trace.inst;
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_hist;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_hist;
 		}
@@ -1328,22 +1328,22 @@ int timerlat_hist_main(int argc, char *argv[])
 		/* all threads left */
 		params_u.stopped_running = 0;
 
-		params_u.set = &params->monitored_cpus;
-		if (params->set_sched)
-			params_u.sched_param = &params->sched_param;
+		params_u.set = &params->common.monitored_cpus;
+		if (params->common.set_sched)
+			params_u.sched_param = &params->common.sched_param;
 		else
 			params_u.sched_param = NULL;
 
-		params_u.cgroup_name = params->cgroup_name;
+		params_u.cgroup_name = params->common.cgroup_name;
 
 		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
 		if (retval)
 			err_msg("Error creating timerlat user-space threads\n");
 	}
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 		if (stop_tracing)
 			goto out_hist;
 	}
@@ -1374,7 +1374,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	if (params->mode == TRACING_MODE_TRACEFS) {
 		while (!stop_tracing) {
-			sleep(params->sleep_time);
+			sleep(params->common.sleep_time);
 
 			retval = tracefs_iterate_raw_events(trace->tep,
 							    trace->inst,
@@ -1456,7 +1456,8 @@ int timerlat_hist_main(int argc, char *argv[])
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
 
 		return_value = FAILED;
 	}
@@ -1467,13 +1468,13 @@ int timerlat_hist_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			restore_cpu_idle_disable_state(i);
 		}
 	}
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(aa);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index c80b81c0b4da..9fb60f4dd092 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -457,7 +457,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
 	timerlat_top_header(params, top);
 
 	for (i = 0; i < nr_cpus; i++) {
-		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 			continue;
 		timerlat_top_print(top, i);
 		timerlat_top_update_sum(top, i, &summary);
@@ -618,8 +618,8 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -633,8 +633,8 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -643,27 +643,27 @@ static struct timerlat_params
 			params->aa_only = 1;
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				timerlat_top_usage("\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
@@ -673,24 +673,24 @@ static struct timerlat_params
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
-			params->events = tevent;
+			if (params->common.events)
+				tevent->next = params->common.events;
+			params->common.events = tevent;
 			break;
 		case 'h':
 		case '?':
 			timerlat_top_usage(NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case 'i':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
 			params->kernel_workload = true;
@@ -704,10 +704,10 @@ static struct timerlat_params
 				timerlat_top_usage("Period longer than 1 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				timerlat_top_usage("Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 'q':
 			params->quiet = 1;
@@ -716,7 +716,7 @@ static struct timerlat_params
 			params->print_stack = get_llong_from_str(optarg);
 			break;
 		case 'T':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
@@ -736,8 +736,8 @@ static struct timerlat_params
 			params->user_data = true;
 			break;
 		case '0': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -747,8 +747,8 @@ static struct timerlat_params
 			}
 			break;
 		case '1': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -771,10 +771,10 @@ static struct timerlat_params
 			params->dump_tasks = 1;
 			break;
 		case '6':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '7':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		case '8':
 			params->deepest_idle_state = get_llong_from_str(optarg);
@@ -809,7 +809,7 @@ static struct timerlat_params
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
 	 */
-	if (!params->stop_us && !params->stop_total_us)
+	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
 	if (params->no_aa && params->aa_only)
@@ -906,9 +906,9 @@ static void
 timerlat_top_set_signals(struct timerlat_params *params)
 {
 	signal(SIGINT, stop_top);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_top);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -926,7 +926,7 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 	int retval;
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		if (params->aa_only && !osnoise_trace_is_off(top, record))
 			continue;
@@ -992,7 +992,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->sleep_time);
+		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->common.sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(top);
 		if (retval) {
@@ -1094,16 +1094,16 @@ int timerlat_top_main(int argc, char *argv[])
 		goto out_free;
 	}
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("timerlat/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup && !params->user_data) {
-		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+	if (params->common.cgroup && !params->user_data) {
+		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -1127,7 +1127,7 @@ int timerlat_top_main(int argc, char *argv[])
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -1150,14 +1150,14 @@ int timerlat_top_main(int argc, char *argv[])
 		params->threshold_actions.trace_output_inst = record->trace.inst;
 		params->end_actions.trace_output_inst = record->trace.inst;
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_top;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_top;
 		}
@@ -1190,22 +1190,22 @@ int timerlat_top_main(int argc, char *argv[])
 		/* all threads left */
 		params_u.stopped_running = 0;
 
-		params_u.set = &params->monitored_cpus;
-		if (params->set_sched)
-			params_u.sched_param = &params->sched_param;
+		params_u.set = &params->common.monitored_cpus;
+		if (params->common.set_sched)
+			params_u.sched_param = &params->common.sched_param;
 		else
 			params_u.sched_param = NULL;
 
-		params_u.cgroup_name = params->cgroup_name;
+		params_u.cgroup_name = params->common.cgroup_name;
 
 		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
 		if (retval)
 			err_msg("Error creating timerlat user-space threads\n");
 	}
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 	}
 
 	/*
@@ -1258,7 +1258,8 @@ int timerlat_top_main(int argc, char *argv[])
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
 
 		return_value = FAILED;
 	} else if (params->aa_only) {
@@ -1279,13 +1280,13 @@ int timerlat_top_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			restore_cpu_idle_disable_state(i);
 		}
 	}
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	timerlat_free_top(top->data);
 	if (aa && aa != top)
-- 
2.50.1


