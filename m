Return-Path: <bpf+bounces-26382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641889EB31
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDF61F21966
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19834D135;
	Wed, 10 Apr 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOiqeNqI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D347F51
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731373; cv=none; b=qHVg3x/HtLOU1NqfWNd8rWSlSufgWHPiVPALUUzwGaYC2apvVZqbGk7YEFRBTBuwb2Rh/ErzQH0jlJg/iXm4U29aIgNbCfglW6FJ3McVfhn2AFwidHkAVsaXSruHgxnMSLyylKbGJSoA1FT61WzX/q7rAifMzeQOsHpj657/ciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731373; c=relaxed/simple;
	bh=3p1yHF/c1QG6QmzKwpTGX3FMxQr4u7DJHh6G2MkxNTE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nDM/igw/uRmFChCR3njnoP2nyu+b5mm7N5Ceq3VBBdhcbyiuKzgwTRxcTYwR8RX+HvBq1+7ROcFPU+eSJQ5l9WTbB0GiO/T1BNpP/lX1+GTKD181/CkAbmoU6vuy8PVzgvRRuCnSvBjyBrXf5KX1mjpPGig33oMFuNJVJNGCPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOiqeNqI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615372710c4so104067057b3.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731365; x=1713336165; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBDZbu9Ta5pNSgcnadmg5vsmSlA+wrH4Vyck59Apn/M=;
        b=rOiqeNqID7eHP/P9WdX2nMDVZ3uxtWG4fDhqqZ9fvIQU/YCTB9CxK/jGGuKMJDqKn+
         Rp6an1ZN4aH2KTIbRSrr/DrGKQMbfKYE83sf2PpBVs7MlUkzo26bMlJZpQ4DGtuLjaee
         cQ3wp/ItOXHi+7qmGYDx3T0EexEIpr639hzDbd2UtMHZZLOPHi07VxfobQRTKzV5iQQh
         xTMA2rxlNVWlt92vAd9AXXaDxBbsjpTtMfgItoiDaofffO1pjcN/mbmnUyHX6VO0ey98
         SAWRCydRetb2je8FyFaLEHPUNWNfdS0i1ZPSS1jiwv5KOPUtocHGP54mFNPbV5eSH1aX
         6qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731365; x=1713336165;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBDZbu9Ta5pNSgcnadmg5vsmSlA+wrH4Vyck59Apn/M=;
        b=PZAW8R0uUa76FW18X1+3ay9Awo4H3WX6YWb9i3bHaoAREuepK4WM8ObrnSTdca68it
         IAxKp2ezTP4ocs3y206218evwv0SfZLH7O8E1dMi8ZOpEGrg2vEVJIKXZp7s+h5nv8ix
         N7Ho7LhJDDRzrFUVB9ObdsMZQBmB1KcF37CuSvAP30Sl3YrlEftsUHUTbZYjlRoyp4sh
         dma3w7ttzVEQRfBZZ/MPvOohU7oACkomsSD7usuAcsiaVWMbXMwcyOz57wSL85przNMM
         qnfZ3SwGwU+pe9z/2iAmRrHOZGIq01Ie3rOcdmv4pKWsny/BvECrzsgMsL7kCTtwvLii
         V0dg==
X-Forwarded-Encrypted: i=1; AJvYcCXEhAsG18CCShGtaL63FYLGFL3vqLZsrO2kcdC9FELqste5Mqj7JtyVechQFc6lxpDrgN5fpazr9AjEToNfEqGzNRF6
X-Gm-Message-State: AOJu0YxMDPtURGDcNNX081huHjTcr2ZfF0GB+4jZ7iA3bF2QSYn2QdAp
	Yr8H9EJwY0+LD5ZRW/w8NQjlXAECaMn2DvpOlRBm08MNbk/FXo2fuaYrOzh5X2Ml3SuVjs6m4Kn
	FGe2PhQ==
X-Google-Smtp-Source: AGHT+IGaAl4iNpkR9T/CC9SjjyI2r+hFrKrkTRo9yfHeUYJNDvvsMqBf3GJ6PxdvGksPdgfCzaFNZlAQx6dT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a05:690c:997:b0:617:cced:e96f with SMTP id
 ce23-20020a05690c099700b00617ccede96fmr379433ywb.8.1712731364939; Tue, 09 Apr
 2024 23:42:44 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:12 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 10/12] perf dso: Add reference count checking and accessor functions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add reference count checking to struct dso, this can help with
implementing correct reference counting discipline. To avoid
RC_CHK_ACCESS everywhere, add accessor functions for the variables in
struct dso.

The majority of the change is mechanical in nature and not easy to
split up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c                 |   8 +-
 tools/perf/builtin-buildid-cache.c            |   2 +-
 tools/perf/builtin-buildid-list.c             |  18 +-
 tools/perf/builtin-inject.c                   |  71 ++-
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |   8 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/tests/code-reading.c               |   8 +-
 tools/perf/tests/dso-data.c                   |  11 +-
 tools/perf/tests/hists_common.c               |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/symbols.c                    |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   6 +-
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   8 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate-data.c               |  14 +-
 tools/perf/util/annotate.c                    |  17 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    |  38 +-
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/disasm.c                      |  34 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 368 +++++++------
 tools/perf/util/dso.h                         | 488 ++++++++++++++++--
 tools/perf/util/dsos.c                        |  54 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     |  46 +-
 tools/perf/util/map.c                         |  77 ++-
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/print_insn.c                  |   2 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 +--
 tools/perf/util/symbol-elf.c                  |  94 ++--
 tools/perf/util/symbol-minimal.c              |   4 +-
 tools/perf/util/symbol.c                      | 186 +++----
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |   8 +-
 57 files changed, 1165 insertions(+), 735 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 16e1581207c9..06efd6af4f88 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -218,7 +218,7 @@ static int process_branch_callback(struct evsel *evsel,
 	}
 
 	if (a.map != NULL)
-		map__dso(a.map)->hit = 1;
+		dso__set_hit(map__dso(a.map));
 
 	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
 
@@ -253,7 +253,7 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 		if (al->sym != NULL) {
 			struct dso *dso = map__dso(al->map);
 
-			rb_erase_cached(&al->sym->rb_node, &dso->symbols);
+			rb_erase_cached(&al->sym->rb_node, dso__symbols(dso));
 			symbol__delete(al->sym);
 			dso__reset_find_symbol_cache(dso);
 		}
@@ -344,7 +344,7 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
 	}
 
 	printf("Annotate type: '%s' in %s (%d samples):\n",
-	       he->mem_type->self.type_name, dso->name, nr_samples);
+		he->mem_type->self.type_name, dso__name(dso), nr_samples);
 
 	if (evsel__is_group_event(evsel)) {
 		struct evsel *pos;
@@ -520,7 +520,7 @@ static void hists__find_annotations(struct hists *hists,
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
 
-		if (he->ms.sym == NULL || map__dso(he->ms.map)->annotate_warned)
+		if (he->ms.sym == NULL || dso__annotate_warned(map__dso(he->ms.map)))
 			goto find_next;
 
 		if (ann->sym_hist_filter &&
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index e2a40f1d9225..b0511d16aeb6 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -286,7 +286,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 
 		pr_warning("Problems with %s file, consider removing it from the cache\n",
 			   filename);
-	} else if (memcmp(dso->bid.data, bid.data, bid.size)) {
+	} else if (memcmp(dso__bid(dso)->data, bid.data, bid.size)) {
 		pr_warning("Problems with %s file, consider removing it from the cache\n",
 			   filename);
 	}
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index c9037477865a..383d5de36ce4 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -26,16 +26,18 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 {
 	const struct dso *dso = map__dso(map);
 	char bid_buf[SBUILD_ID_SIZE];
+	const char *dso_long_name = dso__long_name(dso);
+	const char *dso_short_name = dso__short_name(dso);
 
 	memset(bid_buf, 0, sizeof(bid_buf));
-	if (dso->has_build_id)
-		build_id__sprintf(&dso->bid, bid_buf);
+	if (dso__has_build_id(dso))
+		build_id__sprintf(dso__bid_const(dso), bid_buf);
 	printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map__start(map), map__end(map));
-	if (dso->long_name != NULL) {
-		printf(" %s", dso->long_name);
-	} else if (dso->short_name != NULL) {
-		printf(" %s", dso->short_name);
-	}
+	if (dso_long_name != NULL)
+		printf(" %s", dso_long_name);
+	else if (dso_short_name != NULL)
+		printf(" %s", dso_short_name);
+
 	printf("\n");
 
 	return 0;
@@ -76,7 +78,7 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
 
 static bool dso__skip_buildid(struct dso *dso, int with_hits)
 {
-	return with_hits && !dso->hit;
+	return with_hits && !dso__hit(dso);
 }
 
 static int perf_session__list_build_ids(bool force, bool with_hits)
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ce5e28eaad90..a212678d47be 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -445,10 +445,9 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	}
 
 	if (dso) {
-		mutex_lock(&dso->lock);
-		nsinfo__put(dso->nsinfo);
-		dso->nsinfo = nsi;
-		mutex_unlock(&dso->lock);
+		mutex_lock(dso__lock(dso));
+		dso__set_nsinfo(dso, nsi);
+		mutex_unlock(dso__lock(dso));
 	} else
 		nsinfo__put(nsi);
 
@@ -466,8 +465,8 @@ static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
 	dso = findnew_dso(event->mmap.pid, event->mmap.tid,
 			  event->mmap.filename, NULL, machine);
 
-	if (dso && !dso->hit) {
-		dso->hit = 1;
+	if (dso && !dso__hit(dso)) {
+		dso__set_hit(dso);
 		dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
 	}
 	dso__put(dso);
@@ -492,7 +491,7 @@ static int perf_event__repipe_mmap2(struct perf_tool *tool,
 				  event->mmap2.filename, NULL, machine);
 		if (dso) {
 			/* mark it not to inject build-id */
-			dso->hit = 1;
+			dso__set_hit(dso);
 		}
 		dso__put(dso);
 	}
@@ -544,7 +543,7 @@ static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
 				  event->mmap2.filename, NULL, machine);
 		if (dso) {
 			/* mark it not to inject build-id */
-			dso->hit = 1;
+			dso__set_hit(dso);
 		}
 		dso__put(dso);
 		perf_event__repipe(tool, event, sample, machine);
@@ -554,8 +553,8 @@ static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
 	dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
 			  event->mmap2.filename, &dso_id, machine);
 
-	if (dso && !dso->hit) {
-		dso->hit = 1;
+	if (dso && !dso__hit(dso)) {
+		dso__set_hit(dso);
 		dso__inject_build_id(dso, tool, machine, sample->cpumode,
 				     event->mmap2.flags);
 	}
@@ -631,24 +630,24 @@ static int dso__read_build_id(struct dso *dso)
 {
 	struct nscookie nsc;
 
-	if (dso->has_build_id)
+	if (dso__has_build_id(dso))
 		return 0;
 
-	mutex_lock(&dso->lock);
-	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
-		dso->has_build_id = true;
-	else if (dso->nsinfo) {
-		char *new_name = dso__filename_with_chroot(dso, dso->long_name);
+	mutex_lock(dso__lock(dso));
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (filename__read_build_id(dso__long_name(dso), dso__bid(dso)) > 0)
+		dso__set_has_build_id(dso);
+	else if (dso__nsinfo(dso)) {
+		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0)
-			dso->has_build_id = true;
+		if (new_name && filename__read_build_id(new_name, dso__bid(dso)) > 0)
+			dso__set_has_build_id(dso);
 		free(new_name);
 	}
 	nsinfo__mountns_exit(&nsc);
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 
-	return dso->has_build_id ? 0 : -1;
+	return dso__has_build_id(dso) ? 0 : -1;
 }
 
 static struct strlist *perf_inject__parse_known_build_ids(
@@ -700,14 +699,14 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 		dso_name = strchr(build_id, ' ');
 		bid_len = dso_name - pos->s;
 		dso_name = skip_spaces(dso_name);
-		if (strcmp(dso->long_name, dso_name))
+		if (strcmp(dso__long_name(dso), dso_name))
 			continue;
 		for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
-			dso->bid.data[ix] = (hex(build_id[2 * ix]) << 4 |
-					     hex(build_id[2 * ix + 1]));
+			dso__bid(dso)->data[ix] = (hex(build_id[2 * ix]) << 4 |
+						  hex(build_id[2 * ix + 1]));
 		}
-		dso->bid.size = bid_len / 2;
-		dso->has_build_id = 1;
+		dso__bid(dso)->size = bid_len / 2;
+		dso__set_has_build_id(dso);
 		return true;
 	}
 	return false;
@@ -720,9 +719,9 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
 						  tool);
 	int err;
 
-	if (is_anon_memory(dso->long_name) || flags & MAP_HUGETLB)
+	if (is_anon_memory(dso__long_name(dso)) || flags & MAP_HUGETLB)
 		return 0;
-	if (is_no_dso_memory(dso->long_name))
+	if (is_no_dso_memory(dso__long_name(dso)))
 		return 0;
 
 	if (inject->known_build_ids != NULL &&
@@ -730,14 +729,14 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
 		return 1;
 
 	if (dso__read_build_id(dso) < 0) {
-		pr_debug("no build_id found for %s\n", dso->long_name);
+		pr_debug("no build_id found for %s\n", dso__long_name(dso));
 		return -1;
 	}
 
 	err = perf_event__synthesize_build_id(tool, dso, cpumode,
 					      perf_event__repipe, machine);
 	if (err) {
-		pr_err("Can't synthesize build_id event for %s\n", dso->long_name);
+		pr_err("Can't synthesize build_id event for %s\n", dso__long_name(dso));
 		return -1;
 	}
 
@@ -763,8 +762,8 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
 		struct dso *dso = map__dso(al.map);
 
-		if (!dso->hit) {
-			dso->hit = 1;
+		if (!dso__hit(dso)) {
+			dso__set_hit(dso);
 			dso__inject_build_id(dso, tool, machine,
 					     sample->cpumode, map__flags(al.map));
 		}
@@ -1146,8 +1145,8 @@ static bool dso__is_in_kernel_space(struct dso *dso)
 		return false;
 
 	return dso__is_kcore(dso) ||
-	       dso->kernel ||
-	       is_kernel_module(dso->long_name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
+	       dso__kernel(dso) ||
+	       is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN);
 }
 
 static u64 evlist__first_id(struct evlist *evlist)
@@ -1181,7 +1180,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 	if (!machine)
 		return -ENOMEM;
 
-	dso->hit = 1;
+	dso__set_hit(dso);
 
 	return perf_event__synthesize_build_id(&inject->tool, dso, cpumode,
 					       process_build_id, machine);
@@ -1192,7 +1191,7 @@ static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
 	struct guest_session *gs = data;
 	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
 
-	if (!dso->has_build_id)
+	if (!dso__has_build_id(dso))
 		return 0;
 
 	return synthesize_build_id(inject, dso, gs->machine_pid);
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index 7f75c5b73f26..a3c2ffdc1af8 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -38,7 +38,7 @@ static int __cmd_kallsyms(int argc, const char **argv)
 
 		dso = map__dso(map);
 		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
-			symbol->name, dso->short_name, dso->long_name,
+			symbol->name, dso__short_name(dso), dso__long_name(dso),
 			map__unmap_ip(map, symbol->start), map__unmap_ip(map, symbol->end),
 			symbol->start, symbol->end);
 	}
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 5b851e64e4a1..863fcd735dae 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -213,7 +213,7 @@ dump_raw_samples(struct perf_tool *tool,
 	if (al.map != NULL) {
 		dso = map__dso(al.map);
 		if (dso)
-			dso->hit = 1;
+			dso__set_hit(dso);
 	}
 
 	field_sep = symbol_conf.field_sep;
@@ -255,7 +255,7 @@ dump_raw_samples(struct perf_tool *tool,
 		symbol_conf.field_sep,
 		sample->data_src,
 		symbol_conf.field_sep,
-		dso ? dso->long_name : "???",
+		dso ? dso__long_name(dso) : "???",
 		al.sym ? al.sym->name : "???");
 out_put:
 	addr_location__exit(&al);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcd93ee5fc24..16a925a3e2e7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -322,7 +322,7 @@ static int process_sample_event(struct perf_tool *tool,
 	}
 
 	if (al.map != NULL)
-		map__dso(al.map)->hit = 1;
+		dso__set_hit(map__dso(al.map));
 
 	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
@@ -609,7 +609,7 @@ static void report__warn_kptr_restrict(const struct report *rep)
 		return;
 
 	if (kernel_map == NULL ||
-	     (map__dso(kernel_map)->hit &&
+	    (dso__hit(map__dso(kernel_map)) &&
 	     (kernel_kmap->ref_reloc_sym == NULL ||
 	      kernel_kmap->ref_reloc_sym->addr == 0))) {
 		const char *desc =
@@ -850,7 +850,7 @@ static int maps__fprintf_task_cb(struct map *map, void *data)
 		prot & PROT_EXEC ? 'x' : '-',
 		map__flags(map) ? 's' : 'p',
 		map__pgoff(map),
-		dso->id.ino, dso->name);
+		dso__id_const(dso)->ino, dso__name(dso));
 
 	if (ret < 0)
 		return ret;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 647cb31a47c8..f7c3c3868c3c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1017,11 +1017,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		to   = entries[i].to;
 
 		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
-		    !map__dso(alf.map)->adjust_symbols)
+		    !dso__adjust_symbols(map__dso(alf.map)))
 			from = map__dso_map_ip(alf.map, from);
 
 		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
-		    !map__dso(alt.map)->adjust_symbols)
+		    !dso__adjust_symbols(map__dso(alt.map)))
 			to = map__dso_map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -1082,7 +1082,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		goto out;
 	}
-	if (dso->data.status == DSO_DATA_STATUS_ERROR) {
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		goto out;
 	}
@@ -1094,7 +1094,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	len = dso__data_read_offset(dso, machine, offset, (u8 *)buffer,
 				    end - start + MAXINSN);
 
-	*is64bit = dso->is_64_bit;
+	*is64bit = dso__is_64_bit(dso);
 	if (len <= 0)
 		pr_debug("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
 			start, end);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5ac6dcc64cef..1d6aef51c122 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -129,7 +129,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	/*
 	 * We can't annotate with just /proc/kallsyms
 	 */
-	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
+	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
 		pr_err("Can't annotate %s: No vmlinux file was found in the "
 		       "path\n", sym->name);
 		sleep(1);
@@ -182,7 +182,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 		    "Tools:  %s\n\n"
 		    "Not all samples will be on the annotation output.\n\n"
 		    "Please report to linux-kernel@vger.kernel.org\n",
-		    ip, dso->long_name, dso__symtab_origin(dso),
+		    ip, dso__long_name(dso), dso__symtab_origin(dso),
 		    map__start(map), map__end(map), sym->start, sym->end,
 		    sym->binding == STB_GLOBAL ? 'g' :
 		    sym->binding == STB_LOCAL  ? 'l' : 'w', sym->name,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e5fef39c34bf..439c489bbd9b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2917,7 +2917,7 @@ static void print_location(FILE *f, struct perf_sample *sample,
 {
 
 	if ((verbose > 0 || print_dso) && al->map)
-		fprintf(f, "%s@", map__dso(al->map)->long_name);
+		fprintf(f, "%s@", dso__long_name(map__dso(al->map)));
 
 	if ((verbose > 0 || print_sym) && al->sym)
 		fprintf(f, "%s+0x%" PRIx64, al->sym->name,
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 7a3a7bbbec71..6208f58622d1 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -253,9 +253,9 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		goto out;
 	}
 	dso = map__dso(al.map);
-	pr_debug("File is: %s\n", dso->long_name);
+	pr_debug("File is: %s\n", dso__long_name(dso));
 
-	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
+	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
 		pr_debug("Unexpected kernel address - skipping\n");
 		goto out;
 	}
@@ -274,7 +274,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	 * modules to manage long jumps. Check if the ip offset falls in stubs
 	 * sections for kernel modules. And skip module address after text end
 	 */
-	if (dso->is_kmod && al.addr > dso->text_end) {
+	if (dso__is_kmod(dso) && al.addr > dso__text_end(dso)) {
 		pr_debug("skipping the module address %#"PRIx64" after text end\n", al.addr);
 		goto out;
 	}
@@ -315,7 +315,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		state->done[state->done_cnt++] = map__start(al.map);
 	}
 
-	objdump_name = dso->long_name;
+	objdump_name = dso__long_name(dso);
 	if (dso__needs_decompress(dso)) {
 		if (dso__decompress_kmodule_path(dso, objdump_name,
 						 decomp_name,
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 2d67422c1222..fde4eca84b6f 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -228,7 +228,8 @@ static void dsos__delete(int cnt)
 	for (i = 0; i < cnt; i++) {
 		struct dso *dso = dsos[i];
 
-		unlink(dso->name);
+		dso__data_close(dso);
+		unlink(dso__name(dso));
 		dso__put(dso);
 	}
 
@@ -289,14 +290,14 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
 	}
 
 	/* verify the first one is already open */
-	TEST_ASSERT_VAL("dsos[0] is not open", dsos[0]->data.fd != -1);
+	TEST_ASSERT_VAL("dsos[0] is not open", dso__data(dsos[0])->fd != -1);
 
 	/* open +1 dso to reach the allowed limit */
 	fd = dso__data_fd(dsos[i], &machine);
 	TEST_ASSERT_VAL("failed to get fd", fd > 0);
 
 	/* should force the first one to be closed */
-	TEST_ASSERT_VAL("failed to close dsos[0]", dsos[0]->data.fd == -1);
+	TEST_ASSERT_VAL("failed to close dsos[0]", dso__data(dsos[0])->fd == -1);
 
 	/* cleanup everything */
 	dsos__delete(dso_cnt);
@@ -371,7 +372,7 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	 * dso_0 should get closed, because we reached
 	 * the file descriptor limit
 	 */
-	TEST_ASSERT_VAL("failed to close dso_0", dso_0->data.fd == -1);
+	TEST_ASSERT_VAL("failed to close dso_0", dso__data(dso_0)->fd == -1);
 
 	/* open dso_0 */
 	fd = dso__data_fd(dso_0, &machine);
@@ -381,7 +382,7 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	 * dso_1 should get closed, because we reached
 	 * the file descriptor limit
 	 */
-	TEST_ASSERT_VAL("failed to close dso_1", dso_1->data.fd == -1);
+	TEST_ASSERT_VAL("failed to close dso_1", dso__data(dso_1)->fd == -1);
 
 	/* cleanup everything */
 	close(fd_extra);
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index d08add0f4da6..187f12f5bc21 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -146,7 +146,7 @@ struct machine *setup_fake_machine(struct machines *machines)
 				goto out;
 			}
 
-			symbols__insert(&dso->symbols, sym);
+			symbols__insert(dso__symbols(dso), sym);
 		}
 
 		dso__put(dso);
@@ -183,7 +183,7 @@ void print_hists_in(struct hists *hists)
 
 			pr_info("%2d: entry: %-8s [%-8s] %20s: period = %"PRIu64"\n",
 				i, thread__comm_str(he->thread),
-				dso->short_name,
+				dso__short_name(dso),
 				he->ms.sym->name, he->stat.period);
 		}
 
@@ -212,7 +212,7 @@ void print_hists_out(struct hists *hists)
 
 			pr_info("%2d: entry: %8s:%5d [%-8s] %20s: period = %"PRIu64"/%"PRIu64"\n",
 				i, thread__comm_str(he->thread), thread__tid(he->thread),
-				dso->short_name,
+				dso__short_name(dso),
 				he->ms.sym->name, he->stat.period,
 				he->stat_acc ? he->stat_acc->period : 0);
 		}
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 71dacb0fec4d..1e0f5a310fd5 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -164,11 +164,11 @@ static void put_fake_samples(void)
 typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
-#define DSO(he)   (map__dso(he->ms.map)->short_name)
+#define DSO(he)   (dso__short_name(map__dso(he->ms.map)))
 #define SYM(he)   (he->ms.sym->name)
 #define CPU(he)   (he->cpu)
 #define DEPTH(he) (he->callchain->max_depth)
-#define CDSO(cl)  (map__dso(cl->ms.map)->short_name)
+#define CDSO(cl)  (dso__short_name(map__dso(cl->ms.map)))
 #define CSYM(cl)  (cl->ms.sym->name)
 
 struct result {
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index ba1cccf57049..33b5cc8352a7 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -129,7 +129,7 @@ static void put_fake_samples(void)
 typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
-#define DSO(he)   (map__dso(he->ms.map)->short_name)
+#define DSO(he)   (dso__short_name(map__dso(he->ms.map)))
 #define SYM(he)   (he->ms.sym->name)
 #define CPU(he)   (he->cpu)
 #define PID(he)   (thread__tid(he->thread))
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index b15417a0d617..4f1f9385ea9c 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -26,7 +26,7 @@ static int check_maps_cb(struct map *map, void *data)
 
 	if (map__start(map) != merged->start ||
 	    map__end(map) != merged->end ||
-	    strcmp(map__dso(map)->name, merged->name) ||
+	    strcmp(dso__name(map__dso(map)), merged->name) ||
 	    refcount_read(map__refcnt(map)) != 1) {
 		return 1;
 	}
@@ -39,7 +39,7 @@ static int failed_cb(struct map *map, void *data __maybe_unused)
 	pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: %d\n",
 		map__start(map),
 		map__end(map),
-		map__dso(map)->name,
+		dso__name(map__dso(map)),
 		refcount_read(map__refcnt(map)));
 
 	return 0;
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index d208105919ed..ee20a366f32f 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -81,7 +81,7 @@ static int create_map(struct test_info *ti, char *filename, struct map **map_p)
 	 * If 'filename' matches a current kernel module, must use a kernel
 	 * map. Find the one that already exists.
 	 */
-	if (dso && dso->kernel) {
+	if (dso && dso__kernel(dso) != DSO_SPACE__USER) {
 		*map_p = find_module_map(ti->machine, dso);
 		dso__put(dso);
 		if (!*map_p) {
@@ -116,7 +116,7 @@ static int test_dso(struct dso *dso)
 	if (verbose > 1)
 		dso__fprintf(dso, stderr);
 
-	for (nd = rb_first_cached(&dso->symbols); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 
 		if (sym->type != STT_FUNC && sym->type != STT_GNU_IFUNC)
@@ -145,7 +145,7 @@ static int subdivided_dso_cb(struct dso *dso, struct machine *machine __maybe_un
 {
 	struct dso *text_dso = d;
 
-	if (dso != text_dso && strstarts(dso->short_name, text_dso->short_name))
+	if (dso != text_dso && strstarts(dso__short_name(dso), dso__short_name(text_dso)))
 		if (test_dso(dso) != TEST_OK)
 			return -1;
 
@@ -190,7 +190,7 @@ static int test_file(struct test_info *ti, char *filename)
 	ret = test_dso(dso);
 
 	/* Module dso is split into many dsos by section */
-	if (ret == TEST_OK && dso->kernel)
+	if (ret == TEST_OK && dso__kernel(dso) != DSO_SPACE__USER)
 		ret = process_subdivided_dso(ti->machine, dso);
 out_put:
 	map__put(map);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index fecbf851bb2e..e30fd55f8e51 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -129,7 +129,7 @@ static int test__vmlinux_matches_kallsyms_cb1(struct map *map, void *data)
 	 * cases.
 	 */
 	struct map *pair = maps__find_by_name(args->kallsyms.kmaps,
-					(dso->kernel ? dso->short_name : dso->name));
+					(dso__kernel(dso) ? dso__short_name(dso) : dso__name(dso)));
 
 	if (pair) {
 		map__set_priv(pair, 1);
@@ -162,11 +162,11 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 		}
 
 		pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
-			map__start(map), map__end(map), map__pgoff(map), dso->name);
+			map__start(map), map__end(map), map__pgoff(map), dso__name(dso));
 		if (mem_end != map__end(pair))
 			pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
 				map__start(pair), map__end(pair), map__pgoff(pair));
-		pr_info(" %s\n", dso->name);
+		pr_info(" %s\n", dso__name(dso));
 		map__set_priv(pair, 1);
 	}
 	map__put(pair);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 0e16c268e329..c5730934aac4 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -438,7 +438,7 @@ static int sym_title(struct symbol *sym, struct map *map, char *title,
 		     size_t sz, int percent_type)
 {
 	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
-			map__dso(map)->long_name,
+			dso__long_name(map__dso(map)),
 			percent_type_str(percent_type));
 }
 
@@ -967,14 +967,14 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 		return -1;
 
 	dso = map__dso(ms->map);
-	if (dso->annotate_warned)
+	if (dso__annotate_warned(dso))
 		return -1;
 
 	if (not_annotated) {
 		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
 			char msg[BUFSIZ];
-			dso->annotate_warned = true;
+			dso__set_annotate_warned(dso);
 			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 			return -1;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0c02b3a8e121..2b32c5da47c9 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2488,7 +2488,7 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 {
 	struct dso *dso;
 
-	if (!ms->map || (dso = map__dso(ms->map)) == NULL || dso->annotate_warned)
+	if (!ms->map || (dso = map__dso(ms->map)) == NULL || dso__annotate_warned(dso))
 		return 0;
 
 	if (!ms->sym)
@@ -2581,7 +2581,7 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
 	} else {
 		struct dso *dso = map__dso(map);
 		ui_helpline__fpush("To zoom out press ESC or ENTER + \"Zoom out of %s DSO\"",
-				   __map__is_kernel(map) ? "the Kernel" : dso->short_name);
+				   __map__is_kernel(map) ? "the Kernel" : dso__short_name(dso));
 		browser->hists->dso_filter = dso;
 		perf_hpp__set_elide(HISTC_DSO, true);
 		pstack__push(browser->pstack, &browser->hists->dso_filter);
@@ -2607,7 +2607,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 
 	if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",
 		     browser->hists->dso_filter ? "out of" : "into",
-		     __map__is_kernel(map) ? "the Kernel" : map__dso(map)->short_name) < 0)
+		     __map__is_kernel(map) ? "the Kernel" : dso__short_name(map__dso(map))) < 0)
 		return 0;
 
 	act->ms.map = map;
@@ -3083,7 +3083,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			if (!browser->selection ||
 			    !browser->selection->map ||
 			    !map__dso(browser->selection->map) ||
-			    map__dso(browser->selection->map)->annotate_warned) {
+			    dso__annotate_warned(map__dso(browser->selection->map))) {
 				continue;
 			}
 
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 3d1b958d8832..fba55175a935 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -76,7 +76,7 @@ static int map_browser__run(struct map_browser *browser)
 {
 	int key;
 
-	if (ui_browser__show(&browser->b, map__dso(browser->map)->long_name,
+	if (ui_browser__show(&browser->b, dso__long_name(map__dso(browser->map)),
 			     "Press ESC to exit, %s / to search",
 			     verbose > 0 ? "" : "restart with -v to use") < 0)
 		return -1;
@@ -106,7 +106,7 @@ int map__browse(struct map *map)
 {
 	struct map_browser mb = {
 		.b = {
-			.entries = &map__dso(map)->symbols,
+			.entries = dso__symbols(map__dso(map)),
 			.refresh = ui_browser__rb_tree_refresh,
 			.seek	 = ui_browser__rb_tree_seek,
 			.write	 = map_browser__write,
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b69a1cd1577a..e764d584a359 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -275,7 +275,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	/* Check existing nodes in dso->data_types tree */
 	key.self.type_name = type_name;
 	key.self.size = size;
-	node = rb_find(&key, &dso->data_types, data_type_cmp);
+	node = rb_find(&key, dso__data_types(dso), data_type_cmp);
 	if (node) {
 		result = rb_entry(node, struct annotated_data_type, node);
 		free(type_name);
@@ -296,7 +296,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	if (symbol_conf.annotate_data_member)
 		add_member_types(result, type_die);
 
-	rb_add(&result->node, &dso->data_types, data_type_less);
+	rb_add(&result->node, dso__data_types(dso), data_type_less);
 	return result;
 }
 
@@ -469,7 +469,7 @@ static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64
 	struct dso *dso = map__dso(dloc->ms->map);
 	struct rb_node *node;
 
-	node = rb_find((void *)(uintptr_t)addr, &dso->global_vars, global_var_cmp);
+	node = rb_find((void *)(uintptr_t)addr, dso__global_vars(dso), global_var_cmp);
 	if (node == NULL)
 		return NULL;
 
@@ -500,7 +500,7 @@ static bool global_var__add(struct data_loc_info *dloc, u64 addr,
 	gvar->end = addr + size;
 	gvar->die_offset = dwarf_dieoffset(type_die);
 
-	rb_add(&gvar->node, &dso->global_vars, global_var_less);
+	rb_add(&gvar->node, dso__global_vars(dso), global_var_less);
 	return true;
 }
 
@@ -768,7 +768,7 @@ static void update_insn_state_x86(struct type_state *state,
 			return;
 
 		tsr = &state->regs[dst->reg1];
-		if (map__dso(dloc->ms->map)->kernel &&
+		if (dso__kernel(map__dso(dloc->ms->map)) &&
 		    src->segment == INSN_SEG_X86_GS && src->imm) {
 			u64 ip = dloc->ms->sym->start + dl->al.offset;
 			u64 var_addr;
@@ -1255,7 +1255,7 @@ static int check_matching_type(struct type_state *state,
 		return -1;
 	}
 
-	if (map__dso(dloc->ms->map)->kernel && arch__is(dloc->arch, "x86")) {
+	if (dso__kernel(map__dso(dloc->ms->map)) && arch__is(dloc->arch, "x86")) {
 		u64 addr;
 		int offset;
 
@@ -1593,7 +1593,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
 
-	dloc->di = debuginfo__new(dso->long_name);
+	dloc->di = debuginfo__new(dso__long_name(dso));
 	if (dloc->di == NULL) {
 		pr_debug_dtp("cannot get the debug info\n");
 		return NULL;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 11da27801d88..4c488de88455 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1093,7 +1093,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 	int graph_dotted_len;
 	char buf[512];
 
-	filename = strdup(dso->long_name);
+	filename = strdup(dso__long_name(dso));
 	if (!filename)
 		return -ENOMEM;
 
@@ -1258,7 +1258,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
 	}
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
-		ms->sym->name, map__dso(ms->map)->long_name, ev_name);
+		ms->sym->name, dso__long_name(map__dso(ms->map)), ev_name);
 	symbol__annotate_fprintf2(ms->sym, fp);
 
 	fclose(fp);
@@ -1516,7 +1516,7 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
 	if (err) {
 		char msg[BUFSIZ];
 
-		dso->annotate_warned = true;
+		dso__set_annotate_warned(dso);
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 		return -1;
@@ -1525,13 +1525,12 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
 	if (annotate_opts.print_lines) {
 		srcline_full_filename = annotate_opts.full_path;
 		symbol__calc_lines(ms, &source_line);
-		print_summary(&source_line, dso->long_name);
+		print_summary(&source_line, dso__long_name(dso));
 	}
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
-		buf, percent_type_str(annotate_opts.percent_type), sym->name,
-		dso->long_name);
+		buf, percent_type_str(annotate_opts.percent_type), sym->name, dso__long_name(dso));
 	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
@@ -1550,7 +1549,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel)
 	if (err) {
 		char msg[BUFSIZ];
 
-		dso->annotate_warned = true;
+		dso__set_annotate_warned(dso);
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
 		return -1;
@@ -1561,7 +1560,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel)
 	if (annotate_opts.print_lines) {
 		srcline_full_filename = annotate_opts.full_path;
 		symbol__calc_lines(ms, &source_line);
-		print_summary(&source_line, dso->long_name);
+		print_summary(&source_line, dso__long_name(dso));
 	}
 
 	symbol__annotate_printf(ms, evsel);
@@ -2390,7 +2389,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		}
 
 		/* This CPU access in kernel - pretend PC-relative addressing */
-		if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
+		if (dso__kernel(map__dso(ms->map)) && arch__is(arch, "x86") &&
 		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
 			dloc.var_addr = op_loc->offset;
 			op_loc->reg1 = DWARF_REG_PC;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cfa2153d4611..3fd350de0051 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2654,7 +2654,7 @@ static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
 	}
 
 	filt->addr = 0;
-	filt->size = dso->data.file_size;
+	filt->size = dso__data(dso)->file_size;
 
 	return 0;
 }
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index dec910989701..895ee8adf3b3 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -319,7 +319,7 @@ static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 
 	if (map && map__dso(map)) {
 		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
-				 map__dso(map)->short_name);
+				 dso__short_name(map__dso(map)));
 	}
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 83709146a48a..827695cd0408 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -59,10 +59,10 @@ static int machine__process_bpf_event_load(struct machine *machine,
 		if (map) {
 			struct dso *dso = map__dso(map);
 
-			dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
-			dso->bpf_prog.id = id;
-			dso->bpf_prog.sub_id = i;
-			dso->bpf_prog.env = env;
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_PROG_INFO);
+			dso__bpf_prog(dso)->id = id;
+			dso__bpf_prog(dso)->sub_id = i;
+			dso__bpf_prog(dso)->env = env;
 			map__put(map);
 		}
 	}
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 864bc26b6b46..83a1581e8cf1 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -60,7 +60,7 @@ int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
 
 	addr_location__init(&al);
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
-		map__dso(al.map)->hit = 1;
+		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
 	thread__put(thread);
@@ -272,10 +272,10 @@ char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 	bool alloc = (bf == NULL);
 	int ret;
 
-	if (!dso->has_build_id)
+	if (!dso__has_build_id(dso))
 		return NULL;
 
-	build_id__sprintf(&dso->bid, sbuild_id);
+	build_id__sprintf(dso__bid_const(dso), sbuild_id);
 	linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
 	if (!linkname)
 		return NULL;
@@ -340,25 +340,25 @@ static int machine__write_buildid_table_cb(struct dso *dso, void *data)
 	size_t name_len;
 	bool in_kernel = false;
 
-	if (!dso->has_build_id)
+	if (!dso__has_build_id(dso))
 		return 0;
 
-	if (!dso->hit && !dso__is_vdso(dso))
+	if (!dso__hit(dso) && !dso__is_vdso(dso))
 		return 0;
 
 	if (dso__is_vdso(dso)) {
-		name = dso->short_name;
-		name_len = dso->short_name_len;
+		name = dso__short_name(dso);
+		name_len = dso__short_name_len(dso);
 	} else if (dso__is_kcore(dso)) {
 		name = args->machine->mmap_name;
 		name_len = strlen(name);
 	} else {
-		name = dso->long_name;
-		name_len = dso->long_name_len;
+		name = dso__long_name(dso);
+		name_len = dso__long_name_len(dso);
 	}
 
-	in_kernel = dso->kernel || is_kernel_module(name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
-	return write_buildid(name, name_len, &dso->bid, args->machine->pid,
+	in_kernel = dso__kernel(dso) || is_kernel_module(name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
+	return write_buildid(name, name_len, dso__bid(dso), args->machine->pid,
 			     in_kernel ? args->kmisc : args->umisc, args->fd);
 }
 
@@ -876,11 +876,11 @@ static bool dso__build_id_mismatch(struct dso *dso, const char *name)
 	struct build_id bid;
 	bool ret = false;
 
-	mutex_lock(&dso->lock);
-	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) >= 0)
+	mutex_lock(dso__lock(dso));
+	if (filename__read_build_id_ns(name, &bid, dso__nsinfo(dso)) >= 0)
 		ret = !dso__build_id_equal(dso, &bid);
 
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 
 	return ret;
 }
@@ -890,13 +890,13 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 {
 	bool is_kallsyms = dso__is_kallsyms(dso);
 	bool is_vdso = dso__is_vdso(dso);
-	const char *name = dso->long_name;
+	const char *name = dso__long_name(dso);
 	const char *proper_name = NULL;
 	const char *root_dir = NULL;
 	char *allocated_name = NULL;
 	int ret = 0;
 
-	if (!dso->has_build_id)
+	if (!dso__has_build_id(dso))
 		return 0;
 
 	if (dso__is_kcore(dso)) {
@@ -921,10 +921,10 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 	if (!is_kallsyms && dso__build_id_mismatch(dso, name))
 		goto out_free;
 
-	mutex_lock(&dso->lock);
-	ret = build_id_cache__add_b(&dso->bid, name, dso->nsinfo,
+	mutex_lock(dso__lock(dso));
+	ret = build_id_cache__add_b(dso__bid(dso), name, dso__nsinfo(dso),
 				    is_kallsyms, is_vdso, proper_name, root_dir);
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 out_free:
 	free(allocated_name);
 	return ret;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 7517d16c02ec..68feed871809 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1205,7 +1205,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 	if (show_dso)
 		scnprintf(bf + printed, bfsize - printed, " %s",
 			  cl->ms.map ?
-			  map__dso(cl->ms.map)->short_name :
+			  dso__short_name(map__dso(cl->ms.map)) :
 			  "unknown");
 
 	return bf;
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 09d57efd2d9d..3cf64f5b23ee 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -134,7 +134,7 @@ static void output_sample_callchain_entry(struct perf_tool *tool,
 		output_json_key_string(out, false, 5, "symbol", al->sym->name);
 
 		if (dso) {
-			const char *dso_name = dso->short_name;
+			const char *dso_name = dso__short_name(dso);
 
 			if (dso_name && strlen(dso_name) > 0) {
 				fputc(',', out);
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 106429155c2e..50f916374d87 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -146,10 +146,10 @@ int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 int db_export__dso(struct db_export *dbe, struct dso *dso,
 		   struct machine *machine)
 {
-	if (dso->db_id)
+	if (dso__db_id(dso))
 		return 0;
 
-	dso->db_id = ++dbe->dso_last_db_id;
+	dso__set_db_id(dso, ++dbe->dso_last_db_id);
 
 	if (dbe->export_dso)
 		return dbe->export_dso(dbe, dso, machine);
@@ -184,7 +184,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		err = db_export__dso(dbe, dso, maps__machine(al->maps));
 		if (err)
 			return err;
-		*dso_db_id = dso->db_id;
+		*dso_db_id = dso__db_id(dso);
 
 		if (!al->sym) {
 			al->sym = symbol__new(al->addr, 0, 0, 0, "unknown");
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a1219eb930aa..f488165808d5 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1054,8 +1054,8 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 		char bf[SBUILD_ID_SIZE + 15] = " with build id ";
 		char *build_id_msg = NULL;
 
-		if (dso->has_build_id) {
-			build_id__sprintf(&dso->bid, bf + 15);
+		if (dso__has_build_id(dso)) {
+			build_id__sprintf(dso__bid(dso), bf + 15);
 			build_id_msg = bf;
 		}
 		scnprintf(buf, buflen,
@@ -1077,11 +1077,11 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 		scnprintf(buf, buflen, "Problems while parsing the CPUID in the arch specific initialization.");
 		break;
 	case SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE:
-		scnprintf(buf, buflen, "Invalid BPF file: %s.", dso->long_name);
+		scnprintf(buf, buflen, "Invalid BPF file: %s.", dso__long_name(dso));
 		break;
 	case SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF:
 		scnprintf(buf, buflen, "The %s BPF file has no BTF section, compile with -g or use pahole -J.",
-			  dso->long_name);
+			  dso__long_name(dso));
 		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
@@ -1099,7 +1099,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	char *pos;
 	int len;
 
-	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
+	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
 
@@ -1108,7 +1108,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		__symbol__join_symfs(filename, filename_size, build_id_filename);
 		free(build_id_filename);
 	} else {
-		if (dso->has_build_id)
+		if (dso__has_build_id(dso))
 			return ENOMEM;
 		goto fallback;
 	}
@@ -1142,20 +1142,20 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 * cache, or is just a kallsyms file, well, lets hope that this
 		 * DSO is the same as when 'perf record' ran.
 		 */
-		if (dso->kernel && dso->long_name[0] == '/')
-			snprintf(filename, filename_size, "%s", dso->long_name);
+		if (dso__kernel(dso) && dso__long_name(dso)[0] == '/')
+			snprintf(filename, filename_size, "%s", dso__long_name(dso));
 		else
-			__symbol__join_symfs(filename, filename_size, dso->long_name);
+			__symbol__join_symfs(filename, filename_size, dso__long_name(dso));
 
-		mutex_lock(&dso->lock);
-		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
+		mutex_lock(dso__lock(dso));
+		if (access(filename, R_OK) && errno == ENOENT && dso__nsinfo(dso)) {
 			char *new_name = dso__filename_with_chroot(dso, filename);
 			if (new_name) {
 				strlcpy(filename, new_name, filename_size);
 				free(new_name);
 			}
 		}
-		mutex_unlock(&dso->lock);
+		mutex_unlock(dso__lock(dso));
 	}
 
 	free(build_id_path);
@@ -1423,7 +1423,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		orig_addr = addr + insn->size + op->mem.disp;
 		addr = map__objdump_2mem(map, orig_addr);
 
-		if (map__dso(map)->kernel) {
+		if (dso__kernel(map__dso(map))) {
 			/*
 			 * The kernel maps can be splitted into sections,
 			 * let's find the map first and the search the symbol.
@@ -1477,7 +1477,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(filename, O_RDONLY);
 	nsinfo__mountns_exit(&nsc);
 	if (fd < 0)
@@ -1663,11 +1663,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 map__unmap_ip(map, sym->end));
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
-		 dso, dso->long_name, sym, sym->name);
+		 dso, dso__long_name(dso), sym, sym->name);
 
-	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 		return symbol__disassemble_bpf(sym, args);
-	} else if (dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE) {
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
 		return symbol__disassemble_bpf_image(sym, args);
 	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 908e16813722..7d180bdaedbc 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -33,13 +33,13 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 	if (al->map) {
 		struct dso *dso = map__dso(al->map);
 
-		if (symbol_conf.show_kernel_path && dso->long_name)
-			d_al->dso = dso->long_name;
+		if (symbol_conf.show_kernel_path && dso__long_name(dso))
+			d_al->dso = dso__long_name(dso);
 		else
-			d_al->dso = dso->name;
-		d_al->is_64_bit = dso->is_64_bit;
-		d_al->buildid_size = dso->bid.size;
-		d_al->buildid = dso->bid.data;
+			d_al->dso = dso__name(dso);
+		d_al->is_64_bit = dso__is_64_bit(dso);
+		d_al->buildid_size = dso__bid(dso)->size;
+		d_al->buildid = dso__bid(dso)->data;
 	} else {
 		d_al->dso = NULL;
 		d_al->is_64_bit = 0;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 3caca60a6ce3..27db65e96e04 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -40,6 +40,12 @@ static const char * const debuglink_paths[] = {
 	"/usr/lib/debug%s/%s"
 };
 
+void dso__set_nsinfo(struct dso *dso, struct nsinfo *nsi)
+{
+	nsinfo__put(RC_CHK_ACCESS(dso)->nsinfo);
+	RC_CHK_ACCESS(dso)->nsinfo = nsi;
+}
+
 char dso__symtab_origin(const struct dso *dso)
 {
 	static const char origin[] = {
@@ -63,14 +69,14 @@ char dso__symtab_origin(const struct dso *dso)
 		[DSO_BINARY_TYPE__GUEST_VMLINUX]		= 'V',
 	};
 
-	if (dso == NULL || dso->symtab_type == DSO_BINARY_TYPE__NOT_FOUND)
+	if (dso == NULL || dso__symtab_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
 		return '!';
-	return origin[dso->symtab_type];
+	return origin[dso__symtab_type(dso)];
 }
 
 bool dso__is_object_file(const struct dso *dso)
 {
-	switch (dso->binary_type) {
+	switch (dso__binary_type(dso)) {
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
@@ -117,7 +123,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		char symfile[PATH_MAX];
 		unsigned int i;
 
-		len = __symbol__join_symfs(filename, size, dso->long_name);
+		len = __symbol__join_symfs(filename, size, dso__long_name(dso));
 		last_slash = filename + len;
 		while (last_slash != filename && *last_slash != '/')
 			last_slash--;
@@ -159,12 +165,12 @@ int dso__read_binary_type_filename(const struct dso *dso,
 
 	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
-		snprintf(filename + len, size - len, "%s.debug", dso->long_name);
+		snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
 		break;
 
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
-		snprintf(filename + len, size - len, "%s", dso->long_name);
+		snprintf(filename + len, size - len, "%s", dso__long_name(dso));
 		break;
 
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
@@ -173,13 +179,13 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		 * /usr/lib/debug/lib when it is expected to be in
 		 * /usr/lib/debug/usr/lib
 		 */
-		if (strlen(dso->long_name) < 9 ||
-		    strncmp(dso->long_name, "/usr/lib/", 9)) {
+		if (strlen(dso__long_name(dso)) < 9 ||
+		    strncmp(dso__long_name(dso), "/usr/lib/", 9)) {
 			ret = -1;
 			break;
 		}
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
-		snprintf(filename + len, size - len, "%s", dso->long_name + 4);
+		snprintf(filename + len, size - len, "%s", dso__long_name(dso) + 4);
 		break;
 
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
@@ -187,29 +193,29 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		const char *last_slash;
 		size_t dir_size;
 
-		last_slash = dso->long_name + dso->long_name_len;
-		while (last_slash != dso->long_name && *last_slash != '/')
+		last_slash = dso__long_name(dso) + dso__long_name_len(dso);
+		while (last_slash != dso__long_name(dso) && *last_slash != '/')
 			last_slash--;
 
 		len = __symbol__join_symfs(filename, size, "");
-		dir_size = last_slash - dso->long_name + 2;
+		dir_size = last_slash - dso__long_name(dso) + 2;
 		if (dir_size > (size - len)) {
 			ret = -1;
 			break;
 		}
-		len += scnprintf(filename + len, dir_size, "%s",  dso->long_name);
+		len += scnprintf(filename + len, dir_size, "%s",  dso__long_name(dso));
 		len += scnprintf(filename + len , size - len, ".debug%s",
 								last_slash);
 		break;
 	}
 
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
-		if (!dso->has_build_id) {
+		if (!dso__has_build_id(dso)) {
 			ret = -1;
 			break;
 		}
 
-		build_id__sprintf(&dso->bid, build_id_hex);
+		build_id__sprintf(dso__bid_const(dso), build_id_hex);
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
 		snprintf(filename + len, size - len, "%.2s/%s.debug",
 			 build_id_hex, build_id_hex + 2);
@@ -218,23 +224,23 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__VMLINUX:
 	case DSO_BINARY_TYPE__GUEST_VMLINUX:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
-		__symbol__join_symfs(filename, size, dso->long_name);
+		__symbol__join_symfs(filename, size, dso__long_name(dso));
 		break;
 
 	case DSO_BINARY_TYPE__GUEST_KMODULE:
 	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
 		path__join3(filename, size, symbol_conf.symfs,
-			    root_dir, dso->long_name);
+			    root_dir, dso__long_name(dso));
 		break;
 
 	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
-		__symbol__join_symfs(filename, size, dso->long_name);
+		__symbol__join_symfs(filename, size, dso__long_name(dso));
 		break;
 
 	case DSO_BINARY_TYPE__KCORE:
 	case DSO_BINARY_TYPE__GUEST_KCORE:
-		snprintf(filename, size, "%s", dso->long_name);
+		snprintf(filename, size, "%s", dso__long_name(dso));
 		break;
 
 	default:
@@ -310,8 +316,8 @@ bool is_kernel_module(const char *pathname, int cpumode)
 
 bool dso__needs_decompress(struct dso *dso)
 {
-	return dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+	return dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
+		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 }
 
 int filename__decompress(const char *name, char *pathname,
@@ -363,11 +369,10 @@ static int decompress_kmodule(struct dso *dso, const char *name,
 	if (!dso__needs_decompress(dso))
 		return -1;
 
-	if (dso->comp == COMP_ID__NONE)
+	if (dso__comp(dso) == COMP_ID__NONE)
 		return -1;
 
-	return filename__decompress(name, pathname, len, dso->comp,
-				    &dso->load_errno);
+	return filename__decompress(name, pathname, len, dso__comp(dso), dso__load_errno(dso));
 }
 
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
@@ -468,17 +473,17 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 			  struct machine *machine)
 {
 	if (machine__is_host(machine))
-		dso->symtab_type = DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE;
+		dso__set_symtab_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE);
 	else
-		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KMODULE;
+		dso__set_symtab_type(dso, DSO_BINARY_TYPE__GUEST_KMODULE);
 
 	/* _KMODULE_COMP should be next to _KMODULE */
 	if (m->kmod && m->comp) {
-		dso->symtab_type++;
-		dso->comp = m->comp;
+		dso__set_symtab_type(dso, dso__symtab_type(dso) + 1);
+		dso__set_comp(dso, m->comp);
 	}
 
-	dso->is_kmod = 1;
+	dso__set_is_kmod(dso);
 	dso__set_short_name(dso, strdup(m->name), true);
 }
 
@@ -491,13 +496,15 @@ static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
 
 static void dso__list_add(struct dso *dso)
 {
-	list_add_tail(&dso->data.open_entry, &dso__data_open);
+	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
+	dso__data(dso)->dso = dso__get(dso);
 	dso__data_open_cnt++;
 }
 
 static void dso__list_del(struct dso *dso)
 {
-	list_del_init(&dso->data.open_entry);
+	list_del_init(&dso__data(dso)->open_entry);
+	dso__put(dso__data(dso)->dso);
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
@@ -528,7 +535,7 @@ static int do_open(char *name)
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 {
-	return filename_with_chroot(nsinfo__pid(dso->nsinfo), filename);
+	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
 }
 
 static int __open_dso(struct dso *dso, struct machine *machine)
@@ -541,18 +548,18 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	if (!name)
 		return -ENOMEM;
 
-	mutex_lock(&dso->lock);
+	mutex_lock(dso__lock(dso));
 	if (machine)
 		root_dir = machine->root_dir;
 
-	if (dso__read_binary_type_filename(dso, dso->binary_type,
+	if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
 					    root_dir, name, PATH_MAX))
 		goto out;
 
 	if (!is_regular_file(name)) {
 		char *new_name;
 
-		if (errno != ENOENT || dso->nsinfo == NULL)
+		if (errno != ENOENT || dso__nsinfo(dso) == NULL)
 			goto out;
 
 		new_name = dso__filename_with_chroot(dso, name);
@@ -568,7 +575,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		size_t len = sizeof(newpath);
 
 		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
-			fd = -dso->load_errno;
+			fd = -(*dso__load_errno(dso));
 			goto out;
 		}
 
@@ -582,7 +589,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		unlink(name);
 
 out:
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 	free(name);
 	return fd;
 }
@@ -601,13 +608,13 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	int fd;
 	struct nscookie nsc;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
-		mutex_lock(&dso->lock);
-		nsinfo__mountns_enter(dso->nsinfo, &nsc);
-		mutex_unlock(&dso->lock);
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+		mutex_lock(dso__lock(dso));
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		mutex_unlock(dso__lock(dso));
 	}
 	fd = __open_dso(dso, machine);
-	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE)
 		nsinfo__mountns_exit(&nsc);
 
 	if (fd >= 0) {
@@ -624,10 +631,10 @@ static int open_dso(struct dso *dso, struct machine *machine)
 
 static void close_data_fd(struct dso *dso)
 {
-	if (dso->data.fd >= 0) {
-		close(dso->data.fd);
-		dso->data.fd = -1;
-		dso->data.file_size = 0;
+	if (dso__data(dso)->fd >= 0) {
+		close(dso__data(dso)->fd);
+		dso__data(dso)->fd = -1;
+		dso__data(dso)->file_size = 0;
 		dso__list_del(dso);
 	}
 }
@@ -646,10 +653,10 @@ static void close_dso(struct dso *dso)
 
 static void close_first_dso(void)
 {
-	struct dso *dso;
+	struct dso_data *dso_data;
 
-	dso = list_first_entry(&dso__data_open, struct dso, data.open_entry);
-	close_dso(dso);
+	dso_data = list_first_entry(&dso__data_open, struct dso_data, open_entry);
+	close_dso(dso_data->dso);
 }
 
 static rlim_t get_fd_limit(void)
@@ -728,28 +735,29 @@ static void try_to_open_dso(struct dso *dso, struct machine *machine)
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	int i = 0;
+	struct dso_data *dso_data = dso__data(dso);
 
-	if (dso->data.fd >= 0)
+	if (dso_data->fd >= 0)
 		return;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__NOT_FOUND) {
-		dso->data.fd = open_dso(dso, machine);
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__NOT_FOUND) {
+		dso_data->fd = open_dso(dso, machine);
 		goto out;
 	}
 
 	do {
-		dso->binary_type = binary_type_data[i++];
+		dso__set_binary_type(dso, binary_type_data[i++]);
 
-		dso->data.fd = open_dso(dso, machine);
-		if (dso->data.fd >= 0)
+		dso_data->fd = open_dso(dso, machine);
+		if (dso_data->fd >= 0)
 			goto out;
 
-	} while (dso->binary_type != DSO_BINARY_TYPE__NOT_FOUND);
+	} while (dso__binary_type(dso) != DSO_BINARY_TYPE__NOT_FOUND);
 out:
-	if (dso->data.fd >= 0)
-		dso->data.status = DSO_DATA_STATUS_OK;
+	if (dso_data->fd >= 0)
+		dso_data->status = DSO_DATA_STATUS_OK;
 	else
-		dso->data.status = DSO_DATA_STATUS_ERROR;
+		dso_data->status = DSO_DATA_STATUS_ERROR;
 }
 
 /**
@@ -763,7 +771,7 @@ static void try_to_open_dso(struct dso *dso, struct machine *machine)
  */
 int dso__data_get_fd(struct dso *dso, struct machine *machine)
 {
-	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
 	if (pthread_mutex_lock(&dso__data_open_lock) < 0)
@@ -771,10 +779,10 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine)
 
 	try_to_open_dso(dso, machine);
 
-	if (dso->data.fd < 0)
+	if (dso__data(dso)->fd < 0)
 		pthread_mutex_unlock(&dso__data_open_lock);
 
-	return dso->data.fd;
+	return dso__data(dso)->fd;
 }
 
 void dso__data_put_fd(struct dso *dso __maybe_unused)
@@ -786,10 +794,10 @@ bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
 {
 	u32 flag = 1 << by;
 
-	if (dso->data.status_seen & flag)
+	if (dso__data(dso)->status_seen & flag)
 		return true;
 
-	dso->data.status_seen |= flag;
+	dso__data(dso)->status_seen |= flag;
 
 	return false;
 }
@@ -799,12 +807,13 @@ static ssize_t bpf_read(struct dso *dso, u64 offset, char *data)
 {
 	struct bpf_prog_info_node *node;
 	ssize_t size = DSO__DATA_CACHE_SIZE;
+	struct dso_bpf_prog *dso_bpf_prog = dso__bpf_prog(dso);
 	u64 len;
 	u8 *buf;
 
-	node = perf_env__find_bpf_prog_info(dso->bpf_prog.env, dso->bpf_prog.id);
+	node = perf_env__find_bpf_prog_info(dso_bpf_prog->env, dso_bpf_prog->id);
 	if (!node || !node->info_linear) {
-		dso->data.status = DSO_DATA_STATUS_ERROR;
+		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
 		return -1;
 	}
 
@@ -822,14 +831,15 @@ static ssize_t bpf_read(struct dso *dso, u64 offset, char *data)
 static int bpf_size(struct dso *dso)
 {
 	struct bpf_prog_info_node *node;
+	struct dso_bpf_prog *dso_bpf_prog = dso__bpf_prog(dso);
 
-	node = perf_env__find_bpf_prog_info(dso->bpf_prog.env, dso->bpf_prog.id);
+	node = perf_env__find_bpf_prog_info(dso_bpf_prog->env, dso_bpf_prog->id);
 	if (!node || !node->info_linear) {
-		dso->data.status = DSO_DATA_STATUS_ERROR;
+		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
 		return -1;
 	}
 
-	dso->data.file_size = node->info_linear->info.jited_prog_len;
+	dso__data(dso)->file_size = node->info_linear->info.jited_prog_len;
 	return 0;
 }
 #endif // HAVE_LIBBPF_SUPPORT
@@ -837,10 +847,10 @@ static int bpf_size(struct dso *dso)
 static void
 dso_cache__free(struct dso *dso)
 {
-	struct rb_root *root = &dso->data.cache;
+	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node *next = rb_first(root);
 
-	mutex_lock(&dso->lock);
+	mutex_lock(dso__lock(dso));
 	while (next) {
 		struct dso_cache *cache;
 
@@ -849,12 +859,12 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 }
 
 static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
 {
-	const struct rb_root *root = &dso->data.cache;
+	const struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node * const *p = &root->rb_node;
 	const struct rb_node *parent = NULL;
 	struct dso_cache *cache;
@@ -880,13 +890,13 @@ static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
 static struct dso_cache *
 dso_cache__insert(struct dso *dso, struct dso_cache *new)
 {
-	struct rb_root *root = &dso->data.cache;
+	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	mutex_lock(&dso->lock);
+	mutex_lock(dso__lock(dso));
 	while (*p != NULL) {
 		u64 end;
 
@@ -907,7 +917,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 
 	cache = NULL;
 out:
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 	return cache;
 }
 
@@ -932,18 +942,18 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 	pthread_mutex_lock(&dso__data_open_lock);
 
 	/*
-	 * dso->data.fd might be closed if other thread opened another
+	 * dso__data(dso)->fd might be closed if other thread opened another
 	 * file (dso) due to open file limit (RLIMIT_NOFILE).
 	 */
 	try_to_open_dso(dso, machine);
 
-	if (dso->data.fd < 0) {
-		dso->data.status = DSO_DATA_STATUS_ERROR;
+	if (dso__data(dso)->fd < 0) {
+		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
 		ret = -errno;
 		goto out;
 	}
 
-	ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
+	ret = pread(dso__data(dso)->fd, data, DSO__DATA_CACHE_SIZE, offset);
 out:
 	pthread_mutex_unlock(&dso__data_open_lock);
 	return ret;
@@ -963,11 +973,11 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 		return NULL;
 	}
 #ifdef HAVE_LIBBPF_SUPPORT
-	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		*ret = bpf_read(dso, cache_offset, cache->data);
 	else
 #endif
-	if (dso->binary_type == DSO_BINARY_TYPE__OOL)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__OOL)
 		*ret = DSO__DATA_CACHE_SIZE;
 	else
 		*ret = file_read(dso, machine, cache_offset, cache->data);
@@ -1056,25 +1066,25 @@ static int file_size(struct dso *dso, struct machine *machine)
 	pthread_mutex_lock(&dso__data_open_lock);
 
 	/*
-	 * dso->data.fd might be closed if other thread opened another
+	 * dso__data(dso)->fd might be closed if other thread opened another
 	 * file (dso) due to open file limit (RLIMIT_NOFILE).
 	 */
 	try_to_open_dso(dso, machine);
 
-	if (dso->data.fd < 0) {
+	if (dso__data(dso)->fd < 0) {
 		ret = -errno;
-		dso->data.status = DSO_DATA_STATUS_ERROR;
+		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
 		goto out;
 	}
 
-	if (fstat(dso->data.fd, &st) < 0) {
+	if (fstat(dso__data(dso)->fd, &st) < 0) {
 		ret = -errno;
 		pr_err("dso cache fstat failed: %s\n",
 		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		dso->data.status = DSO_DATA_STATUS_ERROR;
+		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
 		goto out;
 	}
-	dso->data.file_size = st.st_size;
+	dso__data(dso)->file_size = st.st_size;
 
 out:
 	pthread_mutex_unlock(&dso__data_open_lock);
@@ -1083,13 +1093,13 @@ static int file_size(struct dso *dso, struct machine *machine)
 
 int dso__data_file_size(struct dso *dso, struct machine *machine)
 {
-	if (dso->data.file_size)
+	if (dso__data(dso)->file_size)
 		return 0;
 
-	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return -1;
 #ifdef HAVE_LIBBPF_SUPPORT
-	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return bpf_size(dso);
 #endif
 	return file_size(dso, machine);
@@ -1108,7 +1118,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 		return -1;
 
 	/* For now just estimate dso data size is close to file size */
-	return dso->data.file_size;
+	return dso__data(dso)->file_size;
 }
 
 static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
@@ -1119,7 +1129,7 @@ static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
 		return -1;
 
 	/* Check the offset sanity. */
-	if (offset > dso->data.file_size)
+	if (offset > dso__data(dso)->file_size)
 		return -1;
 
 	if (offset + size < offset)
@@ -1142,7 +1152,7 @@ static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size)
 {
-	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
 	return data_read_write_offset(dso, machine, offset, data, size, true);
@@ -1182,7 +1192,7 @@ ssize_t dso__data_write_cache_offs(struct dso *dso, struct machine *machine,
 {
 	u8 *data = (u8 *)data_in; /* cast away const to use same fns for r/w */
 
-	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
 	return data_read_write_offset(dso, machine, offset, data, size, false);
@@ -1235,7 +1245,7 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 	 */
 	if (dso != NULL) {
 		dso__set_short_name(dso, short_name, false);
-		dso->kernel = dso_type;
+		dso__set_kernel(dso, dso_type);
 	}
 
 	return dso;
@@ -1243,7 +1253,7 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 
 static void dso__set_long_name_id(struct dso *dso, const char *name, bool name_allocated)
 {
-	struct dsos *dsos = dso->dsos;
+	struct dsos *dsos = dso__dsos(dso);
 
 	if (name == NULL)
 		return;
@@ -1256,12 +1266,12 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, bool name_a
 		down_write(&dsos->lock);
 	}
 
-	if (dso->long_name_allocated)
-		free((char *)dso->long_name);
+	if (dso__long_name_allocated(dso))
+		free((char *)dso__long_name(dso));
 
-	dso->long_name		 = name;
-	dso->long_name_len	 = strlen(name);
-	dso->long_name_allocated = name_allocated;
+	RC_CHK_ACCESS(dso)->long_name = name;
+	RC_CHK_ACCESS(dso)->long_name_len = strlen(name);
+	dso__set_long_name_allocated(dso, name_allocated);
 
 	if (dsos) {
 		dsos->sorted = false;
@@ -1307,14 +1317,15 @@ bool dso_id__empty(const struct dso_id *id)
 
 void __dso__inject_id(struct dso *dso, struct dso_id *id)
 {
-	struct dsos *dsos = dso->dsos;
+	struct dsos *dsos = dso__dsos(dso);
+	struct dso_id *dso_id = dso__id(dso);
 
 	/* dsos write lock held by caller. */
 
-	dso->id.maj = id->maj;
-	dso->id.min = id->min;
-	dso->id.ino = id->ino;
-	dso->id.ino_generation = id->ino_generation;
+	dso_id->maj = id->maj;
+	dso_id->min = id->min;
+	dso_id->ino = id->ino;
+	dso_id->ino_generation = id->ino_generation;
 
 	if (dsos)
 		dsos->sorted = false;
@@ -1334,7 +1345,7 @@ int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 
 int dso__cmp_id(struct dso *a, struct dso *b)
 {
-	return __dso_id__cmp(&a->id, &b->id);
+	return __dso_id__cmp(dso__id(a), dso__id(b));
 }
 
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
@@ -1344,7 +1355,7 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 {
-	struct dsos *dsos = dso->dsos;
+	struct dsos *dsos = dso__dsos(dso);
 
 	if (name == NULL)
 		return;
@@ -1356,12 +1367,12 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 		 */
 		down_write(&dsos->lock);
 	}
-	if (dso->short_name_allocated)
-		free((char *)dso->short_name);
+	if (dso__short_name_allocated(dso))
+		free((char *)dso__short_name(dso));
 
-	dso->short_name		  = name;
-	dso->short_name_len	  = strlen(name);
-	dso->short_name_allocated = name_allocated;
+	RC_CHK_ACCESS(dso)->short_name		  = name;
+	RC_CHK_ACCESS(dso)->short_name_len	  = strlen(name);
+	dso__set_short_name_allocated(dso, name_allocated);
 
 	if (dsos) {
 		dsos->sorted = false;
@@ -1374,40 +1385,44 @@ int dso__name_len(const struct dso *dso)
 	if (!dso)
 		return strlen("[unknown]");
 	if (verbose > 0)
-		return dso->long_name_len;
+		return dso__long_name_len(dso);
 
-	return dso->short_name_len;
+	return dso__short_name_len(dso);
 }
 
 bool dso__loaded(const struct dso *dso)
 {
-	return dso->loaded;
+	return RC_CHK_ACCESS(dso)->loaded;
 }
 
 bool dso__sorted_by_name(const struct dso *dso)
 {
-	return dso->sorted_by_name;
+	return RC_CHK_ACCESS(dso)->sorted_by_name;
 }
 
 void dso__set_sorted_by_name(struct dso *dso)
 {
-	dso->sorted_by_name = true;
+	RC_CHK_ACCESS(dso)->sorted_by_name = true;
 }
 
 struct dso *dso__new_id(const char *name, struct dso_id *id)
 {
-	struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
+	RC_STRUCT(dso) *dso = zalloc(sizeof(*dso) + strlen(name) + 1);
+	struct dso *res;
+	struct dso_data *data;
 
-	if (dso != NULL) {
+	if (!dso)
+		return NULL;
+
+	if (ADD_RC_CHK(res, dso)) {
 		strcpy(dso->name, name);
 		if (id)
 			dso->id = *id;
-		dso__set_long_name_id(dso, dso->name, false);
-		dso__set_short_name(dso, dso->name, false);
+		dso__set_long_name_id(res, dso->name, false);
+		dso__set_short_name(res, dso->name, false);
 		dso->symbols = RB_ROOT_CACHED;
 		dso->symbol_names = NULL;
 		dso->symbol_names_len = 0;
-		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
@@ -1427,12 +1442,16 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->is_kmod = 0;
 		dso->needs_swap = DSO_SWAP__UNSET;
 		dso->comp = COMP_ID__NONE;
-		INIT_LIST_HEAD(&dso->data.open_entry);
 		mutex_init(&dso->lock);
 		refcount_set(&dso->refcnt, 1);
+		data = &dso->data;
+		data->cache = RB_ROOT;
+		data->fd = -1;
+		data->status = DSO_DATA_STATUS_UNKNOWN;
+		INIT_LIST_HEAD(&data->open_entry);
+		data->dso = NULL; /* Set when on the open_entry list. */
 	}
-
-	return dso;
+	return res;
 }
 
 struct dso *dso__new(const char *name)
@@ -1442,71 +1461,78 @@ struct dso *dso__new(const char *name)
 
 void dso__delete(struct dso *dso)
 {
-	if (dso->dsos)
-		pr_err("DSO %s is still in rbtree when being deleted!\n", dso->long_name);
+	if (dso__dsos(dso))
+		pr_err("DSO %s is still in rbtree when being deleted!\n", dso__long_name(dso));
 
 	/* free inlines first, as they reference symbols */
-	inlines__tree_delete(&dso->inlined_nodes);
-	srcline__tree_delete(&dso->srclines);
-	symbols__delete(&dso->symbols);
-	dso->symbol_names_len = 0;
-	zfree(&dso->symbol_names);
-	annotated_data_type__tree_delete(&dso->data_types);
-	global_var_type__tree_delete(&dso->global_vars);
-
-	if (dso->short_name_allocated) {
-		zfree((char **)&dso->short_name);
-		dso->short_name_allocated = false;
+	inlines__tree_delete(&RC_CHK_ACCESS(dso)->inlined_nodes);
+	srcline__tree_delete(&RC_CHK_ACCESS(dso)->srclines);
+	symbols__delete(&RC_CHK_ACCESS(dso)->symbols);
+	RC_CHK_ACCESS(dso)->symbol_names_len = 0;
+	zfree(&RC_CHK_ACCESS(dso)->symbol_names);
+	annotated_data_type__tree_delete(dso__data_types(dso));
+	global_var_type__tree_delete(dso__global_vars(dso));
+
+	if (RC_CHK_ACCESS(dso)->short_name_allocated) {
+		zfree((char **)&RC_CHK_ACCESS(dso)->short_name);
+		RC_CHK_ACCESS(dso)->short_name_allocated = false;
 	}
 
-	if (dso->long_name_allocated) {
-		zfree((char **)&dso->long_name);
-		dso->long_name_allocated = false;
+	if (RC_CHK_ACCESS(dso)->long_name_allocated) {
+		zfree((char **)&RC_CHK_ACCESS(dso)->long_name);
+		RC_CHK_ACCESS(dso)->long_name_allocated = false;
 	}
 
 	dso__data_close(dso);
-	auxtrace_cache__free(dso->auxtrace_cache);
+	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
-	zfree(&dso->symsrc_filename);
-	nsinfo__zput(dso->nsinfo);
-	mutex_destroy(&dso->lock);
-	free(dso);
+	zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
+	nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
+	mutex_destroy(dso__lock(dso));
+	RC_CHK_FREE(dso);
 }
 
 struct dso *dso__get(struct dso *dso)
 {
-	if (dso)
-		refcount_inc(&dso->refcnt);
-	return dso;
+	struct dso *result;
+
+	if (RC_CHK_GET(result, dso))
+		refcount_inc(&RC_CHK_ACCESS(dso)->refcnt);
+
+	return result;
 }
 
 void dso__put(struct dso *dso)
 {
-	if (dso && refcount_dec_and_test(&dso->refcnt))
+	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
 		dso__delete(dso);
+	else
+		RC_CHK_PUT(dso);
 }
 
 void dso__set_build_id(struct dso *dso, struct build_id *bid)
 {
-	dso->bid = *bid;
-	dso->has_build_id = 1;
+	RC_CHK_ACCESS(dso)->bid = *bid;
+	RC_CHK_ACCESS(dso)->has_build_id = 1;
 }
 
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
 {
-	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
+	const struct build_id *dso_bid = dso__bid_const(dso);
+
+	if (dso_bid->size > bid->size && dso_bid->size == BUILD_ID_SIZE) {
 		/*
 		 * For the backward compatibility, it allows a build-id has
 		 * trailing zeros.
 		 */
-		return !memcmp(dso->bid.data, bid->data, bid->size) &&
-			!memchr_inv(&dso->bid.data[bid->size], 0,
-				    dso->bid.size - bid->size);
+		return !memcmp(dso_bid->data, bid->data, bid->size) &&
+			!memchr_inv(&dso_bid->data[bid->size], 0,
+				    dso_bid->size - bid->size);
 	}
 
-	return dso->bid.size == bid->size &&
-	       memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
+	return dso_bid->size == bid->size &&
+	       memcmp(dso_bid->data, bid->data, dso_bid->size) == 0;
 }
 
 void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
@@ -1516,8 +1542,8 @@ void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
 	if (machine__is_default_guest(machine))
 		return;
 	sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
-	if (sysfs__read_build_id(path, &dso->bid) == 0)
-		dso->has_build_id = true;
+	if (sysfs__read_build_id(path, dso__bid(dso)) == 0)
+		dso__set_has_build_id(dso);
 }
 
 int dso__kernel_module_get_build_id(struct dso *dso,
@@ -1528,14 +1554,14 @@ int dso__kernel_module_get_build_id(struct dso *dso,
 	 * kernel module short names are of the form "[module]" and
 	 * we need just "module" here.
 	 */
-	const char *name = dso->short_name + 1;
+	const char *name = dso__short_name(dso) + 1;
 
 	snprintf(filename, sizeof(filename),
 		 "%s/sys/module/%.*s/notes/.note.gnu.build-id",
 		 root_dir, (int)strlen(name) - 1, name);
 
-	if (sysfs__read_build_id(filename, &dso->bid) == 0)
-		dso->has_build_id = true;
+	if (sysfs__read_build_id(filename, dso__bid(dso)) == 0)
+		dso__set_has_build_id(dso);
 
 	return 0;
 }
@@ -1544,21 +1570,21 @@ static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
-	build_id__sprintf(&dso->bid, sbuild_id);
+	build_id__sprintf(dso__bid(dso), sbuild_id);
 	return fprintf(fp, "%s", sbuild_id);
 }
 
 size_t dso__fprintf(struct dso *dso, FILE *fp)
 {
 	struct rb_node *nd;
-	size_t ret = fprintf(fp, "dso: %s (", dso->short_name);
+	size_t ret = fprintf(fp, "dso: %s (", dso__short_name(dso));
 
-	if (dso->short_name != dso->long_name)
-		ret += fprintf(fp, "%s, ", dso->long_name);
+	if (dso__short_name(dso) != dso__long_name(dso))
+		ret += fprintf(fp, "%s, ", dso__long_name(dso));
 	ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
 	ret += dso__fprintf_buildid(dso, fp);
 	ret += fprintf(fp, ")\n");
-	for (nd = rb_first_cached(&dso->symbols); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
 		ret += symbol__fprintf(pos, fp);
 	}
@@ -1582,7 +1608,7 @@ enum dso_type dso__type(struct dso *dso, struct machine *machine)
 
 int dso__strerror_load(struct dso *dso, char *buf, size_t buflen)
 {
-	int idx, errnum = dso->load_errno;
+	int idx, errnum = *dso__load_errno(dso);
 	/*
 	 * This must have a same ordering as the enum dso_load_errno.
 	 */
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index b22dec8b3f3a..f9689dd60de3 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include "build-id.h"
 #include "mutex.h"
+#include <internal/rc_check.h>
 
 struct machine;
 struct map;
@@ -100,26 +101,27 @@ enum dso_load_errno {
 	__DSO_LOAD_ERRNO__END,
 };
 
-#define DSO__SWAP(dso, type, val)			\
-({							\
-	type ____r = val;				\
-	BUG_ON(dso->needs_swap == DSO_SWAP__UNSET);	\
-	if (dso->needs_swap == DSO_SWAP__YES) {		\
-		switch (sizeof(____r)) {		\
-		case 2:					\
-			____r = bswap_16(val);		\
-			break;				\
-		case 4:					\
-			____r = bswap_32(val);		\
-			break;				\
-		case 8:					\
-			____r = bswap_64(val);		\
-			break;				\
-		default:				\
-			BUG_ON(1);			\
-		}					\
-	}						\
-	____r;						\
+#define DSO__SWAP(dso, type, val)				\
+({								\
+	type ____r = val;					\
+	enum dso_swap_type ___dst = dso__needs_swap(dso);	\
+	BUG_ON(___dst == DSO_SWAP__UNSET);			\
+	if (___dst == DSO_SWAP__YES) {				\
+		switch (sizeof(____r)) {			\
+		case 2:						\
+			____r = bswap_16(val);			\
+			break;					\
+		case 4:						\
+			____r = bswap_32(val);			\
+			break;					\
+		case 8:						\
+			____r = bswap_64(val);			\
+			break;					\
+		default:					\
+			BUG_ON(1);				\
+		}						\
+	}							\
+	____r;							\
 })
 
 #define DSO__DATA_CACHE_SIZE 4096
@@ -142,9 +144,29 @@ struct dso_cache {
 	char data[];
 };
 
+struct dso_data {
+	struct rb_root	 cache;
+	struct list_head open_entry;
+	struct dso	 *dso;
+	int		 fd;
+	int		 status;
+	u32		 status_seen;
+	u64		 file_size;
+	u64		 elf_base_addr;
+	u64		 debug_frame_offset;
+	u64		 eh_frame_hdr_addr;
+	u64		 eh_frame_hdr_offset;
+};
+
+struct dso_bpf_prog {
+	u32		id;
+	u32		sub_id;
+	struct perf_env	*env;
+};
+
 struct auxtrace_cache;
 
-struct dso {
+DECLARE_RC_STRUCT(dso) {
 	struct mutex	 lock;
 	struct dsos	 *dsos;
 	struct rb_root_cached symbols;
@@ -176,24 +198,9 @@ struct dso {
 		u64	 db_id;
 	};
 	/* bpf prog information */
-	struct {
-		struct perf_env	*env;
-		u32		id;
-		u32		sub_id;
-	} bpf_prog;
+	struct dso_bpf_prog bpf_prog;
 	/* dso data file */
-	struct {
-		struct rb_root	 cache;
-		struct list_head open_entry;
-		u64		 file_size;
-		u64		 elf_base_addr;
-		u64		 debug_frame_offset;
-		u64		 eh_frame_hdr_addr;
-		u64		 eh_frame_hdr_offset;
-		int		 fd;
-		int		 status;
-		u32		 status_seen;
-	} data;
+	struct dso_data	 data;
 	struct dso_id	 id;
 	unsigned int	 a2l_fails;
 	int		 comp;
@@ -229,11 +236,388 @@ struct dso {
  * @n: the 'struct rb_node *' to use as a temporary storage
  */
 #define dso__for_each_symbol(dso, pos, n)	\
-	symbols__for_each_entry(&(dso)->symbols, pos, n)
+	symbols__for_each_entry(dso__symbols(dso), pos, n)
+
+static inline void *dso__a2l(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->a2l;
+}
+
+static inline void dso__set_a2l(struct dso *dso, void *val)
+{
+	RC_CHK_ACCESS(dso)->a2l = val;
+}
+
+static inline unsigned int dso__a2l_fails(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->a2l_fails;
+}
+
+static inline void dso__set_a2l_fails(struct dso *dso, unsigned int val)
+{
+	RC_CHK_ACCESS(dso)->a2l_fails = val;
+}
+
+static inline bool dso__adjust_symbols(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->adjust_symbols;
+}
+
+static inline void dso__set_adjust_symbols(struct dso *dso, bool val)
+{
+	RC_CHK_ACCESS(dso)->adjust_symbols = val;
+}
+
+static inline bool dso__annotate_warned(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->annotate_warned;
+}
+
+static inline void dso__set_annotate_warned(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->annotate_warned = 1;
+}
+
+static inline struct auxtrace_cache *dso__auxtrace_cache(struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->auxtrace_cache;
+}
+
+static inline void dso__set_auxtrace_cache(struct dso *dso, struct auxtrace_cache *cache)
+{
+	RC_CHK_ACCESS(dso)->auxtrace_cache = cache;
+}
+
+static inline struct build_id *dso__bid(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->bid;
+}
+
+static inline const struct build_id *dso__bid_const(const struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->bid;
+}
+
+static inline struct dso_bpf_prog *dso__bpf_prog(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->bpf_prog;
+}
+
+static inline bool dso__has_build_id(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->has_build_id;
+}
+
+static inline void dso__set_has_build_id(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->has_build_id = true;
+}
+
+static inline bool dso__has_srcline(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->has_srcline;
+}
+
+static inline void dso__set_has_srcline(struct dso *dso, bool val)
+{
+	RC_CHK_ACCESS(dso)->has_srcline = val;
+}
+
+static inline int dso__comp(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->comp;
+}
+
+static inline void dso__set_comp(struct dso *dso, int comp)
+{
+	RC_CHK_ACCESS(dso)->comp = comp;
+}
+
+static inline struct dso_data *dso__data(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->data;
+}
+
+static inline u64 dso__db_id(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->db_id;
+}
+
+static inline void dso__set_db_id(struct dso *dso, u64 db_id)
+{
+	RC_CHK_ACCESS(dso)->db_id = db_id;
+}
+
+static inline struct dsos *dso__dsos(struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->dsos;
+}
+
+static inline void dso__set_dsos(struct dso *dso, struct dsos *dsos)
+{
+	RC_CHK_ACCESS(dso)->dsos = dsos;
+}
+
+static inline bool dso__header_build_id(struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->header_build_id;
+}
+
+static inline void dso__set_header_build_id(struct dso *dso, bool val)
+{
+	RC_CHK_ACCESS(dso)->header_build_id = val;
+}
+
+static inline bool dso__hit(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->hit;
+}
+
+static inline void dso__set_hit(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->hit = 1;
+}
+
+static inline struct dso_id *dso__id(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->id;
+}
+
+static inline const struct dso_id *dso__id_const(const struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->id;
+}
+
+static inline struct rb_root_cached *dso__inlined_nodes(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->inlined_nodes;
+}
+
+static inline bool dso__is_64_bit(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->is_64_bit;
+}
+
+static inline void dso__set_is_64_bit(struct dso *dso, bool is)
+{
+	RC_CHK_ACCESS(dso)->is_64_bit = is;
+}
+
+static inline bool dso__is_kmod(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->is_kmod;
+}
+
+static inline void dso__set_is_kmod(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->is_kmod = 1;
+}
+
+static inline enum dso_space_type dso__kernel(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->kernel;
+}
+
+static inline void dso__set_kernel(struct dso *dso, enum dso_space_type kernel)
+{
+	RC_CHK_ACCESS(dso)->kernel = kernel;
+}
+
+static inline u64 dso__last_find_result_addr(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->last_find_result.addr;
+}
+
+static inline void dso__set_last_find_result_addr(struct dso *dso, u64 addr)
+{
+	RC_CHK_ACCESS(dso)->last_find_result.addr = addr;
+}
+
+static inline struct symbol *dso__last_find_result_symbol(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->last_find_result.symbol;
+}
+
+static inline void dso__set_last_find_result_symbol(struct dso *dso, struct symbol *symbol)
+{
+	RC_CHK_ACCESS(dso)->last_find_result.symbol = symbol;
+}
+
+static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->load_errno;
+}
 
 static inline void dso__set_loaded(struct dso *dso)
 {
-	dso->loaded = true;
+	RC_CHK_ACCESS(dso)->loaded = true;
+}
+
+static inline struct mutex *dso__lock(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->lock;
+}
+
+static inline const char *dso__long_name(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->long_name;
+}
+
+static inline bool dso__long_name_allocated(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->long_name_allocated;
+}
+
+static inline void dso__set_long_name_allocated(struct dso *dso, bool allocated)
+{
+	RC_CHK_ACCESS(dso)->long_name_allocated = allocated;
+}
+
+static inline u16 dso__long_name_len(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->long_name_len;
+}
+
+static inline const char *dso__name(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->name;
+}
+
+static inline enum dso_swap_type dso__needs_swap(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->needs_swap;
+}
+
+static inline void dso__set_needs_swap(struct dso *dso, enum dso_swap_type type)
+{
+	RC_CHK_ACCESS(dso)->needs_swap = type;
+}
+
+static inline struct nsinfo *dso__nsinfo(struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->nsinfo;
+}
+
+static inline const struct nsinfo *dso__nsinfo_const(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->nsinfo;
+}
+
+static inline struct nsinfo **dso__nsinfo_ptr(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->nsinfo;
+}
+
+void dso__set_nsinfo(struct dso *dso, struct nsinfo *nsi);
+
+static inline u8 dso__rel(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->rel;
+}
+
+static inline void dso__set_rel(struct dso *dso, u8 rel)
+{
+	RC_CHK_ACCESS(dso)->rel = rel;
+}
+
+static inline const char *dso__short_name(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->short_name;
+}
+
+static inline bool dso__short_name_allocated(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->short_name_allocated;
+}
+
+static inline void dso__set_short_name_allocated(struct dso *dso, bool allocated)
+{
+	RC_CHK_ACCESS(dso)->short_name_allocated = allocated;
+}
+
+static inline u16 dso__short_name_len(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->short_name_len;
+}
+
+static inline struct rb_root_cached *dso__srclines(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->srclines;
+}
+
+static inline struct rb_root *dso__data_types(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->data_types;
+}
+
+static inline struct rb_root *dso__global_vars(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->global_vars;
+}
+
+static inline struct rb_root_cached *dso__symbols(struct dso *dso)
+{
+	return &RC_CHK_ACCESS(dso)->symbols;
+}
+
+static inline struct symbol **dso__symbol_names(struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->symbol_names;
+}
+
+static inline void dso__set_symbol_names(struct dso *dso, struct symbol **names)
+{
+	RC_CHK_ACCESS(dso)->symbol_names = names;
+}
+
+static inline size_t dso__symbol_names_len(struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->symbol_names_len;
+}
+
+static inline void dso__set_symbol_names_len(struct dso *dso, size_t len)
+{
+	RC_CHK_ACCESS(dso)->symbol_names_len = len;
+}
+
+static inline const char *dso__symsrc_filename(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->symsrc_filename;
+}
+
+static inline void dso__set_symsrc_filename(struct dso *dso, char *val)
+{
+	RC_CHK_ACCESS(dso)->symsrc_filename = val;
+}
+
+static inline enum dso_binary_type dso__symtab_type(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->symtab_type;
+}
+
+static inline void dso__set_symtab_type(struct dso *dso, enum dso_binary_type bt)
+{
+	RC_CHK_ACCESS(dso)->symtab_type = bt;
+}
+
+static inline u64 dso__text_end(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->text_end;
+}
+
+static inline void dso__set_text_end(struct dso *dso, u64 val)
+{
+	RC_CHK_ACCESS(dso)->text_end = val;
+}
+
+static inline u64 dso__text_offset(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->text_offset;
+}
+
+static inline void dso__set_text_offset(struct dso *dso, u64 val)
+{
+	RC_CHK_ACCESS(dso)->text_offset = val;
 }
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
@@ -265,7 +649,7 @@ bool dso__loaded(const struct dso *dso);
 
 static inline bool dso__has_symbols(const struct dso *dso)
 {
-	return !RB_EMPTY_ROOT(&dso->symbols.rb_root);
+	return !RB_EMPTY_ROOT(&RC_CHK_ACCESS(dso)->symbols.rb_root);
 }
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
@@ -381,21 +765,33 @@ void dso__reset_find_symbol_cache(struct dso *dso);
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
+static inline enum dso_binary_type dso__binary_type(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->binary_type;
+}
+
+static inline void dso__set_binary_type(struct dso *dso, enum dso_binary_type bt)
+{
+	RC_CHK_ACCESS(dso)->binary_type = bt;
+}
+
 static inline bool dso__is_vmlinux(const struct dso *dso)
 {
-	return dso->binary_type == DSO_BINARY_TYPE__VMLINUX ||
-	       dso->binary_type == DSO_BINARY_TYPE__GUEST_VMLINUX;
+	enum dso_binary_type bt = dso__binary_type(dso);
+
+	return bt == DSO_BINARY_TYPE__VMLINUX || bt == DSO_BINARY_TYPE__GUEST_VMLINUX;
 }
 
 static inline bool dso__is_kcore(const struct dso *dso)
 {
-	return dso->binary_type == DSO_BINARY_TYPE__KCORE ||
-	       dso->binary_type == DSO_BINARY_TYPE__GUEST_KCORE;
+	enum dso_binary_type bt = dso__binary_type(dso);
+
+	return bt == DSO_BINARY_TYPE__KCORE || bt == DSO_BINARY_TYPE__GUEST_KCORE;
 }
 
 static inline bool dso__is_kallsyms(const struct dso *dso)
 {
-	return dso->kernel && dso->long_name[0] != '/';
+	return RC_CHK_ACCESS(dso)->kernel && RC_CHK_ACCESS(dso)->long_name[0] != '/';
 }
 
 bool dso__is_object_file(const struct dso *dso);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 23c3fe4f2abb..ab3d0c01dd63 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -29,8 +29,8 @@ static void dsos__purge(struct dsos *dsos)
 	for (unsigned int i = 0; i < dsos->cnt; i++) {
 		struct dso *dso = dsos->dsos[i];
 
+		dso__set_dsos(dso, NULL);
 		dso__put(dso);
-		dso->dsos = NULL;
 	}
 
 	zfree(&dsos->dsos);
@@ -73,22 +73,22 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 	struct dsos__read_build_ids_cb_args *args = data;
 	struct nscookie nsc;
 
-	if (args->with_hits && !dso->hit && !dso__is_vdso(dso))
+	if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
 		return 0;
-	if (dso->has_build_id) {
+	if (dso__has_build_id(dso)) {
 		args->have_build_id = true;
 		return 0;
 	}
-	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	if (filename__read_build_id(dso->long_name, &dso->bid) > 0) {
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (filename__read_build_id(dso__long_name(dso), dso__bid(dso)) > 0) {
 		args->have_build_id = true;
-		dso->has_build_id = true;
-	} else if (errno == ENOENT && dso->nsinfo) {
-		char *new_name = dso__filename_with_chroot(dso, dso->long_name);
+		dso__set_has_build_id(dso);
+	} else if (errno == ENOENT && dso__nsinfo(dso)) {
+		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0) {
+		if (new_name && filename__read_build_id(new_name, dso__bid(dso)) > 0) {
 			args->have_build_id = true;
-			dso->has_build_id = true;
+			dso__set_has_build_id(dso);
 		}
 		free(new_name);
 	}
@@ -110,27 +110,27 @@ bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 static int __dso__cmp_long_name(const char *long_name, const struct dso_id *id,
 				const struct dso *b)
 {
-	int rc = strcmp(long_name, b->long_name);
-	return rc ?: dso_id__cmp(id, &b->id);
+	int rc = strcmp(long_name, dso__long_name(b));
+	return rc ?: dso_id__cmp(id, dso__id_const(b));
 }
 
 static int __dso__cmp_short_name(const char *short_name, const struct dso_id *id,
 				 const struct dso *b)
 {
-	int rc = strcmp(short_name, b->short_name);
-	return rc ?: dso_id__cmp(id, &b->id);
+	int rc = strcmp(short_name, dso__short_name(b));
+	return rc ?: dso_id__cmp(id, dso__id_const(b));
 }
 
 static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 {
 	const struct dso *a = *((const struct dso **)va);
 	const struct dso *b = *((const struct dso **)vb);
-	int rc = strcmp(a->long_name, b->long_name);
+	int rc = strcmp(dso__long_name(a), dso__long_name(b));
 
 	if (!rc) {
-		rc = dso_id__cmp(&a->id, &b->id);
+		rc = dso_id__cmp(dso__id_const(a), dso__id_const(b));
 		if (!rc)
-			rc = strcmp(a->short_name, b->short_name);
+			rc = strcmp(dso__short_name(a), dso__short_name(b));
 	}
 	return rc;
 }
@@ -209,7 +209,7 @@ int __dsos__add(struct dsos *dsos, struct dso *dso)
 								 &dsos->dsos[dsos->cnt - 1])
 			<= 0;
 	}
-	dso->dsos = dsos;
+	dso__set_dsos(dso, dsos);
 	return 0;
 }
 
@@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
 	char *base, *lname;
 	int tid;
 
-	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+	if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) == 1) {
 		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
 			return;
 	} else {
@@ -283,7 +283,7 @@ static void dso__set_basename(struct dso *dso)
 	       * basename() may modify path buffer, so we must pass
                * a copy.
                */
-		lname = strdup(dso->long_name);
+		lname = strdup(dso__long_name(dso));
 		if (!lname)
 			return;
 
@@ -322,7 +322,7 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struc
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
-	if (dso && dso_id__empty(&dso->id) && !dso_id__empty(id))
+	if (dso && dso_id__empty(dso__id(dso)) && !dso_id__empty(id))
 		__dso__inject_id(dso, id);
 
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
@@ -351,8 +351,8 @@ static int dsos__fprintf_buildid_cb(struct dso *dso, void *data)
 
 	if (args->skip && args->skip(dso, args->parm))
 		return 0;
-	build_id__sprintf(&dso->bid, sbuild_id);
-	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso->long_name);
+	build_id__sprintf(dso__bid(dso), sbuild_id);
+	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso__long_name(dso));
 	return 0;
 }
 
@@ -396,7 +396,7 @@ size_t dsos__fprintf(struct dsos *dsos, FILE *fp)
 
 static int dsos__hit_all_cb(struct dso *dso, void *data __maybe_unused)
 {
-	dso->hit = true;
+	dso__set_hit(dso);
 	return 0;
 }
 
@@ -432,7 +432,7 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 	dso__set_basename(dso);
 	dso__set_module_info(dso, m, machine);
 	dso__set_long_name(dso,	strdup(filename), true);
-	dso->kernel = DSO_SPACE__KERNEL;
+	dso__set_kernel(dso, DSO_SPACE__KERNEL);
 	__dsos__add(dsos, dso);
 
 	up_write(&dsos->lock);
@@ -455,8 +455,8 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
-	if (!dso->kernel ||
-	    is_kernel_module(dso->long_name, PERF_RECORD_MISC_CPUMODE_UNKNOWN))
+	if (!dso__kernel(dso) ||
+	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
 	*res = dso__get(dso);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 198903157f9e..f32f9abf6344 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -726,7 +726,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	dso = al->map ? map__dso(al->map) : NULL;
 	dump_printf(" ...... dso: %s\n",
 		dso
-		? dso->long_name
+		? dso__long_name(dso)
 		: (al->level == 'H' ? "[hypervisor]" : "<not found>"));
 
 	if (thread__is_filtered(thread))
@@ -750,10 +750,10 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	if (al->map) {
 		if (symbol_conf.dso_list &&
 		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
-						  dso->short_name) ||
-			       (dso->short_name != dso->long_name &&
+						  dso__short_name(dso)) ||
+			       (dso__short_name(dso) != dso__long_name(dso) &&
 				strlist__has_entry(symbol_conf.dso_list,
-						   dso->long_name))))) {
+						   dso__long_name(dso)))))) {
 			al->filtered |= (1 << HIST_FILTER__DSO);
 		}
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3fe28edc3d01..55e9553861d0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2308,7 +2308,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 
 		build_id__init(&bid, bev->data, size);
 		dso__set_build_id(dso, &bid);
-		dso->header_build_id = 1;
+		dso__set_header_build_id(dso, true);
 
 		if (dso_space != DSO_SPACE__USER) {
 			struct kmod_path m = { .name = NULL, };
@@ -2316,13 +2316,13 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 			if (!kmod_path__parse_name(&m, filename) && m.kmod)
 				dso__set_module_info(dso, &m, machine);
 
-			dso->kernel = dso_space;
+			dso__set_kernel(dso, dso_space);
 			free(m.name);
 		}
 
-		build_id__sprintf(&dso->bid, sbuild_id);
+		build_id__sprintf(dso__bid(dso), sbuild_id);
 		pr_debug("build id event received for %s: %s [%zu]\n",
-			 dso->long_name, sbuild_id, size);
+			 dso__long_name(dso), sbuild_id, size);
 		dso__put(dso);
 	}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fa359180ebf8..4ffa06b96338 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2128,7 +2128,7 @@ static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he)
 {
 	if (hists->dso_filter != NULL &&
-	    (he->ms.map == NULL || map__dso(he->ms.map) != hists->dso_filter)) {
+	    (he->ms.map == NULL || !RC_CHK_EQUAL(map__dso(he->ms.map), hists->dso_filter))) {
 		he->filtered |= (1 << HIST_FILTER__DSO);
 		return true;
 	}
@@ -2808,7 +2808,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	}
 	if (dso)
 		printed += scnprintf(bf + printed, size - printed,
-				    ", DSO: %s", dso->short_name);
+				     ", DSO: %s", dso__short_name(dso));
 	if (socket_id > -1)
 		printed += scnprintf(bf + printed, size - printed,
 				    ", Processor Socket: %d", socket_id);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f38893e0b036..04a291562b14 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -598,15 +598,15 @@ static struct auxtrace_cache *intel_pt_cache(struct dso *dso,
 	struct auxtrace_cache *c;
 	unsigned int bits;
 
-	if (dso->auxtrace_cache)
-		return dso->auxtrace_cache;
+	if (dso__auxtrace_cache(dso))
+		return dso__auxtrace_cache(dso);
 
 	bits = intel_pt_cache_size(dso, machine);
 
 	/* Ignoring cache creation failure */
 	c = auxtrace_cache__new(bits, sizeof(struct intel_pt_cache_entry), 200);
 
-	dso->auxtrace_cache = c;
+	dso__set_auxtrace_cache(dso, c);
 
 	return c;
 }
@@ -650,7 +650,7 @@ intel_pt_cache_lookup(struct dso *dso, struct machine *machine, u64 offset)
 	if (!c)
 		return NULL;
 
-	return auxtrace_cache__lookup(dso->auxtrace_cache, offset);
+	return auxtrace_cache__lookup(dso__auxtrace_cache(dso), offset);
 }
 
 static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
@@ -661,7 +661,7 @@ static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
 	if (!c)
 		return;
 
-	auxtrace_cache__remove(dso->auxtrace_cache, offset);
+	auxtrace_cache__remove(dso__auxtrace_cache(dso), offset);
 }
 
 static inline bool intel_pt_guest_kernel_ip(uint64_t ip)
@@ -820,8 +820,8 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		}
 		dso = map__dso(al.map);
 
-		if (dso->data.status == DSO_DATA_STATUS_ERROR &&
-			dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE)) {
+		if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR &&
+		    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE)) {
 			ret = -ENOENT;
 			goto out_ret;
 		}
@@ -854,7 +854,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		/* Load maps to ensure dso->is_64_bit has been updated */
 		map__load(al.map);
 
-		x86_64 = dso->is_64_bit;
+		x86_64 = dso__is_64_bit(dso);
 
 		while (1) {
 			len = dso__data_read_offset(dso, machine,
@@ -1008,7 +1008,7 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 
 	offset = map__map_ip(al.map, ip);
 
-	res = intel_pt_match_pgd_ip(ptq->pt, ip, offset, map__dso(al.map)->long_name);
+	res = intel_pt_match_pgd_ip(ptq->pt, ip, offset, dso__long_name(map__dso(al.map)));
 	addr_location__exit(&al);
 	return res;
 }
@@ -3416,7 +3416,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 		}
 
 		dso = map__dso(al.map);
-		if (!dso || !dso->auxtrace_cache)
+		if (!dso || !dso__auxtrace_cache(dso))
 			continue;
 
 		offset = map__map_ip(al.map, addr);
@@ -3436,7 +3436,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 		} else {
 			intel_pt_cache_invalidate(dso, machine, offset);
 			intel_pt_log("Invalidated instruction cache for %s at %#"PRIx64"\n",
-				     dso->long_name, addr);
+				     dso__long_name(dso), addr);
 		}
 	}
 out:
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 79225a6a499f..6fce43a0acd6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -694,7 +694,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			err = -ENOMEM;
 			goto out;
 		}
-		dso->kernel = DSO_SPACE__KERNEL;
+		dso__set_kernel(dso, DSO_SPACE__KERNEL);
 		map = map__new2(0, dso);
 		dso__put(dso);
 		if (!map) {
@@ -702,8 +702,8 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			goto out;
 		}
 		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
-			dso->binary_type = DSO_BINARY_TYPE__OOL;
-			dso->data.file_size = event->ksymbol.len;
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
+			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
 		}
 
@@ -718,7 +718,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		dso__set_loaded(dso);
 
 		if (is_bpf_image(event->ksymbol.name)) {
-			dso->binary_type = DSO_BINARY_TYPE__BPF_IMAGE;
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
 			dso__set_long_name(dso, "", false);
 		}
 	} else {
@@ -888,17 +888,17 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	size_t printed = 0;
 	struct dso *kdso = machine__kernel_dso(machine);
 
-	if (kdso->has_build_id) {
+	if (dso__has_build_id(kdso)) {
 		char filename[PATH_MAX];
-		if (dso__build_id_filename(kdso, filename, sizeof(filename),
-					   false))
+
+		if (dso__build_id_filename(kdso, filename, sizeof(filename), false))
 			printed += fprintf(fp, "[0] %s\n", filename);
 	}
 
-	for (i = 0; i < vmlinux_path__nr_entries; ++i)
-		printed += fprintf(fp, "[%d] %s\n",
-				   i + kdso->has_build_id, vmlinux_path[i]);
-
+	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
+		printed += fprintf(fp, "[%d] %s\n", i + dso__has_build_id(kdso),
+				   vmlinux_path[i]);
+	}
 	return printed;
 }
 
@@ -948,7 +948,7 @@ static struct dso *machine__get_kernel(struct machine *machine)
 						 DSO_SPACE__KERNEL_GUEST);
 	}
 
-	if (kernel != NULL && (!kernel->has_build_id))
+	if (kernel != NULL && (!dso__has_build_id(kernel)))
 		dso__read_running_kernel_build_id(kernel, machine);
 
 	return kernel;
@@ -1313,8 +1313,8 @@ static char *get_kernel_version(const char *root_dir)
 
 static bool is_kmod_dso(struct dso *dso)
 {
-	return dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-	       dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE;
+	return dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
+	       dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE;
 }
 
 static int maps__set_module_path(struct maps *maps, const char *path, struct kmod_path *m)
@@ -1341,8 +1341,8 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 	 * we need to update the symtab_type if needed.
 	 */
 	if (m->comp && is_kmod_dso(dso)) {
-		dso->symtab_type++;
-		dso->comp = m->comp;
+		dso__set_symtab_type(dso, dso__symtab_type(dso));
+		dso__set_comp(dso, m->comp);
 	}
 	map__put(map);
 	return 0;
@@ -1643,13 +1643,13 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (kernel == NULL)
 			goto out_problem;
 
-		kernel->kernel = dso_space;
+		dso__set_kernel(kernel, dso_space);
 		if (__machine__create_kernel_maps(machine, kernel) < 0) {
 			dso__put(kernel);
 			goto out_problem;
 		}
 
-		if (strstr(kernel->long_name, "vmlinux"))
+		if (strstr(dso__long_name(kernel), "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
 		if (machine__update_kernel_mmap(machine, xm->start, xm->end) < 0) {
@@ -2031,14 +2031,14 @@ static char *callchain_srcline(struct map_symbol *ms, u64 ip)
 		return srcline;
 
 	dso = map__dso(map);
-	srcline = srcline__tree_find(&dso->srclines, ip);
+	srcline = srcline__tree_find(dso__srclines(dso), ip);
 	if (!srcline) {
 		bool show_sym = false;
 		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
 
 		srcline = get_srcline(dso, map__rip_2objdump(map, ip),
 				      ms->sym, show_sym, show_addr, ip);
-		srcline__tree_insert(&dso->srclines, ip, srcline);
+		srcline__tree_insert(dso__srclines(dso), ip, srcline);
 	}
 
 	return srcline;
@@ -2836,12 +2836,12 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	addr = map__rip_2objdump(map, addr);
 	dso = map__dso(map);
 
-	inline_node = inlines__tree_find(&dso->inlined_nodes, addr);
+	inline_node = inlines__tree_find(dso__inlined_nodes(dso), addr);
 	if (!inline_node) {
 		inline_node = dso__parse_addr_inlines(dso, addr, sym);
 		if (!inline_node)
 			return ret;
-		inlines__tree_insert(&dso->inlined_nodes, inline_node);
+		inlines__tree_insert(dso__inlined_nodes(dso), inline_node);
 	}
 
 	ilist_ms = (struct map_symbol) {
@@ -3130,7 +3130,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	if (sym == NULL)
 		return NULL;
 
-	*modp = __map__is_kmodule(map) ? (char *)map__dso(map)->short_name : NULL;
+	*modp = __map__is_kmodule(map) ? (char *)dso__short_name(map__dso(map)) : NULL;
 	*addrp = map__unmap_ip(map, sym->start);
 	return sym->name;
 }
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cca871959f87..117c4bb78b35 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -168,7 +168,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
-		assert(!dso->kernel);
+		assert(!dso__kernel(dso));
 		map__init(result, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
@@ -182,10 +182,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
-		mutex_lock(&dso->lock);
-		nsinfo__put(dso->nsinfo);
-		dso->nsinfo = nsi;
-		mutex_unlock(&dso->lock);
+		mutex_lock(dso__lock(dso));
+		dso__set_nsinfo(dso, nsi);
+		mutex_unlock(dso__lock(dso));
 
 		if (build_id__is_defined(bid)) {
 			dso__set_build_id(dso, bid);
@@ -197,9 +196,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * have it missing.
 			 */
 			header_bid_dso = dsos__find(&machine->dsos, filename, false);
-			if (header_bid_dso && header_bid_dso->header_build_id) {
-				dso__set_build_id(dso, &header_bid_dso->bid);
-				dso->header_build_id = 1;
+			if (header_bid_dso && dso__header_build_id(header_bid_dso)) {
+				dso__set_build_id(dso, dso__bid(header_bid_dso));
+				dso__set_header_build_id(dso, 1);
 			}
 		}
 		dso__put(dso);
@@ -221,7 +220,7 @@ struct map *map__new2(u64 start, struct dso *dso)
 	struct map *result;
 	RC_STRUCT(map) *map;
 
-	map = calloc(1, sizeof(*map) + (dso->kernel ? sizeof(struct kmap) : 0));
+	map = calloc(1, sizeof(*map) + (dso__kernel(dso) ? sizeof(struct kmap) : 0));
 	if (ADD_RC_CHK(result, map)) {
 		/*
 		 * ->end will be filled after we load all the symbols
@@ -234,7 +233,7 @@ struct map *map__new2(u64 start, struct dso *dso)
 
 bool __map__is_kernel(const struct map *map)
 {
-	if (!map__dso(map)->kernel)
+	if (!dso__kernel(map__dso(map)))
 		return false;
 	return machine__kernel_map(maps__machine(map__kmaps((struct map *)map))) == map;
 }
@@ -251,7 +250,7 @@ bool __map__is_bpf_prog(const struct map *map)
 	const char *name;
 	struct dso *dso = map__dso(map);
 
-	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return true;
 
 	/*
@@ -259,7 +258,7 @@ bool __map__is_bpf_prog(const struct map *map)
 	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
 	 * guess the type based on name.
 	 */
-	name = dso->short_name;
+	name = dso__short_name(dso);
 	return name && (strstr(name, "bpf_prog_") == name);
 }
 
@@ -268,7 +267,7 @@ bool __map__is_bpf_image(const struct map *map)
 	const char *name;
 	struct dso *dso = map__dso(map);
 
-	if (dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
 		return true;
 
 	/*
@@ -276,7 +275,7 @@ bool __map__is_bpf_image(const struct map *map)
 	 * type of DSO_BINARY_TYPE__BPF_IMAGE. In such cases, we can
 	 * guess the type based on name.
 	 */
-	name = dso->short_name;
+	name = dso__short_name(dso);
 	return name && is_bpf_image(name);
 }
 
@@ -284,7 +283,7 @@ bool __map__is_ool(const struct map *map)
 {
 	const struct dso *dso = map__dso(map);
 
-	return dso && dso->binary_type == DSO_BINARY_TYPE__OOL;
+	return dso && dso__binary_type(dso) == DSO_BINARY_TYPE__OOL;
 }
 
 bool map__has_symbols(const struct map *map)
@@ -315,7 +314,7 @@ void map__put(struct map *map)
 void map__fixup_start(struct map *map)
 {
 	struct dso *dso = map__dso(map);
-	struct rb_root_cached *symbols = &dso->symbols;
+	struct rb_root_cached *symbols = dso__symbols(dso);
 	struct rb_node *nd = rb_first_cached(symbols);
 
 	if (nd != NULL) {
@@ -328,7 +327,7 @@ void map__fixup_start(struct map *map)
 void map__fixup_end(struct map *map)
 {
 	struct dso *dso = map__dso(map);
-	struct rb_root_cached *symbols = &dso->symbols;
+	struct rb_root_cached *symbols = dso__symbols(dso);
 	struct rb_node *nd = rb_last(&symbols->rb_root);
 
 	if (nd != NULL) {
@@ -342,7 +341,7 @@ void map__fixup_end(struct map *map)
 int map__load(struct map *map)
 {
 	struct dso *dso = map__dso(map);
-	const char *name = dso->long_name;
+	const char *name = dso__long_name(dso);
 	int nr;
 
 	if (dso__loaded(dso))
@@ -350,10 +349,10 @@ int map__load(struct map *map)
 
 	nr = dso__load(dso, map);
 	if (nr < 0) {
-		if (dso->has_build_id) {
+		if (dso__has_build_id(dso)) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-			build_id__sprintf(&dso->bid, sbuild_id);
+			build_id__sprintf(dso__bid(dso), sbuild_id);
 			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
 			pr_debug("Failed to open %s", name);
@@ -415,7 +414,7 @@ struct map *map__clone(struct map *from)
 	size_t size = sizeof(RC_STRUCT(map));
 	struct dso *dso = map__dso(from);
 
-	if (dso && dso->kernel)
+	if (dso && dso__kernel(dso))
 		size += sizeof(struct kmap);
 
 	map = memdup(RC_CHK_ACCESS(from), size);
@@ -432,14 +431,14 @@ size_t map__fprintf(struct map *map, FILE *fp)
 	const struct dso *dso = map__dso(map);
 
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
-		       map__start(map), map__end(map), map__pgoff(map), dso->name);
+		       map__start(map), map__end(map), map__pgoff(map), dso__name(dso));
 }
 
 static bool prefer_dso_long_name(const struct dso *dso, bool print_off)
 {
-	return dso->long_name &&
+	return dso__long_name(dso) &&
 	       (symbol_conf.show_kernel_path ||
-		(print_off && (dso->name[0] == '[' || dso__is_kcore(dso))));
+		(print_off && (dso__name(dso)[0] == '[' || dso__is_kcore(dso))));
 }
 
 static size_t __map__fprintf_dsoname(struct map *map, bool print_off, FILE *fp)
@@ -450,9 +449,9 @@ static size_t __map__fprintf_dsoname(struct map *map, bool print_off, FILE *fp)
 
 	if (dso) {
 		if (prefer_dso_long_name(dso, print_off))
-			dsoname = dso->long_name;
+			dsoname = dso__long_name(dso);
 		else
-			dsoname = dso->name;
+			dsoname = dso__name(dso);
 	}
 
 	if (symbol_conf.pad_output_len_dso) {
@@ -545,14 +544,14 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 		}
 	}
 
-	if (!dso->adjust_symbols)
+	if (!dso__adjust_symbols(dso))
 		return rip;
 
-	if (dso->rel)
+	if (dso__rel(dso))
 		return rip - map__pgoff(map);
 
-	if (dso->kernel == DSO_SPACE__USER)
-		return rip + dso->text_offset;
+	if (dso__kernel(dso) == DSO_SPACE__USER)
+		return rip + dso__text_offset(dso);
 
 	return map__unmap_ip(map, rip) - map__reloc(map);
 }
@@ -573,14 +572,14 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
-	if (!dso->adjust_symbols)
+	if (!dso__adjust_symbols(dso))
 		return map__unmap_ip(map, ip);
 
-	if (dso->rel)
+	if (dso__rel(dso))
 		return map__unmap_ip(map, ip + map__pgoff(map));
 
-	if (dso->kernel == DSO_SPACE__USER)
-		return map__unmap_ip(map, ip - dso->text_offset);
+	if (dso__kernel(dso) == DSO_SPACE__USER)
+		return map__unmap_ip(map, ip - dso__text_offset(dso));
 
 	return ip + map__reloc(map);
 }
@@ -590,14 +589,14 @@ u64 map__objdump_2rip(struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
-	if (!dso->adjust_symbols)
+	if (!dso__adjust_symbols(dso))
 		return ip;
 
-	if (dso->rel)
+	if (dso__rel(dso))
 		return ip + map__pgoff(map);
 
-	if (dso->kernel == DSO_SPACE__USER)
-		return ip - dso->text_offset;
+	if (dso__kernel(dso) == DSO_SPACE__USER)
+		return ip - dso__text_offset(dso);
 
 	return map__map_ip(map, ip + map__reloc(map));
 }
@@ -613,7 +612,7 @@ struct kmap *__map__kmap(struct map *map)
 {
 	const struct dso *dso = map__dso(map);
 
-	if (!dso || !dso->kernel)
+	if (!dso || !dso__kernel(dso))
 		return NULL;
 	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
 }
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index ce13145a9f8e..725300896f38 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -76,7 +76,7 @@ static void check_invariants(const struct maps *maps __maybe_unused)
 		/* Expect at least 1 reference count. */
 		assert(refcount_read(map__refcnt(map)) > 0);
 
-		if (map__dso(map) && map__dso(map)->kernel)
+		if (map__dso(map) && dso__kernel(map__dso(map)))
 			assert(RC_CHK_EQUAL(map__kmap(map)->kmaps, maps));
 
 		if (i > 0) {
@@ -346,7 +346,7 @@ static int map__strcmp(const void *a, const void *b)
 	const struct map *map_b = *(const struct map * const *)b;
 	const struct dso *dso_a = map__dso(map_a);
 	const struct dso *dso_b = map__dso(map_b);
-	int ret = strcmp(dso_a->short_name, dso_b->short_name);
+	int ret = strcmp(dso__short_name(dso_a), dso__short_name(dso_b));
 
 	if (ret == 0 && RC_CHK_ACCESS(map_a) != RC_CHK_ACCESS(map_b)) {
 		/* Ensure distinct but name equal maps have an order. */
@@ -485,7 +485,7 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	}
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
-	if (dso && dso->kernel) {
+	if (dso && dso__kernel(dso)) {
 		struct kmap *kmap = map__kmap(new);
 
 		if (kmap)
@@ -766,7 +766,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 
 		if (use_browser) {
 			pr_debug("overlapping maps in %s (disable tui for more info)\n",
-				map__dso(new)->name);
+				dso__name(map__dso(new)));
 		} else if (verbose >= 2) {
 			pr_debug("overlapping maps:\n");
 			map__fprintf(new, fp);
@@ -987,7 +987,7 @@ static int map__strcmp_name(const void *name, const void *b)
 {
 	const struct dso *dso = map__dso(*(const struct map **)b);
 
-	return strcmp(name, dso->short_name);
+	return strcmp(name, dso__short_name(dso));
 }
 
 struct map *maps__find_by_name(struct maps *maps, const char *name)
@@ -1006,7 +1006,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 		if (i < maps__nr_maps(maps) && maps__maps_by_name(maps)) {
 			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
-			if (dso && strcmp(dso->short_name, name) == 0) {
+			if (dso && strcmp(dso__short_name(dso), name) == 0) {
 				result = map__get(maps__maps_by_name(maps)[i]);
 				done = true;
 			}
@@ -1043,7 +1043,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 					struct map *pos = maps_by_address[i];
 					struct dso *dso = map__dso(pos);
 
-					if (dso && strcmp(dso->short_name, name) == 0) {
+					if (dso && strcmp(dso__short_name(dso), name) == 0) {
 						result = map__get(pos);
 						break;
 					}
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index aab11d8e1b1d..a950e9157d2d 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -104,7 +104,7 @@ static bool is64bitip(struct machine *machine, struct addr_location *al)
 	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
 
 	if (dso)
-		return dso->is_64_bit;
+		return dso__is_64_bit(dso);
 
 	return machine__is(machine, "x86_64") ||
 		machine__normalized_is(machine, "arm64") ||
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 5c12459e9765..69235d8af3b7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -159,8 +159,8 @@ static int kernel_get_module_map_cb(struct map *map, void *data)
 {
 	struct kernel_get_module_map_cb_args *args = data;
 	struct dso *dso = map__dso(map);
-	const char *short_name = dso->short_name; /* short_name is "[module]" */
-	u16 short_name_len =  dso->short_name_len;
+	const char *short_name = dso__short_name(dso);
+	u16 short_name_len =  dso__short_name_len(dso);
 
 	if (strncmp(short_name + 1, args->module, short_name_len - 2) == 0 &&
 	    args->module[short_name_len - 2] == '\0') {
@@ -202,10 +202,9 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 		map = dso__new_map(target);
 		dso = map ? map__dso(map) : NULL;
 		if (dso) {
-			mutex_lock(&dso->lock);
-			nsinfo__put(dso->nsinfo);
-			dso->nsinfo = nsinfo__get(nsi);
-			mutex_unlock(&dso->lock);
+			mutex_lock(dso__lock(dso));
+			dso__set_nsinfo(dso, nsinfo__get(nsi));
+			mutex_unlock(dso__lock(dso));
 		}
 		return map;
 	} else {
@@ -368,11 +367,11 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 
 	map = machine__kernel_map(host_machine);
 	dso = map__dso(map);
-	if (!dso->has_build_id)
+	if (!dso__has_build_id(dso))
 		dso__read_running_kernel_build_id(dso, host_machine);
 
 	vmlinux_name = symbol_conf.vmlinux_name;
-	dso->load_errno = 0;
+	*dso__load_errno(dso) = 0;
 	if (vmlinux_name)
 		ret = dso__load_vmlinux(dso, map, vmlinux_name, false);
 	else
@@ -499,7 +498,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
 	if (!c)
 		return NULL;
 
-	build_id__sprintf(&dso->bid, sbuild_id);
+	build_id__sprintf(dso__bid(dso), sbuild_id);
 	fd = debuginfod_find_debuginfo(c, (const unsigned char *)sbuild_id,
 					0, &path);
 	if (fd >= 0)
@@ -542,7 +541,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 	if (!module || !strchr(module, '/')) {
 		err = kernel_get_module_dso(module, &dso);
 		if (err < 0) {
-			if (!dso || dso->load_errno == 0) {
+			if (!dso || *dso__load_errno(dso) == 0) {
 				if (!str_error_r(-err, reason, STRERR_BUFSIZE))
 					strcpy(reason, "(unknown)");
 			} else
@@ -559,7 +558,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 			}
 			return NULL;
 		}
-		path = dso->long_name;
+		path = dso__long_name(dso);
 	}
 	nsinfo__mountns_enter(nsi, &nsc);
 	ret = debuginfo__new(path);
@@ -3795,8 +3794,8 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (size_t i = 0; i < dso->symbol_names_len; i++) {
-		struct symbol *pos = dso->symbol_names[i];
+	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
+		struct symbol *pos = dso__symbol_names(dso)[i];
 
 		if (strfilter__compare(_filter, pos->name))
 			printf("%s\n", pos->name);
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index b072ac5d3bc2..e16257d5ab2c 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -320,10 +320,10 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 			const char *dsoname = "[unknown]";
 
 			if (dso) {
-				if (symbol_conf.show_kernel_path && dso->long_name)
-					dsoname = dso->long_name;
+				if (symbol_conf.show_kernel_path && dso__long_name(dso))
+					dsoname = dso__long_name(dso);
 				else
-					dsoname = dso->name;
+					dsoname = dso__name(dso);
 			}
 			if (!hv_stores(elem, "dso", newSVpv(dsoname,0))) {
 				hv_undef(elem);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8aa301948de5..c2caa5720299 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -393,10 +393,10 @@ static const char *get_dsoname(struct map *map)
 	struct dso *dso = map ? map__dso(map) : NULL;
 
 	if (dso) {
-		if (symbol_conf.show_kernel_path && dso->long_name)
-			dsoname = dso->long_name;
+		if (symbol_conf.show_kernel_path && dso__long_name(dso))
+			dsoname = dso__long_name(dso);
 		else
-			dsoname = dso->name;
+			dsoname = dso__name(dso);
 	}
 
 	return dsoname;
@@ -799,8 +799,9 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = map__dso(al->map);
 
-		pydict_set_item_string_decref(dict, dso_field, _PyUnicode_FromString(dso->name));
-		build_id__sprintf(&dso->bid, sbuild_id);
+		pydict_set_item_string_decref(dict, dso_field,
+					      _PyUnicode_FromString(dso__name(dso)));
+		build_id__sprintf(dso__bid(dso), sbuild_id);
 		pydict_set_item_string_decref(dict, dso_bid_field,
 			_PyUnicode_FromString(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_map_start,
@@ -1246,14 +1247,14 @@ static int python_export_dso(struct db_export *dbe, struct dso *dso,
 	char sbuild_id[SBUILD_ID_SIZE];
 	PyObject *t;
 
-	build_id__sprintf(&dso->bid, sbuild_id);
+	build_id__sprintf(dso__bid(dso), sbuild_id);
 
 	t = tuple_new(5);
 
-	tuple_set_d64(t, 0, dso->db_id);
+	tuple_set_d64(t, 0, dso__db_id(dso));
 	tuple_set_d64(t, 1, machine->db_id);
-	tuple_set_string(t, 2, dso->short_name);
-	tuple_set_string(t, 3, dso->long_name);
+	tuple_set_string(t, 2, dso__short_name(dso));
+	tuple_set_string(t, 3, dso__long_name(dso));
 	tuple_set_string(t, 4, sbuild_id);
 
 	call_object(tables->dso_handler, t, "dso_table");
@@ -1273,7 +1274,7 @@ static int python_export_symbol(struct db_export *dbe, struct symbol *sym,
 	t = tuple_new(6);
 
 	tuple_set_d64(t, 0, *sym_db_id);
-	tuple_set_d64(t, 1, dso->db_id);
+	tuple_set_d64(t, 1, dso__db_id(dso));
 	tuple_set_d64(t, 2, sym->start);
 	tuple_set_d64(t, 3, sym->end);
 	tuple_set_s32(t, 4, sym->binding);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 92a1bd695e8a..944e67e4f84e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -239,11 +239,11 @@ static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
 		return cmp_null(dso_r, dso_l);
 
 	if (verbose > 0) {
-		dso_name_l = dso_l->long_name;
-		dso_name_r = dso_r->long_name;
+		dso_name_l = dso__long_name(dso_l);
+		dso_name_r = dso__long_name(dso_r);
 	} else {
-		dso_name_l = dso_l->short_name;
-		dso_name_r = dso_r->short_name;
+		dso_name_l = dso__short_name(dso_l);
+		dso_name_r = dso__short_name(dso_r);
 	}
 
 	return strcmp(dso_name_l, dso_name_r);
@@ -262,7 +262,7 @@ static int _hist_entry__dso_snprintf(struct map *map, char *bf,
 	const char *dso_name = "[unknown]";
 
 	if (dso)
-		dso_name = verbose > 0 ? dso->long_name : dso->short_name;
+		dso_name = verbose > 0 ? dso__long_name(dso) : dso__short_name(dso);
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, dso_name);
 }
@@ -364,7 +364,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 		char o = dso ? dso__symtab_origin(dso) : '!';
 		u64 rip = ip;
 
-		if (dso && dso->kernel && dso->adjust_symbols)
+		if (dso && dso__kernel(dso) && dso__adjust_symbols(dso))
 			rip = map__unmap_ip(map, ip);
 
 		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
@@ -1586,8 +1586,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	 */
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
-	    (!(map__flags(l_map) & MAP_SHARED)) && !l_dso->id.maj && !l_dso->id.min &&
-	    !l_dso->id.ino && !l_dso->id.ino_generation) {
+	    (!(map__flags(l_map) & MAP_SHARED)) && !dso__id(l_dso)->maj && !dso__id(l_dso)->min &&
+	     !dso__id(l_dso)->ino && !dso__id(l_dso)->ino_generation) {
 		/* userspace anonymous */
 
 		if (thread__pid(left->thread) > thread__pid(right->thread))
@@ -1626,7 +1626,8 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
 		     map && !(map__prot(map) & PROT_EXEC) &&
 		     (map__flags(map) & MAP_SHARED) &&
-		    (dso->id.maj || dso->id.min || dso->id.ino || dso->id.ino_generation))
+		     (dso__id(dso)->maj || dso__id(dso)->min || dso__id(dso)->ino ||
+		      dso__id(dso)->ino_generation))
 			level = 's';
 		else if (!map)
 			level = 'X';
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 7addc34afcf5..9d670d8c1c08 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -27,14 +27,14 @@ bool srcline_full_filename;
 
 char *srcline__unknown = (char *)"??:0";
 
-static const char *dso__name(struct dso *dso)
+static const char *srcline_dso_name(struct dso *dso)
 {
 	const char *dso_name;
 
-	if (dso->symsrc_filename)
-		dso_name = dso->symsrc_filename;
+	if (dso__symsrc_filename(dso))
+		dso_name = dso__symsrc_filename(dso);
 	else
-		dso_name = dso->long_name;
+		dso_name = dso__long_name(dso);
 
 	if (dso_name[0] == '[')
 		return NULL;
@@ -638,7 +638,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		     struct inline_node *node,
 		     struct symbol *sym __maybe_unused)
 {
-	struct child_process *a2l = dso->a2l;
+	struct child_process *a2l = dso__a2l(dso);
 	char *record_function = NULL;
 	char *record_filename = NULL;
 	unsigned int record_line_nr = 0;
@@ -655,8 +655,9 @@ static int addr2line(const char *dso_name, u64 addr,
 		if (!filename__has_section(dso_name, ".debug_line"))
 			goto out;
 
-		dso->a2l = addr2line_subprocess_init(symbol_conf.addr2line_path, dso_name);
-		a2l = dso->a2l;
+		dso__set_a2l(dso,
+			     addr2line_subprocess_init(symbol_conf.addr2line_path, dso_name));
+		a2l = dso__a2l(dso);
 	}
 
 	if (a2l == NULL) {
@@ -770,7 +771,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	free(record_function);
 	free(record_filename);
 	if (io.eof) {
-		dso->a2l = NULL;
+		dso__set_a2l(dso, NULL);
 		addr2line_subprocess_cleanup(a2l);
 	}
 	return ret;
@@ -778,14 +779,14 @@ static int addr2line(const char *dso_name, u64 addr,
 
 void dso__free_a2l(struct dso *dso)
 {
-	struct child_process *a2l = dso->a2l;
+	struct child_process *a2l = dso__a2l(dso);
 
 	if (!a2l)
 		return;
 
 	addr2line_subprocess_cleanup(a2l);
 
-	dso->a2l = NULL;
+	dso__set_a2l(dso, NULL);
 }
 
 #endif /* HAVE_LIBBFD_SUPPORT */
@@ -823,33 +824,34 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	char *srcline;
 	const char *dso_name;
 
-	if (!dso->has_srcline)
+	if (!dso__has_srcline(dso))
 		goto out;
 
-	dso_name = dso__name(dso);
+	dso_name = srcline_dso_name(dso);
 	if (dso_name == NULL)
-		goto out;
+		goto out_err;
 
 	if (!addr2line(dso_name, addr, &file, &line, dso,
 		       unwind_inlines, NULL, sym))
-		goto out;
+		goto out_err;
 
 	srcline = srcline_from_fileline(file, line);
 	free(file);
 
 	if (!srcline)
-		goto out;
+		goto out_err;
 
-	dso->a2l_fails = 0;
+	dso__set_a2l_fails(dso, 0);
 
 	return srcline;
 
-out:
-	if (dso->a2l_fails && ++dso->a2l_fails > A2L_FAIL_LIMIT) {
-		dso->has_srcline = 0;
+out_err:
+	dso__set_a2l_fails(dso, dso__a2l_fails(dso) + 1);
+	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
+		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
 	}
-
+out:
 	if (!show_addr)
 		return (show_sym && sym) ?
 			    strndup(sym->name, sym->namelen) : SRCLINE_UNKNOWN;
@@ -858,7 +860,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		if (asprintf(&srcline, "%s+%" PRIu64, show_sym ? sym->name : "",
 					ip - sym->start) < 0)
 			return SRCLINE_UNKNOWN;
-	} else if (asprintf(&srcline, "%s[%" PRIx64 "]", dso->short_name, addr) < 0)
+	} else if (asprintf(&srcline, "%s[%" PRIx64 "]", dso__short_name(dso), addr) < 0)
 		return SRCLINE_UNKNOWN;
 	return srcline;
 }
@@ -869,22 +871,23 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	char *file = NULL;
 	const char *dso_name;
 
-	if (!dso->has_srcline)
-		goto out;
+	if (!dso__has_srcline(dso))
+		return NULL;
 
-	dso_name = dso__name(dso);
+	dso_name = srcline_dso_name(dso);
 	if (dso_name == NULL)
-		goto out;
+		goto out_err;
 
 	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL))
-		goto out;
+		goto out_err;
 
-	dso->a2l_fails = 0;
+	dso__set_a2l_fails(dso, 0);
 	return file;
 
-out:
-	if (dso->a2l_fails && ++dso->a2l_fails > A2L_FAIL_LIMIT) {
-		dso->has_srcline = 0;
+out_err:
+	dso__set_a2l_fails(dso, dso__a2l_fails(dso) + 1);
+	if (dso__a2l_fails(dso) > A2L_FAIL_LIMIT) {
+		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
 	}
 
@@ -982,7 +985,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 {
 	const char *dso_name;
 
-	dso_name = dso__name(dso);
+	dso_name = srcline_dso_name(dso);
 	if (dso_name == NULL)
 		return NULL;
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 0b91f813c4fa..3be5e8d1e278 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -174,7 +174,7 @@ static inline bool elf_sec__is_data(const GElf_Shdr *shdr,
 
 static bool elf_sec__filter(GElf_Shdr *shdr, Elf_Data *secstrs)
 {
-	return elf_sec__is_text(shdr, secstrs) || 
+	return elf_sec__is_text(shdr, secstrs) ||
 	       elf_sec__is_data(shdr, secstrs);
 }
 
@@ -312,8 +312,8 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	 * DWARF DW_compile_unit has this, but we don't always have access
 	 * to it...
 	 */
-	if (!want_demangle(dso->kernel || kmodule))
-	    return demangled;
+	if (!want_demangle(dso__kernel(dso) || kmodule))
+		return demangled;
 
 	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
 	if (demangled == NULL) {
@@ -470,7 +470,7 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 	}
 	if (*plt_entry_size)
 		return true;
-	pr_debug("Missing PLT entry size for %s\n", dso->long_name);
+	pr_debug("Missing PLT entry size for %s\n", dso__long_name(dso));
 	return false;
 }
 
@@ -654,7 +654,7 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
 		if (!sym)
 			goto out;
-		symbols__insert(&dso->symbols, sym);
+		symbols__insert(dso__symbols(dso), sym);
 	}
 	err = 0;
 out:
@@ -708,7 +708,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	plt_sym = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
 	if (!plt_sym)
 		goto out_elf_end;
-	symbols__insert(&dso->symbols, plt_sym);
+	symbols__insert(dso__symbols(dso), plt_sym);
 
 	/* Only x86 has .plt.got */
 	if (machine_is_x86(ehdr.e_machine) &&
@@ -830,7 +830,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			goto out_elf_end;
 
 		plt_offset += plt_entry_size;
-		symbols__insert(&dso->symbols, f);
+		symbols__insert(dso__symbols(dso), f);
 		++nr;
 	}
 
@@ -840,7 +840,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	if (err == 0)
 		return nr;
 	pr_debug("%s: problems reading %s PLT info.\n",
-		 __func__, dso->long_name);
+		 __func__, dso__long_name(dso));
 	return 0;
 }
 
@@ -1175,19 +1175,19 @@ static int dso__swap_init(struct dso *dso, unsigned char eidata)
 {
 	static unsigned int const endian = 1;
 
-	dso->needs_swap = DSO_SWAP__NO;
+	dso__set_needs_swap(dso, DSO_SWAP__NO);
 
 	switch (eidata) {
 	case ELFDATA2LSB:
 		/* We are big endian, DSO is little endian. */
 		if (*(unsigned char const *)&endian != 1)
-			dso->needs_swap = DSO_SWAP__YES;
+			dso__set_needs_swap(dso, DSO_SWAP__YES);
 		break;
 
 	case ELFDATA2MSB:
 		/* We are little endian, DSO is big endian. */
 		if (*(unsigned char const *)&endian != 0)
-			dso->needs_swap = DSO_SWAP__YES;
+			dso__set_needs_swap(dso, DSO_SWAP__YES);
 		break;
 
 	default:
@@ -1238,11 +1238,11 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		if (fd < 0)
 			return -1;
 
-		type = dso->symtab_type;
+		type = dso__symtab_type(dso);
 	} else {
 		fd = open(name, O_RDONLY);
 		if (fd < 0) {
-			dso->load_errno = errno;
+			*dso__load_errno(dso) = errno;
 			return -1;
 		}
 	}
@@ -1250,37 +1250,37 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
 	if (elf == NULL) {
 		pr_debug("%s: cannot read %s ELF file.\n", __func__, name);
-		dso->load_errno = DSO_LOAD_ERRNO__INVALID_ELF;
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
 		goto out_close;
 	}
 
 	if (gelf_getehdr(elf, &ehdr) == NULL) {
-		dso->load_errno = DSO_LOAD_ERRNO__INVALID_ELF;
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
 		pr_debug("%s: cannot get elf header.\n", __func__);
 		goto out_elf_end;
 	}
 
 	if (dso__swap_init(dso, ehdr.e_ident[EI_DATA])) {
-		dso->load_errno = DSO_LOAD_ERRNO__INTERNAL_ERROR;
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INTERNAL_ERROR;
 		goto out_elf_end;
 	}
 
 	/* Always reject images with a mismatched build-id: */
-	if (dso->has_build_id && !symbol_conf.ignore_vmlinux_buildid) {
+	if (dso__has_build_id(dso) && !symbol_conf.ignore_vmlinux_buildid) {
 		u8 build_id[BUILD_ID_SIZE];
 		struct build_id bid;
 		int size;
 
 		size = elf_read_build_id(elf, build_id, BUILD_ID_SIZE);
 		if (size <= 0) {
-			dso->load_errno = DSO_LOAD_ERRNO__CANNOT_READ_BUILDID;
+			*dso__load_errno(dso) = DSO_LOAD_ERRNO__CANNOT_READ_BUILDID;
 			goto out_elf_end;
 		}
 
 		build_id__init(&bid, build_id, size);
 		if (!dso__build_id_equal(dso, &bid)) {
 			pr_debug("%s: build id mismatch for %s.\n", __func__, name);
-			dso->load_errno = DSO_LOAD_ERRNO__MISMATCHING_BUILDID;
+			*dso__load_errno(dso) = DSO_LOAD_ERRNO__MISMATCHING_BUILDID;
 			goto out_elf_end;
 		}
 	}
@@ -1305,14 +1305,14 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	if (ss->opdshdr.sh_type != SHT_PROGBITS)
 		ss->opdsec = NULL;
 
-	if (dso->kernel == DSO_SPACE__USER)
+	if (dso__kernel(dso) == DSO_SPACE__USER)
 		ss->adjust_symbols = true;
 	else
 		ss->adjust_symbols = elf__needs_adjust_symbols(ehdr);
 
 	ss->name   = strdup(name);
 	if (!ss->name) {
-		dso->load_errno = errno;
+		*dso__load_errno(dso) = errno;
 		goto out_elf_end;
 	}
 
@@ -1432,7 +1432,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	if (adjust_kernel_syms)
 		sym->st_value -= shdr->sh_addr - shdr->sh_offset;
 
-	if (strcmp(section_name, (curr_dso->short_name + dso->short_name_len)) == 0)
+	if (strcmp(section_name, (dso__short_name(curr_dso) + dso__short_name_len(dso))) == 0)
 		return 0;
 
 	if (strcmp(section_name, ".text") == 0) {
@@ -1441,7 +1441,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 * kallsyms and identity maps.  Overwrite it to
 		 * map to the kernel dso.
 		 */
-		if (*remap_kernel && dso->kernel && !kmodule) {
+		if (*remap_kernel && dso__kernel(dso) && !kmodule) {
 			*remap_kernel = false;
 			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
 			map__set_end(map, map__start(map) + shdr->sh_size);
@@ -1489,7 +1489,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		return 0;
 	}
 
-	snprintf(dso_name, sizeof(dso_name), "%s%s", dso->short_name, section_name);
+	snprintf(dso_name, sizeof(dso_name), "%s%s", dso__short_name(dso), section_name);
 
 	curr_map = maps__find_by_name(kmaps, dso_name);
 	if (curr_map == NULL) {
@@ -1501,17 +1501,17 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		curr_dso = dso__new(dso_name);
 		if (curr_dso == NULL)
 			return -1;
-		curr_dso->kernel = dso->kernel;
-		curr_dso->long_name = dso->long_name;
-		curr_dso->long_name_len = dso->long_name_len;
-		curr_dso->binary_type = dso->binary_type;
-		curr_dso->adjust_symbols = dso->adjust_symbols;
+		dso__set_kernel(curr_dso, dso__kernel(dso));
+		RC_CHK_ACCESS(curr_dso)->long_name = dso__long_name(dso);
+		RC_CHK_ACCESS(curr_dso)->long_name_len = dso__long_name_len(dso);
+		dso__set_binary_type(curr_dso, dso__binary_type(dso));
+		dso__set_adjust_symbols(curr_dso, dso__adjust_symbols(dso));
 		curr_map = map__new2(start, curr_dso);
 		dso__put(curr_dso);
 		if (curr_map == NULL)
 			return -1;
 
-		if (curr_dso->kernel)
+		if (dso__kernel(curr_dso))
 			map__kmap(curr_map)->kmaps = kmaps;
 
 		if (adjust_kernel_syms) {
@@ -1521,7 +1521,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		} else {
 			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 		}
-		curr_dso->symtab_type = dso->symtab_type;
+		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
 		if (maps__insert(kmaps, curr_map))
 			return -1;
 		/*
@@ -1547,7 +1547,7 @@ static int
 dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		       struct symsrc *runtime_ss, int kmodule, int dynsym)
 {
-	struct kmap *kmap = dso->kernel ? map__kmap(map) : NULL;
+	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
 	struct map *curr_map = map;
 	struct dso *curr_dso = dso;
@@ -1581,8 +1581,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
 				".text", NULL)) {
-		dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
-		dso->text_end = tshdr.sh_offset + tshdr.sh_size;
+		dso__set_text_offset(dso, tshdr.sh_addr - tshdr.sh_offset);
+		dso__set_text_end(dso, tshdr.sh_offset + tshdr.sh_size);
 	}
 
 	if (runtime_ss->opdsec)
@@ -1641,16 +1641,16 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * attempted to prelink vdso to its virtual address.
 	 */
 	if (dso__is_vdso(dso))
-		map__set_reloc(map, map__start(map) - dso->text_offset);
+		map__set_reloc(map, map__start(map) - dso__text_offset(dso));
 
-	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
+	dso__set_adjust_symbols(dso, runtime_ss->adjust_symbols || ref_reloc(kmap));
 	/*
 	 * Initial kernel and module mappings do not map to the dso.
 	 * Flag the fixups.
 	 */
-	if (dso->kernel) {
+	if (dso__kernel(dso)) {
 		remap_kernel = true;
-		adjust_kernel_syms = dso->adjust_symbols;
+		adjust_kernel_syms = dso__adjust_symbols(dso);
 	}
 
 	if (kmodule && adjust_kernel_syms)
@@ -1743,7 +1743,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
-		if (dso->kernel) {
+		if (dso__kernel(dso)) {
 			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
 						       section_name, adjust_kernel_syms, kmodule,
 						       &remap_kernel, max_text_sh_offset))
@@ -1792,7 +1792,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(&curr_dso->symbols, f, dso->kernel);
+		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
 	}
 
@@ -1800,8 +1800,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * For misannotated, zeroed, ASM function sizes.
 	 */
 	if (nr > 0) {
-		symbols__fixup_end(&dso->symbols, false);
-		symbols__fixup_duplicate(&dso->symbols);
+		symbols__fixup_end(dso__symbols(dso), false);
+		symbols__fixup_duplicate(dso__symbols(dso));
 		if (kmap) {
 			/*
 			 * We need to fixup this here too because we create new
@@ -1821,16 +1821,16 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	int nr = 0;
 	int err = -1;
 
-	dso->symtab_type = syms_ss->type;
-	dso->is_64_bit = syms_ss->is_64_bit;
-	dso->rel = syms_ss->ehdr.e_type == ET_REL;
+	dso__set_symtab_type(dso, syms_ss->type);
+	dso__set_is_64_bit(dso, syms_ss->is_64_bit);
+	dso__set_rel(dso, syms_ss->ehdr.e_type == ET_REL);
 
 	/*
 	 * Modules may already have symbols from kallsyms, but those symbols
 	 * have the wrong values for the dso maps, so remove them.
 	 */
 	if (kmodule && syms_ss->symtab)
-		symbols__delete(&dso->symbols);
+		symbols__delete(dso__symbols(dso));
 
 	if (!syms_ss->symtab) {
 		/*
@@ -1838,7 +1838,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		 * to using kallsyms. The vmlinux runtime symbols aren't
 		 * of much use.
 		 */
-		if (dso->kernel)
+		if (dso__kernel(dso))
 			return err;
 	} else  {
 		err = dso__load_sym_internal(dso, map, syms_ss, runtime_ss,
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 1da8b713509c..c6f369b5d893 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -273,7 +273,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 out_close:
 	close(fd);
 out_errno:
-	dso->load_errno = errno;
+	RC_CHK_ACCESS(dso)->load_errno = errno;
 	return -1;
 }
 
@@ -348,7 +348,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 
 	ret = fd__is_64_bit(ss->fd);
 	if (ret >= 0)
-		dso->is_64_bit = ret;
+		RC_CHK_ACCESS(dso)->is_64_bit = ret;
 
 	if (filename__read_build_id(ss->name, &bid) > 0)
 		dso__set_build_id(dso, &bid);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9ebdb8e13c0b..c95fb69de096 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -532,52 +532,52 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
 void dso__reset_find_symbol_cache(struct dso *dso)
 {
-	dso->last_find_result.addr   = 0;
-	dso->last_find_result.symbol = NULL;
+	dso__set_last_find_result_addr(dso, 0);
+	dso__set_last_find_result_symbol(dso, NULL);
 }
 
 void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(&dso->symbols, sym, dso->kernel);
+	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
 
 	/* update the symbol cache if necessary */
-	if (dso->last_find_result.addr >= sym->start &&
-	    (dso->last_find_result.addr < sym->end ||
+	if (dso__last_find_result_addr(dso) >= sym->start &&
+	    (dso__last_find_result_addr(dso) < sym->end ||
 	    sym->start == sym->end)) {
-		dso->last_find_result.symbol = sym;
+		dso__set_last_find_result_symbol(dso, sym);
 	}
 }
 
 void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 {
-	rb_erase_cached(&sym->rb_node, &dso->symbols);
+	rb_erase_cached(&sym->rb_node, dso__symbols(dso));
 	symbol__delete(sym);
 	dso__reset_find_symbol_cache(dso);
 }
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 {
-	if (dso->last_find_result.addr != addr || dso->last_find_result.symbol == NULL) {
-		dso->last_find_result.addr   = addr;
-		dso->last_find_result.symbol = symbols__find(&dso->symbols, addr);
+	if (dso__last_find_result_addr(dso) != addr || dso__last_find_result_symbol(dso) == NULL) {
+		dso__set_last_find_result_addr(dso, addr);
+		dso__set_last_find_result_symbol(dso, symbols__find(dso__symbols(dso), addr));
 	}
 
-	return dso->last_find_result.symbol;
+	return dso__last_find_result_symbol(dso);
 }
 
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 {
-	return symbols__find(&dso->symbols, addr);
+	return symbols__find(dso__symbols(dso), addr);
 }
 
 struct symbol *dso__first_symbol(struct dso *dso)
 {
-	return symbols__first(&dso->symbols);
+	return symbols__first(dso__symbols(dso));
 }
 
 struct symbol *dso__last_symbol(struct dso *dso)
 {
-	return symbols__last(&dso->symbols);
+	return symbols__last(dso__symbols(dso));
 }
 
 struct symbol *dso__next_symbol(struct symbol *sym)
@@ -587,11 +587,11 @@ struct symbol *dso__next_symbol(struct symbol *sym)
 
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 {
-	if (*idx + 1 >= dso->symbol_names_len)
+	if (*idx + 1 >= dso__symbol_names_len(dso))
 		return NULL;
 
 	++*idx;
-	return dso->symbol_names[*idx];
+	return dso__symbol_names(dso)[*idx];
 }
 
  /*
@@ -599,27 +599,29 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
   */
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx)
 {
-	struct symbol *s = symbols__find_by_name(dso->symbol_names, dso->symbol_names_len,
-						name, SYMBOL_TAG_INCLUDE__NONE, idx);
-	if (!s)
-		s = symbols__find_by_name(dso->symbol_names, dso->symbol_names_len,
-					name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
+	struct symbol *s = symbols__find_by_name(dso__symbol_names(dso),
+						 dso__symbol_names_len(dso),
+						 name, SYMBOL_TAG_INCLUDE__NONE, idx);
+	if (!s) {
+		s = symbols__find_by_name(dso__symbol_names(dso), dso__symbol_names_len(dso),
+					  name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
+	}
 	return s;
 }
 
 void dso__sort_by_name(struct dso *dso)
 {
-	mutex_lock(&dso->lock);
+	mutex_lock(dso__lock(dso));
 	if (!dso__sorted_by_name(dso)) {
 		size_t len;
 
-		dso->symbol_names = symbols__sort_by_name(&dso->symbols, &len);
-		if (dso->symbol_names) {
-			dso->symbol_names_len = len;
+		dso__set_symbol_names(dso, symbols__sort_by_name(dso__symbols(dso), &len));
+		if (dso__symbol_names(dso)) {
+			dso__set_symbol_names_len(dso, len);
 			dso__set_sorted_by_name(dso);
 		}
 	}
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 }
 
 /*
@@ -746,7 +748,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 {
 	struct symbol *sym;
 	struct dso *dso = arg;
-	struct rb_root_cached *root = &dso->symbols;
+	struct rb_root_cached *root = dso__symbols(dso);
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -786,8 +788,8 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
 	struct symbol *pos;
 	int count = 0;
-	struct rb_root_cached old_root = dso->symbols;
-	struct rb_root_cached *root = &dso->symbols;
+	struct rb_root_cached *root = dso__symbols(dso);
+	struct rb_root_cached old_root = *root;
 	struct rb_node *next = rb_first_cached(root);
 
 	if (!kmaps)
@@ -821,13 +823,13 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			pos->end = map__end(curr_map);
 		if (pos->end)
 			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
-		symbols__insert(&curr_map_dso->symbols, pos);
+		symbols__insert(dso__symbols(curr_map_dso), pos);
 		++count;
 		map__put(curr_map);
 	}
 
 	/* Symbols have been adjusted */
-	dso->adjust_symbols = 1;
+	dso__set_adjust_symbols(dso, true);
 
 	return count;
 }
@@ -844,7 +846,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	struct map *curr_map = map__get(initial_map);
 	struct symbol *pos;
 	int count = 0, moved = 0;
-	struct rb_root_cached *root = &dso->symbols;
+	struct rb_root_cached *root = dso__symbols(dso);
 	struct rb_node *next = rb_first_cached(root);
 	int kernel_range = 0;
 	bool x86_64;
@@ -871,9 +873,9 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 			*module++ = '\0';
 			curr_map_dso = map__dso(curr_map);
-			if (strcmp(curr_map_dso->short_name, module)) {
+			if (strcmp(dso__short_name(curr_map_dso), module)) {
 				if (!RC_CHK_EQUAL(curr_map, initial_map) &&
-				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
+				    dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
 					/*
 					 * We assume all symbols of a module are
@@ -896,7 +898,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 					goto discard_symbol;
 				}
 				curr_map_dso = map__dso(curr_map);
-				if (curr_map_dso->loaded &&
+				if (dso__loaded(curr_map_dso) &&
 				    !machine__is_default_guest(machine))
 					goto discard_symbol;
 			}
@@ -932,7 +934,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				goto add_symbol;
 			}
 
-			if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
+			if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
 				snprintf(dso_name, sizeof(dso_name),
 					"[guest.kernel].%d",
 					kernel_range++);
@@ -946,7 +948,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			if (ndso == NULL)
 				return -1;
 
-			ndso->kernel = dso->kernel;
+			dso__set_kernel(ndso, dso__kernel(dso));
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
@@ -971,7 +973,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			struct dso *curr_map_dso = map__dso(curr_map);
 
 			rb_erase_cached(&pos->rb_node, root);
-			symbols__insert(&curr_map_dso->symbols, pos);
+			symbols__insert(dso__symbols(curr_map_dso), pos);
 			++moved;
 		} else
 			++count;
@@ -983,7 +985,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	}
 
 	if (!RC_CHK_EQUAL(curr_map, initial_map) &&
-	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
+	    dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
 		dso__set_loaded(map__dso(curr_map));
 	}
@@ -1157,7 +1159,7 @@ static int do_validate_kcore_modules_cb(struct map *old_map, void *data)
 
 	dso = map__dso(old_map);
 	/* Module must be in memory at the same address */
-	mi = find_module(dso->short_name, modules);
+	mi = find_module(dso__short_name(dso), modules);
 	if (!mi || mi->start != map__start(old_map))
 		return -EINVAL;
 
@@ -1326,7 +1328,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			      &is_64_bit);
 	if (err)
 		goto out_err;
-	dso->is_64_bit = is_64_bit;
+	dso__set_is_64_bit(dso, is_64_bit);
 
 	if (list_empty(&md.maps)) {
 		err = -EINVAL;
@@ -1418,10 +1420,10 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	 * Set the data type and long name so that kcore can be read via
 	 * dso__data_read_addr().
 	 */
-	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
-		dso->binary_type = DSO_BINARY_TYPE__GUEST_KCORE;
+	if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_KCORE);
 	else
-		dso->binary_type = DSO_BINARY_TYPE__KCORE;
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__KCORE);
 	dso__set_long_name(dso, strdup(kcore_filename), true);
 
 	close(fd);
@@ -1482,13 +1484,13 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 	if (kallsyms__delta(kmap, filename, &delta))
 		return -1;
 
-	symbols__fixup_end(&dso->symbols, true);
-	symbols__fixup_duplicate(&dso->symbols);
+	symbols__fixup_end(dso__symbols(dso), true);
+	symbols__fixup_duplicate(dso__symbols(dso));
 
-	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
-		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KALLSYMS;
+	if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
+		dso__set_symtab_type(dso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
 	else
-		dso->symtab_type = DSO_BINARY_TYPE__KALLSYMS;
+		dso__set_symtab_type(dso, DSO_BINARY_TYPE__KALLSYMS);
 
 	if (!no_kcore && !dso__load_kcore(dso, map, filename))
 		return maps__split_kallsyms_for_kcore(kmap->kmaps, dso);
@@ -1544,7 +1546,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (sym == NULL)
 			goto out_delete_line;
 
-		symbols__insert(&dso->symbols, sym);
+		symbols__insert(dso__symbols(dso), sym);
 		nr_syms++;
 	}
 
@@ -1670,15 +1672,15 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 		if (!symbol)
 			goto out_free;
 
-		symbols__insert(&dso->symbols, symbol);
+		symbols__insert(dso__symbols(dso), symbol);
 	}
 #ifdef bfd_get_section
 #undef bfd_asymbol_section
 #endif
 
-	symbols__fixup_end(&dso->symbols, false);
-	symbols__fixup_duplicate(&dso->symbols);
-	dso->adjust_symbols = 1;
+	symbols__fixup_end(dso__symbols(dso), false);
+	symbols__fixup_duplicate(dso__symbols(dso));
+	dso__set_adjust_symbols(dso);
 
 	err = 0;
 out_free:
@@ -1701,17 +1703,17 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
-		return !kmod && dso->kernel == DSO_SPACE__USER;
+		return !kmod && dso__kernel(dso) == DSO_SPACE__USER;
 
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__VMLINUX:
 	case DSO_BINARY_TYPE__KCORE:
-		return dso->kernel == DSO_SPACE__KERNEL;
+		return dso__kernel(dso) == DSO_SPACE__KERNEL;
 
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_VMLINUX:
 	case DSO_BINARY_TYPE__GUEST_KCORE:
-		return dso->kernel == DSO_SPACE__KERNEL_GUEST;
+		return dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST;
 
 	case DSO_BINARY_TYPE__GUEST_KMODULE:
 	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
@@ -1721,7 +1723,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 		 * kernel modules know their symtab type - it's set when
 		 * creating a module dso in machine__addnew_module_map().
 		 */
-		return kmod && dso->symtab_type == type;
+		return kmod && dso__symtab_type(dso) == type;
 
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
@@ -1789,18 +1791,19 @@ int dso__load(struct dso *dso, struct map *map)
 	struct build_id bid;
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
-	const char *map_path = dso->long_name;
+	const char *map_path = dso__long_name(dso);
 
-	mutex_lock(&dso->lock);
-	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
+	mutex_lock(dso__lock(dso));
+	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
 	if (perfmap) {
-		if (dso->nsinfo && (dso__find_perf_map(newmapname,
-		    sizeof(newmapname), &dso->nsinfo) == 0)) {
+		if (dso__nsinfo(dso) &&
+		    (dso__find_perf_map(newmapname, sizeof(newmapname),
+					dso__nsinfo_ptr(dso)) == 0)) {
 			map_path = newmapname;
 		}
 	}
 
-	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
@@ -1808,15 +1811,15 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+	kmod = dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
+		dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
+		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE ||
+		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 
-	if (dso->kernel && !kmod) {
-		if (dso->kernel == DSO_SPACE__KERNEL)
+	if (dso__kernel(dso) && !kmod) {
+		if (dso__kernel(dso) == DSO_SPACE__KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
-		else if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
+		else if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
 		machine = maps__machine(map__kmaps(map));
@@ -1825,12 +1828,13 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	dso->adjust_symbols = 0;
+	dso__set_adjust_symbols(dso, false);
 
 	if (perfmap) {
 		ret = dso__load_perf_map(map_path, dso);
-		dso->symtab_type = ret > 0 ? DSO_BINARY_TYPE__JAVA_JIT :
-					     DSO_BINARY_TYPE__NOT_FOUND;
+		dso__set_symtab_type(dso, ret > 0
+				? DSO_BINARY_TYPE__JAVA_JIT
+				: DSO_BINARY_TYPE__NOT_FOUND);
 		goto out;
 	}
 
@@ -1845,9 +1849,9 @@ int dso__load(struct dso *dso, struct map *map)
 	 * Read the build id if possible. This is required for
 	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
 	 */
-	if (!dso->has_build_id &&
-	    is_regular_file(dso->long_name)) {
-	    __symbol__join_symfs(name, PATH_MAX, dso->long_name);
+	if (!dso__has_build_id(dso) &&
+	    is_regular_file(dso__long_name(dso))) {
+		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
 		if (filename__read_build_id(name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
 	}
@@ -1881,7 +1885,7 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_exit(&nsc);
 
 		is_reg = is_regular_file(name);
-		if (!is_reg && errno == ENOENT && dso->nsinfo) {
+		if (!is_reg && errno == ENOENT && dso__nsinfo(dso)) {
 			char *new_name = dso__filename_with_chroot(dso, name);
 			if (new_name) {
 				is_reg = is_regular_file(new_name);
@@ -1898,7 +1902,7 @@ int dso__load(struct dso *dso, struct map *map)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
 		if (nsexit)
-			nsinfo__mountns_enter(dso->nsinfo, &nsc);
+			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		if (bfdrc == 0) {
 			ret = 0;
@@ -1911,8 +1915,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (!syms_ss && symsrc__has_symtab(ss)) {
 			syms_ss = ss;
 			next_slot = true;
-			if (!dso->symsrc_filename)
-				dso->symsrc_filename = strdup(name);
+			if (!dso__symsrc_filename(dso))
+				dso__set_symsrc_filename(dso, strdup(name));
 		}
 
 		if (!runtime_ss && symsrc__possibly_runtime(ss)) {
@@ -1959,11 +1963,11 @@ int dso__load(struct dso *dso, struct map *map)
 		symsrc__destroy(&ss_[ss_pos - 1]);
 out_free:
 	free(name);
-	if (ret < 0 && strstr(dso->name, " (deleted)") != NULL)
+	if (ret < 0 && strstr(dso__name(dso), " (deleted)") != NULL)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
-	mutex_unlock(&dso->lock);
+	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
@@ -1982,7 +1986,7 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 	else
 		symbol__join_symfs(symfs_vmlinux, vmlinux);
 
-	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
+	if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
 		symtab_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
 	else
 		symtab_type = DSO_BINARY_TYPE__VMLINUX;
@@ -1995,10 +1999,10 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 	 * an incorrect long name unless we set it here first.
 	 */
 	dso__set_long_name(dso, vmlinux, vmlinux_allocated);
-	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
-		dso->binary_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
+	if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_VMLINUX);
 	else
-		dso->binary_type = DSO_BINARY_TYPE__VMLINUX;
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__VMLINUX);
 
 	err = dso__load_sym(dso, map, &ss, &ss, 0);
 	symsrc__destroy(&ss);
@@ -2091,7 +2095,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	bool is_host = false;
 	char path[PATH_MAX];
 
-	if (!dso->has_build_id) {
+	if (!dso__has_build_id(dso)) {
 		/*
 		 * Last resort, if we don't have a build-id and couldn't find
 		 * any vmlinux file, try the running kernel kallsyms table.
@@ -2116,7 +2120,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 			goto proc_kallsyms;
 	}
 
-	build_id__sprintf(&dso->bid, sbuild_id);
+	build_id__sprintf(dso__bid(dso), sbuild_id);
 
 	/* Find kallsyms in build-id cache with kcore */
 	scnprintf(path, sizeof(path), "%s/%s/%s",
@@ -2209,7 +2213,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	free(kallsyms_allocated_filename);
 
 	if (err > 0 && !dso__is_kcore(dso)) {
-		dso->binary_type = DSO_BINARY_TYPE__KALLSYMS;
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
 		dso__set_long_name(dso, DSO__NAME_KALLSYMS, false);
 		map__fixup_start(map);
 		map__fixup_end(map);
@@ -2252,7 +2256,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 	if (err > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	if (err > 0 && !dso__is_kcore(dso)) {
-		dso->binary_type = DSO_BINARY_TYPE__GUEST_KALLSYMS;
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
 		dso__set_long_name(dso, machine->mmap_name, false);
 		map__fixup_start(map);
 		map__fixup_end(map);
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 088f4abf230f..53e1af4ed9ac 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -64,8 +64,8 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 {
 	size_t ret = 0;
 
-	for (size_t i = 0; i < dso->symbol_names_len; i++) {
-		struct symbol *pos = dso->symbol_names[i];
+	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
+		struct symbol *pos = dso__symbol_names(dso)[i];
 
 		ret += fprintf(fp, "%s\n", pos->name);
 	}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2a0289c14959..5498048f56ea 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -385,8 +385,8 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	id.ino_generation = event->ino_generation;
 
 	dso = dsos__findnew_id(&machine->dsos, event->filename, &id);
-	if (dso && dso->has_build_id) {
-		bid = dso->bid;
+	if (dso && dso__has_build_id(dso)) {
+		bid = *dso__bid(dso);
 		rc = 0;
 		goto out;
 	}
@@ -407,7 +407,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 		event->__reserved_1 = 0;
 		event->__reserved_2 = 0;
 
-		if (dso && !dso->has_build_id)
+		if (dso && !dso__has_build_id(dso))
 			dso__set_build_id(dso, &bid);
 	} else {
 		if (event->filename[0] == '/') {
@@ -684,7 +684,7 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
 	dso = map__dso(map);
 	if (symbol_conf.buildid_mmap2) {
-		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
 		event->mmap2.header.type = PERF_RECORD_MMAP2;
 		event->mmap2.header.size = (sizeof(event->mmap2) -
 					(sizeof(event->mmap2.filename) - size));
@@ -694,11 +694,11 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 		event->mmap2.len   = map__size(map);
 		event->mmap2.pid   = args->machine->pid;
 
-		memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
+		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
 
 		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
 	} else {
-		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
 		event->mmap.header.type = PERF_RECORD_MMAP;
 		event->mmap.header.size = (sizeof(event->mmap) -
 					(sizeof(event->mmap.filename) - size));
@@ -708,7 +708,7 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 		event->mmap.len   = map__size(map);
 		event->mmap.pid   = args->machine->pid;
 
-		memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
+		memcpy(event->mmap.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
 	}
 
 	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
@@ -2231,20 +2231,20 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 	union perf_event ev;
 	size_t len;
 
-	if (!pos->hit)
+	if (!dso__hit(pos))
 		return 0;
 
 	memset(&ev, 0, sizeof(ev));
 
-	len = pos->long_name_len + 1;
+	len = dso__long_name_len(pos) + 1;
 	len = PERF_ALIGN(len, NAME_ALIGN);
-	ev.build_id.size = min(pos->bid.size, sizeof(pos->bid.data));
-	memcpy(&ev.build_id.build_id, pos->bid.data, ev.build_id.size);
+	ev.build_id.size = min(dso__bid(pos)->size, sizeof(dso__bid(pos)->data));
+	memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
 	ev.build_id.header.size = sizeof(ev.build_id) + len;
-	memcpy(&ev.build_id.filename, pos->long_name, pos->long_name_len);
+	memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name_len(pos));
 
 	return process(tool, &ev, NULL, machine);
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 1aa8962dcf52..0a473112f881 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -457,14 +457,14 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 
 	dso = map__dso(al.map);
 
-	if (!dso || dso->data.status == DSO_DATA_STATUS_ERROR || map__load(al.map) < 0) {
+	if (!dso || dso__data(dso)->status == DSO_DATA_STATUS_ERROR || map__load(al.map) < 0) {
 		addr_location__exit(&al);
 		return -1;
 	}
 
 	offset = map__map_ip(al.map, ip);
 	if (is64bit)
-		*is64bit = dso->is_64_bit;
+		*is64bit = dso__is_64_bit(dso);
 
 	addr_location__exit(&al);
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 6a5ac0faa6f4..cde267ea3e99 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -329,27 +329,27 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 	};
 	int ret, fd;
 
-	if (dso->data.eh_frame_hdr_offset == 0) {
+	if (dso__data(dso)->eh_frame_hdr_offset == 0) {
 		fd = dso__data_get_fd(dso, ui->machine);
 		if (fd < 0)
 			return -EINVAL;
 
 		/* Check the .eh_frame section for unwinding info */
 		ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
-						     &dso->data.eh_frame_hdr_addr,
-						     &dso->data.eh_frame_hdr_offset);
-		dso->data.elf_base_addr = elf_base_address(fd);
+						     &dso__data(dso)->eh_frame_hdr_addr,
+						     &dso__data(dso)->eh_frame_hdr_offset);
+		dso__data(dso)->elf_base_addr = elf_base_address(fd);
 		dso__data_put_fd(dso);
-		if (ret || dso->data.eh_frame_hdr_offset == 0)
+		if (ret || dso__data(dso)->eh_frame_hdr_offset == 0)
 			return -EINVAL;
 	}
 
 	maps__for_each_map(thread__maps(ui->thread), read_unwind_spec_eh_frame_maps_cb, &args);
 
-	args.base_addr -= dso->data.elf_base_addr;
+	args.base_addr -= dso__data(dso)->elf_base_addr;
 	/* Address of .eh_frame_hdr */
-	*segbase = args.base_addr + dso->data.eh_frame_hdr_addr;
-	ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
+	*segbase = args.base_addr + dso__data(dso)->eh_frame_hdr_addr;
+	ret = unwind_spec_ehframe(dso, ui->machine, dso__data(dso)->eh_frame_hdr_offset,
 				   table_data, fde_count);
 	if (ret)
 		return ret;
@@ -460,7 +460,7 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 		return -EINVAL;
 	}
 
-	pr_debug("unwind: find_proc_info dso %s\n", dso->name);
+	pr_debug("unwind: find_proc_info dso %s\n", dso__name(dso));
 
 	/* Check the .eh_frame section for unwinding info */
 	if (!read_unwind_spec_eh_frame(dso, ui, &table_data, &segbase, &fde_count)) {
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 2728eb4f13ea..cb8be6acfb6f 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -25,7 +25,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 		return 0;
 
 	if (maps__addr_space(maps)) {
-		pr_debug("unwind: thread map already set, dso=%s\n", dso->name);
+		pr_debug("unwind: thread map already set, dso=%s\n", dso__name(dso));
 		if (initialized)
 			*initialized = true;
 		return 0;
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 35532dcbff74..1b6f8f6db7aa 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -148,7 +148,7 @@ static int machine__thread_dso_type_maps_cb(struct map *map, void *data)
 	struct machine__thread_dso_type_maps_cb_args *args = data;
 	struct dso *dso = map__dso(map);
 
-	if (!dso || dso->long_name[0] != '/')
+	if (!dso || dso__long_name(dso)[0] != '/')
 		return 0;
 
 	args->dso_type = dso__type(dso, args->machine);
@@ -361,7 +361,7 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 
 bool dso__is_vdso(struct dso *dso)
 {
-	return !strcmp(dso->short_name, DSO__NAME_VDSO) ||
-	       !strcmp(dso->short_name, DSO__NAME_VDSO32) ||
-	       !strcmp(dso->short_name, DSO__NAME_VDSOX32);
+	return !strcmp(dso__short_name(dso), DSO__NAME_VDSO) ||
+	       !strcmp(dso__short_name(dso), DSO__NAME_VDSO32) ||
+	       !strcmp(dso__short_name(dso), DSO__NAME_VDSOX32);
 }
-- 
2.44.0.478.gd926399ef9-goog


