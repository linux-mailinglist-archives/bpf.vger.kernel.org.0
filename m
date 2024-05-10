Return-Path: <bpf+bounces-29409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55A8C1BB2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BDB1F2122A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470F4DA1F;
	Fri, 10 May 2024 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAVUeDj/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BA4D584
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300688; cv=none; b=kssYp/RfJM9fOzMRGkbNqVpKbjdKmrmPDYOw6F0WowPNDh4Rwpgki2Pqh8XY1KRKGBf9jMhXstw/+IeWqXUf5GtNZ7Kipz5zuBkuLSeT1WyaVnp/1L+10+AqT0g3Agi5xIhgAnCGBsxFAMVINxbrz2I1Fb8TXW5oUR8Gt93oDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300688; c=relaxed/simple;
	bh=h9T/hWcYd16AoD1la+Akzb6wRgZknIdJh4UH2m1KpFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e477nayVfqfjl2Dhf9ulkzNB9sYeqbOiyG4d0ZqCjag5iuBsWfhVPBuGyIVaU63+R0MWVGWDpXKN8mTHniu0Su0tPP58Gmfwud22s79TY3C5ZM6apxQCTISDLCzV2jE6yo0FaT2KooF04JfnwlkeggDhzEtB1UGrNRSPUxHRh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAVUeDj/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60321ce6cso2622770276.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300686; x=1715905486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEhmGuC8oUTZwVi2h6WErUBS5w6ne3vZ9G77u3QpAiI=;
        b=VAVUeDj/NozbUkhyaeIqM3HbzfJeL8jTI57GPlp/P+07ANy1gne7h2jFkDcHqyG8mz
         aDk2uML1i3ARBLc7o1ytDKNONM0xh5oocmR6rd53OT6nHKY5KFB7VNtTz9ZcbGz5Ha6n
         AyNoyWhvSRBqfgcm4cdChry4j6YzbcIQU/fxT+fS6J6AU5YvEMZ/XZar/I+Ho4IJpBm2
         D9Rz4KspliYpFgCiivuCVNcBJnMAt1jN5Xp8g3Cb+iOsxLi6oDQxzz1GIjR12Bm/3Dc/
         59gz+aZ9IuFqwbp/PCsw1J5UBcVU7A+6ltktr6BoncafWgSe0EIgDsSlpkdyeUly+ba/
         dvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300686; x=1715905486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEhmGuC8oUTZwVi2h6WErUBS5w6ne3vZ9G77u3QpAiI=;
        b=MHUgdzvxUxBy97aT0jTXCVwCtapsRwPcIGhU+Q3Cjq53VnSLqMtGlVBweFGW+zTvT0
         VrKnnL6q6N6BpDREs9xg1BtwbWka56tlGQnCRjH2u94FZY72kHZkvAq8aJ745cAzKqMb
         rfkNXK7E5VbzyxGRkIFjHMQFWytMdpgVUF7hdZpZzxM34rvNYP+cBhf2y9xOi0ik5shx
         +IfRp20MoFMqIUgtXYkbsYHXztM2AFzjxDpYlPF54hqUQRmXL3avoppsUvoZEb2BO1v4
         Z/wwhHgIu/nfxFg75Mdokzs8hA2AMQy2dMSmUvt2oJt4Uc2+JNFsxY/U6RjyAs5pq5qM
         WR0w==
X-Forwarded-Encrypted: i=1; AJvYcCVUm49egY/LckA6tSns2G5pJlF1lNXc+N8Oop16vfXckFbO/DobJ+8AtjWxaYUpEP5zr76uBXhajy6Ex+mnyYZQvf2Q
X-Gm-Message-State: AOJu0YxAHahi14ysYBZWjz0wGmNHekRH8HBrNFBVEHsoOGSyAJy/+sHH
	oZSPsjdc/NrSJvOtGILvCCoYqMLE9QACxC4ZSfR/BACs9zeg9r1OrTLIBxmRpDVdyg6/34H0zu0
	T
X-Google-Smtp-Source: AGHT+IEOhxkFEZFd9IOgCTNmtdNHgxHs7/BU0QBCUG8MINyjgRLrnm4Z+DffoCYp+ZKNgxRqYw2k4D3ACuc=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:6902:110c:b0:de5:8427:d66e with SMTP id
 3f1490d57ef6-dee4f38b7c0mr299253276.11.1715300686192; Thu, 09 May 2024
 17:24:46 -0700 (PDT)
Date: Thu,  9 May 2024 17:24:22 -0700
In-Reply-To: <20240510002424.1277314-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510002424.1277314-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510002424.1277314-2-yabinc@google.com>
Subject: [PATCH v3 1/3] perf/core: Save raw sample data conditionally based on
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
 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/ibs.c          |  2 +-
 include/linux/perf_event.h         |  4 ++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 7 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 41ed6e0f0a2a..c7fb99cb1e15 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -971,7 +971,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = cpuhw->usedss;
 		raw.frag.data = cpuhw->stop;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 4ad472d130a3..2fb8aeba4872 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -444,7 +444,7 @@ static int paicrypt_push_sample(size_t rawsize, struct paicrypt_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index a6da7e0cc7a6..b2914df2107a 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -458,7 +458,7 @@ static int paiext_push_sample(size_t rawsize, struct paiext_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..c3a2f6f57770 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1118,7 +1118,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 				.data = ibs_data.data,
 			},
 		};
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	if (perf_ibs == &perf_ibs_op)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..9fc55193ff99 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1240,12 +1240,16 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 }
 
 static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
+					     struct perf_event *event,
 					     struct perf_raw_record *raw)
 {
 	struct perf_raw_frag *frag = &raw->frag;
 	u32 sum = 0;
 	int size;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
+		return;
+
 	do {
 		sum += frag->size;
 		if (perf_raw_frag_last(frag))
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..3031cade53bb 100644
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
@@ -10180,13 +10181,17 @@ static void __perf_tp_event_target_task(u64 count, void *record,
 	/* Cannot deliver synchronous signal to other task. */
 	if (event->attr.sigtrap)
 		return;
-	if (perf_tp_event_match(event, data, regs))
+	if (perf_tp_event_match(event, raw, regs)) {
+		perf_sample_data_init(data, 0, 0);
+		perf_sample_save_raw_data(data, event, raw);
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
@@ -10194,15 +10199,15 @@ static void perf_tp_event_target_task(u64 count, void *record,
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
 
@@ -10220,15 +10225,10 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
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
@@ -10238,7 +10238,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			 * because data->sample_flags is set.
 			 */
 			perf_sample_data_init(&data, 0, 0);
-			perf_sample_save_raw_data(&data, &raw);
+			perf_sample_save_raw_data(&data, event, &raw);
+			perf_swevent_event(event, count, &data, regs);
 		}
 	}
 
@@ -10255,7 +10256,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		perf_tp_event_target_task(count, record, regs, &data, &raw, ctx);
 		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9dc605f08a23..23bcf28ccc82 100644
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
@@ -645,6 +646,8 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
+	perf_sample_save_raw_data(sd, event, raw);
+
 	return perf_event_output(event, sd, regs);
 }
 
@@ -688,9 +691,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	err = __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_trace_nest_level);
 	preempt_enable();
@@ -749,9 +751,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	ret = __bpf_perf_event_output(regs, map, flags, sd);
+	ret = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
 	preempt_enable();
-- 
2.45.0.118.g7fe29c98d7-goog


