Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6E695815
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjBNFFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjBNFFC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:05:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7155FCC;
        Mon, 13 Feb 2023 21:05:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h4so8030391pll.9;
        Mon, 13 Feb 2023 21:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2b01AK+kYNw/IVOT6UQhHqJHrExhR6VVuUopSv4L/o=;
        b=fHezmiFS3dZ5YIFlugabnaXfHF/ZgMHGk1IigC9SPz+tu4ePFnemEwO0jDKFBrHewT
         WaMoF6Ir5y7lZdctVKlo1X2PC+eC203B3wvm0U+xC/bbVxRahBwWfINpildV7pz39FZm
         ot0/fJwRtd+zOKn+PLiZerf6Gfm2fy3h9/lo3Z5WyiA7JmFNWxvGNg7t6V6/W1LAK404
         3TtoI/PWvUvgwtX5QEdnuNIDEPEVNiNxMsMi0khUlFZh0CAmy2T7pBmOPqbKAI0I2dNu
         POS0JNSVyboaTECIrqnIXZxw6WGRbScJmGNqkGwGTpySrDdu2aSHIldrAyXMbvVTmnnm
         939w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2b01AK+kYNw/IVOT6UQhHqJHrExhR6VVuUopSv4L/o=;
        b=aU8sO7Eg+A2zUwRcdcPmMA39KQltSucN6ulNjvDuPt2qNp1Mg80Q5EX8bgTag7ZZap
         vkDd5wVbjkfE6aKdCh51VGP+XMDcUbGjRNyXi57qmdxZlGcR9QQ72gAUEB65EB8z10H5
         oZo/v1e1AFtLoQhK9YezCE7zUR98RlexvicEuJiIwI4LXRL2kodhOTigq0630QiqEof3
         2zv4DrUYFcif4XA9VIlsgfBWjAm9x5WyiWsINQ3E8L6fStW8n4MoWLSniI78VplWPXLg
         xjQy18vaIAf4lsMXagoGWnCin0K+YTxttwory/iBxTUg5jA/NRou1o83a8ogY7mbxNQb
         vJVA==
X-Gm-Message-State: AO0yUKV423KXQwZw4Yxf9+RsN4DLonPLiIKGCXIEcZj5ggy/zn5QV/zd
        tLAprSyhpmHrUeo7fgRbWkQ=
X-Google-Smtp-Source: AK7set81ZVQssRe1JJMkTG0mgEVIZuPvkK8hWwDtkDZmlsxsuISAozoCmP/gbVW87f6W0hfrxMNoDA==
X-Received: by 2002:a17:902:d50e:b0:199:33ff:918a with SMTP id b14-20020a170902d50e00b0019933ff918amr1730878plg.21.1676351100502;
        Mon, 13 Feb 2023 21:05:00 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:de3c:c4c2:3f15:764d])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902761200b001932a9e4f2csm9045593pll.255.2023.02.13.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:05:00 -0800 (PST)
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
Subject: [PATCH 3/7] perf record: Add BPF event filter support
Date:   Mon, 13 Feb 2023 21:04:48 -0800
Message-Id: <20230214050452.26390-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230214050452.26390-1-namhyung@kernel.org>
References: <20230214050452.26390-1-namhyung@kernel.org>
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

Use --filter option to set BPF filter for any events.  The filter string
must start with 'bpf:' prefix.  Then the BPF program will check the sample
data and filter according to the expression.

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

$ sudo ./perf record -e cycles --filter 'bpf: period > 1000' true
$ sudo ./perf script
       perf-exec 2273949 546850.708501:       5029 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
       perf-exec 2273949 546850.708508:      32409 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
       perf-exec 2273949 546850.708526:     143369 cycles:  ffffffff82b4cdbf xas_start+0x5f ([kernel.kallsyms])
       perf-exec 2273949 546850.708600:     372650 cycles:  ffffffff8286b8f7 __pagevec_lru_add+0x117 ([kernel.kallsyms])
       perf-exec 2273949 546850.708791:     482953 cycles:  ffffffff829190de __mod_memcg_lruvec_state+0x4e ([kernel.kallsyms])
            true 2273949 546850.709036:     501985 cycles:  ffffffff828add7c tlb_gather_mmu+0x4c ([kernel.kallsyms])
            true 2273949 546850.709292:     503065 cycles:      7f2446d97c03 _dl_map_object_deps+0x973 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 10 +++++++++-
 tools/perf/builtin-record.c              |  9 +++++++++
 tools/perf/util/bpf_counter.c            |  3 +--
 tools/perf/util/evsel.c                  |  2 ++
 tools/perf/util/parse-events.c           |  4 ++++
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ff815c2f67e8..7c6bb3be842a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -121,7 +121,9 @@ OPTIONS
 --filter=<filter>::
         Event filter. This option should follow an event selector (-e) which
 	selects either tracepoint event(s) or a hardware trace PMU
-	(e.g. Intel PT or CoreSight).
+	(e.g. Intel PT or CoreSight).  If the filter string starts with 'bpf:'
+	it means a general filter using BPF which can be applied for any kind
+	of events.
 
 	- tracepoint filters
 
@@ -174,6 +176,12 @@ OPTIONS
 	within a single mapping.  MMAP events (or /proc/<pid>/maps) can be
 	examined to determine if that is a possibility.
 
+	- bpf filters
+
+	BPF filter can access the sample data and make a decision based on the
+	data.  Users need to set the appropriate sample type to use the BPF
+	filter.
+
 	Multiple filters can be separated with space or comma.
 
 --exclude-perf::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 29dcd454b8e2..c81047a78f3e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -52,6 +52,7 @@
 #include "util/pmu-hybrid.h"
 #include "util/evlist-hybrid.h"
 #include "util/off_cpu.h"
+#include "util/bpf-filter.h"
 #include "asm/bug.h"
 #include "perf.h"
 #include "cputopo.h"
@@ -1368,6 +1369,14 @@ static int record__open(struct record *rec)
 
 	session->evlist = evlist;
 	perf_session__set_id_hdr_size(session);
+
+	evlist__for_each_entry(evlist, pos) {
+		if (list_empty(&pos->bpf_filters))
+			continue;
+		rc = perf_bpf_filter__prepare(pos);
+		if (rc)
+			break;
+	}
 out:
 	return rc;
 }
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index eeee899fcf34..0414385794ee 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -781,8 +781,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
 
 static inline bool bpf_counter_skip(struct evsel *evsel)
 {
-	return list_empty(&evsel->bpf_counter_list) &&
-		evsel->follower_skel == NULL;
+	return evsel->bpf_counter_ops == NULL;
 }
 
 int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 51e8ce6edddc..cae624fde026 100644
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
@@ -1494,6 +1495,7 @@ void evsel__exit(struct evsel *evsel)
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	bpf_counter__destroy(evsel);
+	perf_bpf_filter__destroy(evsel);
 	evsel__free_counts(evsel);
 	perf_evsel__free_fd(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0336ff27c15f..33f654be6fcc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -27,6 +27,7 @@
 #include "perf.h"
 #include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
+#include "util/bpf-filter.h"
 #include "tracepoint.h"
 #include "thread_map.h"
 
@@ -2517,6 +2518,9 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
+	if (!strncmp(str, "bpf:", 4))
+		return perf_bpf_filter__parse(&evsel->bpf_filters, str+4);
+
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
 		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
-- 
2.39.1.581.gbfd45094c4-goog

