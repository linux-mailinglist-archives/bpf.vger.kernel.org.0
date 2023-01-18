Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56896713D0
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjARGVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjARGTs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:19:48 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94C1E284;
        Tue, 17 Jan 2023 22:06:12 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 7so23755898pga.1;
        Tue, 17 Jan 2023 22:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UMOA0c+N7OAsEuvPNaOaIppjJrZZvJ4XmiXNPGO7jM=;
        b=nRTb7lNQXs0UljzO9lnEQzwEFyUDs2cUuu24BBrSK7xU5xhX7gkvGADL+JeOfVtOC7
         bIh9UfRtdt5x0p7jQ5buGbLMxxD4GH68XWLFI0pEfTkFFrBnIQmXCiffcKS8udc0Pd1t
         eoRJ3+NjwhuRuGPZo1KBHobDhbItVN1Z950lTWYGOZ3R8YEJCksgCmHT31TALo18DEmp
         2+xlckgBjhhKib0P9MNtdZhYONTXiuL1OwwZZHMjda84Ftk8HHJpHXic5ob6JMuLrSRY
         yHXI+9wB/K1UC6n/zbwENCNGT5l6reo1OGB5/TT/TxEFYoz9bZJfTx/FHjiM6Er9Akyb
         V0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UMOA0c+N7OAsEuvPNaOaIppjJrZZvJ4XmiXNPGO7jM=;
        b=k6HkI6AnKJIUeALw0c1tT+EQmAknvPIArmqQSHn2EJQtKtyzf0ueD8cmNQZ/pwPDCf
         /n97P5nXuwtUH7hoe/8FE+2xA37lxgZLu2OF8AUmKgoV+vMhgRYGoimvN/End/NUJr2y
         tbWQPYeAe8F/zA/ycmPd25zarlf5j8sFHxDnWyh63FDHhpRlpwdIKoZ4qvQifTmqzORD
         M0TxHUtJidQQRMLGki0hgXRhJJUIn8ydmOW7XEn+5X8Avua48WDXueVI/ZH1HHeWocuZ
         YNK0iqZsQoXHD2AIt+qYhZY48Kb1Trha9yIPDB3w9eWF6M8HL+cgalbwjW3/q1CR3svc
         lYcQ==
X-Gm-Message-State: AFqh2krK8Sb7viN110NW0vGxvU3DbpMEiFbiuzcWjaZO4e9Qo/TgcZIi
        plKj5tVHLgqcVhWk/+2Qew0=
X-Google-Smtp-Source: AMrXdXsgpHAFSMvfJ97QDSqfE+WKzuYVN0tIzxUSZMMoa+G5QN0omUTUE4jyZ8Y78ZCzjIzUjJpfRQ==
X-Received: by 2002:aa7:9607:0:b0:580:9e9e:c442 with SMTP id q7-20020aa79607000000b005809e9ec442mr5956540pfg.24.1674021964985;
        Tue, 17 Jan 2023 22:06:04 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:04 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
Subject: [PATCH 3/8] perf/core: Add perf_sample_save_raw_data() helper
Date:   Tue, 17 Jan 2023 22:05:54 -0800
Message-Id: <20230118060559.615653-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230118060559.615653-1-namhyung@kernel.org>
References: <20230118060559.615653-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When it saves the raw_data to the perf sample data, it needs to update
the sample flags and the dynamic size.  To make sure this, add the
perf_sample_save_raw_data() helper and convert all call sites.

Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: bpf@vger.kernel.org
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c    |  4 +---
 arch/s390/kernel/perf_pai_crypto.c |  4 +---
 arch/s390/kernel/perf_pai_ext.c    |  4 +---
 arch/x86/events/amd/ibs.c          |  3 +--
 include/linux/perf_event.h         | 33 +++++++++++++++++++++++++-----
 kernel/events/core.c               | 31 +++++-----------------------
 kernel/trace/bpf_trace.c           |  6 ++----
 7 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index f043a7ff220b..aa38649c7c27 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -662,9 +662,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = cpuhw->usedss;
 		raw.frag.data = cpuhw->stop;
-		raw.size = raw.frag.size;
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 985e243a2ed8..a7b339c4fd7c 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -362,9 +362,7 @@ static int paicrypt_push_sample(void)
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		raw.size = raw.frag.size;
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 1138f57baae3..555597222bad 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -451,9 +451,7 @@ static int paiext_push_sample(void)
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		raw.size = raw.frag.size;
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 417c80bd3274..64582954b5f6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1110,8 +1110,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 				.data = ibs_data.data,
 			},
 		};
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	if (perf_ibs == &perf_ibs_op)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a9419608402b..569dfac5887f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -95,6 +95,11 @@ struct perf_raw_record {
 	u32				size;
 };
 
+static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
+{
+	return frag->pad < sizeof(u64);
+}
+
 /*
  * branch stack layout:
  *  nr: number of taken branches stored in entries[]
@@ -1182,6 +1187,29 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
 }
 
+static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
+					     struct perf_raw_record *raw)
+{
+	struct perf_raw_frag *frag = &raw->frag;
+	u32 sum = 0;
+	int size;
+
+	do {
+		sum += frag->size;
+		if (perf_raw_frag_last(frag))
+			break;
+		frag = frag->next;
+	} while (1);
+
+	size = round_up(sum + sizeof(u32), sizeof(u64));
+	raw->size = size - sizeof(u32);
+	frag->pad = raw->size - sum;
+
+	data->raw = raw;
+	data->dyn_size += size;
+	data->sample_flags |= PERF_SAMPLE_RAW;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1690,11 +1718,6 @@ extern void perf_restore_debug_store(void);
 static inline void perf_restore_debug_store(void)			{ }
 #endif
 
-static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
-{
-	return frag->pad < sizeof(u64);
-}
-
 #define perf_output_put(handle, x) perf_output_copy((handle), &(x), sizeof(x))
 
 struct perf_pmu_events_attr {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0fba98b9cd65..133894ae5e30 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7588,30 +7588,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
 
-	if (sample_type & PERF_SAMPLE_RAW) {
-		struct perf_raw_record *raw = data->raw;
-		int size;
-
-		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
-			struct perf_raw_frag *frag = &raw->frag;
-			u32 sum = 0;
-
-			do {
-				sum += frag->size;
-				if (perf_raw_frag_last(frag))
-					break;
-				frag = frag->next;
-			} while (1);
-
-			size = round_up(sum + sizeof(u32), sizeof(u64));
-			raw->size = size - sizeof(u32);
-			frag->pad = raw->size - sum;
-		} else {
-			size = sizeof(u64);
-			data->raw = NULL;
-		}
-
-		data->dyn_size += size;
+	if (filtered_sample_type & PERF_SAMPLE_RAW) {
+		data->raw = NULL;
+		data->dyn_size += sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -10127,8 +10107,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	};
 
 	perf_sample_data_init(&data, 0, 0);
-	data.raw = &raw;
-	data.sample_flags |= PERF_SAMPLE_RAW;
+	perf_sample_save_raw_data(&data, &raw);
 
 	perf_trace_buf_update(record, event_type);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..ad37608afc35 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -687,8 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	sd->raw = &raw;
-	sd->sample_flags |= PERF_SAMPLE_RAW;
+	perf_sample_save_raw_data(sd, &raw);
 
 	err = __bpf_perf_event_output(regs, map, flags, sd);
 
@@ -746,8 +745,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	sd->raw = &raw;
-	sd->sample_flags |= PERF_SAMPLE_RAW;
+	perf_sample_save_raw_data(sd, &raw);
 
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
-- 
2.39.0.314.g84b9a713c41-goog

