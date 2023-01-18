Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9C671439
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjARGbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjARGZy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:25:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7440D552B3;
        Tue, 17 Jan 2023 22:14:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so1267093pjg.4;
        Tue, 17 Jan 2023 22:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzb3dDf80FIRCQmibSPI5U5nXORwuSiNGSgRt/kZLJ0=;
        b=ktpzLfRdqURJuPDPKtq3ilBF/shlSgM+zuRpAf6OrVPdaUahGR82u/YgTl0v+6Y7S2
         UXi7fChjOc2fX/K2UsltwuKWnVpQW3M7e1MZWB361SDU4d4sy7nKEnD+YkbEL+Kxi09S
         fgAINUrK9U7b6YCXtKY8y2CaP6CWmefcU/nnQsXW7WdxHjHef/h8icQTgnho0VpcW/hn
         7oVF7Brnx5fsgldJZcPCutOsUUkT5e7SuQDvdmXLLhcIH1JPL/tiowMnNdIWbB4+p6eR
         uwbxYax8x4khmav4eyaMznL2YQ8uybHKOUd43982irD7ZXorKN5n7KdQgt+4dhJEbUnP
         pwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xzb3dDf80FIRCQmibSPI5U5nXORwuSiNGSgRt/kZLJ0=;
        b=c2YX7KQ5XqCMkN7BS7HneeosTaUgojjHi24t9Qh1uZz/RD3Fi3BnFBlIztiB+mSXlf
         msPNJpVqImRvWixZse5vg9o6mQjBfkVVps5ePhPsubju1+CyU8qpAOQmvmsswPYX7PXm
         8jEHoTMeWVifJP694d7gpEhI5WuM6vJvww9oM+wgE45ly+1mtnAmW1KZyZGI5Q8gm4cd
         HpJf+BBUcKLBxoVYB764N2qWI+M4aSAOwrrOf0z1id+xAajCYOKhKOs+ko0y0O96DhyN
         P/JVequchCB7nuN8xc0Ebz7MSeGhi8zLd1m8sv8nFMGS+k2YdRJyP3h5RjJ2Tk8hNUvO
         WYXA==
X-Gm-Message-State: AFqh2kpsIrhKp0OrTtM5Z2VbCPs4sYHuDoLi1GaUpcX3Qn9MBgH6KF5f
        GZ8hKijBB1ORw9xxBlM1a6tS+fY6KOA=
X-Google-Smtp-Source: AMrXdXu6gygno9P1g5Po2rkAAg4WltPLLTA2MBIM0tMtwy6iL08lEqK5rXFqXcGgtQpkcOIqrLc+ZA==
X-Received: by 2002:a05:6a00:4ac8:b0:581:bae0:d5d5 with SMTP id ds8-20020a056a004ac800b00581bae0d5d5mr5814871pfb.9.1674021963543;
        Tue, 17 Jan 2023 22:06:03 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:03 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/8] perf/core: Add perf_sample_save_callchain() helper
Date:   Tue, 17 Jan 2023 22:05:53 -0800
Message-Id: <20230118060559.615653-3-namhyung@kernel.org>
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

When it saves the callchain to the perf sample data, it needs to update
the sample flags and the dynamic size.  To make sure this, add the
perf_sample_save_callchain() helper and convert all call sites.

Cc: x86@kernel.org
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c  |  6 ++----
 arch/x86/events/intel/ds.c | 12 ++++--------
 include/linux/perf_event.h | 16 +++++++++++++++-
 kernel/events/core.c       | 12 ++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index da3f5ebac4e1..417c80bd3274 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1122,10 +1122,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data.callchain = perf_callchain(event, iregs);
-		data.sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6ec326b47e2e..158cf845fc80 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1617,10 +1617,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data->callchain = perf_callchain(event, iregs);
-		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1795,10 +1793,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data->callchain = perf_callchain(event, iregs);
-		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 16b980014449..a9419608402b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1095,6 +1095,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
+extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
+
 
 struct perf_sample_data {
 	/*
@@ -1167,6 +1169,19 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	}
 }
 
+static inline void perf_sample_save_callchain(struct perf_sample_data *data,
+					      struct perf_event *event,
+					      struct pt_regs *regs)
+{
+	int size = 1;
+
+	data->callchain = perf_callchain(event, regs);
+	size += data->callchain->nr;
+
+	data->dyn_size += size * sizeof(u64);
+	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1408,7 +1423,6 @@ extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
-extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8c8de26f04ab..0fba98b9cd65 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7585,16 +7585,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		int size = 1;
-
-		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
-			data->callchain = perf_callchain(event, regs);
-
-		size += data->callchain->nr;
-
-		data->dyn_size += size * sizeof(u64);
-	}
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, regs);
 
 	if (sample_type & PERF_SAMPLE_RAW) {
 		struct perf_raw_record *raw = data->raw;
-- 
2.39.0.314.g84b9a713c41-goog

