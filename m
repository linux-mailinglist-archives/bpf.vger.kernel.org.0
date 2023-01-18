Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B56713D2
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjARGWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjARGTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:19:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAEB1E2A7;
        Tue, 17 Jan 2023 22:06:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 20so19939506pfu.13;
        Tue, 17 Jan 2023 22:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+qpR2MM6KIrediMBwRe+lRsg42bPXrIFANMIti0WTY=;
        b=AHn0AGChsQpTHgkbeZqtS/cfWyiMw8UpNXfgmWSmeJuU6tUlAz5UuaQC0cE49NcCo1
         ZYBSkvYlKwaHXdqqPYIUZsZPG2IlJv3VswZfphc1VgaCFXsV1LPfEnqmWCTm2ziAdA3Y
         4sfmgpSyPHYauwWQ7gvL8rpb58O8+SHmtaHa3FpViqNtZUtHcGw63UdKqlKPbSfLVyN5
         rKBeMf5KszGcAlfCZ50W++c2536cRsnZEtNxmmw50j/SBjC5yl7XOKcumoaJLnOYd1Eo
         TDhpv3/GTjIeoVizWwTTqo7iUiU92Lmid101ChaTqQMqdlla3u/B/ZGqmPnC9wKZklVb
         x7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+qpR2MM6KIrediMBwRe+lRsg42bPXrIFANMIti0WTY=;
        b=FElfg+x+YPg4WJVlI+j1i0HFsJJ6p46bKBewGeh6YpIxYeO+dT9d1B4rWcnlp2Z6iU
         y2Z/g9xBjrrPxZAXsyCoaZ1WPa3j2RTBDcLnyavnHjRU8DqeQoS/kaUo/yc8xk/lU/gA
         XiAg14pdYqL+XYP729McTAyh2BicbRj6FIYT0u8kb+6HAInbKzVRvlWdBve5ej0CRwOu
         r3HUWmTOrmkX3UABKoaIbZn6x/s/FmreD10q53j3/jbCOHho+HSDcNaQ2Z7EEmkwWUPl
         ZojtmpDWKoTXEivuDVzJOgx9BZFuuK/l792hVCUlu5G9vbYps9MPdfpxuEG3MjJPosKM
         QmSA==
X-Gm-Message-State: AFqh2krXi6ggRNg61zHZbgPBWT18jlDmXB8CsFfRABKVp3szwJew280S
        jQHHORjaB4Jlieb81fCi5ec=
X-Google-Smtp-Source: AMrXdXumFYdIwy5aH9TRn1vyywoGG+/O0LEu1c8zfWb3kL8iq7J+KbpKD0sB/P+TDfhegMDVfWkaDg==
X-Received: by 2002:a05:6a00:4c0b:b0:58d:8d8f:cc3d with SMTP id ea11-20020a056a004c0b00b0058d8d8fcc3dmr6930488pfb.23.1674021967889;
        Tue, 17 Jan 2023 22:06:07 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:07 -0800 (PST)
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
Subject: [PATCH 5/8] perf/core: Set data->sample_flags in perf_prepare_sample()
Date:   Tue, 17 Jan 2023 22:05:56 -0800
Message-Id: <20230118060559.615653-6-namhyung@kernel.org>
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

The perf_prepare_sample() sets the perf_sample_data according to the
attr->sample_type before copying it to the ring buffer.  But BPF also
wants to access the sample data so it needs to prepare the sample even
before the regular path.

That means the perf_prepare_sample() can be called more than once.  Set
the data->sample_flags consistently so that it can indicate which fields
are set already and skip them if sets.

Also update the filtered_sample_type to have the dependent flags to
reduce the number of branches.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 85 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0218b6ffaf36..1384137a90f7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7053,12 +7053,21 @@ static void perf_aux_sample_output(struct perf_event *event,
 	ring_buffer_put(rb);
 }
 
+/*
+ * A set of common sample data types saved even for non-sample records
+ * when event->attr.sample_id_all is set.
+ */
+#define PERF_SAMPLE_ID_ALL  (PERF_SAMPLE_TID | PERF_SAMPLE_TIME |	\
+			     PERF_SAMPLE_ID | PERF_SAMPLE_STREAM_ID |	\
+			     PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
+
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
 					 struct perf_event *event,
 					 u64 sample_type)
 {
 	data->type = event->attr.sample_type;
+	data->sample_flags |= data->type & PERF_SAMPLE_ID_ALL;
 	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
@@ -7561,6 +7570,11 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	return callchain ?: &__empty_callchain;
 }
 
+static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
+{
+	return d * !!(flags & s);
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
@@ -7576,14 +7590,24 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc |= perf_misc_flags(regs);
 
 	/*
-	 * Clear the sample flags that have already been done by the
-	 * PMU driver.
+	 * Add the sample flags that are dependent to others.  And clear the
+	 * sample flags that have already been done by the PMU driver.
 	 */
-	filtered_sample_type = sample_type & ~data->sample_flags;
+	filtered_sample_type = sample_type;
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_CODE_PAGE_SIZE,
+					   PERF_SAMPLE_IP);
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_DATA_PAGE_SIZE |
+					   PERF_SAMPLE_PHYS_ADDR, PERF_SAMPLE_ADDR);
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_STACK_USER,
+					   PERF_SAMPLE_REGS_USER);
+	filtered_sample_type &= ~data->sample_flags;
+
 	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
-	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
+	if (filtered_sample_type & PERF_SAMPLE_IP) {
 		data->ip = perf_instruction_pointer(regs);
+		data->sample_flags |= PERF_SAMPLE_IP;
+	}
 
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
@@ -7600,10 +7624,15 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
+	if (filtered_sample_type & PERF_SAMPLE_REGS_USER)
 		perf_sample_regs_user(&data->regs_user, regs);
 
-	if (sample_type & PERF_SAMPLE_REGS_USER) {
+	/*
+	 * It cannot use the filtered_sample_type here as REGS_USER can be set
+	 * by STACK_USER (using __cond_set() above) and we don't want to update
+	 * the dyn_size if it's not requested by users.
+	 */
+	if ((sample_type & ~data->sample_flags) & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
@@ -7613,9 +7642,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		}
 
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
-	if (sample_type & PERF_SAMPLE_STACK_USER) {
+	if (filtered_sample_type & PERF_SAMPLE_STACK_USER) {
 		/*
 		 * Either we need PERF_SAMPLE_STACK_USER bit to be always
 		 * processed as the last one or have additional check added
@@ -7638,23 +7668,30 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		data->stack_user_size = stack_size;
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_STACK_USER;
 	}
 
-	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		data->weight.full = 0;
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 
-	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
+	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC) {
 		data->data_src.val = PERF_MEM_NA;
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
 
-	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION)
+	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION) {
 		data->txn = 0;
+		data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+	}
 
-	if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		if (filtered_sample_type & PERF_SAMPLE_ADDR)
-			data->addr = 0;
+	if (filtered_sample_type & PERF_SAMPLE_ADDR) {
+		data->addr = 0;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
 	}
 
-	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+	if (filtered_sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
@@ -7667,19 +7704,22 @@ void perf_prepare_sample(struct perf_event_header *header,
 		}
 
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
 
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
-	    filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
+	if (filtered_sample_type & PERF_SAMPLE_PHYS_ADDR) {
 		data->phys_addr = perf_virt_to_phys(data->addr);
+		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
+	}
 
 #ifdef CONFIG_CGROUP_PERF
-	if (sample_type & PERF_SAMPLE_CGROUP) {
+	if (filtered_sample_type & PERF_SAMPLE_CGROUP) {
 		struct cgroup *cgrp;
 
 		/* protected by RCU */
 		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
 		data->cgroup = cgroup_id(cgrp);
+		data->sample_flags |= PERF_SAMPLE_CGROUP;
 	}
 #endif
 
@@ -7688,13 +7728,17 @@ void perf_prepare_sample(struct perf_event_header *header,
 	 * require PERF_SAMPLE_ADDR, kernel implicitly retrieve the data->addr,
 	 * but the value will not dump to the userspace.
 	 */
-	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+	if (filtered_sample_type & PERF_SAMPLE_DATA_PAGE_SIZE) {
 		data->data_page_size = perf_get_page_size(data->addr);
+		data->sample_flags |= PERF_SAMPLE_DATA_PAGE_SIZE;
+	}
 
-	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+	if (filtered_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
 		data->code_page_size = perf_get_page_size(data->ip);
+		data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
+	}
 
-	if (sample_type & PERF_SAMPLE_AUX) {
+	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
 		header->size += sizeof(u64); /* size */
@@ -7712,6 +7756,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		data->dyn_size += size + sizeof(u64); /* size above */
+		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
 
 	header->size += data->dyn_size;
-- 
2.39.0.314.g84b9a713c41-goog

