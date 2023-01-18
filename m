Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64E6713C4
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjARGUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjARGSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:18:17 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7D442D4;
        Tue, 17 Jan 2023 22:06:03 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q9so23748273pgq.5;
        Tue, 17 Jan 2023 22:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4FWYNGqeIRLLvbuHSi4QxIqv+Z+4df4xqBN1sLuHUI=;
        b=LWvdJAHv1jZf2z/7zujPgBAeAQ9KRsb7GuuOIaayNaFGOHtclEFJNra3G9kr6/uxei
         zR2Juw7BZwh2ifMPPiDuNeZeXPCA48C1PahDHi7cWjsCw8fBkvm2qfeIw5L5lltkzDFF
         WYb58icJKGcvZWXpubVZToPAOkDHgyJEr2xn9IP/zyx/kxIb0TLonxdTcmBotQFeeMGR
         JQhjTOfvONTkw+R2EQ5+xeCiOtjEpdsE3/xy4H4W8R8E5UwLyNrR3JYh4rldqVb+VWEe
         b1jWcd8/kyha9QadyEQuIu7zIy4uzz/xsHbt8GObU0YbAW2yMi9EnRC+mFAVX7DuiN6f
         oEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4FWYNGqeIRLLvbuHSi4QxIqv+Z+4df4xqBN1sLuHUI=;
        b=tSgeZaUOzcqGTPO0151PFgXi2crUWlIySGcLGi50TiLLH9C2ZfQ5AmQ3XTFTPPOUFj
         7ToHVAqXw3/3wJKGIXudIGsx/GRNb5TFBBoBT4ag4kb55x2Xhu8UH5F0SFrA39pMcVwz
         M1INgCjrjnwZxK37vPygzj8GyZ7mXMJFVM2uZwY7JQOBbVLXb6VZ7ZeMmustEVb5iXUL
         X0GQ9QrajGl1pyEj2QPJPk/Ox8PYH3xg221rKbiwkbohYZKfdAng6QOYS6AAvyu9Nt7m
         KPtQhwQ22+a+NOGpvvKmqCXxdqGrg+WSO6x0q2ullJEWZEbJsYUh3APEMWc6q3LooGBo
         +wQg==
X-Gm-Message-State: AFqh2koWr93iWJFmfwks3xGl3mHurvrko9IhDcILICZgCp3Y2M+NzeV7
        JtpFGKs2+Uo7BHO2mAtatnSlCvXYylA=
X-Google-Smtp-Source: AMrXdXu4JZ8K4+nwdu5Ql6RmPRpETATz1ehBeMVqW1WRR163R1j1Zq1erJ2q6YP17Z7TMZGGtcXj4w==
X-Received: by 2002:a62:640f:0:b0:581:f301:23fc with SMTP id y15-20020a62640f000000b00581f30123fcmr24054116pfb.12.1674021962020;
        Tue, 17 Jan 2023 22:06:02 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:01 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH 1/8] perf/core: Save the dynamic parts of sample data size
Date:   Tue, 17 Jan 2023 22:05:52 -0800
Message-Id: <20230118060559.615653-2-namhyung@kernel.org>
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

The perf sample data can be divided into parts.  The event->header_size
and event->id_header_size keep the static part of the sample data which
is determined by the sample_type flags.

But other parts like CALLCHAIN and BRANCH_STACK are changing dynamically
so it needs to see the actual data.  In preparation of handling repeated
calls for perf_prepare_sample(), it can save the dynamic size to the
perf sample data to avoid the duplicate work.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 03949d017ac9..16b980014449 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,6 +1103,7 @@ struct perf_sample_data {
 	 */
 	u64				sample_flags;
 	u64				period;
+	u64				dyn_size;
 
 	/*
 	 * Fields commonly set by __perf_event_header__init_id(),
@@ -1158,6 +1159,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
+	data->dyn_size = 0;
 
 	if (addr) {
 		data->addr = addr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc3702654d..8c8de26f04ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7593,7 +7593,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		size += data->callchain->nr;
 
-		header->size += size * sizeof(u64);
+		data->dyn_size += size * sizeof(u64);
 	}
 
 	if (sample_type & PERF_SAMPLE_RAW) {
@@ -7619,7 +7619,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			data->raw = NULL;
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -7631,7 +7631,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
 		}
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
@@ -7646,7 +7646,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += hweight64(mask) * sizeof(u64);
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
@@ -7671,7 +7671,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += sizeof(u64) + stack_size;
 
 		data->stack_user_size = stack_size;
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
@@ -7700,7 +7700,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += hweight64(mask) * sizeof(u64);
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
@@ -7745,8 +7745,11 @@ void perf_prepare_sample(struct perf_event_header *header,
 		size = perf_prepare_sample_aux(event, data, size);
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
-		header->size += size;
+		data->dyn_size += size + sizeof(u64); /* size above */
 	}
+
+	header->size += data->dyn_size;
+
 	/*
 	 * If you're adding more sample types here, you likely need to do
 	 * something about the overflowing header::size, like repurpose the
-- 
2.39.0.314.g84b9a713c41-goog

