Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA46BA3B6
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCNXoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCNXnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3983D900;
        Tue, 14 Mar 2023 16:42:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i5so18295490pla.2;
        Tue, 14 Mar 2023 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUFOE/ZuiUM3Ns/cxvGLc/qAYr4eK2YvuKfQk+NEO2I=;
        b=GXSiPZagxF/lmkk11W4iBnDUv2s/J10HagCprGYOdGNOb/xOsXPpryTs1N1tFujUJG
         IsbRzDP5ivzBksxwVzfi1ZPy25VQOyh+qGyWnKgi1BnVAk0Zd8iLwpYB9GirQmBm+zkF
         U2pVa0FYScZK9ZHEieK0ioaPbn1sAsaFqpB/leeGGi5Awy4Qc83Bzm+wyxAs6ldL983m
         qJat04N2t9my6xj7y5zv5NpMXLDx8mv2MwE4Ih8D37m/KHhhAMaBw+yBhI3fxamHq7vO
         qfIKJps6xyBRK0GJau+6AbUt9PoXpKnu31xCknwG31V8AvADI9xYU6ffKOMEbAWqN7ul
         L9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zUFOE/ZuiUM3Ns/cxvGLc/qAYr4eK2YvuKfQk+NEO2I=;
        b=dEDpDlkyN1wBgho97nEyU16j7ttBckZ8SmKXclIO2KqykK8sfXsCCQcTHn2jMhKgQj
         x0lpKcWdzwOAgM3Alx85Bjt6WrwlIamsbYWCze3vYTqmrem2h+o92Kkn4Uj4msoSyeG5
         n9z1QDgBLXy1gGIEEl7fy0lsDI0ZuZjsqRM2OFv3JXx+JMpa2Tc8ywkV1yLsK6qcOaaO
         NhrwTPz4OFn5bWs7xAIe79uX16ZHy0zN2+tnuGtz2B8BwyPizB30sfvXJ5SvBLYtWp0Q
         MY2VHrTqFecg9huC+M41pf8Ys/kzEKYdy7t4JNLp25S4dYvxOJLbFKgrcyUh2OCcMQg9
         JVbA==
X-Gm-Message-State: AO0yUKXXZRu5GlON5526JZlC1U/8YhGO9Ka9CXJ0IrV0JCx2PerzJbb8
        WsblKY1N0WXadIEHlLym19I=
X-Google-Smtp-Source: AK7set+O5Otba+9dsdXQPxK6ixmfhs94JDzfGvD0Iboa3LR2gf99jYpyHWcQkqaGDz8BVPh+Rsb8Nw==
X-Received: by 2002:a17:902:e54c:b0:1a0:428b:d8c5 with SMTP id n12-20020a170902e54c00b001a0428bd8c5mr616734plf.45.1678837365204;
        Tue, 14 Mar 2023 16:42:45 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:44 -0700 (PDT)
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
Subject: [PATCH 04/10] perf record: Record dropped sample count
Date:   Tue, 14 Mar 2023 16:42:31 -0700
Message-Id: <20230314234237.3008956-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314234237.3008956-1-namhyung@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
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
index 33ebe42b025e..6df8b823859d 100644
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
-		pr_debug("read LOST count failed\n");
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
+					pr_debug("read LOST count failed\n");
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

