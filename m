Return-Path: <bpf+bounces-69335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B29B94329
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA25218A7BEE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0E2BD5B9;
	Tue, 23 Sep 2025 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnFVoXHH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A327703C
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601165; cv=none; b=O1XkZ27g7Ysk8ofIA0Lii7U6sp2FCeHer1uH0czNVXedHYvc5Ges6K1te12xyQLg7W0cq9s0W48jQdrIRtKO2VKvwYLFwg/s/Aqe+8+U+3PMJ7JYjteNOLPN3/1KPHkJCcPbc7W+ugz3BIC0t5RZ26xGIYcxwMv8/ixetv4RtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601165; c=relaxed/simple;
	bh=NWBAW3y8TVj1NFNioDjU58ZzRhKs/wIfiAJJKu8kiJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkH6ACk/JJFKvJpDoXyBJRH5BotRGUMztkmSnPccUSZLfRF018stVVr70E+1QQkaTfcRJ6LfTJ/O5WUwjFEHZQbXy9mdeB2a3HYhauJQb/ILmVBpIFPwyBVC2JLVzK/hCPnlpfxUtqzHdeNfEs2b7kRYHsA6g+Hqu6xTtM50P+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnFVoXHH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-268149e1c28so59576275ad.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601161; x=1759205961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7eBWQBMnNteQHZ1zVbXYWUdnzRH/KvDEdLro/KwtrM=;
        b=JnFVoXHH0yDXxw7f7LIxTaSLpAnVlfuIgf+eU1mme9A7RAJGeuS6p4A7m3BcqbR644
         PFhBSwDM8y2fxpNWdErkJT1yc9FUBM6NuXOibyZa/Fo/yYB7+rJKxoUEQL+tCST3ini4
         f+KIE2/T3gzmzwQqiNEgabrR2qWEpwhwBv4yw5GRJ0rOsELKpUyYPyzlJCFr14oY7AIJ
         hBfMfW2pIBaajL2ShRc4l1DzlQ5f9xy6jgqe+hlScaySEiIT22kabf/1Fj9okzSn/wjF
         UGiG/LX9kZTF0TIkMPRUm4i5hKcK31upQuqEa/pZcxbIoKM5fhp/PpihIxYxtTcBfb5i
         jEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601161; x=1759205961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7eBWQBMnNteQHZ1zVbXYWUdnzRH/KvDEdLro/KwtrM=;
        b=bqAGh2g9tkPnB/aAU3LxMBFcoJ4vLwUjYykbY2tWdA9ylkRw+0JTnZmRLr9tttLz7z
         J50oFueES7XXSX3Q7caK2SWk2J+KZaQ0bVhuv92sfB14zqhXXmwj1/0MEOreMx7Yo6uN
         lqTKriVhlnmg3nze4QsLYzyX3Yy676EyD4T5A7rx+LeCTHgQVpl7zXUwjQP7juCxR0cC
         BQyBb4K/u12BOYlKHZIKcoQKNwVc8oQ/83xBHyE89TIo87ymYNgAcl1Due6VmxLD649q
         Mx3mAxczGOi9WOGw/MNw7n1Pio81LicjnF3iq+fdp0uYRklv5UWDm4JPBKLekVeNxTkt
         M9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXE/hoL6UMgyHzRwYolby2ajJbgQcmPUT9yw487YR3W/e7fPCBztMpjFRaCd39XBGEzvb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZq531y1JggG0CJ0+TUSXw9laooxNhH5KzyLXmrdGLcbFXLf5V
	ar+oKj3nJO5thn6WrhZ29xFSXzK9Ae23lWT5uoEqMHEreyT5rc2G+35z5JyrDQibh2vH7pcoXgt
	GvNYrSxzJ7A==
X-Google-Smtp-Source: AGHT+IEYLJRrVdJn24ITbOWXqVwiFnIcFBnu10skEtQ3IZitPdrM0V2tzUDIGD2OJiUBldHKG8KIuYvcFquC
X-Received: from plmm10.prod.google.com ([2002:a17:902:c44a:b0:269:7051:8e4a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2311:b0:267:cdb8:c682
 with SMTP id d9443c01a7336-27cc561f88bmr15485245ad.30.1758601161368; Mon, 22
 Sep 2025 21:19:21 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:34 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-16-irogers@google.com>
Subject: [PATCH v5 15/25] perf print-events: Remove print_symbol_events
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

Now legacy hardware events are in json there's no need for a specific
printing routine that previously served for both hardware and software
events. The associated event_symbols_hw is also removed. To support
the previous filtered version use an event glob of "legacy hardware"
which matches the topic of the json events.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 18 +++++++----
 tools/perf/util/parse-events.c | 43 -------------------------
 tools/perf/util/parse-events.h |  1 -
 tools/perf/util/print-events.c | 57 ----------------------------------
 tools/perf/util/print-events.h |  3 --
 5 files changed, 12 insertions(+), 110 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b6720ef3adf6..16400366f827 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -633,10 +633,18 @@ int cmd_list(int argc, const char **argv)
 			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") == 0 ||
-			 strcmp(argv[i], "hardware") == 0)
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
-		else if (strcmp(argv[i], "sw") == 0 ||
+			   strcmp(argv[i], "hardware") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy hardware");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
 			static const char * const sw_globs[] = { "software", "tool" };
@@ -714,8 +722,6 @@ int cmd_list(int argc, const char **argv)
 				continue;
 			}
 			default_ps.event_glob = s;
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f9c52eadac46..8d3eda3badfd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -42,49 +42,6 @@ static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
-const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = {
-		.symbol = "cpu-cycles",
-		.alias  = "cycles",
-	},
-	[PERF_COUNT_HW_INSTRUCTIONS] = {
-		.symbol = "instructions",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_REFERENCES] = {
-		.symbol = "cache-references",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_MISSES] = {
-		.symbol = "cache-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = {
-		.symbol = "branch-instructions",
-		.alias  = "branches",
-	},
-	[PERF_COUNT_HW_BRANCH_MISSES] = {
-		.symbol = "branch-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BUS_CYCLES] = {
-		.symbol = "bus-cycles",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {
-		.symbol = "stalled-cycles-frontend",
-		.alias  = "idle-cycles-frontend",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = {
-		.symbol = "stalled-cycles-backend",
-		.alias  = "idle-cycles-backend",
-	},
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = {
-		.symbol = "ref-cycles",
-		.alias  = "",
-	},
-};
-
 static const char *const event_types[] = {
 	[PERF_TYPE_HARDWARE]	= "hardware",
 	[PERF_TYPE_SOFTWARE]	= "software",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0db5e223e10d..23a42395d516 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -265,7 +265,6 @@ struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
-extern const struct event_symbol event_symbols_hw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 91a5d9c7882b..8f3ed83853a9 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,60 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max)
-{
-	struct strlist *evt_name_list = strlist__new(NULL, NULL);
-	struct str_node *nd;
-
-	if (!evt_name_list) {
-		pr_debug("Failed to allocate new strlist for symbol events\n");
-		return;
-	}
-	for (unsigned int i = 0; i < max; i++) {
-		/*
-		 * New attr.config still not supported here, the latest
-		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
-		 */
-		if (syms[i].symbol == NULL)
-			continue;
-
-		if (!is_event_supported(type, i))
-			continue;
-
-		if (strlen(syms[i].alias)) {
-			char name[MAX_NAME_LEN];
-
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms[i].symbol, syms[i].alias);
-			strlist__add(evt_name_list, name);
-		} else
-			strlist__add(evt_name_list, syms[i].symbol);
-	}
-
-	strlist__for_each_entry(nd, evt_name_list) {
-		char *alias = strstr(nd->s, " OR ");
-
-		if (alias) {
-			*alias = '\0';
-			alias += 4;
-		}
-		print_cb->print_event(print_state,
-				/*topic=*/NULL,
-				/*pmu_name=*/NULL,
-				type,
-				nd->s,
-				alias,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				event_type_descriptors[type],
-				/*desc=*/NULL,
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-	}
-	strlist__delete(evt_name_list);
-}
-
 /** struct mep - RB-tree node for building printing information. */
 struct mep {
 	/** nd - RB-tree element. */
@@ -378,9 +324,6 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
-			event_symbols_hw, PERF_COUNT_HW_MAX);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 44e5dbd91400..eabba5d4a1fd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -33,9 +33,6 @@ struct print_callbacks {
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max);
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
-- 
2.51.0.534.gc79095c0ca-goog


