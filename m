Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6D695819
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBNFFY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjBNFFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:05:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80465B6;
        Mon, 13 Feb 2023 21:05:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nh19-20020a17090b365300b00233ceae8407so6812473pjb.3;
        Mon, 13 Feb 2023 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lDTeFq3DMLp2HO8sGdZ7LtKYGQh7aSuEDpGdSPDQzs=;
        b=NGNDb4oh/ch7g/UQ19QDffm7P4xY7fkZxALQUnSe7cvPoglt3tZibb5luD34vRYZ8t
         rRPWaA/loYrNgiKmeXZfFzS5ELQ+evBNvq8m54uUUJa7zo1GpNZrYyY/ictJ86WZ5pEM
         RDhpu4VupYi8lpwoKxjyOKXazTrPNwd7oUk59y1Qygf8OkJnHj+3NZmPmIHEFEurw6gv
         V9vkjezsKuBBu0ucw6xsgooRQlcrwXOF1eiDKr0DUhAj3vIsOTcS7PGUra1AkxFvv3vC
         vl/ADJ2ZabCc/vMmwqQPuBnBA8wfQJTOfnzqXUxRl8ksLiSRE7ryN/qUS3vOPcqKUQUT
         U1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lDTeFq3DMLp2HO8sGdZ7LtKYGQh7aSuEDpGdSPDQzs=;
        b=Xv9O8GeEmruEM1hSKeHUk6OebnY3lZXlF4ZBoClnZPWJkjKpUpQQh9inEC7+pA3NPn
         huyGSj1Qwsi3nuTkRtyu4CklwowPMIecQhkaDc7NAP/PSx3bnLo9LBozkV4pU/ONiZRd
         zojP16NY7wu9cWgJt0anjjXvTHosniUjOloTcDBpKeT12mD72fslPAWBDv1LH45aIVbW
         sejOvRCWCtQ8fv7+2TlrCzlYM1aSX013IArXaKun1RRyhaXvZPtAz/v/S6O4Rx8gFda7
         UQ189GTHWYrIYJasFgvPXal4fQIL9yi/MpjKoVya/UzSXVjvD/EJNXdewR3pNZHzWghm
         xxoA==
X-Gm-Message-State: AO0yUKUdVyR8or4iJv6Vno6O3kNHJDV0hQ84yCmGjMfNcVm52WtNHyzQ
        U561tKFWp+8EtGBNOY3EDF4=
X-Google-Smtp-Source: AK7set9JCxuU+wXUi5/8lVFcPfZ0TweAJakBoEiSsZNqIvMCJQIfMWvGYiXL1XhXqipl7KQxvRjrwQ==
X-Received: by 2002:a17:902:f0cd:b0:19a:7e06:fd0a with SMTP id v13-20020a170902f0cd00b0019a7e06fd0amr927768pla.23.1676351101968;
        Mon, 13 Feb 2023 21:05:01 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:de3c:c4c2:3f15:764d])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902761200b001932a9e4f2csm9045593pll.255.2023.02.13.21.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:05:01 -0800 (PST)
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
Subject: [PATCH 4/7] perf record: Record dropped sample count
Date:   Mon, 13 Feb 2023 21:04:49 -0800
Message-Id: <20230214050452.26390-5-namhyung@kernel.org>
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

When it uses bpf filters, event might drop some samples.  It'd be nice
if it can report how many samples it lost.  As LOST_SAMPLES event can
carry the similar information, let's use it for bpf filters.

To indicate it's from BPF filters, add a new misc flag for that and
do not display cpu load warnings.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c  | 37 ++++++++++++++++++++++--------------
 tools/perf/util/bpf-filter.c |  7 +++++++
 tools/perf/util/bpf-filter.h |  5 +++++
 tools/perf/util/session.c    |  3 ++-
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c81047a78f3e..3201d1a1ea1f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1869,24 +1869,16 @@ record__switch_output(struct record *rec, bool at_exit)
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
@@ -1895,6 +1887,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
 						       evsel->core.attr.sample_type, &sample);
 	lost->header.size = sizeof(*lost) + id_hdr_size;
+	lost->header.misc = misc_flag;
 	record__write(rec, NULL, lost, lost->header.size);
 }
 
@@ -1918,6 +1911,7 @@ static void record__read_lost_samples(struct record *rec)
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
+		u64 lost_count;
 
 		if (xy == NULL || evsel->core.fd == NULL)
 			continue;
@@ -1929,12 +1923,27 @@ static void record__read_lost_samples(struct record *rec)
 
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
index f47420cf81c9..11fb391c92e9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -76,6 +76,13 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
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
2.39.1.581.gbfd45094c4-goog

