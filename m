Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12A6685CF
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbjALVsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbjALVrg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18686DBA4;
        Thu, 12 Jan 2023 13:40:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h192so13691860pgc.7;
        Thu, 12 Jan 2023 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3GEYOgHwVgvJBmBnAdUL8BdmY/9n1zanIfz8U25Xac=;
        b=Gb11zOzI9XeCl+/zCSz8IqtHBx1WB/Pd3fb3E2R32TTjj2OD1cwX9X8V6TSptQQv4i
         MaFNBKnV3reJc2C/aH3UjumX3hFZ0Y+WpC9LSBGH4NS9RDx2XCa0C0kpe98OHCg08b+/
         vLC6CfHccT4mUKZHJicRNjOpCGAbGjIQ25ywc2nSHkbHLq1kWI2hN08wxujg6BURrs/9
         e1H0brQCK9Enl3zWbMiwOWn9y0wJw21x/i7Obphk7dBJDd1ss8j4b0ewmTwLr0qXH2ok
         kdFo2Kw81t/lH4lGnlX9pNWssTvKD88pq4ExF1dQmxEjfktEhXm6pIh0VJ30507tC08b
         UpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3GEYOgHwVgvJBmBnAdUL8BdmY/9n1zanIfz8U25Xac=;
        b=bArBiHr6srPrm8CNsUgDFDCyq4aOETUOkiiZC0WUT5vgFJXLsJkalil9r+CTLbYY4a
         e1gH79HYO1PW257VpREAa0hAL+yoh3rRRjN73DlO1DXERa8+q1KsJsRWkw9Im+w9/bTl
         7UgZdWuMJgPKOuhc5M51nKclANnJiiQ9z4xvw3UvSqoIhPXG92ZV4NpPiQLqnGLIp2fl
         WAUMNdASvvEWvhRYygEFeVOcyCZbMferFSb9zn/hT/W502/zauLaSHxTJvjiBc3ESVN3
         i9PrlA6r72C5I26p4dGhwG4tBVru0hC36t+MRYud0jiarXCia+79sncB5cM1kvvIqGVk
         MSPw==
X-Gm-Message-State: AFqh2koxHwOpdW9oD3R6SSrOya05GDWwL/U/Y9c2AxQGTGVtRbRAofHy
        3Kk/jEX1yKPNuwaJycg/TDA=
X-Google-Smtp-Source: AMrXdXubGB5Pd7aXclXke3/QKfLbDxQrtVVvLizKeXonP8BECBbNKliNCfkDMiH+agQTZxzwWIIevw==
X-Received: by 2002:a62:cd4e:0:b0:58a:d606:4258 with SMTP id o75-20020a62cd4e000000b0058ad6064258mr11338748pfg.10.1673559623278;
        Thu, 12 Jan 2023 13:40:23 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:22 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        linux-s390@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org
Subject: [PATCH 3/8] perf/core: Add perf_sample_save_raw_data() helper
Date:   Thu, 12 Jan 2023 13:40:10 -0800
Message-Id: <20230112214015.1014857-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

