Return-Path: <bpf+bounces-68339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240BB56B24
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8139E17BD71
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF72E92D6;
	Sun, 14 Sep 2025 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWmgaa1K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F32DF145
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873527; cv=none; b=RCylVbwNoj2bGIT3usvyGl2KN8l3CW8dZgkc+oG6okFbkKJXCiKi+1qaLTmQk4MIeac64+MjCXW5TCywN0a0Bdg1jz5jDvMF+sqx16otmzI/qfGElP298jrZI164K3v0gHkH3FL0niAYn/FvnyP7m25K62HfpbE4vLRahe+olPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873527; c=relaxed/simple;
	bh=YGMlOPsQY0hS1FbIjoAhFgk7taxcZ7ly+5Y8Bc8jJm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mnp93HV+09Bzaxkhu7HR1nbrrIg2nsBtcy4Ihiy/h160Y+lS58IEtHrKR+gVLAw/TWpGQsELQ5yV+O0YeRpLKdn1C1A0XvfJv3LRgw/G9BlIMHRXVBDXXHDoNhP+3w8YgfKYVhCgckzRCG4qO+/XdgOWJSMvi9OTBDlA2fnjxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWmgaa1K; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4e796ad413so4630615a12.2
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873524; x=1758478324; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3HS3F+a4MkqhTUFmgS8wFSMiMxKWwkY+tvpDfXEhKQ=;
        b=BWmgaa1KkPS3L1L+tNcphgf2Lo1b2dEBgZ3NtkfFs7e8txBXqsgt/pDDZ+e47/taC3
         XchD4y0EvX+PySQq4NxSlgDra98p6I25ok0EsgrKnnrzQunN+7zSDkAEj9gzRCnTzI0S
         Wp1j/3Of3OPEI3poWX2gZK+gF9Bp5oCqenUn+eRY/6x8R/1/wZrrN9QWJGL+eDnbEWKG
         8eahSJPgyd6U4FvM5lHxSmtTeDadzpyOp7wsCud+wxgFRkiP8EzrtBR6cKch719GCJ7Z
         CpCOtltsXmORk6x+J9h+GxY0AnRG1D8ujsC1x9fm8WjRJYy72fYM+q4pZfGyYNTQDoao
         4lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873524; x=1758478324;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3HS3F+a4MkqhTUFmgS8wFSMiMxKWwkY+tvpDfXEhKQ=;
        b=ZH9JcfbFjT6niYhK5A5HjJucX6vfEhXSSn97YE/pVOW4UX+jl6B6I/AghMLe3Jhnqh
         zGySO+jbdP5P5Taj9l8wySHNVBCZmH9qfCfspTPtoHzSE4l3oP5YiKd/mwPDeyXa1FEz
         iLSbfHeGgiV7SAfUvA4l2FCHkuZVZ3rN2tht5AUx/OAlFcIrjIuwnJ+sQMADYlHX6PPw
         tsJCkdDnWVjr8UPP6gRH4UeOCKK0fDRsI2T3JntVrj/NZzDSln+C5bqNIKhLcVGaFWB3
         9rTkLYDtWbxdq+BQaC9cMEWp1IXWFIziZK6PDPD1fDx1qNOqgUEMenAlddv4o21fwACN
         uZbg==
X-Forwarded-Encrypted: i=1; AJvYcCXiSXfOK5i5tTvApId6eKap1JeLcY55D8c3bDXQ1xl+fzcxA+TcZHIblfgQoBp38TxBSIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqWgslqUPYXVSA9IO+jG1nqxYhSDNZvrIzkUrpFGYSpzil/rf
	/ucrjshOBp5dFv62nlu/FJvnXycxWnCcgjJy+if5O4tynXOe4G4NM+QO+M3CMKwifxzBGeemfqD
	5X4eyNpMI0Q==
X-Google-Smtp-Source: AGHT+IGsh3vLBHwnJUL4win41JQSrMrRhUFPE3RQXe7UrnWY8LOHLtjzbWd1BgEnWyAkK84QSxjvjAV2Xfyw
X-Received: from plbnb15.prod.google.com ([2002:a17:903:15cf:b0:24c:af07:f077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78c:b0:25d:89ca:35d4
 with SMTP id d9443c01a7336-25d89ca40fdmr106751025ad.4.1757873524153; Sun, 14
 Sep 2025 11:12:04 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:20 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-21-irogers@google.com>
Subject: [PATCH v4 20/21] perf parse-events: Add HW_CYCLES_STR as default
 cycles event string
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
Content-Type: text/plain; charset="UTF-8"

ARM managed to significantly overload the meaning of the "cycles"
event in their PMU kernel drivers through sysfs. In the tool use
"cpu-cycles" on ARM to avoid wildcard matching on different PMUS. This
is most commonly done in test code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c           |   4 +-
 tools/perf/tests/code-reading.c     |   4 +-
 tools/perf/tests/keep-tracking.c    |   2 +-
 tools/perf/tests/parse-events.c     | 100 ++++++++++++++--------------
 tools/perf/tests/perf-time-to-tsc.c |   2 +-
 tools/perf/tests/switch-tracking.c  |   2 +-
 tools/perf/util/evlist.c            |   2 +-
 tools/perf/util/parse-events.h      |  10 +++
 tools/perf/util/perf_api_probe.c    |   4 +-
 9 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2c38dd98f6ca..9f522b787ad5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1957,7 +1957,7 @@ static int add_default_events(void)
 				"cpu-migrations,"
 				"page-faults,"
 				"instructions,"
-				"cycles,"
+				HW_CYCLES_STR ","
 				"stalled-cycles-frontend,"
 				"stalled-cycles-backend,"
 				"branches,"
@@ -2043,7 +2043,7 @@ static int add_default_events(void)
 			 * Make at least one event non-skippable so fatal errors are visible.
 			 * 'cycles' always used to be default and non-skippable, so use that.
 			 */
-			if (strcmp("cycles", evsel__name(evsel)))
+			if (strcmp(HW_CYCLES_STR, evsel__name(evsel)))
 				evsel->skippable = true;
 		}
 	}
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9c2091310191..baa44918f555 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -649,7 +649,9 @@ static int do_test_code_reading(bool try_kcore)
 	struct map *map;
 	bool have_vmlinux, have_kcore;
 	struct dso *dso;
-	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
+	const char *events[] = {
+		HW_CYCLES_STR, HW_CYCLES_STR ":u", "cpu-clock", "cpu-clock:u", NULL
+	};
 	int evidx = 0;
 	struct perf_env host_env;
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index eafb49eb0b56..d54ddb4db47b 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	CHECK__(parse_event(evlist, "dummy:u"));
-	CHECK__(parse_event(evlist, "cycles:u"));
+	CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4e55b0d295bd..7d59648a0591 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -198,7 +198,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
 	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		int ret = assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		int ret = assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 
 		if (ret)
 			return ret;
@@ -884,7 +884,7 @@ static int test__group1(struct evlist *evlist)
 
 		/* cycles:upp */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		/* cycles:k */
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1085,7 +1085,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 
 		/* cycles:u + p */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1133,7 +1133,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles + G */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1168,7 +1168,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles:G */
 		evsel = leader = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1202,7 +1202,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1231,7 +1231,7 @@ static int test__group_gh1(struct evlist *evlist)
 
 		/* cycles + :H group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1278,7 +1278,7 @@ static int test__group_gh2(struct evlist *evlist)
 
 		/* cycles + :G group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1325,7 +1325,7 @@ static int test__group_gh3(struct evlist *evlist)
 
 		/* cycles:G + :u group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1372,7 +1372,7 @@ static int test__group_gh4(struct evlist *evlist)
 
 		/* cycles:G + :uG group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1417,7 +1417,7 @@ static int test__leader_sample1(struct evlist *evlist)
 
 		/* cycles - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1540,7 +1540,7 @@ static int test__pinned_group(struct evlist *evlist)
 
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1594,7 +1594,7 @@ static int test__exclusive_group(struct evlist *evlist)
 
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 		if (ret)
 			return ret;
 
@@ -1759,7 +1759,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 
 	if (ret)
 		return ret;
@@ -1771,7 +1771,7 @@ static int test__sym_event_slash(struct evlist *evlist)
 static int test__sym_event_dc(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 
 	if (ret)
 		return ret;
@@ -1783,7 +1783,7 @@ static int test__sym_event_dc(struct evlist *evlist)
 static int test__term_equal_term(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 
 	if (ret)
 		return ret;
@@ -1795,7 +1795,7 @@ static int test__term_equal_term(struct evlist *evlist)
 static int test__term_equal_legacy(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_CYCLES_STR);
 
 	if (ret)
 		return ret;
@@ -2006,27 +2006,27 @@ static const struct evlist_test test__events[] = {
 		/* 7 */
 	},
 	{
-		.name  = "{instructions:k,cycles:upp}",
+		.name  = "{instructions:k," HW_CYCLES_STR ":upp}",
 		.check = test__group1,
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,branches}:u,cycles:k",
+		.name  = "{faults:k,branches}:u," HW_CYCLES_STR ":k",
 		.check = test__group2,
 		/* 9 */
 	},
 	{
-		.name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
+		.name  = "group1{syscalls:sys_enter_openat:H," HW_CYCLES_STR ":kppp},group2{" HW_CYCLES_STR ",1:3}:G,instructions:u",
 		.check = test__group3,
 		/* 0 */
 	},
 	{
-		.name  = "{cycles:u,instructions:kp}:p",
+		.name  = "{" HW_CYCLES_STR ":u,instructions:kp}:p",
 		.check = test__group4,
 		/* 1 */
 	},
 	{
-		.name  = "{cycles,instructions}:G,{cycles:G,instructions:G},cycles",
+		.name  = "{" HW_CYCLES_STR ",instructions}:G,{" HW_CYCLES_STR ":G,instructions:G}," HW_CYCLES_STR,
 		.check = test__group5,
 		/* 2 */
 	},
@@ -2036,27 +2036,27 @@ static const struct evlist_test test__events[] = {
 		/* 3 */
 	},
 	{
-		.name  = "{cycles,cache-misses:G}:H",
+		.name  = "{" HW_CYCLES_STR ",cache-misses:G}:H",
 		.check = test__group_gh1,
 		/* 4 */
 	},
 	{
-		.name  = "{cycles,cache-misses:H}:G",
+		.name  = "{" HW_CYCLES_STR ",cache-misses:H}:G",
 		.check = test__group_gh2,
 		/* 5 */
 	},
 	{
-		.name  = "{cycles:G,cache-misses:H}:u",
+		.name  = "{" HW_CYCLES_STR ":G,cache-misses:H}:u",
 		.check = test__group_gh3,
 		/* 6 */
 	},
 	{
-		.name  = "{cycles:G,cache-misses:H}:uG",
+		.name  = "{" HW_CYCLES_STR ":G,cache-misses:H}:uG",
 		.check = test__group_gh4,
 		/* 7 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:S",
+		.name  = "{" HW_CYCLES_STR ",cache-misses,branch-misses}:S",
 		.check = test__leader_sample1,
 		/* 8 */
 	},
@@ -2071,7 +2071,7 @@ static const struct evlist_test test__events[] = {
 		/* 0 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:D",
+		.name  = "{" HW_CYCLES_STR ",cache-misses,branch-misses}:D",
 		.check = test__pinned_group,
 		/* 1 */
 	},
@@ -2109,7 +2109,7 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "task-clock:P,cycles",
+		.name  = "task-clock:P," HW_CYCLES_STR,
 		.check = test__checkevent_precise_max_modifier,
 		/* 7 */
 	},
@@ -2140,17 +2140,17 @@ static const struct evlist_test test__events[] = {
 		/* 2 */
 	},
 	{
-		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
+		.name  = HW_CYCLES_STR "/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
 	{
-		.name  = "cycles//u",
+		.name  = HW_CYCLES_STR "//u",
 		.check = test__sym_event_slash,
 		/* 4 */
 	},
 	{
-		.name  = "cycles:k",
+		.name  = HW_CYCLES_STR ":k",
 		.check = test__sym_event_dc,
 		/* 5 */
 	},
@@ -2160,17 +2160,17 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:e",
+		.name  = "{" HW_CYCLES_STR ",cache-misses,branch-misses}:e",
 		.check = test__exclusive_group,
 		/* 7 */
 	},
 	{
-		.name  = "cycles/name=name/",
+		.name  = HW_CYCLES_STR "/name=name/",
 		.check = test__term_equal_term,
 		/* 8 */
 	},
 	{
-		.name  = "cycles/name=l1d/",
+		.name  = HW_CYCLES_STR "/name=l1d/",
 		.check = test__term_equal_legacy,
 		/* 9 */
 	},
@@ -2311,7 +2311,7 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 9 */
 	},
 	{
-		.name  = "cpu/cycles,period=100000,config2/",
+		.name  = "cpu/" HW_CYCLES_STR ",period=100000,config2/",
 		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_symbolic_name_config,
 		/* 0 */
@@ -2335,43 +2335,43 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 3 */
 	},
 	{
-		.name  = "{cpu/instructions/k,cpu/cycles/upp}",
+		.name  = "{cpu/instructions/k,cpu/" HW_CYCLES_STR "/upp}",
 		.valid = test__pmu_cpu_valid,
 		.check = test__group1,
 		/* 4 */
 	},
 	{
-		.name  = "{cpu/cycles/u,cpu/instructions/kp}:p",
+		.name  = "{cpu/" HW_CYCLES_STR "/u,cpu/instructions/kp}:p",
 		.valid = test__pmu_cpu_valid,
 		.check = test__group4,
 		/* 5 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/G}:H",
+		.name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/G}:H",
 		.valid = test__pmu_cpu_valid,
 		.check = test__group_gh1,
 		/* 6 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/H}:G",
+		.name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/H}:G",
 		.valid = test__pmu_cpu_valid,
 		.check = test__group_gh2,
 		/* 7 */
 	},
 	{
-		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:u",
+		.name  = "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H}:u",
 		.valid = test__pmu_cpu_valid,
 		.check = test__group_gh3,
 		/* 8 */
 	},
 	{
-		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:uG",
+		.name  = "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H}:uG",
 		.valid = test__pmu_cpu_valid,
 		.check = test__group_gh4,
 		/* 9 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:S",
+		.name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu/branch-misses/}:S",
 		.valid = test__pmu_cpu_valid,
 		.check = test__leader_sample1,
 		/* 0 */
@@ -2389,7 +2389,7 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 2 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:D",
+		.name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu/branch-misses/}:D",
 		.valid = test__pmu_cpu_valid,
 		.check = test__pinned_group,
 		/* 3 */
@@ -2407,13 +2407,13 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 5 */
 	},
 	{
-		.name  = "cpu/cycles/u",
+		.name  = "cpu/" HW_CYCLES_STR "/u",
 		.valid = test__pmu_cpu_valid,
 		.check = test__sym_event_slash,
 		/* 6 */
 	},
 	{
-		.name  = "cpu/cycles/k",
+		.name  = "cpu/" HW_CYCLES_STR "/k",
 		.valid = test__pmu_cpu_valid,
 		.check = test__sym_event_dc,
 		/* 7 */
@@ -2425,19 +2425,19 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 8 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:e",
+		.name  = "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu/branch-misses/}:e",
 		.valid = test__pmu_cpu_valid,
 		.check = test__exclusive_group,
 		/* 9 */
 	},
 	{
-		.name  = "cpu/cycles,name=name/",
+		.name  = "cpu/" HW_CYCLES_STR ",name=name/",
 		.valid = test__pmu_cpu_valid,
 		.check = test__term_equal_term,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/cycles,name=l1d/",
+		.name  = "cpu/" HW_CYCLES_STR ",name=l1d/",
 		.valid = test__pmu_cpu_valid,
 		.check = test__term_equal_legacy,
 		/* 1 */
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d4437410c99f..7ebcb1f004b2 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -101,7 +101,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_event(evlist, "cycles:u"));
+	CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5be294014d3b..ad3a87978c0d 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist,
 static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	const char *sched_switch = "sched:sched_switch";
-	const char *cycles = "cycles:u";
+	const char *cycles = HW_CYCLES_STR ":u";
 	struct switch_tracking switch_tracking = { .tids = NULL, };
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8217efdda53..d7e935faeda0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -112,7 +112,7 @@ struct evlist *evlist__new_default(void)
 		char buf[256];
 		int err;
 
-		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+		snprintf(buf, sizeof(buf), "%s/%s/%s", pmu->name, HW_CYCLES_STR,
 			 can_profile_kernel ? "P" : "Pu");
 		err = parse_event(evlist, buf);
 		if (err) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index db92cd67bc0f..304676bf32dd 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -20,6 +20,16 @@ struct option;
 struct perf_pmu;
 struct strbuf;
 
+/*
+ * The name used for the "cycles" event. A different event name is used on ARM
+ * as many ARM PMUs define a "cycles" event.
+ */
+#if defined(__aarch64__) || defined(__arm__)
+#define HW_CYCLES_STR "cpu-cycles"
+#else
+#define HW_CYCLES_STR "cycles"
+#endif
+
 const char *event_type(size_t type);
 
 /* Arguments encoded in opt->value. */
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 6ecf38314f01..693bb5891bc4 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -74,9 +74,9 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	if (!ret)
 		return true;
 
-	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	pmu = perf_pmus__find_core_pmu();
 	if (pmu) {
-		const char *try[] = {"cycles", "instructions", NULL};
+		const char *try[] = {HW_CYCLES_STR, "instructions", NULL};
 		char buf[256];
 		int i = 0;
 
-- 
2.51.0.384.g4c02a37b29-goog


