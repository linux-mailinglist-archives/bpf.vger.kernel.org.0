Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3F6AFA71
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCGXdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCGXdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:33:23 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C24ECCA;
        Tue,  7 Mar 2023 15:33:20 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s18so8649066pgq.1;
        Tue, 07 Mar 2023 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678231999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiPCdS7YWLbLvqN+ql4t86Rs7fqQxGYeQIPy6W1tBaw=;
        b=gTP8xiKt7O/TOcN7c2AuJ2CaxZonWsTkMN399Oq8ErCb5+dGYtbI6auI4R6TiEondz
         A86R+TLxWMt7CYgwslMP50xyLHQv/fcjJe3AGtJT0vq4Z7gnu0U/62mj7FDQ6vGnO8vY
         eLk48WuB1l9Rg6C9v0Zl2ri4X+2Rm0GerlgsdRTRtA21TL7isQTDb8Pa+IE+jSsTnwwI
         OP3bc5BHIXhi4RQBFDnIAmtkRYf5DXHZ5GC50GXAqlwRQ1XDE58cvzhT8vurufYF3fYp
         5f5Vf+bxUAVLG7Y24gGNr60V8OiFMNHL/Y0QxtIMtcNF0sTY6yreqZ3SfnDDOvXYQI3I
         8jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiPCdS7YWLbLvqN+ql4t86Rs7fqQxGYeQIPy6W1tBaw=;
        b=QEZmu34EagLaF4qjwLSHuhiGCGA9bDq/TSpGCIusv28QL62YU5HiRPCWaQ2VaSl83F
         4a7BQxDy6n9TTrvPsOpV/i09aTGjj5tLu8F89ZycU13wg54ipfXFfV/Hsoc4QfNQjNUm
         ldSyluDN5cOlkLPaFEAYCmShZ7XJnAEDvP8wxUu8xu6nf2JP/kIShd1KA21BniFK7lio
         DCYZZQHAAWakhxLlMLXnjEIf6BNOxBVIpqCxqxgUWFPoZ+DlmS32JrAsrc43mjmQnKxs
         /QJKCqMjR+kRvHRpX5qwa5zFPO/5gKOKsA+yhLlYK8+o7Ma0OfmDFnHZqZXbjiPoRYN9
         mR4w==
X-Gm-Message-State: AO0yUKWwU+gyVlC+/JjLcRtsyUO/a9YwnuTykj46nuMm6xZuHSkoWBzr
        ilGu5XOcBlEFLQMiIW9wRDg=
X-Google-Smtp-Source: AK7set/j3aXuw30R0wzsqrDuf73erFHyMldCeOgBdA3BHON8T2Q/STYKrIgH6+CI41pnLFXugx/10w==
X-Received: by 2002:a62:1dd4:0:b0:5d6:138f:5596 with SMTP id d203-20020a621dd4000000b005d6138f5596mr16883881pfd.14.1678231999625;
        Tue, 07 Mar 2023 15:33:19 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:15e8:b801:cd55:a496])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b005da23d8cbffsm8342217pff.158.2023.03.07.15.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:33:18 -0800 (PST)
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
Subject: [PATCH 4/9] perf record: Record dropped sample count
Date:   Tue,  7 Mar 2023 15:33:04 -0800
Message-Id: <20230307233309.3546160-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230307233309.3546160-1-namhyung@kernel.org>
References: <20230307233309.3546160-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When it uses bpf filters, event might drop some samples.  It'd be nice
if it can report how many samples it lost.  As LOST_SAMPLES event can
carry the similar information, let's use it for bpf filters.

To indicate it's from BPF filters, add a new misc flag for that and
do not display cpu load warnings.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h |  2 ++
 tools/perf/builtin-record.c         | 38 ++++++++++++++++++-----------
 tools/perf/util/bpf-filter.c        |  7 ++++++
 tools/perf/util/bpf-filter.h        |  5 ++++
 tools/perf/util/session.c           |  3 ++-
 5 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ad47d7b31046..51b9338f4c11 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -70,6 +70,8 @@ struct perf_record_lost {
 	__u64			 lost;
 };
 
+#define PERF_RECORD_MISC_LOST_SAMPLES_BPF (1 << 15)
+
 struct perf_record_lost_samples {
 	struct perf_event_header header;
 	__u64			 lost;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..197e802a150b 100644
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
@@ -1856,24 +1857,16 @@ record__switch_output(struct record *rec, bool at_exit)
 	return fd;
 }
 
-static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
+static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 					struct perf_record_lost_samples *lost,
-					int cpu_idx, int thread_idx)
+					int cpu_idx, int thread_idx, u64 lost_count,
+					u16 misc_flag)
 {
-	struct perf_counts_values count;
 	struct perf_sample_id *sid;
 	struct perf_sample sample = {};
 	int id_hdr_size;
 
-	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
-		pr_err("read LOST count failed\n");
-		return;
-	}
-
-	if (count.lost == 0)
-		return;
-
-	lost->lost = count.lost;
+	lost->lost = lost_count;
 	if (evsel->core.ids) {
 		sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
 		sample.id = sid->id;
@@ -1882,6 +1875,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
 						       evsel->core.attr.sample_type, &sample);
 	lost->header.size = sizeof(*lost) + id_hdr_size;
+	lost->header.misc = misc_flag;
 	record__write(rec, NULL, lost, lost->header.size);
 }
 
@@ -1905,6 +1899,7 @@ static void record__read_lost_samples(struct record *rec)
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
+		u64 lost_count;
 
 		if (xy == NULL || evsel->core.fd == NULL)
 			continue;
@@ -1916,12 +1911,27 @@ static void record__read_lost_samples(struct record *rec)
 
 		for (int x = 0; x < xyarray__max_x(xy); x++) {
 			for (int y = 0; y < xyarray__max_y(xy); y++) {
-				__record__read_lost_samples(rec, evsel, lost, x, y);
+				struct perf_counts_values count;
+
+				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
+					pr_err("read LOST count failed\n");
+					goto out;
+				}
+
+				if (count.lost) {
+					__record__save_lost_samples(rec, evsel, lost,
+								    x, y, count.lost, 0);
+				}
 			}
 		}
+
+		lost_count = perf_bpf_filter__lost_count(evsel);
+		if (lost_count)
+			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
+						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
 	}
+out:
 	free(lost);
-
 }
 
 static volatile sig_atomic_t workload_exec_errno;
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index f20e1bc03778..7bd6f2e41513 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -69,6 +69,13 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 	return 0;
 }
 
+u64 perf_bpf_filter__lost_count(struct evsel *evsel)
+{
+	struct sample_filter_bpf *skel = evsel->bpf_skel;
+
+	return skel ? skel->bss->dropped : 0;
+}
+
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val)
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index eb8e1ac43cdf..f0c66764c6d0 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -22,6 +22,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
 int perf_bpf_filter__prepare(struct evsel *evsel);
 int perf_bpf_filter__destroy(struct evsel *evsel);
+u64 perf_bpf_filter__lost_count(struct evsel *evsel);
 
 #else /* !HAVE_BPF_SKEL */
 
@@ -38,5 +39,9 @@ static inline int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
 {
 	return -EOPNOTSUPP;
 }
+static inline u64 perf_bpf_filter__lost_count(struct evsel *evsel __maybe_unused)
+{
+	return 0;
+}
 #endif /* HAVE_BPF_SKEL*/
 #endif /* PERF_UTIL_BPF_FILTER_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 749d5b5c135b..7d8d057d1772 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1582,7 +1582,8 @@ static int machines__deliver_event(struct machines *machines,
 			evlist->stats.total_lost += event->lost.lost;
 		return tool->lost(tool, event, sample, machine);
 	case PERF_RECORD_LOST_SAMPLES:
-		if (tool->lost_samples == perf_event__process_lost_samples)
+		if (tool->lost_samples == perf_event__process_lost_samples &&
+		    !(event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF))
 			evlist->stats.total_lost_samples += event->lost_samples.lost;
 		return tool->lost_samples(tool, event, sample, machine);
 	case PERF_RECORD_READ:
-- 
2.40.0.rc1.284.g88254d51c5-goog

