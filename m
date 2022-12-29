Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5ED6591B4
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiL2UoC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 15:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiL2Unf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 15:43:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF6E17E3F;
        Thu, 29 Dec 2022 12:41:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n4so20000275plp.1;
        Thu, 29 Dec 2022 12:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmwkCEHetXBe+z8HVKhwpOa0Sm3E12lwSvVQJBdivlE=;
        b=DWmE/DvUb0iixZ+Th3zuF8bwmY9akzqdB/4FdduhAVq4NwGLoBzxEhfqob9cupg1JW
         p3wZ4OHU0jop3IyMcTNbdKJ2yqbJp0f2FCyJe/EruYMtQbbukFEsjP3UDv5Z1HAVwOax
         9ISc8TQoeHCEPx1s5X8Ojhw3HeGRgcUKqMbyx7NVj7481fWt3KXWVE3WpUuTFJOY+vds
         gB7La4TBvquno1QnEsDhak45zE0pshfAYKzVgq0lempVxsG6uVPS8Bx1KR9szIgCc35w
         zyD3/inqYKNnr6ReMNbMX4LWGnwgNBiv3Lpqm1Lx2JFDBwBFDEnQ3VBcyReDs3aZfXXF
         hrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmwkCEHetXBe+z8HVKhwpOa0Sm3E12lwSvVQJBdivlE=;
        b=UgL4m3g+fQ5jBWz16y7E45U/dMZakgVZVY5bt840vBhhLcIHeSSpX86CqzF1i2SZQp
         Y17H7MCoW1aYtSHwkKlOlfiXI40Ktw9sxWCWg2ZkYqXSwshJQIHZr3KNEzn9ww69QfIc
         OboJVagagbvzqRKB525FXW0trIMQx9gYp6qywoC2b33HPQiwqy9K9nJx+uWDqXttBarS
         uS0pn99+s6juEKeOm+iZrCqHWpT3FCnNbfrB4O1FqvhJDxK9ltYsKGT8Ra9EgCbmQNVJ
         I5fsjpP9UqI5iYPzO7THe3ZkTZwPOnSU2VGj0zQpWLELeGfgMKJtxolU9S/5lsVi2qST
         Q8qg==
X-Gm-Message-State: AFqh2kohiuOQPJ9jXNymtMxEFmkHRwTnpb5EovWTP/J4o7/SOfFln/sU
        a7Z6W1LnyUxOD6WqtOfs/+hhqv1izL2iYQ==
X-Google-Smtp-Source: AMrXdXsQ+NzRgHrMa6ZvQpt/dV6ntrSNImWz2vMyTxIHEW4gFaXt4g5lE3lKDtLr0mMf0igr0gynaQ==
X-Received: by 2002:a17:902:8302:b0:192:73c9:11bd with SMTP id bd2-20020a170902830200b0019273c911bdmr14247538plb.23.1672346465287;
        Thu, 29 Dec 2022 12:41:05 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:d74d:9c28:5a9d:f5b9])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b001754fa42065sm13413824plh.143.2022.12.29.12.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:41:04 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: [PATCH 2/3] perf/core: Set data->sample_flags in perf_prepare_sample()
Date:   Thu, 29 Dec 2022 12:41:00 -0800
Message-Id: <20221229204101.1099430-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229204101.1099430-1-namhyung@kernel.org>
References: <20221229204101.1099430-1-namhyung@kernel.org>
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

The perf_prepare_sample() sets the perf_sample_data according to the
attr->sample_type before copying it to the ring buffer.  But BPF also
wants to access the sample data so it needs to prepare the sample even
before the regular path.

That means the perf_prepare_sample() can be called more than once.  Set
the data->sample_flags consistently so that it can indicate which fields
are set already and skip them if sets.

Mostly it's just a matter of checking filtered_sample_type which is a
bitmask for unset bits in the attr->sample_type.  But some of sample
data is implied by others even if it's not in the attr->sample_type
(like PERF_SAMPLE_ADDR for PERF_SAMPLE_PHYS_ADDR).  So they need to
check data->sample_flags separately.

Also some of them like callchain, user regs/stack and aux data require
more calculations.  Protect them using the data->sample_flags to avoid
the duplicate work.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Maybe we don't need this change to prevent duplication in favor of the
next patch using the data->saved_size.  But I think it's still useful
to set data->sample_flags consistently.  Anyway it's up to you.

 kernel/events/core.c | 86 ++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc3702654d..70bff8a04583 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7582,14 +7582,21 @@ void perf_prepare_sample(struct perf_event_header *header,
 	filtered_sample_type = sample_type & ~data->sample_flags;
 	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
-	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
-		data->ip = perf_instruction_pointer(regs);
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
+		/* attr.sample_type may not have PERF_SAMPLE_IP */
+		if (!(data->sample_flags & PERF_SAMPLE_IP)) {
+			data->ip = perf_instruction_pointer(regs);
+			data->sample_flags |= PERF_SAMPLE_IP;
+		}
+	}
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
+		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
 			data->callchain = perf_callchain(event, regs);
+			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+		}
 
 		size += data->callchain->nr;
 
@@ -7634,8 +7641,13 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
-		perf_sample_regs_user(&data->regs_user, regs);
+	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER)) {
+		/* attr.sample_type may not have PERF_SAMPLE_REGS_USER */
+		if (!(data->sample_flags & PERF_SAMPLE_REGS_USER)) {
+			perf_sample_regs_user(&data->regs_user, regs);
+			data->sample_flags |= PERF_SAMPLE_REGS_USER;
+		}
+	}
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
@@ -7656,11 +7668,18 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * in case new sample type is added, because we could eat
 		 * up the rest of the sample size.
 		 */
-		u16 stack_size = event->attr.sample_stack_user;
 		u16 size = sizeof(u64);
+		u16 stack_size;
+
+		if (filtered_sample_type & PERF_SAMPLE_STACK_USER) {
+			stack_size = event->attr.sample_stack_user;
+			stack_size = perf_sample_ustack_size(stack_size, header->size,
+							     data->regs_user.regs);
 
-		stack_size = perf_sample_ustack_size(stack_size, header->size,
-						     data->regs_user.regs);
+			data->stack_user_size = stack_size;
+			data->sample_flags |= PERF_SAMPLE_STACK_USER;
+		}
+		stack_size = data->stack_user_size;
 
 		/*
 		 * If there is something to dump, add space for the dump
@@ -7670,29 +7689,40 @@ void perf_prepare_sample(struct perf_event_header *header,
 		if (stack_size)
 			size += sizeof(u64) + stack_size;
 
-		data->stack_user_size = stack_size;
 		header->size += size;
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
 
 	if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		if (filtered_sample_type & PERF_SAMPLE_ADDR)
+		/* attr.sample_type may not have PERF_SAMPLE_ADDR */
+		if (!(data->sample_flags & PERF_SAMPLE_ADDR)) {
 			data->addr = 0;
+			data->sample_flags |= PERF_SAMPLE_ADDR;
+		}
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		if (filtered_sample_type & PERF_SAMPLE_REGS_INTR) {
+			perf_sample_regs_intr(&data->regs_intr, regs);
+			data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+		}
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
@@ -7703,17 +7733,19 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
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
 
@@ -7722,11 +7754,15 @@ void perf_prepare_sample(struct perf_event_header *header,
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
 
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
@@ -7739,10 +7775,14 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * Make sure this doesn't happen by using up to U16_MAX bytes
 		 * per sample in total (rounded down to 8 byte boundary).
 		 */
-		size = min_t(size_t, U16_MAX - header->size,
-			     event->attr.aux_sample_size);
-		size = rounddown(size, 8);
-		size = perf_prepare_sample_aux(event, data, size);
+		if (filtered_sample_type & PERF_SAMPLE_AUX) {
+			size = min_t(size_t, U16_MAX - header->size,
+				     event->attr.aux_sample_size);
+			size = rounddown(size, 8);
+			perf_prepare_sample_aux(event, data, size);
+			data->sample_flags |= PERF_SAMPLE_AUX;
+		}
+		size = data->aux_size;
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		header->size += size;
-- 
2.39.0.314.g84b9a713c41-goog

