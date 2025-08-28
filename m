Return-Path: <bpf+bounces-66797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC60BB39408
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08104613F3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F92D0C67;
	Thu, 28 Aug 2025 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o32xaiX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27E2C2366
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363384; cv=none; b=M616N3vlvcHywhMGQ5Pz+1FwhQ192IvJDnJRWh/sg4NC2A9GLoCb2b0Z13oYKmuscLblVMWGSyA2ACr+SaODLTD6nPg+pfjrQ9mZB0jNW4jPUgKe9gLkftnBnVpUcYdUo8B1OGPAOhFSBvQtNadUk6JK/ZlF0vEFV/PVblcrwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363384; c=relaxed/simple;
	bh=Y9VemDJWbX8TQHe2hx79oPzCwB0Rr6nB+BanYPuzm88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GprS/zKwmuk1fs160Sjzd/jO9BWocvj1WKGVnPr2Sjo/LJ+QI+Nf2qzUK09LzvlK1Jvz3J3pPbDq+3zCc0hGlnIcj8EC9Ez/lXpFL2rlj6DdDxBZ4k5LicjwugF8jRoPgmoOwlLXD5NBWjPEPAoLKbexqq477ghQBscYRfX2eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o32xaiX7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2461c537540so8388465ad.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363382; x=1756968182; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAePWUSiZp5PO9N7cG5oKfC65uH/82xCZXfhzrxUKBY=;
        b=o32xaiX74isRW/ejjlqj9lb0gNGPVdZKATY1lwaAbUTtoizQMtYgM0imHuxX0qIeql
         wwcJCNavw22ghL2lCy9uMJ9kV53neqOAWzt8k281IovyCugjYp9mjEyAWjM9TWm8vya0
         Z92PgPeruV8q8+Gb7krTd/k/9stqjVaG89sJleAV0lvKX/+CT17jHW1yP6F1o2OWctmi
         onSxVXeJV/LVB2cTDiS9yt9mmeVTTn9DnbbEZ4aSE+nNSPGj8wmF4il3femdWYxDSmax
         CZxi4+lDnr2nMcjDmoZ9Wk0bvCACdSvNri23Yt2hmeIcvlOARt4WbeR+T1ub2z3TM6Se
         4Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363382; x=1756968182;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAePWUSiZp5PO9N7cG5oKfC65uH/82xCZXfhzrxUKBY=;
        b=nTAxmN3JbcoWs8jPCpFOSR3e7T+KLu3fpdblhXY1JZAXuSyLGSOrulGdBZgHnEEvDh
         PwGtOhZZRyzBfBfaITpDaEjwyOQ+K7/5fQbPoWgattQGY2C9YGGuBcpIZkR/JmZEmO5t
         6Phu/RchvPE50rn6udbVProY2sBE6M9msAk0Z6GqSnSSGptzmHpNtspolS5ylan/4XkJ
         JjhWvkDRFRdjm3lgpERacQDg+lRG2ptAhY8lrRtVE0Lk8Z3rMrVBc6MHf1Ij61+dDsYG
         63CO+XmrdmJroeBWc4yK+QLODe6wBGeRsfdyjMeBxIMK3dTIwVZsa8Y4zqw4X123t2o1
         gtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm3cE0AHSodXprP/Kh1D/T2lUkJrZbYZZ5cq/o3e5GrguAt1AlTR5DmyE9kQW1qwC0mpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYr/vcRCjOxAV378iWpf4KI2v2rqvAAKoyAnZv58QANIBOf4Y
	JO2U/92u+puK3pY4R8ncQARxnM85cZ+xixFSgqXqs661RksuzPHMzxpIvCoHmjjy7lf7GYr8eD3
	yJLQX8YOxwQ==
X-Google-Smtp-Source: AGHT+IHlM5wdtxRKgqraUgucxgZhWKIxth1oWcvTSUpfT8WOQ4ZagTi894CbwvdJHJiE3wmtI/Ho2lWoB0KX
X-Received: from plez4.prod.google.com ([2002:a17:902:ccc4:b0:246:1ef:f07c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c5:b0:240:3b9e:dd65
 with SMTP id d9443c01a7336-2462ef44573mr270453315ad.38.1756363382279; Wed, 27
 Aug 2025 23:43:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:30 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-13-irogers@google.com>
Subject: [PATCH v1 12/13] perf print-events: Remove print_symbol_events
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

Now legacy hardware events are in json there's no need for a specific
printing routine that previously served for both hardware and software
events. The associated event_symbols_hw is also removed. To support
the previous filtered version use an event glob of "legacy hardware"
which matches the topic of the json events.

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
index 5c4dc12637ef..1d59a0914f8e 100644
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
index 7981a5d468fa..6433f0ecdc88 100644
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
2.51.0.268.g9569e192d0-goog


