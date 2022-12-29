Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805326591B3
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiL2UoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 15:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiL2Unf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 15:43:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6218381;
        Thu, 29 Dec 2022 12:41:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so19905010pjh.5;
        Thu, 29 Dec 2022 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=giBOQ9TT79Q9Ar9UFHe+CfFhm/Y3dEEkbsA9TNwaa/I=;
        b=E+uyxeyPPYSvY01lhhcegEwzc9fU9oCG6NlW4KvnjJgXWBv2kwB2A+gGWUGZ9yy227
         bPt45bNkMa7ZKIGCPH07qOOAfC5Yd/x2NIsNLT+CwrQ+HGA0bxJ+cQ7D1/AaZ2rwyQBd
         Q6C7oIhVbymoUXzZdB7fqm/G7P6Dm6QZTf7v1xN7lF+TkNH5LqL/Afl8SEKqTFmvZNb+
         NOhKDi8twLJTvWOjQR0cG0CCEwLDgOK0cZqM4MZM0INshYm5wKgDgkB4ece3SLXx1gGR
         OMLpcrek/QlH2dj8wyFPKVunTOrtBibkFZ/k6FNK6X9QZKZVCER0uXQ3Qr+6wIrWHOiu
         5uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giBOQ9TT79Q9Ar9UFHe+CfFhm/Y3dEEkbsA9TNwaa/I=;
        b=Jpkf2bzxSlLkMc4OBE25q4rjq9/++YqHYtJIjXqMLP/8TLAr/J5tOoqUZYtbL+oY97
         Om47ukAu3+2FJCzDvI7kDA1F9dI2hEs1A+G6gsMpeK9MruQ9B+wajYCtFL4hmW/uZIPQ
         BikVD1688tx/Hsz5lz5n7j/Dti2hU3Toabw69C9Czqf/A3HOqixs+zWhQmqSI5R8eJF9
         qK9XVXZf1y7+joHLWoE//Dh5mrROi2MF0M8R0VIg6qja9s5mGfvzGb19NaQMoaT519kU
         v5M1CCx7kwwDW2bvufE9Rc/KBvkmlLp2inYDDIApct3lGpEtO0oxL/LxE4NWK1dRTS/y
         g2gg==
X-Gm-Message-State: AFqh2krrRtHTLni9JF3EsLEFvepPHzgji2DZyVbMAPKuwBxA0IGdqBPs
        +oySmepZWFmaviXqeQuXQlbzf/8TlIJVBQ==
X-Google-Smtp-Source: AMrXdXsASjKS0bhWV9+n4cxTGdfOHm2L7MEZwJtaWn6YFgT9qDB9bJDzGZiQk/vC2Xki7WWdphGAMA==
X-Received: by 2002:a17:903:32ca:b0:192:7847:b047 with SMTP id i10-20020a17090332ca00b001927847b047mr16600357plr.54.1672346463931;
        Thu, 29 Dec 2022 12:41:03 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:d74d:9c28:5a9d:f5b9])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b001754fa42065sm13413824plh.143.2022.12.29.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:41:03 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: [PATCH 1/3] perf/core: Change the layout of perf_sample_data
Date:   Thu, 29 Dec 2022 12:40:59 -0800
Message-Id: <20221229204101.1099430-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
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

The layout of perf_sample_data is designed to minimize cache-line
access.  The perf_sample_data_init() used to initialize a couple of
fields unconditionally so they were placed together at the head.

But it's changed now to set the fields according to the actual
sample_type flags.  The main user (the perf tools) sets the IP, TID,
TIME, PERIOD always.  Also group relevant fields like addr, phys_addr
and data_page_size.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c6a3bac76966..dd565306f479 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1098,47 +1098,51 @@ extern u64 perf_event_read_value(struct perf_event *event,
 
 struct perf_sample_data {
 	/*
-	 * Fields set by perf_sample_data_init(), group so as to
-	 * minimize the cachelines touched.
+	 * Fields set by perf_sample_data_init() unconditionally,
+	 * group so as to minimize the cachelines touched.
 	 */
 	u64				sample_flags;
 	u64				period;
 
 	/*
-	 * The other fields, optionally {set,used} by
-	 * perf_{prepare,output}_sample().
+	 * Fields commonly set by __perf_event_header__init_id(),
+	 * group so as to minimize the cachelines touched.
 	 */
-	struct perf_branch_stack	*br_stack;
-	union perf_sample_weight	weight;
-	union  perf_mem_data_src	data_src;
-	u64				txn;
-	u64				addr;
-	struct perf_raw_record		*raw;
-
 	u64				type;
-	u64				ip;
 	struct {
 		u32	pid;
 		u32	tid;
 	}				tid_entry;
 	u64				time;
 	u64				id;
-	u64				stream_id;
 	struct {
 		u32	cpu;
 		u32	reserved;
 	}				cpu_entry;
+
+	/*
+	 * The other fields, optionally {set,used} by
+	 * perf_{prepare,output}_sample().
+	 */
+	u64				ip;
 	struct perf_callchain_entry	*callchain;
-	u64				aux_size;
+	struct perf_raw_record		*raw;
+	struct perf_branch_stack	*br_stack;
+	union perf_sample_weight	weight;
+	union  perf_mem_data_src	data_src;
+	u64				txn;
 
 	struct perf_regs		regs_user;
 	struct perf_regs		regs_intr;
 	u64				stack_user_size;
 
-	u64				phys_addr;
+	u64				stream_id;
 	u64				cgroup;
+	u64				addr;
+	u64				phys_addr;
 	u64				data_page_size;
 	u64				code_page_size;
+	u64				aux_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
-- 
2.39.0.314.g84b9a713c41-goog

