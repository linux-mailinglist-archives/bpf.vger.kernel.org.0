Return-Path: <bpf+bounces-61944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3AAEEE15
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64409189BD24
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B6218E99;
	Tue,  1 Jul 2025 06:04:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6EB18D;
	Tue,  1 Jul 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349843; cv=none; b=UvT7GMMAc/Oc+rf4v1CUuk+nJYInVRhGN/VFMDQtMTMtQLLaHayEkQutBddowzttwJiX3lUeAn8uCYeKV1XPnvw8S32+QheAoRFu9vOHvAwyO2inUK/t7m1ZKH/OZSVeS/TAL4u87v5CWDF5jjxQjrlF7iASSkmsDpxhgwAvYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349843; c=relaxed/simple;
	bh=aam3jqa0fO/VRzRpiRG8saL2ppQvVEt3VefmrmsXiTw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mXY1kQj//lmcmuH1ldpDIF7KIDZi60KP+kNnMUq2KKLI/r55fCzUTjG/tvQuOKNidSz22fMeWCFjo+ZXuxhDSOSbTrXVmNTmNiNNSrpCHAfKN+CojQtajBqUDWnb3iYSelLeckGEfhK0MWJ1PU4car9OFzdnuVDuyz2bQCMJdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so2489624f8f.2;
        Mon, 30 Jun 2025 23:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751349836; x=1751954636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlSY4PfFnZ+QFyRwPRdbpv456tvzDvOamZooLk66mD0=;
        b=YtDi+VLRkaYignxAgnKI8YqvrB8WLxXS+B5Lwr66nmTfXB9j0rr/i/1t6v01XaIqUw
         l20UJ4x5avCEnaEX68iwYIigLTPlu0Sfbf0YQzTCy0yVfaFp6pOPHzOZc4NTXP+bgkiF
         DigUWh3mWZPm0kOO+skk1C1JX2mFqR61mpzCR/s9EEflIbL+1cHqVSXh+b3oLGVkEqfG
         KiWAt77WeHkuGz6fsCXJnRO14J02R3VffSYDcdBvNLjSHd6nmAXvM65KKO0U8wQPHDvh
         6Tzayvt0prAmZ8yXIRbQrvf/RHMqOyhheftaXaZhCCguP26lWi9wbNsIFcl2B/JYKvho
         W8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUbHHOFL1A5qf29n+Nt+DlTutsxKqu2jndPMIYpn6Gv+PPwZChJpuSib2krjku5F2c+1O0=@vger.kernel.org, AJvYcCWFogdAP9M479yRCy0uP+JCI3jg7LNWf5t5RO/kBeLo4lWJ3NXPnD98PdI24F9gs6AAtqYFZg79xC9fdgAgr28OFCT7@vger.kernel.org, AJvYcCWivbRpxT4G7+oZ5ajBXl/E5sc+hHRGQUZLRkXJ/JcCCW5y6yRvds0V8nuSUZGIcZaVb20Yh7KS3qpqtl3v@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIZZgIbm14jlXFzf3KE1CbPoN+5ZkLgiMOn+g5NMPlPtByJPl
	Ka18GJKU7U2SAHyioJPcIf5ycKvQ4qwoNwH1IOBto3U2/9QsSdePGTZ/
X-Gm-Gg: ASbGncvwSn6UgerSVxdAJ4CqdlW//GVlSlafdRsGWkCyQ954pMVM+zBv/zv8lQuaCt0
	7MxMIxnGg53PlEJSCwKQbKN2aqUPKY6VrY7qbaUb1MyaulDIthiyXdjiqYD5xJ2lzd0QTLZ4Egv
	AKz9EirlT/C4oZUm60RjNSCrBzsLttIiqP/C7W83mpZof7IGt1XmqyP8lxUUgcrsTi7HvVN3j+1
	yJc9z2z6COawlhuKukPlF7Gt3HYlKs2pZF+0u9hdzvky6i5AmVj/VfpYh8eVVP7UWC3A6yvYP//
	UAdRYO+RDXyxLJzpqjY14h6Ph9/hI/51Xv8aljYVI/WlxoWXBRMS3TLKOeGzg9ses7fp7xK341n
	dLeU=
X-Google-Smtp-Source: AGHT+IEHQyqdwApVbMRtuJMXxBKETvubLza93fiHNs3j/xEoD2BIhF2g9HLON2rqMR9E4/QZYQmgKQ==
X-Received: by 2002:a05:6000:2083:b0:3a4:dc32:6cbb with SMTP id ffacd0b85a97d-3a8fee64e3amr13908001f8f.31.1751349835114;
        Mon, 30 Jun 2025 23:03:55 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e71dfsm11970260f8f.7.2025.06.30.23.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:03:54 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Consolidate common parameters into shared structure
Date: Tue,  1 Jul 2025 09:03:14 +0300
Message-ID: <20250701060337.648475-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timerlat_params and osnoise_params structures contain 17 identical
fields.

Introduce a common_params structure and move those fields into it to
eliminate the code duplication and improve maintainability.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c       |  24 ++---
 tools/tracing/rtla/src/osnoise.h       |  19 +---
 tools/tracing/rtla/src/osnoise_hist.c  | 112 ++++++++++-----------
 tools/tracing/rtla/src/osnoise_top.c   | 102 +++++++++----------
 tools/tracing/rtla/src/timerlat.c      |  24 ++---
 tools/tracing/rtla/src/timerlat.h      |  19 +---
 tools/tracing/rtla/src/timerlat_bpf.c  |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c | 129 +++++++++++++------------
 tools/tracing/rtla/src/timerlat_top.c  | 121 +++++++++++------------
 tools/tracing/rtla/src/utils.h         |  31 ++++++
 10 files changed, 292 insertions(+), 293 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 2dc3e4539e99..f8a323a6614e 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1127,18 +1127,18 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
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
 	}
 
-	if (params->runtime || params->period) {
+	if (params->common.runtime || params->period) {
 		retval = osnoise_set_runtime_period(tool->context,
-						    params->runtime,
+						    params->common.runtime,
 						    params->period);
 	} else {
 		retval = osnoise_set_runtime_period(tool->context,
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
index ac1c99910744..a887c95a9809 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -10,26 +10,9 @@ enum osnoise_mode {
 };
 
 struct osnoise_params {
-	/* Common params */
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*trace_output;
-	char			*cgroup_name;
-	unsigned long long	runtime;
+	struct common_params	common;
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
index 8d579bcee709..9e1277357c96 100644
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
@@ -537,13 +537,13 @@ static struct osnoise_params
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 
 			/* set sample threshold to 1 */
 			params->threshold = 1;
 
 			/* set trace */
-			params->trace_output = "osnoise_trace.txt";
+			params->common.trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'b':
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
@@ -610,21 +610,21 @@ static struct osnoise_params
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
-			params->runtime = get_llong_from_str(optarg);
-			if (params->runtime < 100)
+			params->common.runtime = get_llong_from_str(optarg);
+			if (params->common.runtime < 100)
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
@@ -632,13 +632,13 @@ static struct osnoise_params
 		case 't':
 			if (optarg) {
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					params->common.trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					params->common.trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '0')
-				params->trace_output = argv[optind];
+				params->common.trace_output = argv[optind];
 			else
-				params->trace_output = "osnoise_trace.txt";
+				params->common.trace_output = "osnoise_trace.txt";
 			break;
 		case '0': /* no header */
 			params->no_header = 1;
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
 
@@ -798,37 +798,37 @@ int osnoise_hist_main(int argc, char *argv[])
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
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->common.trace_output) {
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
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
@@ -841,13 +841,13 @@ int osnoise_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->common.trace_output)
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
@@ -894,13 +894,13 @@ int osnoise_hist_main(int argc, char *argv[])
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
 		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+				   params->common.trace_output);
 		return_value = FAILED;
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
index 2c12780c8aa9..a69e79c6ca02 100644
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
@@ -335,7 +335,7 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 		/*
 		 * Reduce CPU usage for 75% to avoid killing the system.
 		 */
-		params->runtime = 750000;
+		params->common.runtime = 750000;
 		params->period = 1000000;
 	}
 
@@ -377,37 +377,37 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 
 			/* set sample threshold to 1 */
 			params->threshold = 1;
 
 			/* set trace */
-			params->trace_output = "osnoise_trace.txt";
+			params->common.trace_output = "osnoise_trace.txt";
 
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
@@ -440,42 +440,42 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
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
 			break;
 		case 'r':
-			params->runtime = get_llong_from_str(optarg);
-			if (params->runtime < 100)
+			params->common.runtime = get_llong_from_str(optarg);
+			if (params->common.runtime < 100)
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
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					params->common.trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					params->common.trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '-')
-				params->trace_output = argv[optind];
+				params->common.trace_output = argv[optind];
 			else
-				params->trace_output = "osnoise_trace.txt";
+				params->common.trace_output = "osnoise_trace.txt";
 			break;
 		case 'T':
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
 
@@ -622,37 +622,37 @@ int osnoise_top_main(int argc, char **argv)
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
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->common.trace_output) {
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
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
@@ -665,13 +665,13 @@ int osnoise_top_main(int argc, char **argv)
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->common.trace_output)
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
@@ -720,13 +720,13 @@ int osnoise_top_main(int argc, char **argv)
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
 		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+				   params->common.trace_output);
 		return_value = FAILED;
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
index c29e2ba2d7d8..d1b6f8150781 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -26,27 +26,27 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
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
@@ -69,14 +69,14 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
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
@@ -84,7 +84,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		 *
 		 * No need to check results as this is an automatic attempt.
 		 */
-		auto_house_keeping(&params->monitored_cpus);
+		auto_house_keeping(&params->common.monitored_cpus);
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 73045aef23fa..e9c385a01da3 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -2,34 +2,17 @@
 #include "osnoise.h"
 
 struct timerlat_params {
-	/* Common params */
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*trace_output;
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
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 0bc44ce5d69b..4a78afa9f3b2 100644
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
index 36d2294c963d..72fe55592d3d 100644
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
@@ -856,30 +856,30 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			params->trace_output = "timerlat_trace.txt";
+			params->common.trace_output = "timerlat_trace.txt";
 
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
@@ -891,8 +891,8 @@ static struct timerlat_params
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
@@ -902,10 +902,10 @@ static struct timerlat_params
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
@@ -917,15 +917,15 @@ static struct timerlat_params
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
@@ -939,27 +939,27 @@ static struct timerlat_params
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
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					params->common.trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					params->common.trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '-')
-				params->trace_output = argv[optind];
+				params->common.trace_output = argv[optind];
 			else
-				params->trace_output = "timerlat_trace.txt";
+				params->common.trace_output = "timerlat_trace.txt";
 			break;
 		case 'u':
 			params->user_workload = 1;
@@ -986,8 +986,8 @@ static struct timerlat_params
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
@@ -997,8 +997,8 @@ static struct timerlat_params
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
@@ -1021,10 +1021,10 @@ static struct timerlat_params
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
@@ -1048,7 +1048,7 @@ static struct timerlat_params
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
 	 */
-	if (!params->stop_us && !params->stop_total_us)
+	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
 	if (params->kernel_workload && params->user_workload)
@@ -1130,9 +1130,9 @@ static void
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
 
@@ -1199,16 +1199,16 @@ int timerlat_hist_main(int argc, char *argv[])
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
@@ -1232,7 +1232,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -1245,21 +1245,21 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->common.trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
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
@@ -1289,22 +1289,22 @@ int timerlat_hist_main(int argc, char *argv[])
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
@@ -1316,7 +1316,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->common.trace_output)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1335,7 +1335,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	if (no_bpf) {
 		while (!stop_tracing) {
-			sleep(params->sleep_time);
+			sleep(params->common.sleep_time);
 
 			retval = tracefs_iterate_raw_events(trace->tep,
 							    trace->inst,
@@ -1384,10 +1384,11 @@ int timerlat_hist_main(int argc, char *argv[])
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
 
 		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+				   params->common.trace_output);
 		return_value = FAILED;
 	}
 
@@ -1397,13 +1398,13 @@ int timerlat_hist_main(int argc, char *argv[])
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
index 7365e08fe986..bd811ff1130f 100644
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
@@ -607,22 +607,22 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			params->trace_output = "timerlat_trace.txt";
+			params->common.trace_output = "timerlat_trace.txt";
 			break;
 		case '5':
 			/* it is here because it is similar to -a */
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -631,27 +631,27 @@ static struct timerlat_params
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
@@ -661,24 +661,24 @@ static struct timerlat_params
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
@@ -692,10 +692,10 @@ static struct timerlat_params
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
@@ -704,18 +704,18 @@ static struct timerlat_params
 			params->print_stack = get_llong_from_str(optarg);
 			break;
 		case 'T':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
 				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
+					params->common.trace_output = &optarg[1];
 				else
-					params->trace_output = &optarg[0];
+					params->common.trace_output = &optarg[0];
 			} else if (optind < argc && argv[optind][0] != '-')
-				params->trace_output = argv[optind];
+				params->common.trace_output = argv[optind];
 			else
-				params->trace_output = "timerlat_trace.txt";
+				params->common.trace_output = "timerlat_trace.txt";
 
 			break;
 		case 'u':
@@ -725,8 +725,8 @@ static struct timerlat_params
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
@@ -736,8 +736,8 @@ static struct timerlat_params
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
@@ -760,10 +760,10 @@ static struct timerlat_params
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
@@ -781,7 +781,7 @@ static struct timerlat_params
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
 	 */
-	if (!params->stop_us && !params->stop_total_us)
+	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
 	if (params->no_aa && params->aa_only)
@@ -869,9 +869,9 @@ static void
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
 
@@ -888,7 +888,7 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 	int retval;
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		if (params->aa_only && !osnoise_trace_is_off(top, record))
 			continue;
@@ -954,7 +954,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->sleep_time);
+		wait_retval = timerlat_bpf_wait(params->common.sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(top);
 		if (retval) {
@@ -1044,16 +1044,16 @@ int timerlat_top_main(int argc, char *argv[])
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
@@ -1077,7 +1077,7 @@ int timerlat_top_main(int argc, char *argv[])
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -1090,21 +1090,21 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->trace_output) {
+	if (params->common.trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
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
@@ -1137,22 +1137,22 @@ int timerlat_top_main(int argc, char *argv[])
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
@@ -1162,7 +1162,7 @@ int timerlat_top_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->trace_output)
+	if (params->common.trace_output)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1203,10 +1203,11 @@ int timerlat_top_main(int argc, char *argv[])
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
 
 		save_trace_to_file(record ? record->trace.inst : NULL,
-				   params->trace_output);
+				   params->common.trace_output);
 		return_value = FAILED;
 	} else if (params->aa_only) {
 		/*
@@ -1226,13 +1227,13 @@ int timerlat_top_main(int argc, char *argv[])
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
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index a2a6f89f342d..ea3ce1b59ac5 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -59,6 +59,37 @@ struct sched_attr {
 };
 #endif /* SCHED_ATTR_SIZE_VER0 */
 
+/*
+ * common_params - Parameters shared between timerlat_params and osnoise_params
+ *
+ * This structure contains all the fields that are identical in both
+ * timerlat_params and osnoise_params structures, eliminating duplication.
+ */
+struct common_params {
+	/* trace configuration */
+	char			*cpus;
+	cpu_set_t		monitored_cpus;
+	struct trace_events	*events;
+	int			buffer_size;
+	char			*trace_output;
+
+	/* Timing parameters */
+	int			warmup;
+	unsigned long long	runtime;
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
+
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int parse_cpu_set(char *cpu_list, cpu_set_t *set);
 int __set_sched_attr(int pid, struct sched_attr *attr);
-- 
2.48.1


