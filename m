Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50BB67144A
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjARGeL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjARGZy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:25:54 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C12552A8;
        Tue, 17 Jan 2023 22:14:27 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4d13cb4bbffso334309407b3.3;
        Tue, 17 Jan 2023 22:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYsRe09JkVPoqaZ4OGb+wtxVDI81dN8UGiocCLjkwaM=;
        b=UuNDWiWkCSC/tViFrw0EsvSVoiLmSFAmRZo8dL5cwLjHZKK1sSbLL+i18W7mW+xrAL
         nG09hM7nqHgkx6Jq7ZZxm7yXP33VUPXFenmn2XAwb7HkbRw4eif9G4eUFegzbaAF9B9d
         NwNw/ApRjUGIaPsKBeFyWciTBzceR1RJLNBM9aTGg8bPMp1prUrh8KL0xXqq8bBek9ZL
         om9Lku+XchTVTXd+FhRDQFKgA3U8aZoPK8ZNosZwInKuwawoD4ODga8s8Kp+rRADfLv5
         Hx/NyyN4nrarPQ5TzGrTT6cMZ4sq3GJDRR1xvp1J0QoFaX5coQaVk/be9EFaoc6/2oSO
         qKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYsRe09JkVPoqaZ4OGb+wtxVDI81dN8UGiocCLjkwaM=;
        b=ZsFQJhTxP5m76XA+EFZKK1OcjR5G/MV4qaVQk9l4IhQi0Wj8kJNJdU8tPHjBnvsuYT
         CP0iTQIChrpOgM3ReYXWTLQyo529ZveJL2LWOKKUV5cSIGCYE1a45Wmb/nybj9f6EofA
         2QJy2RJ8gZbMGcbUhxXNbGajy5iXoKpS6JNcL9OlJhjaJ12O9l9DE6C5MihXxmKQhCn8
         p8t9uX3v7Gh/0KTPMURk17pPoN6LpK2/H/Iw84BWwTOawY+ZeurOVJr/+n1xlo/CW1Rr
         A04LceZw6xJ5NFhvZ7tu9zEZX0BibqX6FqNPcJ6YUeBh6UkmP/yveWtwzgFhFn6M4hZd
         A0aA==
X-Gm-Message-State: AFqh2kpF40HMfYGz0iAYvfsSzAFF7/D6utcecxv00k+IdUc9muuINm3o
        t5zZVKxj/16tn1PRjQ+NzvGvH+5/xDc=
X-Google-Smtp-Source: AMrXdXss8e7nXUP+ZjM15x2GJzrqRSg8fzFma/4f2iXac7vFD7UHXfk0fx65B1hl64TnA/Z4PeJgVw==
X-Received: by 2002:a62:ab0b:0:b0:58b:46c9:a6b1 with SMTP id p11-20020a62ab0b000000b0058b46c9a6b1mr6485937pff.33.1674021970712;
        Tue, 17 Jan 2023 22:06:10 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:10 -0800 (PST)
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
Subject: [PATCH 7/8] perf/core: Introduce perf_prepare_header()
Date:   Tue, 17 Jan 2023 22:05:58 -0800
Message-Id: <20230118060559.615653-8-namhyung@kernel.org>
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

Factor out perf_prepare_header() so that it can call
perf_prepare_sample() without a header if not needed.

Also it checks the filtered_sample_type to avoid duplicate
work when perf_prepare_sample() is called twice (or more).

Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Suggested-by: Peter Zijlstr <peterz@infradead.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c |  3 ++-
 arch/x86/events/intel/ds.c      |  3 ++-
 include/linux/perf_event.h      | 16 +++++++++++++-
 kernel/events/core.c            | 38 +++++++++++++++++++++------------
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..fd02f8423243 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -671,7 +671,8 @@ static void cpumsf_output_event_pid(struct perf_event *event,
 	/* Protect callchain buffers, tasks */
 	rcu_read_lock();
 
-	perf_prepare_sample(&header, data, event, regs);
+	perf_prepare_sample(data, event, regs);
+	perf_prepare_header(&header, data, event, regs);
 	if (perf_output_begin(&handle, data, event, header.size))
 		goto out;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 07c8a2cdc3ee..183efa914b99 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -807,7 +807,8 @@ int intel_pmu_drain_bts_buffer(void)
 	 * the sample.
 	 */
 	rcu_read_lock();
-	perf_prepare_sample(&header, &data, event, &regs);
+	perf_prepare_sample(&data, event, &regs);
+	perf_prepare_header(&header, &data, event, &regs);
 
 	if (perf_output_begin(&handle, &data, event,
 			      header.size * (top - base - skip)))
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7db0e9cc2682..d5628a7b5eaa 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1250,6 +1250,17 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline u32 perf_sample_data_size(struct perf_sample_data *data,
+					struct perf_event *event)
+{
+	u32 size = sizeof(struct perf_event_header);
+
+	size += event->header_size + event->id_header_size;
+	size += data->dyn_size;
+
+	return size;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1271,7 +1282,10 @@ extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
 			       struct perf_event *event);
-extern void perf_prepare_sample(struct perf_event_header *header,
+extern void perf_prepare_sample(struct perf_sample_data *data,
+				struct perf_event *event,
+				struct pt_regs *regs);
+extern void perf_prepare_header(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event,
 				struct pt_regs *regs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9cc55122188f..73c40ce84c48 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7575,20 +7575,13 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
 	return d * !!(flags & s);
 }
 
-void perf_prepare_sample(struct perf_event_header *header,
-			 struct perf_sample_data *data,
+void perf_prepare_sample(struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
 	u64 sample_type = event->attr.sample_type;
 	u64 filtered_sample_type;
 
-	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size + event->id_header_size;
-
-	header->misc = 0;
-	header->misc |= perf_misc_flags(regs);
-
 	/*
 	 * Add the sample flags that are dependent to others.  And clear the
 	 * sample flags that have already been done by the PMU driver.
@@ -7602,6 +7595,12 @@ void perf_prepare_sample(struct perf_event_header *header,
 					   PERF_SAMPLE_REGS_USER);
 	filtered_sample_type &= ~data->sample_flags;
 
+	if (filtered_sample_type == 0) {
+		/* Make sure it has the correct data->type for output */
+		data->type = event->attr.sample_type;
+		return;
+	}
+
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
@@ -7653,9 +7652,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * up the rest of the sample size.
 		 */
 		u16 stack_size = event->attr.sample_stack_user;
+		u16 header_size = perf_sample_data_size(data, event);
 		u16 size = sizeof(u64);
 
-		stack_size = perf_sample_ustack_size(stack_size, header->size,
+		stack_size = perf_sample_ustack_size(stack_size, header_size,
 						     data->regs_user.regs);
 
 		/*
@@ -7740,8 +7740,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
+		u16 header_size = perf_sample_data_size(data, event);
 
-		header->size += sizeof(u64); /* size */
+		header_size += sizeof(u64); /* size */
 
 		/*
 		 * Given the 16bit nature of header::size, an AUX sample can
@@ -7749,17 +7750,25 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * Make sure this doesn't happen by using up to U16_MAX bytes
 		 * per sample in total (rounded down to 8 byte boundary).
 		 */
-		size = min_t(size_t, U16_MAX - header->size,
+		size = min_t(size_t, U16_MAX - header_size,
 			     event->attr.aux_sample_size);
 		size = rounddown(size, 8);
 		size = perf_prepare_sample_aux(event, data, size);
 
-		WARN_ON_ONCE(size + header->size > U16_MAX);
+		WARN_ON_ONCE(size + header_size > U16_MAX);
 		data->dyn_size += size + sizeof(u64); /* size above */
 		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
+}
 
-	header->size += data->dyn_size;
+void perf_prepare_header(struct perf_event_header *header,
+			 struct perf_sample_data *data,
+			 struct perf_event *event,
+			 struct pt_regs *regs)
+{
+	header->type = PERF_RECORD_SAMPLE;
+	header->size = perf_sample_data_size(data, event);
+	header->misc = perf_misc_flags(regs);
 
 	/*
 	 * If you're adding more sample types here, you likely need to do
@@ -7788,7 +7797,8 @@ __perf_event_output(struct perf_event *event,
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
-	perf_prepare_sample(&header, data, event, regs);
+	perf_prepare_sample(data, event, regs);
+	perf_prepare_header(&header, data, event, regs);
 
 	err = output_begin(&handle, data, event, header.size);
 	if (err)
-- 
2.39.0.314.g84b9a713c41-goog

