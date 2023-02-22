Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37469FF20
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjBVXB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjBVXBx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:01:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C9474E8;
        Wed, 22 Feb 2023 15:01:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d6so1747900pgu.2;
        Wed, 22 Feb 2023 15:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSHHrm+IEmV5+3GpaQf/dlzbSvgoq0GvPdlbNwmtKI8=;
        b=Nhj414ywG2TE9ErmyOTlaFQkJOD6MjzVKHLUrO8QrHkwXxxTGgMCwLXjP4/aHxUihh
         d3XxS60pprtJIVqdu25FTkBg42c+9aT/JNj+2lPqyn7ejul0kvkmPTb27DA3asDR/pnh
         JLDssxetYXa5xJX5xhFg61oIs1hv0GV4ktGSSjp9xfmHnNaOfXT7tqTFe95J5X/mMZuB
         rVFtXbg1r/EcQwjphjalM8NgGQb4zRw4ND6lXGjVJOaD4bK90WxnycUxneJtwcbRtrJh
         Va59jBOxOaHRXelKNus9aW7tViaLeCGgbubI4TqkVYGLFeOX7QNnUdMrBnS9HDWi8RD+
         8ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSHHrm+IEmV5+3GpaQf/dlzbSvgoq0GvPdlbNwmtKI8=;
        b=P6UgG5jsE4CdaFhTlw7q4QCJIT9+Jvx7Q4g13xUv+EHpW5RJYPRwprVIIqohmUknfi
         124JXmuIv5BjjsTXoE83U6CyT0wyHaTVGq0E+LajqTSNIw21VbZJrfl29E9YCBgSVSS6
         7D3kcGAv0Fgv9lzEWXJpLSKvdBHQ63TY5kTYu6hapLH5/1oy9HFl7pakQKV9D+fLDdk7
         hPja2PrwgNp7/b0VVR7A6vaD4+VFh71snLPSlJZ9LhUl+r0RJvWgqSXUkY0ypAOYU6Oy
         6RRnB2W1wDYu+Q8IXSdEquwIzN9CcmCE+79kxAdanEa6Wii3czF2y/pKlwenLdZMu903
         MNzw==
X-Gm-Message-State: AO0yUKUtMnFnCDVdyzfGvCKhHSITgm2/n8CvEUGtx0VwXgiQonaQ4jBI
        11wVyAgvA703LV5w5C+52fo=
X-Google-Smtp-Source: AK7set+Xkyo2r1X68PW+Via+KdnUCMYAitGbgT9zhJK1tIEJ8zrNF/+FP1lGTYm/+spC+TjaBqWzHg==
X-Received: by 2002:a62:64d4:0:b0:5a8:b2c1:97c7 with SMTP id y203-20020a6264d4000000b005a8b2c197c7mr6509410pfb.34.1677106910659;
        Wed, 22 Feb 2023 15:01:50 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:8f76:587d:f250:fecf])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b005ccbe5346ebsm3895127pfm.163.2023.02.22.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:01:50 -0800 (PST)
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
Subject: [PATCH 4/8] perf record: Record dropped sample count
Date:   Wed, 22 Feb 2023 15:01:37 -0800
Message-Id: <20230222230141.1729048-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230222230141.1729048-1-namhyung@kernel.org>
References: <20230222230141.1729048-1-namhyung@kernel.org>
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

When it uses bpf filters, event might drop some samples.  It'd be nice
if it can report how many samples it lost.  As LOST_SAMPLES event can
carry the similar information, let's use it for bpf filters.

To indicate it's from BPF filters, add a new misc flag for that and
do not display cpu load warnings.

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
index e1b1a5343bad..660db5ccd3da 100644
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
index 6077930073f9..36b44c8188ab 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -22,6 +22,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
 int perf_bpf_filter__prepare(struct evsel *evsel);
 int perf_bpf_filter__destroy(struct evsel *evsel);
+u64 perf_bpf_filter__lost_count(struct evsel *evsel);
 
 #else /* !HAVE_BPF_SKEL */
 
@@ -38,5 +39,9 @@ static inline int perf_bpf_filter__destroy(struct evsel *evsel)
 {
 	return -ENOSYS;
 }
+static inline u64 perf_bpf_filter__lost_count(struct evsel *evsel)
+{
+	return 0;
+}
 #endif /* HAVE_BPF_SKEL*/
 #endif /* PERF_UTIL_BPF_FILTER_H */
\ No newline at end of file
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
2.39.2.637.g21b0678d19-goog

