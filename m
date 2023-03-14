Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1E6BA3A9
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCNXnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCNXmq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:42:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CAB3D0BD;
        Tue, 14 Mar 2023 16:42:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so83808pjg.4;
        Tue, 14 Mar 2023 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0iyfi/1hHleidl81oNqA/YSDrWcJGps480EcOB3sSs=;
        b=PnlRh1amO8g8O7V01qNUxPyH1FRY2eoPDzerbAsGNO9Q5qA3bdtHSf/IbZT+J9ytHQ
         Stp/WCskA4YFzv637/Xwf+oZrIdmHx4+uIXtQlyWxWQkMcvIK36FPuEnWQ8QuF04IRmu
         10jNDbZVR9ajhUOluiZITJ+C7PkzZJ9aDW7ZcFEH6B2jYMExPsa833JM9KIsT+InyfsM
         6ja7p5t9VL5iI5dWxVMWe1b3+RfH9sTyqPNDQq05SbjFP+yw29H6S4iGunv6Xgef9T5t
         cz0Ymc9+H4s2pLp15ObkVmx87MN2WuXwb4x9GRYsSGq36KisCrf/7OpgBh4P6AmY+mP3
         /phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0iyfi/1hHleidl81oNqA/YSDrWcJGps480EcOB3sSs=;
        b=PwL6ABv/uMzPMRIj/y4YPlkbl/2arAmI+Rvqi8cof6EgvgOgcd0EyJf8tArIlWL3EP
         /JXezF7AMJUg6OfS0RP6lWUHWPs3AxP2ubWjkYk9+chllOl/daIx9HUZQMw88q+DxUKL
         +v4vICNkMeKMOTKqpPfhj7zxSF7ftinEq1IrTeIO1+e0cWfBSSAlBRPR7xp1nqGLu4Hj
         gz4ZGvDAAbQrLW2mp9/ZJHu/l1jtBPh48BpPYtUJBk2ZED5IC/C/vWMC/s2NePcm5qOO
         qgeuRoyE2icLNNx6RroFfV38oBdJQssHvuA+KZoU/dfUYUESLwniLi6y8YMci4OBg25b
         sT8Q==
X-Gm-Message-State: AO0yUKU9vWtyAscoBqRyIkbzyx/i/3YLcfjkj47pHzkYCuOOxzHtd0rT
        V/UpaA6QIAOc6PZfbW1cU7eR/WV54NU=
X-Google-Smtp-Source: AK7set/zzJvnjzkPxj0no0CxlUOKOCsJAjxxSzdAQFw10i5O+WJk0gVujWQQZuqueL9lQXIJkNMoCQ==
X-Received: by 2002:a17:902:c60a:b0:19c:be09:20d5 with SMTP id r10-20020a170902c60a00b0019cbe0920d5mr608958plr.11.1678837363926;
        Tue, 14 Mar 2023 16:42:43 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 03/10] perf record: Add BPF event filter support
Date:   Tue, 14 Mar 2023 16:42:30 -0700
Message-Id: <20230314234237.3008956-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314234237.3008956-1-namhyung@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
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

Use --filter option to set BPF filter for generic events other than the
tracepoints or Intel PT.  The BPF program will check the sample data and
filter according to the expression.

For example, the below is the typical perf record for frequency mode.
The sample period started from 1 and increased gradually.

$ sudo ./perf record -e cycles true
$ sudo ./perf script
       perf-exec 2272336 546683.916875:          1 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916892:          1 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916899:          3 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916905:         17 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916911:        100 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916917:        589 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916924:       3470 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
       perf-exec 2272336 546683.916930:      20465 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
            true 2272336 546683.916940:     119873 cycles:  ffffffff8283afdd perf_iterate_ctx+0x2d ([kernel.kallsyms])
            true 2272336 546683.917003:     461349 cycles:  ffffffff82892517 vma_interval_tree_insert+0x37 ([kernel.kallsyms])
            true 2272336 546683.917237:     635778 cycles:  ffffffff82a11400 security_mmap_file+0x20 ([kernel.kallsyms])

When you add a BPF filter to get samples having periods greater than 1000,
the output would look like below:

$ sudo ./perf record -e cycles --filter 'period > 1000' true
$ sudo ./perf script
       perf-exec 2273949 546850.708501:       5029 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
       perf-exec 2273949 546850.708508:      32409 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
       perf-exec 2273949 546850.708526:     143369 cycles:  ffffffff82b4cdbf xas_start+0x5f ([kernel.kallsyms])
       perf-exec 2273949 546850.708600:     372650 cycles:  ffffffff8286b8f7 __pagevec_lru_add+0x117 ([kernel.kallsyms])
       perf-exec 2273949 546850.708791:     482953 cycles:  ffffffff829190de __mod_memcg_lruvec_state+0x4e ([kernel.kallsyms])
            true 2273949 546850.709036:     501985 cycles:  ffffffff828add7c tlb_gather_mmu+0x4c ([kernel.kallsyms])
            true 2273949 546850.709292:     503065 cycles:      7f2446d97c03 _dl_map_object_deps+0x973 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 15 +++++++++++---
 tools/perf/util/bpf_counter.c            |  3 +--
 tools/perf/util/evlist.c                 | 25 +++++++++++++++++-------
 tools/perf/util/evsel.c                  |  2 ++
 tools/perf/util/parse-events.c           |  8 +++-----
 5 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ff815c2f67e8..122f71726eaa 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -119,9 +119,12 @@ OPTIONS
 	  "perf report" to view group events together.
 
 --filter=<filter>::
-        Event filter. This option should follow an event selector (-e) which
-	selects either tracepoint event(s) or a hardware trace PMU
-	(e.g. Intel PT or CoreSight).
+	Event filter.  This option should follow an event selector (-e).
+	If the event is a tracepoint, the filter string will be parsed by
+	the kernel.  If the event is a hardware trace PMU (e.g. Intel PT
+	or CoreSight), it'll be processed as an address filter.  Otherwise
+	it means a general filter using BPF which can be applied for any
+	kind of event.
 
 	- tracepoint filters
 
@@ -176,6 +179,12 @@ OPTIONS
 
 	Multiple filters can be separated with space or comma.
 
+	- bpf filters
+
+	A BPF filter can access the sample data and make a decision based on the
+	data.  Users need to set an appropriate sample type to use the BPF
+	filter.
+
 --exclude-perf::
 	Don't record events issued by perf itself. This option should follow
 	an event selector (-e) which selects tracepoint event(s). It adds a
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index aa78a15a6f0a..1b77436e067e 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -763,8 +763,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
 
 static inline bool bpf_counter_skip(struct evsel *evsel)
 {
-	return list_empty(&evsel->bpf_counter_list) &&
-		evsel->follower_skel == NULL;
+	return evsel->bpf_counter_ops == NULL;
 }
 
 int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b74e12239aec..cc491a037836 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -31,6 +31,7 @@
 #include "util/evlist-hybrid.h"
 #include "util/pmu.h"
 #include "util/sample.h"
+#include "util/bpf-filter.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -1086,17 +1087,27 @@ int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->filter == NULL)
-			continue;
-
 		/*
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
-		if (err) {
-			*err_evsel = evsel;
-			break;
+		if (evsel->filter) {
+			err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
+			if (err) {
+				*err_evsel = evsel;
+				break;
+			}
+		}
+
+		/*
+		 * non-tracepoint events can have BPF filters.
+		 */
+		if (!list_empty(&evsel->bpf_filters)) {
+			err = perf_bpf_filter__prepare(evsel);
+			if (err) {
+				*err_evsel = evsel;
+				break;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a83d8cd5eb51..dc3faf005c3b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -50,6 +50,7 @@
 #include "off_cpu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
+#include "util/bpf-filter.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
@@ -1517,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	bpf_counter__destroy(evsel);
+	perf_bpf_filter__destroy(evsel);
 	evsel__free_counts(evsel);
 	perf_evsel__free_fd(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3b2e5bb3e852..6c5cf5244486 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "perf.h"
 #include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
+#include "util/bpf-filter.h"
 #include "tracepoint.h"
 #include "thread_map.h"
 
@@ -2542,11 +2543,8 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
 
-	if (!nr_addr_filters) {
-		fprintf(stderr,
-			"This CPU does not support address filtering\n");
-		return -1;
-	}
+	if (!nr_addr_filters)
+		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
 
 	if (evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
-- 
2.40.0.rc1.284.g88254d51c5-goog

