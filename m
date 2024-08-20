Return-Path: <bpf+bounces-37642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5193958B8B
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 17:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC01F229B5
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D72D195FF1;
	Tue, 20 Aug 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaMA8QJX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF460194149;
	Tue, 20 Aug 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168708; cv=none; b=IOfTLVbZ92UTRxz6CAgc9bI7gg5d1PvmqJ4K0uus/kTckdrwyoigQPFxYAehOxJDTPriBlNaXcT0TxsgEuNxfqz9dbPEkojWTMdCnEr6pHvzyZl9QfIVXEE31ECz5mp5g/Wcic7cxGZyib8o/LP9x+0I1L0o+TIjOR7CpzfoTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168708; c=relaxed/simple;
	bh=sJFUl3UfyFEZI8rrsQwW8vX8hUUY9bduTZpmp31KZgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHPnJsnu2jYpMwxfYVpybYUtf+ehowit6br51ASt8srwBXNdn0c8NxsOoUycytfVKtCmSTJAUT9ScYeFDPYt4G/DYbjTxJpG1JdRuE117oazk5EyvOZHhNNKxQXrs71IcvTmADpsShXqjIGW0j7trJXJkf2I+Mv9kQACsvSchlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaMA8QJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDCFC4AF15;
	Tue, 20 Aug 2024 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168707;
	bh=sJFUl3UfyFEZI8rrsQwW8vX8hUUY9bduTZpmp31KZgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaMA8QJXr79BAhLnJKw+Tpcj0BNNxwJuwNydINTWRObBWdnCO8HOZrjK47SWXKZYi
	 ltkQHIOkr3xCKaxQIPo/FcxAGSykutBdByVViDa45NhBMUXANbODH/X6ac9+eA8s5F
	 79ntIQdf8U6mFcaskrppLQbuNJ3dV9OzhgCxaXGtTQN7Tf7GKKDNtb1gD14mXbulXj
	 1LPbp+qzPOC9ieVXd0mQlXGevz6wGva5wYj7YGWXmAI8Zpes5lGCqHtxsBuG+fbCfd
	 0K5gZ7mafI7P/PNeEAzTr4ZZoVnvsG3ynH/L4I//LAaxcZWcd/gcPSq8be0b3lYerK
	 eTsGp/1DkA/DQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH v3 2/3] perf tools: Print lost samples due to BPF filter
Date: Tue, 20 Aug 2024 08:45:03 -0700
Message-ID: <20240820154504.128923-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240820154504.128923-1-namhyung@kernel.org>
References: <20240820154504.128923-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the actual dropped sample count in the event stat.

  $ sudo perf record -o- -e cycles --filter 'period < 10000' \
      -e instructions --filter 'ip > 0x8000000000000000' perf test -w noploop | \
      perf report --stat -i-
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.058 MB - ]

  Aggregated stats:
                 TOTAL events:        469
                  MMAP events:        268  (57.1%)
                  COMM events:          2  ( 0.4%)
                  EXIT events:          1  ( 0.2%)
                SAMPLE events:         16  ( 3.4%)
                 MMAP2 events:         22  ( 4.7%)
          LOST_SAMPLES events:          2  ( 0.4%)
               KSYMBOL events:         89  (19.0%)
             BPF_EVENT events:         39  ( 8.3%)
                  ATTR events:          2  ( 0.4%)
        FINISHED_ROUND events:          1  ( 0.2%)
              ID_INDEX events:          1  ( 0.2%)
            THREAD_MAP events:          1  ( 0.2%)
               CPU_MAP events:          1  ( 0.2%)
          EVENT_UPDATE events:          2  ( 0.4%)
             TIME_CONV events:          1  ( 0.2%)
               FEATURE events:         20  ( 4.3%)
         FINISHED_INIT events:          1  ( 0.2%)
  cycles stats:
                SAMPLE events:          2
    LOST_SAMPLES (BPF) events:       4010
  instructions stats:
                SAMPLE events:         14
    LOST_SAMPLES (BPF) events:       3990

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c    |  9 +++++++--
 tools/perf/ui/stdio/hist.c     |  4 ++--
 tools/perf/util/events_stats.h | 15 ++++++++++++++-
 tools/perf/util/hist.c         | 19 +++++++++++++++----
 tools/perf/util/hist.h         |  1 +
 tools/perf/util/machine.c      |  5 +++--
 tools/perf/util/session.c      |  5 +++--
 7 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1643113616f4..c304d9b06190 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -795,8 +795,13 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 
 	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
-		hists__inc_nr_lost_samples(evsel__hists(evsel),
-					   event->lost_samples.lost);
+		struct hists *hists = evsel__hists(evsel);
+		u32 count = event->lost_samples.lost;
+
+		if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF)
+			hists__inc_nr_dropped_samples(hists, count);
+		else
+			hists__inc_nr_lost_samples(hists, count);
 	}
 	return 0;
 }
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 9372e8904d22..74b2c619c56c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -913,11 +913,11 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp)
 			continue;
 
 		if (i && total) {
-			ret += fprintf(fp, "%16s events: %10d  (%4.1f%%)\n",
+			ret += fprintf(fp, "%20s events: %10d  (%4.1f%%)\n",
 				       name, stats->nr_events[i],
 				       100.0 * stats->nr_events[i] / total);
 		} else {
-			ret += fprintf(fp, "%16s events: %10d\n",
+			ret += fprintf(fp, "%20s events: %10d\n",
 				       name, stats->nr_events[i]);
 		}
 	}
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index f43e5b1a366a..eabd7913c309 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -18,7 +18,18 @@
  * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
  * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
  * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
- * all struct perf_record_lost_samples.lost fields reported.
+ * all struct perf_record_lost_samples.lost fields reported without setting the
+ * misc field in the header.
+ *
+ * The BPF program can discard samples according to the filter expressions given
+ * by the user.  This number is kept in a BPF map and dumped at the end of perf
+ * record in a PERF_RECORD_LOST_SAMPLES event.  To differentiate it from other
+ * lost samples, perf tools sets PERF_RECORD_MISC_LOST_SAMPLES_BPF flag in the
+ * header.misc field.  The number of dropped-samples events is stored in
+ * .nr_events[PERF_RECORD_LOST_SAMPLES] while total_dropped_samples tells
+ * exactly how many samples the BPF program in fact dropped, i.e. it is the sum
+ * of all struct perf_record_lost_samples.lost fields reported with the misc
+ * field set in the header.
  *
  * The total_period is needed because by default auto-freq is used, so
  * multiplying nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
@@ -28,6 +39,7 @@
 struct events_stats {
 	u64 total_lost;
 	u64 total_lost_samples;
+	u64 total_dropped_samples;
 	u64 total_aux_lost;
 	u64 total_aux_partial;
 	u64 total_aux_collision;
@@ -48,6 +60,7 @@ struct hists_stats {
 	u32 nr_samples;
 	u32 nr_non_filtered_samples;
 	u32 nr_lost_samples;
+	u32 nr_dropped_samples;
 };
 
 void events_stats__inc(struct events_stats *stats, u32 type);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0f9ce2ee2c31..dadce2889e52 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2385,6 +2385,11 @@ void hists__inc_nr_lost_samples(struct hists *hists, u32 lost)
 	hists->stats.nr_lost_samples += lost;
 }
 
+void hists__inc_nr_dropped_samples(struct hists *hists, u32 lost)
+{
+	hists->stats.nr_dropped_samples += lost;
+}
+
 static struct hist_entry *hists__add_dummy_entry(struct hists *hists,
 						 struct hist_entry *pair)
 {
@@ -2729,18 +2734,24 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
+		u64 total_samples = hists->stats.nr_samples;
+
+		total_samples += hists->stats.nr_lost_samples;
+		total_samples += hists->stats.nr_dropped_samples;
 
-		if (symbol_conf.skip_empty && !hists->stats.nr_samples &&
-		    !hists->stats.nr_lost_samples)
+		if (symbol_conf.skip_empty && total_samples == 0)
 			continue;
 
 		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
 		if (hists->stats.nr_samples)
-			ret += fprintf(fp, "%16s events: %10d\n",
+			ret += fprintf(fp, "%20s events: %10d\n",
 				       "SAMPLE", hists->stats.nr_samples);
 		if (hists->stats.nr_lost_samples)
-			ret += fprintf(fp, "%16s events: %10d\n",
+			ret += fprintf(fp, "%20s events: %10d\n",
 				       "LOST_SAMPLES", hists->stats.nr_lost_samples);
+		if (hists->stats.nr_dropped_samples)
+			ret += fprintf(fp, "%20s events: %10d\n",
+				       "LOST_SAMPLES (BPF)", hists->stats.nr_dropped_samples);
 	}
 
 	return ret;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 30c13fc8cbe4..4ea247e54fb6 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -371,6 +371,7 @@ void hists__inc_stats(struct hists *hists, struct hist_entry *h);
 void hists__inc_nr_events(struct hists *hists);
 void hists__inc_nr_samples(struct hists *hists, bool filtered);
 void hists__inc_nr_lost_samples(struct hists *hists, u32 lost);
+void hists__inc_nr_dropped_samples(struct hists *hists, u32 lost);
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c08774d06d14..00a49d0744fc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -642,8 +642,9 @@ int machine__process_lost_event(struct machine *machine __maybe_unused,
 int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 					union perf_event *event, struct perf_sample *sample)
 {
-	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "\n",
-		    sample->id, event->lost_samples.lost);
+	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "%s\n",
+		    sample->id, event->lost_samples.lost,
+		    event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF ? " (BPF)" : "");
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d2bd563119bc..774eb3382000 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1290,8 +1290,9 @@ static int machines__deliver_event(struct machines *machines,
 			evlist->stats.total_lost += event->lost.lost;
 		return tool->lost(tool, event, sample, machine);
 	case PERF_RECORD_LOST_SAMPLES:
-		if (tool->lost_samples == perf_event__process_lost_samples &&
-		    !(event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF))
+		if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF)
+			evlist->stats.total_dropped_samples += event->lost_samples.lost;
+		else if (tool->lost_samples == perf_event__process_lost_samples)
 			evlist->stats.total_lost_samples += event->lost_samples.lost;
 		return tool->lost_samples(tool, event, sample, machine);
 	case PERF_RECORD_READ:
-- 
2.46.0.184.g6999bdac58-goog


