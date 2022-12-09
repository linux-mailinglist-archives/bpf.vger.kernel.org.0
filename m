Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B96488D1
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLITHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiLITHe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 14:07:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101F269;
        Fri,  9 Dec 2022 11:07:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt4so4080691pjb.1;
        Fri, 09 Dec 2022 11:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aIrSZH4sRTZgzrgB2QgBuSdHXwS+g9LIfT5ra6cPpo=;
        b=dXe8IdfvQ+WkhgsDLHpK9Cf5WKvXRnGBRR7pXw9a5+4bMTBnPKDMbh1G9Cu1yIb2h0
         R/4dfG3wqUM8tNQ3TyxGGPGR9oG/b9OGGXXH76vh/QODEiGyYMAlzNxVTejXPwo9JMAQ
         ouGk/kmcDLub+zvBHGQ9adOfc9hHXjiK6i1eYusEv+j9kWwfMj8DIPMgfaq8nNBKBdR2
         CqavnjMd+bIoXuuc8vK4OqGLqrnPLdaqaLixW3u02I+TKMazu/oPnEvcyKqe+hN6SYHu
         N82NbB+41U8MCk5GvQ4G82S5Rn9r7Jlf5M94HhGkxdg5bOQPIAIdx8qDJWjblx84ZYTV
         w1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+aIrSZH4sRTZgzrgB2QgBuSdHXwS+g9LIfT5ra6cPpo=;
        b=4wjvcGle6MWBAQLsJZEYqFEGYjWMVzgJBQlQErSsfyQtkRmw+g2NKkR4+pDY9ts1U3
         A1yRL1i2LiXF7Hzr81JB9NQeOp6ayuI330trZCo42hybG1w3U0tFuplusAud0KCcrI2C
         xSx3M/DNUoUyRiL3eOdTuCwCAUfbmMvzfQOswrgEQK+S6qIQDclHmdejlTODBFrdBawr
         0pKbUf9gLxMK0eRLXYElmmpydn3eelUjvByDqKdEI5xNYmat200f7AFGydGoPfazeqna
         Z8REdmO22pPasqvxCvTXW6OfnsapWqFmEH5PGoX93JFyvxAHCmu8mtgMWNhoiYymEKtA
         h+cA==
X-Gm-Message-State: ANoB5ploj0zO4jThF/Klc33Tj0sKKAzq1j+v2IpqjjPC2YV3sYKwlE6b
        NZtMM2UI3Srn5e0pOSWTZ/k=
X-Google-Smtp-Source: AA0mqf452IZZuqO+6BdXUcXpbSb7XvVI7Feo29T4TiuAtd1nvcY9yrpXmupI0HRWs4Wrtfb1tIXuDg==
X-Received: by 2002:a17:90a:7646:b0:219:756b:ec1e with SMTP id s6-20020a17090a764600b00219756bec1emr6813537pjl.28.1670612851956;
        Fri, 09 Dec 2022 11:07:31 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:c952:d848:9e00:3cce])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm1431432pjb.32.2022.12.09.11.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:07:31 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: [PATCH 1/4] perf lock contention: Add lock_data.h for common data
Date:   Fri,  9 Dec 2022 11:07:24 -0800
Message-Id: <20221209190727.759804-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209190727.759804-1-namhyung@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
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

Accessing BPF maps should use the same data types.  Add bpf_skel/lock_data.h
to define the common data structures.  No functional changes.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c         | 19 ++++--------
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 17 ++---------
 tools/perf/util/bpf_skel/lock_data.h          | 30 +++++++++++++++++++
 3 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/lock_data.h

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index f4ebb9a2e380..b6a8eb7164b3 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -12,17 +12,10 @@
 #include <bpf/bpf.h>
 
 #include "bpf_skel/lock_contention.skel.h"
+#include "bpf_skel/lock_data.h"
 
 static struct lock_contention_bpf *skel;
 
-struct lock_contention_data {
-	u64 total_time;
-	u64 min_time;
-	u64 max_time;
-	u32 count;
-	u32 flags;
-};
-
 int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
@@ -110,8 +103,8 @@ int lock_contention_stop(void)
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack, err = 0;
-	s32 prev_key, key;
-	struct lock_contention_data data = {};
+	struct contention_key *prev_key, key;
+	struct contention_data data = {};
 	struct lock_stat *st = NULL;
 	struct machine *machine = con->machine;
 	u64 *stack_trace;
@@ -126,8 +119,8 @@ int lock_contention_read(struct lock_contention *con)
 	if (stack_trace == NULL)
 		return -1;
 
-	prev_key = 0;
-	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
+	prev_key = NULL;
+	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
 		struct map *kmap;
 		struct symbol *sym;
 		int idx = 0;
@@ -184,7 +177,7 @@ int lock_contention_read(struct lock_contention *con)
 		}
 
 		hlist_add_head(&st->hash_entry, con->result);
-		prev_key = key;
+		prev_key = &key;
 
 		/* we're fine now, reset the values */
 		st = NULL;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 9681cb59b0df..0f63cc28ccba 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -5,24 +5,11 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-/* maximum stack trace depth */
-#define MAX_STACKS   8
+#include "lock_data.h"
 
 /* default buffer size */
 #define MAX_ENTRIES  10240
 
-struct contention_key {
-	__s32 stack_id;
-};
-
-struct contention_data {
-	__u64 total_time;
-	__u64 min_time;
-	__u64 max_time;
-	__u32 count;
-	__u32 flags;
-};
-
 struct tstamp_data {
 	__u64 timestamp;
 	__u64 lock;
@@ -34,7 +21,7 @@ struct tstamp_data {
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
 	__uint(key_size, sizeof(__u32));
-	__uint(value_size, MAX_STACKS * sizeof(__u64));
+	__uint(value_size, sizeof(__u64));
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
new file mode 100644
index 000000000000..dbdf4caedc4a
--- /dev/null
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Data structures shared between BPF and tools. */
+#ifndef UTIL_BPF_SKEL_LOCK_DATA_H
+#define UTIL_BPF_SKEL_LOCK_DATA_H
+
+struct contention_key {
+	s32 stack_or_task_id;
+};
+
+#define TASK_COMM_LEN  16
+
+struct contention_task_data {
+	char comm[TASK_COMM_LEN];
+};
+
+struct contention_data {
+	u64 total_time;
+	u64 min_time;
+	u64 max_time;
+	u32 count;
+	u32 flags;
+};
+
+enum lock_aggr_mode {
+	LOCK_AGGR_ADDR = 0,
+	LOCK_AGGR_TASK,
+	LOCK_AGGR_CALLER,
+};
+
+#endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
-- 
2.39.0.rc1.256.g54fd8350bd-goog

