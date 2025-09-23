Return-Path: <bpf+bounces-69327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A5DB942FF
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B363B111C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261C281370;
	Tue, 23 Sep 2025 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="En6oQYU+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9627FB21
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601145; cv=none; b=a73WXnTuYKE6nWeuVSpjLXPm9xkiXbBZbPYbn0QfNhyN4omx93kS+wg8p3byAUDQl1jaA0ps8pN6hDlL9vkrtN3E+j+mXUfDsFsDBKEeaxtvMKq2Oe9HSWr2TNFQ8jjL5NpOVi7YoupFAtyGsckRozB0Zs82cs+G6vmqjAZRIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601145; c=relaxed/simple;
	bh=Cs8Alqy8OItgfjcI+ymyaZsJYwmV9qH6XDxHYBmBFQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LQNpHgyLPajEP0HkJpguQFXVet+xlMtYX1z+Xy/M7BY69eMLJn7YwCSGtEJS2F8VIYGD922rWMF/QPa2CyZdDjT/X5XCMn1D+PdoAvcKLHL20gLNBzKo0CSovS2Ff/sE37bYPA4x/0L7LeQ/ACxq4t4H89M3DocAM5MAlGP2j3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=En6oQYU+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso4774375a91.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601142; x=1759205942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGADey4D+shMjiufqcPZD2udEIukPpBkEtxE2aRvRZc=;
        b=En6oQYU+uo7Y8icwcZ1ZpCi7fWNmgT0kG6HvGQqQ75Fu2tG7ibrn4nhz//rru1VFqY
         4HWg8CfQSDUUVKMS7oMSJ/XiB/Chjf/moeCxhcqaIim3WuE+eidmsy7xlKBnfL9Pd1OH
         tYk3PGH11Nmf4uBqoOAY63eSgjeTEKsT0dxDrHHUEOhvLcBLI02B5L0Nzu/DN7E5AFVJ
         3MpDXN18CE6HUKPEf/MCMWkwWY0d+Ruz5VIaS2YKwT37D2mCAPonPWs6vr2HuAJuwfJ5
         wLXDrud3Tpim8DosPr54Ogz1yVnZdApCAD94vixChuvNXLN9ekoMG95LsP1GwTMMnMmG
         vLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601142; x=1759205942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGADey4D+shMjiufqcPZD2udEIukPpBkEtxE2aRvRZc=;
        b=TkxjgRAKuNBGH2e89HTcPNRHFt9LlUhSW066nxR89sA/yqjMg30Au/G38qWdkXM47B
         //OHLGeYYjs8NOkF/eLpMHh98LZSEUzH1uz9+4RjAdlgjE+anPMY9D8M1BeyD7O3/1qu
         gwUd3Ilyh29axVg8iaZidrBe1b+ossNkKtsFRkVJn8WBzPTT8C8/aoYDf/F68zBuDhUx
         9DaZyxR5v8W6FlcXGoGLse6Yi7muFgE5CedoHkYQ9Ko/dZ4aFGGcTcVSLaDKFvOQtCmf
         8hKzlz0/2kZ4oD6FnDrUqRIc+2L8FC+kFz+PunDBTgaXI7/WGcK51K/2dro52IgZnQYZ
         EDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUd3h1DPCSahxglJzRd7luUx1VtP7HR5iRYbyB6lVK2SLEXuHxb8Yw6o510eRwVlSGRV38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUIs4Dw14STj+xxwI4jcFPH5eP2tH5QLIlW4rpN+pRE3eGBhmQ
	4LevcEMCGEA59Q2sTArrVfpmukxK6P2/6P+6udsfGd67O/lbJ9B07L6K4q5bU50ZCgL2YlxD2g1
	y6C5ByP5w2Q==
X-Google-Smtp-Source: AGHT+IHHV+n0ga9EJeQV2GQR4QE6sntZ0aW4o0rgO0MBwPzp2wF8ynAISk1a5aSZQixepD+aZmbBqiJnuJK7
X-Received: from pjur13.prod.google.com ([2002:a17:90a:d40d:b0:327:b1f8:7689])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec83:b0:32b:a2b9:b200
 with SMTP id 98e67ed59e1d1-332a954b821mr1615148a91.13.1758601141817; Mon, 22
 Sep 2025 21:19:01 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:25 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-7-irogers@google.com>
Subject: [PATCH v5 06/25] perf pmu: Don't eagerly parse event terms
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
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

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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
index d5675471afc5..9ec1738a5a64 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -40,6 +40,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
+static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
 const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -2854,7 +2855,7 @@ void parse_events_terms__delete(struct parse_events_terms *terms)
 	free(terms);
 }
 
-int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb)
+static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb)
 {
 	struct parse_events_term *term;
 	bool first = true;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index be8d2ac1e4e4..9c975bb09fe8 100644
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
2.51.0.534.gc79095c0ca-goog


