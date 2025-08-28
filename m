Return-Path: <bpf+bounces-66791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD1B393FD
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811C7682444
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C22877DA;
	Thu, 28 Aug 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvTYlASH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898E27A90F
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363368; cv=none; b=YuDJfsMM6tr2DDpvl1clsEkhqlJc85tuaRlHVByjCPXt+l3cvHBKs2o7h+Z9j6Ys/9sgoOjU/G85LivH5RS1bOTz/yV6UCkEaZdjCqh93bR0ePWLX7XOyrILfJZMoIGVo/p4yH2OlgDVcRvRdRRfZqvjcaPRYZXjKOp+OO2p2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363368; c=relaxed/simple;
	bh=kAT02dDDWsSGP9sGI7I247Ndnj+YB4J+E7aqX6xLsqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=vCJ4nyKO5zsgwSH7KunBHRfU/IRe5QT7PZWsJhB4mL7Pg9jFy9KVaE3RBH12GEcDpD9JMjfwZN11g8I9koEc2ZeIMXynHH0+Yv/1djty2E+aivwJKvf9lhjJOI7Ndy2Sjdlc2QsS9CPY0MKZgQalTuZ4GDltLTDFcYoRgb+V4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvTYlASH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32752f91beaso822802a91.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363366; x=1756968166; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gF9feMjUqWwRH6NwL2mVQB58/A0Uxdl0uj3m+TeYl8=;
        b=pvTYlASHVMNCLyWs9hQmyh01tbo0meJamBtcHivNfhipE1YryxI5kHZTTQ3VKXM7Zc
         PLU/na0vkyWhFtllTTeNrUqNlYFglEMauDBHnZDwhmPj1VR1M8OCjpsiJ8/7AGGu85od
         ITmKTiD1vNgPvbkG/hGBVel2JWL33V5DWU4H+HVDIw9xzT+HdWIpqHkH0EszBDJznvto
         MYV9cmooYcL5hBFSdCD7HbS6pEv71Av1CPgSH56UrIR/wGKXredjjbdR+LMe3az5IH6V
         YW3OvE8q+5vJIxRKSutVVZTPU2s/zacnqAkGeKIMRmB8TLWx7J6l0yj3OA5gh0Jn8wT5
         /yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363366; x=1756968166;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gF9feMjUqWwRH6NwL2mVQB58/A0Uxdl0uj3m+TeYl8=;
        b=dJezjACQy7CX8V398cfjK/7R8J2ww7+Ax9wqGVxbDPHoYPkFItpg22sNi8K5x6mClh
         qZM78KjE4enMYVjPMyW8UrsqGvc68So4iz75H76KzzRVjGz9hxTjyjSeu7oDMttURTyw
         fpYafEoBWck99h8Hbrww8bttbacuGOVpo/5rtZBf5zuPqxejgpLBAQNdpQ63dzMCX5zk
         jSYsUrMH+83O9xsDzoroUzTtErCL0nIN5FWUnwNSOvIucWVnv4fkpGjviCp8MEUFBOXW
         ip9xycqIGPGRTD6TMS6gzR6+Dvag8jMp7lQXCaUuXXPXG9dpYwzUe4xNbmJJ8K2P9g3l
         Pxfg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/Nr6fA29LJK8grwEhDbgv2x3axqIDOJ2m5H8Q52otjq7CYCKzaj+YB3vR47YoTOV744=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbRvgqmu46m89RDBnCt2IedtsOF1VDCF2B4BujnZtoA20N5zi
	LWG3wwdOQNKud7tGJ1KfkTDnsp0PYDBbDdcodjiG5cdwiYwv2fKwIhCmF1izveVnd4RnMHr/QM/
	SQJtRde6Jfg==
X-Google-Smtp-Source: AGHT+IFgW0Fx1q5G+olKYMDpPri5WIiekUFtsAq3GsVW/rKmMll0HaM2VvuHcxN3FoAgFWl/xuQuJrlD0RAM
X-Received: from pjbpa13.prod.google.com ([2002:a17:90b:264d:b0:31f:3029:884a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5343:b0:314:2892:b1e0
 with SMTP id 98e67ed59e1d1-32515ee3bcfmr26127640a91.34.1756363365698; Wed, 27
 Aug 2025 23:42:45 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:23 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-6-irogers@google.com>
Subject: [PATCH v1 05/13] perf pmu: Don't eagerly parse event terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

When an event/alias is created for a PMU the terms are eagerly parsed
using parse_events_terms. For a command like perf stat or perf record,
the particularly event/alias will be found, the terms parsed, the
terms cloned for use in the event parsing, and then the terms used to
configure the perf_event_attr. Events/aliases may be eagerly loaded,
such as from sysfs or in perf list, in which case the aliases terms
will be little or never used. To avoid redundant work, to avoid
cloning, and to reduce memory overhead, hold the terms for an event as
a string until they need handling as a term list. This may introduce
duplicate parsing if an event is repeated in a list, but this
situation is expected to be uncommon.

Measuring the number of instructions before and after with a sysfs
event and perf stat, there is a minor reduction in the number of
instructions executed by 0.3%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c  |  24 +------
 tools/perf/util/parse-events.c |   3 +-
 tools/perf/util/parse-events.h |   1 -
 tools/perf/util/pmu.c          | 111 ++++++++++++++++++++-------------
 4 files changed, 70 insertions(+), 69 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 95fd9f671a22..f40a828c9861 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -22,10 +22,6 @@ struct perf_pmu_test_event {
 	/* used for matching against events from generated pmu-events.c */
 	struct pmu_event event;
 
-	/* used for matching against event aliases */
-	/* extra events for aliases */
-	const char *alias_str;
-
 	/*
 	 * Note: For when PublicDescription does not exist in the JSON, we
 	 * will have no long_desc in pmu_event.long_desc, but long_desc may
@@ -52,7 +48,6 @@ static const struct perf_pmu_test_event bp_l1_btb_correct = {
 		.desc = "L1 BTB Correction",
 		.topic = "branch",
 	},
-	.alias_str = "event=0x8a",
 };
 
 static const struct perf_pmu_test_event bp_l2_btb_correct = {
@@ -63,7 +58,6 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
 		.desc = "L2 BTB Correction",
 		.topic = "branch",
 	},
-	.alias_str = "event=0x8b",
 };
 
 static const struct perf_pmu_test_event segment_reg_loads_any = {
@@ -74,7 +68,6 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
 		.desc = "Number of segment register loads",
 		.topic = "other",
 	},
-	.alias_str = "event=0x6,period=0x30d40,umask=0x80",
 };
 
 static const struct perf_pmu_test_event dispatch_blocked_any = {
@@ -85,7 +78,6 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
 		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
 		.topic = "other",
 	},
-	.alias_str = "event=0x9,period=0x30d40,umask=0x20",
 };
 
 static const struct perf_pmu_test_event eist_trans = {
@@ -96,7 +88,6 @@ static const struct perf_pmu_test_event eist_trans = {
 		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 		.topic = "other",
 	},
-	.alias_str = "event=0x3a,period=0x30d40",
 };
 
 static const struct perf_pmu_test_event l3_cache_rd = {
@@ -108,7 +99,6 @@ static const struct perf_pmu_test_event l3_cache_rd = {
 		.long_desc = "Attributable Level 3 cache access, read",
 		.topic = "cache",
 	},
-	.alias_str = "event=0x40",
 	.alias_long_desc = "Attributable Level 3 cache access, read",
 };
 
@@ -130,7 +120,6 @@ static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
 		.topic = "uncore",
 		.pmu = "hisi_sccl,ddrc",
 	},
-	.alias_str = "event=0x2",
 	.matching_pmu = "hisi_sccl1_ddrc2",
 };
 
@@ -142,7 +131,6 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 		.topic = "uncore",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0x22,umask=0x81",
 	.matching_pmu = "uncore_cbox_0",
 };
 
@@ -154,7 +142,6 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 		.topic = "uncore",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0xe0",
 	.matching_pmu = "uncore_cbox_0",
 };
 
@@ -166,7 +153,6 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
 		.topic = "uncore",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "event=0xc0",
 	.matching_pmu = "uncore_cbox_0",
 };
 
@@ -178,7 +164,6 @@ static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
 		.topic = "uncore",
 		.pmu = "hisi_sccl,l3c",
 	},
-	.alias_str = "event=0x7",
 	.matching_pmu = "hisi_sccl3_l3c7",
 };
 
@@ -190,7 +175,6 @@ static const struct perf_pmu_test_event uncore_imc_free_running_cache_miss = {
 		.topic = "uncore",
 		.pmu = "uncore_imc_free_running",
 	},
-	.alias_str = "event=0x12",
 	.matching_pmu = "uncore_imc_free_running_0",
 };
 
@@ -202,7 +186,6 @@ static const struct perf_pmu_test_event uncore_imc_cache_hits = {
 		.topic = "uncore",
 		.pmu = "uncore_imc",
 	},
-	.alias_str = "event=0x34",
 	.matching_pmu = "uncore_imc_0",
 };
 
@@ -226,7 +209,6 @@ static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
 		.pmu = "uncore_sys_ddr_pmu",
 		.compat = "v8",
 	},
-	.alias_str = "event=0x2b",
 	.matching_pmu = "uncore_sys_ddr_pmu0",
 };
 
@@ -239,7 +221,6 @@ static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
 		.pmu = "uncore_sys_ccn_pmu",
 		.compat = "0x01",
 	},
-	.alias_str = "config=0x2c",
 	.matching_pmu = "uncore_sys_ccn_pmu4",
 };
 
@@ -252,7 +233,6 @@ static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
 		.pmu = "uncore_sys_cmn_pmu",
 		.compat = "(434|436|43c|43a).*",
 	},
-	.alias_str = "eventid=0x1,type=0x5",
 	.matching_pmu = "uncore_sys_cmn_pmu0",
 };
 
@@ -374,9 +354,9 @@ static int compare_alias_to_test_event(struct pmu_event_info *alias,
 		return -1;
 	}
 
-	if (!is_same(alias->str, test_event->alias_str)) {
+	if (!is_same(alias->str, test_event->event.event)) {
 		pr_debug("testing aliases PMU %s: mismatched str, %s vs %s\n",
-			  pmu_name, alias->str, test_event->alias_str);
+			  pmu_name, alias->str, test_event->event.event);
 		return -1;
 	}
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c219e3ffae65..cc677d9b2d5a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -40,6 +40,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
+static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
 const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -2849,7 +2850,7 @@ void parse_events_terms__delete(struct parse_events_terms *terms)
 	free(terms);
 }
 
-int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb)
+static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb)
 {
 	struct parse_events_term *term;
 	bool first = true;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c498d896badf..34a5ec21d5e8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -199,7 +199,6 @@ void parse_events_terms__delete(struct parse_events_terms *terms);
 void parse_events_terms__init(struct parse_events_terms *terms);
 void parse_events_terms__exit(struct parse_events_terms *terms);
 int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
-int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
 struct parse_events_modifier {
 	u8 precise;	/* Number of repeated 'p' for precision. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5a291f1380ed..ddcd4918832d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -67,8 +67,8 @@ struct perf_pmu_alias {
 	 * json events.
 	 */
 	char *topic;
-	/** @terms: Owned list of the original parsed parameters. */
-	struct parse_events_terms terms;
+	/** @terms: Owned copy of the event terms. */
+	char *terms;
 	/**
 	 * @pmu_name: The name copied from the json struct pmu_event. This can
 	 * differ from the PMU name as it won't have suffixes.
@@ -429,7 +429,7 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 	zfree(&alias->long_desc);
 	zfree(&alias->topic);
 	zfree(&alias->pmu_name);
-	parse_events_terms__exit(&alias->terms);
+	zfree(&alias->terms);
 	free(alias);
 }
 
@@ -537,8 +537,8 @@ static int update_alias(const struct pmu_event *pe,
 	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
 	data->alias->per_pkg = pe->perpkg;
 	if (pe->event) {
-		parse_events_terms__exit(&data->alias->terms);
-		ret = parse_events_terms(&data->alias->terms, pe->event, /*input=*/NULL);
+		zfree(&data->alias->terms);
+		data->alias->terms = strdup(pe->event);
 	}
 	if (!ret && pe->unit) {
 		char *unit;
@@ -590,7 +590,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (!alias)
 		return -ENOMEM;
 
-	parse_events_terms__init(&alias->terms);
 	alias->scale = 1.0;
 	alias->unit[0] = '\0';
 	alias->per_pkg = perpkg;
@@ -615,11 +614,16 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	ret = parse_events_terms(&alias->terms, val, val_fd);
-	if (ret) {
-		pr_err("Cannot parse alias %s: %d\n", val, ret);
-		free(alias);
-		return ret;
+	if (!val_fd) {
+		alias->terms = strdup(val);
+	} else {
+		size_t line_len;
+
+		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		if (ret) {
+			pr_err("Failed to read alias %s\n", name);
+			return ret;
+		}
 	}
 
 	alias->name = strdup(name);
@@ -767,29 +771,21 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 	return ret;
 }
 
-static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
+static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
 {
-	struct parse_events_term *term, *cloned;
-	struct parse_events_terms clone_terms;
-
-	parse_events_terms__init(&clone_terms);
-	list_for_each_entry(term, &alias->terms.terms, list) {
-		int ret = parse_events_term__clone(&cloned, term);
+	struct parse_events_terms alias_terms;
+	int ret;
 
-		if (ret) {
-			parse_events_terms__exit(&clone_terms);
-			return ret;
-		}
-		/*
-		 * Weak terms don't override command line options,
-		 * which we don't want for implicit terms in aliases.
-		 */
-		cloned->weak = true;
-		cloned->err_term = cloned->err_val = err_loc;
-		list_add_tail(&cloned->list, &clone_terms.terms);
+	parse_events_terms__init(&alias_terms);
+	ret = parse_events_terms(&alias_terms, alias->terms, /*input=*/NULL);
+	if (ret) {
+		pr_err("Cannot parse '%s' terms '%s': %d\n",
+		       alias->name, alias->terms, ret);
+		parse_events_terms__exit(&alias_terms);
+		return ret;
 	}
-	list_splice_init(&clone_terms.terms, terms);
-	parse_events_terms__exit(&clone_terms);
+	list_splice_init(&alias_terms.terms, terms);
+	parse_events_terms__exit(&alias_terms);
 	return 0;
 }
 
@@ -1813,10 +1809,10 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		alias = pmu_find_alias(pmu, term);
 		if (!alias)
 			continue;
-		ret = pmu_alias_terms(alias, term->err_term, &term->list);
+		ret = pmu_alias_terms(alias, &term->list);
 		if (ret) {
 			parse_events_error__handle(err, term->err_term,
-						strdup("Failure to duplicate terms"),
+						strdup("Failed to parse terms"),
 						NULL);
 			return ret;
 		}
@@ -2035,18 +2031,37 @@ static int sub_non_neg(int a, int b)
 static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
+	struct parse_events_terms terms;
 	struct parse_events_term *term;
+	int ret, used;
 	size_t pmu_name_len = pmu_deduped_name_len(pmu, pmu->name,
 						   skip_duplicate_pmus);
-	int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
-	list_for_each_entry(term, &alias->terms.terms, list) {
+	/* Paramemterized events have the parameters shown. */
+	if (strstr(alias->terms, "=?")) {
+		/* No parameters. */
+		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
+		return buf;
+	}
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, alias->terms, /*input=*/NULL);
+	if (ret) {
+		pr_err("Failure to parse '%s' terms '%s': %d\n",
+			alias->name, alias->terms, ret);
+		parse_events_terms__exit(&terms);
+		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
+		return buf;
+	}
+	used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
+
+	list_for_each_entry(term, &terms.terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
 			used += snprintf(buf + used, sub_non_neg(len, used),
 					",%s=%s", term->config,
 					term->val.str);
 	}
-
+	parse_events_terms__exit(&terms);
 	if (sub_non_neg(len, used) > 0) {
 		buf[used] = '/';
 		used++;
@@ -2069,7 +2084,6 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
-	struct strbuf sb;
 	struct hashmap_entry *entry;
 	size_t bkt;
 
@@ -2080,7 +2094,6 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__for_each_event(pmu, state, cb);
 
-	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
@@ -2115,16 +2128,14 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.desc = event->desc;
 		info.long_desc = event->long_desc;
 		info.encoding_desc = buf + buf_used;
-		parse_events_terms__to_strbuf(&event->terms, &sb);
 		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, sb.buf) + 1;
+				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
+		info.str = event->terms;
 		info.topic = event->topic;
-		info.str = sb.buf;
 		info.deprecated = event->deprecated;
 		ret = cb(state, &info);
 		if (ret)
 			goto out;
-		strbuf_setlen(&sb, /*len=*/ 0);
 	}
 	if (pmu->selectable) {
 		info.name = buf;
@@ -2140,7 +2151,6 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		ret = cb(state, &info);
 	}
 out:
-	strbuf_release(&sb);
 	return ret;
 }
 
@@ -2588,10 +2598,21 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
+		struct parse_events_terms terms;
+		int ret;
 
-		int ret = perf_pmu__config(pmu, &attr, &event->terms, /*apply_hardcoded=*/true,
-					   /*err=*/NULL);
+		parse_events_terms__init(&terms);
+		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
+		if (ret) {
+			pr_debug("Failed to parse '%s' terms '%s': %d\n",
+				event->name, event->terms, ret);
+			parse_events_terms__exit(&terms);
+			continue;
+		}
+		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
+				       /*err=*/NULL);
 
+		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.268.g9569e192d0-goog


