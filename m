Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E196513AE
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiLSURo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiLSURl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD9D4B;
        Mon, 19 Dec 2022 12:17:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gt4so10265742pjb.1;
        Mon, 19 Dec 2022 12:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSBoXkTO9My+aXQVa73V9O3XAdMbkV24JOkMxSiJcY8=;
        b=ldw1Ubfb3TjOoV8lyocAD3ad70POYsiMVbiHAwjBkuOH+en9Ff+QJWE9C0z0rHdUtS
         rxj8pXSIgt810LRp8agyqRdfOrRmISRLFKkn8Gdwss1F+wxjhx8MCFOqEhJnO/SMriPE
         faKs7reTjqSH1TDRPmP45MfiCdvX8IeDDjWVKlsDu5B+g9Andgeu2gK04A0zTufBniTa
         HKXG26BYX0FbhxbWC82Y8UqFj8E+jyuFVktFK9CuMNC4T31fKCBtaH3F2ODEJYAYj7s9
         M6wgVUHUOPG9T4gwgtFEPC3bW7JsMAiR5j9e5wJqOGb8gQX/LCGbMRUmTWB+E793StJn
         Z/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cSBoXkTO9My+aXQVa73V9O3XAdMbkV24JOkMxSiJcY8=;
        b=48w/RqQNrJKwu5L/QdIJvt5afRxLZkWfY8MQmc1UTtrJ/9IjVxjJyGwch++giKGoHL
         w+V1QV4DA/ZEW+QTyOht648bjQvcK+bKB1IH7ULlwC9lGt9xxAD/v8QEZGFpHFbanddd
         flereDlVa9I9rabr6EgMy41XXI7JbejUpmERNbSsoM3ii2CAABvOk1SiNA/B0oi6iekI
         nLhXnhVmHLza22fk0HLp/l2iD1iCap/9M/YctxzSV4SKNMUejgoPZarBT1mVRuM+MnqN
         ONWV+foqainSOgXNABVx839ixG9TW8YroGUdURWmcI1cp69gT6+sut9Twe+Qg1CRITAk
         VXMQ==
X-Gm-Message-State: AFqh2kphrbNHq26qQnVmIcFXmRg9hmDyXS5CE0e/8ZCq2yfq89NzCOkX
        lUrWLqZ7oRcSl21TJLMgandOsFPkkpM=
X-Google-Smtp-Source: AMrXdXssdnN3A8dp+4at4lNkqCo6ZBKkRRyB4eNIrVaWlnhtXU8nQXWQOpDTF+3bg0oHij03Ht8v4w==
X-Received: by 2002:a17:90a:c7d3:b0:219:ba3d:7ee2 with SMTP id gf19-20020a17090ac7d300b00219ba3d7ee2mr11600054pjb.30.1671481060401;
        Mon, 19 Dec 2022 12:17:40 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:39 -0800 (PST)
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
Subject: [PATCH 3/6] perf lock contention: Support lock type filtering for BPF
Date:   Mon, 19 Dec 2022 12:17:29 -0800
Message-Id: <20221219201732.460111-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219201732.460111-1-namhyung@kernel.org>
References: <20221219201732.460111-1-namhyung@kernel.org>
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

Likewise, add type_filter BPF hash map and check it when user gave a
lock type filter.

  $ sudo ./perf lock con -ab -Y rwlock -- ./perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.203 [sec]
   contended   total wait     max wait     avg wait         type   caller

          15    156.19 us     19.45 us     10.41 us     rwlock:W   do_exit+0x36d
           1     11.12 us     11.12 us     11.12 us     rwlock:R   do_wait+0x8b
           1      5.09 us      5.09 us      5.09 us     rwlock:W   release_task+0x6e

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                     |  1 +
 tools/perf/util/bpf_lock_contention.c         | 15 ++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 21 +++++++++++++++++--
 tools/perf/util/lock-contention.h             |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 49b4add53204..e4e785d3b4ec 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1689,6 +1689,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.map_nr_entries = bpf_map_entries,
 		.max_stack = max_stack_depth,
 		.stack_skip = stack_skip,
+		.filters = &filters,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 8e1b791dc58f..b8590b82ad3d 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -20,7 +20,7 @@ static struct lock_contention_bpf *skel;
 int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
-	int ncpus = 1, ntasks = 1;
+	int ncpus = 1, ntasks = 1, ntypes = 1;
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 
@@ -46,9 +46,12 @@ int lock_contention_prepare(struct lock_contention *con)
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
 	if (target__has_task(target))
 		ntasks = perf_thread_map__nr(evlist->core.threads);
+	if (con->filters->nr_types)
+		ntypes = con->filters->nr_types;
 
 	bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
 	bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	bpf_map__set_max_entries(skel->maps.type_filter, ntypes);
 
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
@@ -90,6 +93,16 @@ int lock_contention_prepare(struct lock_contention *con)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	if (con->filters->nr_types) {
+		u8 val = 1;
+
+		skel->bss->has_type = 1;
+		fd = bpf_map__fd(skel->maps.type_filter);
+
+		for (i = 0; i < con->filters->nr_types; i++)
+			bpf_map_update_elem(fd, &con->filters->types[i], &val, BPF_ANY);
+	}
+
 	/* these don't work well if in the rodata section */
 	skel->bss->stack_skip = con->stack_skip;
 	skel->bss->aggr_mode = con->aggr_mode;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 11b0fc7ee53b..fb0128de7c00 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -62,10 +62,18 @@ struct {
 	__uint(max_entries, 1);
 } task_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} type_filter SEC(".maps");
+
 /* control flags */
 int enabled;
 int has_cpu;
 int has_task;
+int has_type;
 int stack_skip;
 
 /* determine the key of lock stat */
@@ -74,7 +82,7 @@ int aggr_mode;
 /* error stat */
 int lost;
 
-static inline int can_record(void)
+static inline int can_record(u64 *ctx)
 {
 	if (has_cpu) {
 		__u32 cpu = bpf_get_smp_processor_id();
@@ -94,6 +102,15 @@ static inline int can_record(void)
 			return 0;
 	}
 
+	if (has_type) {
+		__u8 *ok;
+		__u32 flags = (__u32)ctx[1];
+
+		ok = bpf_map_lookup_elem(&type_filter, &flags);
+		if (!ok)
+			return 0;
+	}
+
 	return 1;
 }
 
@@ -116,7 +133,7 @@ int contention_begin(u64 *ctx)
 	__u32 pid;
 	struct tstamp_data *pelem;
 
-	if (!enabled || !can_record())
+	if (!enabled || !can_record(ctx))
 		return 0;
 
 	pid = bpf_get_current_pid_tgid();
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index d5b75b222d8e..dc621386a16b 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -118,6 +118,7 @@ struct lock_contention {
 	struct target *target;
 	struct machine *machine;
 	struct hlist_head *result;
+	struct lock_filter *filters;
 	unsigned long map_nr_entries;
 	int lost;
 	int max_stack;
-- 
2.39.0.314.g84b9a713c41-goog

