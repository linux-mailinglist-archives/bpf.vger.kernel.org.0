Return-Path: <bpf+bounces-28415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1868B92AA
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 02:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13761F21ACF
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0429AB;
	Thu,  2 May 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BhoMKOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC01647
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608368; cv=none; b=ksdi30lw8WLsyolKhQw64MPWdhDa9UsIzT9W6kHsfJa91fXtMAl+LlzGHJeNxALvphljuNwwFQ/qan5m4zCzW/88Hhjtz6ZCIgkd16f9tQIG1jDPF+5OokuMjiqjtTvPX/kSAXCNu8ljMYBMvSVWZAwSH4p3/PjXFkK7YpSo5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608368; c=relaxed/simple;
	bh=ydHrqPxoGeEttPy9dZN+F3NvpxP2IRhfrRzA30wOWp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YLiaGIVclGP0llMwOh+1oO4X2++mniY1AGpKrXZLIBCBcPF7RChpTIIb35NwiuiPvsTNc2FsryqSoxPRndKJrLdkIaZ+VcaIaCbet7z9291fcFP0idMOEhF4pDUpb28iOnLFdh1+Y1YcYqfKXbGWhnk88EcYiOEJU3kkqtfSCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BhoMKOl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de6054876efso5983186276.2
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714608365; x=1715213165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQRSP9X13w24BKs2qzwk/bhbNErXynjf0Rfm5l0EiQA=;
        b=2BhoMKOlvY3p9M6TME3JwxugtGNr6trMq4TgKLQv+e1DkPSfMV9vBk3E7u/ByfgcxU
         bLL1X+7fnF9V8273P7PNKplWPufgxEX3xJC3NRSJTqRq+juNJ9HNtKJxKpPcOvuQZFhY
         UpzKaE1YB7tRAf6AxJpNuQWiC3dHSrPdaBR5jilUEcUPa4JS6RvKP4XtAUx0W4jmJvM2
         0zaF8O88aLxB+feiyVUgnyfmUPklWkIq1sUZoXVqxDHTw/Ev2sdD2iykTCBCEevpHnI4
         I4W+61R+H8cWqxQeX4sNQk2sb3tal/BuO+hiKmNCJAnePXqNFdEF9a8FanRVDPBT5n6Q
         D1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714608365; x=1715213165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQRSP9X13w24BKs2qzwk/bhbNErXynjf0Rfm5l0EiQA=;
        b=JaUcx1C+PhTLZm4xGJDf85Jwb87lZDpSEvXtJInF2ZZi/UVd4UIIaDRzCQL2vFZD63
         K3O4azvlxLYIht7cYsaLiZw6HfjR6OlUPAS/o04fmrBc4NH7twO/0Heky/56xpRGvoLi
         ZBVS7W9SQe+UkXMYGDTFx7j4DpkWvy8vkUfX787qyAwkOc43R2YLu6kYedx+XP6sJAe0
         98eSlUUDvrw443D3AiTVlhS0x3IHEA5C73McLrR2atXJ3BeH2AiCMfEKWb/mHz1ZBYMH
         W6ZsNy+kqOyQ/VBNu+vdkQqPfh/WlYL+fxnAE/L5AJ5Qx16uJ8hTOzlMnEYUgN6hbF8L
         eNbA==
X-Forwarded-Encrypted: i=1; AJvYcCVk4CDFkAZM7HgkoNtU0XGk5gtHMAJOxWkUeQQCoTXjbfGCsLXV9vmFecZWFc3OC3qnFWm7muWIKIquhC/QZ0jHftpm
X-Gm-Message-State: AOJu0YzNyFboR1FSI8B1llzKIFQYBLw4akck8qk/KpXGGj0oIchZwgLi
	xM2DLb5olxi0P5LmjAhKyx1G59iGq8vic6CazWkLR7f3JVpmAHELevqLAScT+EvIIWiN9kJzQxe
	Y
X-Google-Smtp-Source: AGHT+IHP8OVULzYdZ/+rNjnenXdxVIu1A6L0kGwRCEVIBzk82Mkash/Yy6qJdq3lu7WrFTxM4xr0U9dwA+c=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:a80f:b677:9355:6ccc])
 (user=yabinc job=sendgmr) by 2002:a05:6902:708:b0:dd9:1702:4837 with SMTP id
 k8-20020a056902070800b00dd917024837mr1190112ybt.3.1714608365414; Wed, 01 May
 2024 17:06:05 -0700 (PDT)
Date: Wed,  1 May 2024 17:06:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240502000602.753861-1-yabinc@google.com>
Subject: [PATCH v2] perf/core: Save raw sample data conditionally based on
 sample type
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, space for raw sample data is always allocated within sample
records for both BPF output and tracepoint events. This leads to unused
space in sample records when raw sample data is not requested.

This patch checks sample type of an event before saving raw sample data
in both BPF output and tracepoint event handling logic. Raw sample data
will only be saved if explicitly requested, reducing overhead when it
is not needed.

Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
Signed-off-by: Yabin Cui <yabinc@google.com>
---

Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Original commit message from v1:
perf/core: Trim dyn_size if raw data is absent

 kernel/events/core.c     | 37 ++++++++++++++++++++-----------------
 kernel/trace/bpf_trace.c | 12 +++++++-----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..dc5f3147feef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10120,9 +10120,9 @@ static struct pmu perf_tracepoint = {
 };
 
 static int perf_tp_filter_match(struct perf_event *event,
-				struct perf_sample_data *data)
+				struct perf_raw_record *raw)
 {
-	void *record = data->raw->frag.data;
+	void *record = raw->frag.data;
 
 	/* only top level events have filters set */
 	if (event->parent)
@@ -10134,7 +10134,7 @@ static int perf_tp_filter_match(struct perf_event *event,
 }
 
 static int perf_tp_event_match(struct perf_event *event,
-				struct perf_sample_data *data,
+				struct perf_raw_record *raw,
 				struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
@@ -10145,7 +10145,7 @@ static int perf_tp_event_match(struct perf_event *event,
 	if (event->attr.exclude_kernel && !user_mode(regs))
 		return 0;
 
-	if (!perf_tp_filter_match(event, data))
+	if (!perf_tp_filter_match(event, raw))
 		return 0;
 
 	return 1;
@@ -10171,6 +10171,7 @@ EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
 static void __perf_tp_event_target_task(u64 count, void *record,
 					struct pt_regs *regs,
 					struct perf_sample_data *data,
+					struct perf_raw_record *raw,
 					struct perf_event *event)
 {
 	struct trace_entry *entry = record;
@@ -10180,13 +10181,18 @@ static void __perf_tp_event_target_task(u64 count, void *record,
 	/* Cannot deliver synchronous signal to other task. */
 	if (event->attr.sigtrap)
 		return;
-	if (perf_tp_event_match(event, data, regs))
+	if (perf_tp_event_match(event, raw, regs)) {
+		perf_sample_data_init(data, 0, 0);
+		if (event->attr.sample_type & PERF_SAMPLE_RAW)
+			perf_sample_save_raw_data(data, raw);
 		perf_swevent_event(event, count, data, regs);
+	}
 }
 
 static void perf_tp_event_target_task(u64 count, void *record,
 				      struct pt_regs *regs,
 				      struct perf_sample_data *data,
+				      struct perf_raw_record *raw,
 				      struct perf_event_context *ctx)
 {
 	unsigned int cpu = smp_processor_id();
@@ -10194,15 +10200,15 @@ static void perf_tp_event_target_task(u64 count, void *record,
 	struct perf_event *event, *sibling;
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 }
 
@@ -10220,15 +10226,10 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		},
 	};
 
-	perf_sample_data_init(&data, 0, 0);
-	perf_sample_save_raw_data(&data, &raw);
-
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs)) {
-			perf_swevent_event(event, count, &data, regs);
-
+		if (perf_tp_event_match(event, &raw, regs)) {
 			/*
 			 * Here use the same on-stack perf_sample_data,
 			 * some members in data are event-specific and
@@ -10238,7 +10239,9 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			 * because data->sample_flags is set.
 			 */
 			perf_sample_data_init(&data, 0, 0);
-			perf_sample_save_raw_data(&data, &raw);
+			if (event->attr.sample_type & PERF_SAMPLE_RAW)
+				perf_sample_save_raw_data(&data, &raw);
+			perf_swevent_event(event, count, &data, regs);
 		}
 	}
 
@@ -10255,7 +10258,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		perf_tp_event_target_task(count, record, regs, &data, &raw, ctx);
 		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9dc605f08a23..4b3ff71b4c0a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -620,7 +620,8 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
-			u64 flags, struct perf_sample_data *sd)
+			u64 flags, struct perf_raw_record *raw,
+			struct perf_sample_data *sd)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	unsigned int cpu = smp_processor_id();
@@ -645,6 +646,9 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
+	if (event->attr.sample_type & PERF_SAMPLE_RAW)
+		perf_sample_save_raw_data(sd, raw);
+
 	return perf_event_output(event, sd, regs);
 }
 
@@ -688,9 +692,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	err = __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_trace_nest_level);
 	preempt_enable();
@@ -749,9 +752,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	ret = __bpf_perf_event_output(regs, map, flags, sd);
+	ret = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
 	preempt_enable();
-- 
2.45.0.rc0.197.gbae5840b3b-goog


