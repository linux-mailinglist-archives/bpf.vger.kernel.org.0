Return-Path: <bpf+bounces-76115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E2CA8525
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D8AA33B7576
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879273590CA;
	Fri,  5 Dec 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a19PZLYF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m1W7ZSel"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E88314D15
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948001; cv=none; b=PjCzdNXKuqwx5c7z9RxKto9dENBwN58Y3vsdv0x6ASH9P+ZuCMi3hPYwqHq7ppRTffMxR5GifXXucP28jNGRCgw/Mg/nRNbQVT1EXiGCnILpQwmhTOAlbC+Vv7d5hqd4F7KSnJxi2Tevz9nzUAJLc/eSWuYYZnxCBsJgrXbOMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948001; c=relaxed/simple;
	bh=Ge+xHcYscy7hibFPQ5CR6Kcj7CI8bXEYe8XIup/ucVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcHg6gjVMb8m+seicMsdxgI0wsUtoxURSdw/2ba0asUrx4ChAsWDRV8cR7Cd70GaXOSOmClN545c6jPy9DOl54xrnaWVihjg9+4U9Kvc1bmt2PR9DdE8Oy/k3sYX+DU4Tp1X7CnBKOuCQH7SmawXGdyAN5H0WxFTJQWtTpQA9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a19PZLYF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m1W7ZSel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764947994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRPU8uLPrnJcp2kzXwNUa4bZReRP3QAAdFafUOJXZZY=;
	b=a19PZLYFbm+KXiHVjal00s/HiBtuGgWp8GGWYm5E6XZlQQEoh4xKVEy/g7056JtHkVxyUt
	lz65gz4mSyIK+CV82ypEqQ7ypbiMNR5YY+OcZ5BV7juStMz6bWV3+2Nc/QL/4JxlduWs7F
	g/7Jjkc9ZAu7wVB5xdtvywGzSUcLQzc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-huwUcggFP0yt77vfBua9xw-1; Fri, 05 Dec 2025 10:19:52 -0500
X-MC-Unique: huwUcggFP0yt77vfBua9xw-1
X-Mimecast-MFC-AGG-ID: huwUcggFP0yt77vfBua9xw_1764947991
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso30266385e9.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764947991; x=1765552791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRPU8uLPrnJcp2kzXwNUa4bZReRP3QAAdFafUOJXZZY=;
        b=m1W7ZSelFc3yxsiEkJjQ7vVhdeg1oEgENEoZPGnm38MkJnOh91PCn70gp7mvLk8uxR
         qhSGhNv9aPYwVkm8fjooH5Fwxdfg59vsb2UJYk1ipvvZedD7o3x4iozCSEeyd/a22+ff
         p0vkGyZVqn+ocWC+O00v66GZnsY9gZE/LBRnzuQIU44cak09qdLIhiyusUbL/ZrDvhdE
         gqNGgebinKsV8uNhPyjzIdtl5zaQ4ikNjbIEwo1N607fpDFPjYNnxC/NqrDFVrJs6KSe
         pxNGRFcOdBM8M1koiuatmfbY/YaLChGeRBF7VLGmUaNFDKUztyOzfPQDmIZMbuolUJKc
         sd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947991; x=1765552791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRPU8uLPrnJcp2kzXwNUa4bZReRP3QAAdFafUOJXZZY=;
        b=lHdV6C68WuevEu30rnOpk/S+fBx+Yvh2syY3Z2IQBzuW6kijVQYSwgRZrcpiLTgHVG
         AX44RB1sHve21/XUku8O1PgTT8QsnxWooXBRlOH3TTwpA5cFHF/vBVFsuzDJgPBYdBXz
         G6uoSOjvwytrnHS15suoIWNycVG/6LThcDxLgkWKN2KoHMlmsi4cgT1JC44eL8fGkfZb
         LgJcq6SRZUgNyIqlRh82aAByJE44DenYNzEWrwCI7jN4iNXiPNmgWv9HfB1M6WUZXjxY
         ehglqBU27YEbWERG4mMiVWO/Micxs/xIIIXtib8PsViZBOstwh1o947P1F4IST4Z1AJI
         kMbw==
X-Forwarded-Encrypted: i=1; AJvYcCWdPiTiILRL4qVAvJDF6ItpuPItKp3Sv6wSx7+9VL0faBvKMAyiN/QiKSobXnrVrkSAOns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYBuAZDxyoTY/k+eW4ldclH3sU99dZqYR86TLQ6P6UaFBk8ax
	qV33PTdA0WVYmCxVabPbZZ2elPuPuo8E1b4pDQG2Gv4bOmk2yr31o6pE6rlpfM2xSdaMvVVmSHT
	Sc1gciyhgib9DHGj0hK4P22TnyNUMNGEiZlBWflaLn6NhCnfzhDjAkQ==
X-Gm-Gg: ASbGnculBmufz+s5fakehypCfa9wtlbJzyzpMqQXcSQby6avdm4R6rhx9nj6B11JmZA
	WZ7DPjfgEhy45mUye+2TSGzNMU9c7rePTGuCWHQXQLE10+zp/FawoD0n1yfUhJIY85PJ96f88nh
	hIO0SrJzQe+pFfgWhwjeJLwtoTG1xD/Ru3APlyIWk7pHWAm0EwBdrybGCVNpcoaydBOoC34h8AY
	+6WR5mnNMt9S2kyAVSP0c+67eFQ314hVuN1yn/sRZ4CyPmI+l3F7w1ay2eiXwCYuwsqgt9zbcKQ
	6j63Npk3WQqTHxea/oW/h36hkax8q7vAhplrktGPDmw5z3qAMOuagxWazFCpacARZllYFDItfWy
	3FzsLJ9OYJ2K6um4l7Dg8l2L8M1k=
X-Received: by 2002:a05:600c:4512:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4792f25bf1bmr78451515e9.12.1764947990980;
        Fri, 05 Dec 2025 07:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9FrEf19wCCSYk50h4PVg7Hgyxf3VtI4DoI+w4TKTX1XWuX3cnM0YvurOs50FiPzx7sDFSRg==
X-Received: by 2002:a05:600c:4512:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4792f25bf1bmr78451045e9.12.1764947990465;
        Fri, 05 Dec 2025 07:19:50 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b021cd2sm74880785e9.1.2025.12.05.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:19:49 -0800 (PST)
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
Subject: [PATCH v1 3/4] tools/rtla: Remove unneeded nr_cpus members
Date: Fri,  5 Dec 2025 17:19:23 +0200
Message-ID: <20251205151924.2250142-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151924.2250142-1-costa.shul@redhat.com>
References: <20251205151924.2250142-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_cpus does not change at runtime, so keeping it in struct members is
unnecessary.

Use the global nr_cpus instead of struct members.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 18 ++++++------
 tools/tracing/rtla/src/osnoise_top.c   |  3 --
 tools/tracing/rtla/src/timerlat_aa.c   | 10 +++----
 tools/tracing/rtla/src/timerlat_hist.c | 40 ++++++++++++--------------
 tools/tracing/rtla/src/timerlat_top.c  | 19 ++++++------
 5 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index ae773334e700..7514b29ec559 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -30,7 +30,6 @@ struct osnoise_hist_data {
 	struct osnoise_hist_cpu	*hist;
 	int			entries;
 	int			bucket_size;
-	int			nr_cpus;
 };
 
 /*
@@ -42,7 +41,7 @@ osnoise_free_histogram(struct osnoise_hist_data *data)
 	int cpu;
 
 	/* one histogram for IRQ and one for thread, per CPU */
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		if (data->hist[cpu].samples)
 			free(data->hist[cpu].samples);
 	}
@@ -74,7 +73,6 @@ static struct osnoise_hist_data
 
 	data->entries = entries;
 	data->bucket_size = bucket_size;
-	data->nr_cpus = nr_cpus;
 
 	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
 	if (!data->hist)
@@ -247,7 +245,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -276,7 +274,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -288,7 +286,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -301,7 +299,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -317,7 +315,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -352,7 +350,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -388,7 +386,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 367a765387c8..e5a13f1bdfb6 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -31,7 +31,6 @@ struct osnoise_top_cpu {
 
 struct osnoise_top_data {
 	struct osnoise_top_cpu	*cpu_data;
-	int			nr_cpus;
 };
 
 /*
@@ -59,8 +58,6 @@ static struct osnoise_top_data *osnoise_alloc_top(void)
 	if (!data)
 		return NULL;
 
-	data->nr_cpus = nr_cpus;
-
 	/* one set of histograms per CPU */
 	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
 	if (!data->cpu_data)
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 5766d58709eb..59b219a1503e 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -102,7 +102,6 @@ struct timerlat_aa_data {
  * The analysis context and system wide view
  */
 struct timerlat_aa_context {
-	int nr_cpus;
 	int dump_tasks;
 
 	/* per CPU data */
@@ -738,7 +737,7 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 	irq_thresh = irq_thresh * 1000;
 	thread_thresh = thread_thresh * 1000;
 
-	for (cpu = 0; cpu < taa_ctx->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 
 		if (irq_thresh && taa_data->tlat_irq_latency >= irq_thresh) {
@@ -766,7 +765,7 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 
 	printf("\n");
 	printf("Printing CPU tasks:\n");
-	for (cpu = 0; cpu < taa_ctx->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 		tep = taa_ctx->tool->trace.tep;
 
@@ -792,7 +791,7 @@ static void timerlat_aa_destroy_seqs(struct timerlat_aa_context *taa_ctx)
 	if (!taa_ctx->taa_data)
 		return;
 
-	for (i = 0; i < taa_ctx->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, i);
 
 		if (taa_data->prev_irqs_seq) {
@@ -842,7 +841,7 @@ static int timerlat_aa_init_seqs(struct timerlat_aa_context *taa_ctx)
 	struct timerlat_aa_data *taa_data;
 	int i;
 
-	for (i = 0; i < taa_ctx->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 
 		taa_data = timerlat_aa_get_data(taa_ctx, i);
 
@@ -1031,7 +1030,6 @@ int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
 
 	__timerlat_aa_ctx = taa_ctx;
 
-	taa_ctx->nr_cpus = nr_cpus;
 	taa_ctx->tool = tool;
 	taa_ctx->dump_tasks = dump_tasks;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index d4a9dcd67d48..207359f1cec4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -44,7 +44,6 @@ struct timerlat_hist_data {
 	struct timerlat_hist_cpu	*hist;
 	int				entries;
 	int				bucket_size;
-	int				nr_cpus;
 };
 
 /*
@@ -56,7 +55,7 @@ timerlat_free_histogram(struct timerlat_hist_data *data)
 	int cpu;
 
 	/* one histogram for IRQ and one for thread, per CPU */
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		if (data->hist[cpu].irq)
 			free(data->hist[cpu].irq);
 
@@ -94,7 +93,6 @@ static struct timerlat_hist_data
 
 	data->entries = entries;
 	data->bucket_size = bucket_size;
-	data->nr_cpus = nr_cpus;
 
 	/* one set of histograms per CPU */
 	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
@@ -204,17 +202,17 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 {
 	struct timerlat_hist_data *data = tool->data;
 	int i, j, err;
-	long long value_irq[data->nr_cpus],
-		  value_thread[data->nr_cpus],
-		  value_user[data->nr_cpus];
+	long long value_irq[nr_cpus],
+		  value_thread[nr_cpus],
+		  value_user[nr_cpus];
 
 	/* Pull histogram */
 	for (i = 0; i < data->entries; i++) {
 		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
-						  value_user, data->nr_cpus);
+						  value_user, nr_cpus);
 		if (err)
 			return err;
-		for (j = 0; j < data->nr_cpus; j++) {
+		for (j = 0; j < nr_cpus; j++) {
 			data->hist[j].irq[i] = value_irq[j];
 			data->hist[j].thread[i] = value_thread[j];
 			data->hist[j].user[i] = value_user[j];
@@ -226,7 +224,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].irq_count = value_irq[i];
 		data->hist[i].thread_count = value_thread[i];
 		data->hist[i].user_count = value_user[i];
@@ -236,7 +234,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].min_irq = value_irq[i];
 		data->hist[i].min_thread = value_thread[i];
 		data->hist[i].min_user = value_user[i];
@@ -246,7 +244,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].max_irq = value_irq[i];
 		data->hist[i].max_thread = value_thread[i];
 		data->hist[i].max_user = value_user[i];
@@ -256,7 +254,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].sum_irq = value_irq[i];
 		data->hist[i].sum_thread = value_thread[i];
 		data->hist[i].sum_user = value_user[i];
@@ -266,7 +264,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].irq[data->entries] = value_irq[i];
 		data->hist[i].thread[data->entries] = value_thread[i];
 		data->hist[i].user[data->entries] = value_user[i];
@@ -300,7 +298,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -352,7 +350,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -374,7 +372,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -402,7 +400,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -430,7 +428,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -475,7 +473,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -622,7 +620,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -660,7 +658,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7b62549f69e3..34c8a0010828 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -42,7 +42,6 @@ struct timerlat_top_cpu {
 
 struct timerlat_top_data {
 	struct timerlat_top_cpu	*cpu_data;
-	int			nr_cpus;
 };
 
 /*
@@ -72,8 +71,6 @@ static struct timerlat_top_data *timerlat_alloc_top(void)
 	if (!data)
 		return NULL;
 
-	data->nr_cpus = nr_cpus;
-
 	/* one set of histograms per CPU */
 	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
 	if (!data->cpu_data)
@@ -191,16 +188,16 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 {
 	struct timerlat_top_data *data = tool->data;
 	int i, err;
-	long long value_irq[data->nr_cpus],
-		  value_thread[data->nr_cpus],
-		  value_user[data->nr_cpus];
+	long long value_irq[nr_cpus],
+		  value_thread[nr_cpus],
+		  value_user[nr_cpus];
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].cur_irq = value_irq[i];
 		data->cpu_data[i].cur_thread = value_thread[i];
 		data->cpu_data[i].cur_user = value_user[i];
@@ -210,7 +207,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].irq_count = value_irq[i];
 		data->cpu_data[i].thread_count = value_thread[i];
 		data->cpu_data[i].user_count = value_user[i];
@@ -220,7 +217,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].min_irq = value_irq[i];
 		data->cpu_data[i].min_thread = value_thread[i];
 		data->cpu_data[i].min_user = value_user[i];
@@ -230,7 +227,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].max_irq = value_irq[i];
 		data->cpu_data[i].max_thread = value_thread[i];
 		data->cpu_data[i].max_user = value_user[i];
@@ -240,7 +237,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].sum_irq = value_irq[i];
 		data->cpu_data[i].sum_thread = value_thread[i];
 		data->cpu_data[i].sum_user = value_user[i];
-- 
2.52.0


