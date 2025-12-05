Return-Path: <bpf+bounces-76116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C854BCA835A
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0903011320
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9593596F7;
	Fri,  5 Dec 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMWh8KrK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9ZiHxmm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B686358D32
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948004; cv=none; b=VePH39YSuX7Y1GRER7t7CEnCwWqgAvpNN8KXPbtPwesvPt7zt86Xc2TAKpYr0PSuk+nu9k55BqC0yCnZTi1rSLAFz+PjCJ+gw6Y5Tp7PZeGbdonXJb1g2LorHGTrdsh4cQshij8n3GqE2wq8X9OT8wh2ACfT/o/HwnrgnQB7N9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948004; c=relaxed/simple;
	bh=1zpC3boqKD7w1pM9kextaa6f1WgP7ZLPKy2Nz7w1Xpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy1fJ5pakKwt4KS7YdMaTbBrqGeEzpSVPYbiZh7VACmq2EwrRgkbn0iAEwCWXAXfgci7oJ5ukfKDUnn+VnUYIj+hqnhWJ8ReoDeDb4ckURyXDd8aO9sOkGJ3FwOgtQ/2h3F/78qxutpigRESd+6dZXeAhjumSX6QyN8UZupl4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMWh8KrK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9ZiHxmm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764947996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqKIlVXXTKmBZEACp6ZW5pAUcp+AnDB3jgqSU2dLbHE=;
	b=SMWh8KrKDpzlihEaG4pEdeRnVaC7+WnyVg4R3zdIrnU11WYfLFraveYHYJ39w85wTxQM7c
	DY3/KjSh1dUHTmIGksjQ6iwV1gLvnBko9O/Wg1VEGQMI/tZ7tRkn9QqaQxSZto6kMxgmkg
	mZcottjSJr4g/TZTrp0equD2/cse6Ug=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-yA4a3juRMHK0BjMLria2VA-1; Fri, 05 Dec 2025 10:19:55 -0500
X-MC-Unique: yA4a3juRMHK0BjMLria2VA-1
X-Mimecast-MFC-AGG-ID: yA4a3juRMHK0BjMLria2VA_1764947994
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b352355a1so1620084f8f.1
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764947994; x=1765552794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqKIlVXXTKmBZEACp6ZW5pAUcp+AnDB3jgqSU2dLbHE=;
        b=G9ZiHxmm317S8r4IbfeixPakD84ONqFeieSJpOuUh2ZcMkhQDDDhWpne6ssUFbvIPR
         YgE404a3Gu4Rnvp+8XKtiKjW+oCKJ2b0aZZbLh+vUlm5si+wvtxUcKgN/2bME1ea77Nf
         jCNcWsv1QcUc5XQ+vYUl7yK5RVk/i+Uh7U8Eng8NScQj5WQ/CotFynM4dUL0MMwJfA/K
         D2mqdZFaSrhdOwyZq66vgI0AZXh0veJII0WI5PhotcCNpNAJvhHaSzKPzRONzFg7B+rl
         S4TsILVjVWdjMjSFOnn4rQ7ifRts055XPaDzP8rIv7KR56ISlq/FjLXepnM6KYSeoABA
         wkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947994; x=1765552794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CqKIlVXXTKmBZEACp6ZW5pAUcp+AnDB3jgqSU2dLbHE=;
        b=D3QZsv9+8pt86/Wy3Y7iibLctpuNZVhJpGJRzywUOsPMv6lKPAeXbwcqwYE4TXuDjF
         sGs2z3fSgPOiZVD3Qf0VahVXjalL5z+cm6bvRZMbOMh6zZL2/xSlZJ+vRdhS05MtK0If
         yhWQZFeQx+c8wkL551jwFvRXi8A5An/EDHQLxXDmQYRDUMdU27B0xCp/cZmzDJyokDe6
         KwCxm4u5DbyDMAN4tN9Sct7gPorBUHOy80xQaatCWDHyUx0Mct6zFAZM2feEmpoO/y7b
         58fQtkukQH4iRjmVH+ZBLXFqu1h0vy5dSvtPucqW8mH0XOqfvYgtA/fcwPa553hkXK/q
         s/7w==
X-Forwarded-Encrypted: i=1; AJvYcCVGHrem3wsqfiUeqfoctOVc1NSt6g7G/YHFSnofJ1xN97XPtHxVIgAnqv/Ogwy9nl5PQpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXok0/vmC394z0uLC4iR198EhAN+05OzNJ3K512MjGGJOLJjym
	7dDs7H3hBVGTLHqURDqqNAOmNf4cbZBBgwviPhiJD4R1Vr53l0nttRBdTE/Mr5iELrsK6NzyyJq
	T5fkRt+9kkeAs01B8XjyrsUv0AlVVPgb6ZYtgRNkXOeBn4Thp/QFI3Q==
X-Gm-Gg: ASbGnctvm3tYrO7LMUkTMocCOyDDiIRhiXmED8kYj8lt+8hYn51QHqGfe9nDQ7ZLGxA
	eJln5l6YpR3h/AK3rWxqFvzaTvgn+DNHiUsgXk6QkYlERytOEHiCltCJl9UJZicFrNoQ4JjPe9A
	mLZRsdC6fEpYh3/MzO40s73mZuHP2ba6WrcXmpGtMGrYWpiQsWP2Z19PwTexTzquEdehEnuSmWM
	8gUxxj6jEaYz/8IV2cJoqMmAXxdoafUE+6x4P+YkokD+Ts38wsVrpTSQliwhY9nzzvBflX308qD
	d272i7qLoRRebyyPEjJejEaEGua9dmTEDWTinLk7oWfugo6iu3z5fF+WCdmuOyHDNUkZ+mwsgeq
	+RAOxUiy93dQ3Dbck8YMJSdcyYNw=
X-Received: by 2002:a05:600c:35cb:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-4792eb34362mr87708825e9.9.1764947993627;
        Fri, 05 Dec 2025 07:19:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsalfLoAN7coI5FE0IesHktXh0uZ/rZJu8GrJTUoz+4jj9gwBhkJ+9n5C5J3zuXs0/CIA+MQ==
X-Received: by 2002:a05:600c:35cb:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-4792eb34362mr87708475e9.9.1764947993198;
        Fri, 05 Dec 2025 07:19:53 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b021cd2sm74880785e9.1.2025.12.05.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:19:52 -0800 (PST)
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
Subject: [PATCH v1 4/4] tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
Date: Fri,  5 Dec 2025 17:19:24 +0200
Message-ID: <20251205151924.2250142-4-costa.shul@redhat.com>
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

nr_cpus does not change at runtime, so passing it through the macro
argument is unnecessary.

Remove the argument and use the global nr_cpus instead.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.h        |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 15 +++++++--------
 tools/tracing/rtla/src/osnoise_top.c   |  2 +-
 tools/tracing/rtla/src/timerlat.c      |  4 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 16 ++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  |  2 +-
 6 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 2765e2a9f85f..a597e7591e20 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -109,7 +109,7 @@ struct common_params {
 
 extern int nr_cpus;
 
-#define for_each_monitored_cpu(cpu, nr_cpus, common) \
+#define for_each_monitored_cpu(cpu, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7514b29ec559..56bca13b991f 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -245,7 +245,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -274,8 +274,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
-
+	for_each_monitored_cpu(cpu, &params->common) {
 		if (!data->hist[cpu].count)
 			continue;
 
@@ -286,7 +285,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -299,7 +298,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -315,7 +314,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -350,7 +349,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -386,7 +385,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index e5a13f1bdfb6..0f5b86f11486 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -236,7 +236,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 
 	osnoise_top_header(top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		osnoise_top_print(top, i);
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 7503e18b905c..181d72de3197 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -124,7 +124,7 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 		}
 
-		for_each_monitored_cpu(i, nr_cpus, &params->common) {
+		for_each_monitored_cpu(i, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
 				return -1;
@@ -217,7 +217,7 @@ void timerlat_free(struct osnoise_tool *tool)
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
-		for_each_monitored_cpu(i, nr_cpus, &params->common) {
+		for_each_monitored_cpu(i, &params->common) {
 			restore_cpu_idle_disable_state(i);
 		}
 	}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 207359f1cec4..e93476e18ad8 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -298,7 +298,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -350,7 +350,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -372,7 +372,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -400,7 +400,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -428,7 +428,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -473,7 +473,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -620,7 +620,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -658,7 +658,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 34c8a0010828..c48f02075197 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -447,7 +447,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 
 	timerlat_top_header(params, top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		timerlat_top_print(top, i);
 		timerlat_top_update_sum(top, i, &summary);
 	}
-- 
2.52.0


