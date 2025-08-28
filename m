Return-Path: <bpf+bounces-66793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9777B39401
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A8A189A5B6
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A22797A1;
	Thu, 28 Aug 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUk670if"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E412980A8
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363373; cv=none; b=hD6cUQlppOTtRdakEi183MMazKsIluSFNuDfT7AKKHHglxlDGUBc/lkAeNfHuk3S7tJ94+1TJAFnrSOZwqn3G6QY+D2Dt9RhTC2iNme2DXfs+Jk+GTqxUKeLoXzFli2Fq1nWrxvbQUYj4KOLEke8OZdj3H1Q9Pfsui6xs3xZATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363373; c=relaxed/simple;
	bh=d8ASCVbJfjI+Ig1PZ48cxOSZajqQcnMq8YIfaI0YDkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lA3jLtqXpM8wMT0UQEl7hb7Z1s0NI8dSs8evGAG0WyTkeA3pwRzaDd+lSJI76kt+0fiBBxbYDQRkqGiK+ESAg+uD9xYrbDJmN/b1N6JwAjrSVFXEhM6gaS8Bqapwc3uQnCIHPxn5uQUuZmZZeYU+vomSfEPK7pfbcaavf8en0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUk670if; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e953ada05c2so718437276.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363370; x=1756968170; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwovs+ILDIZvo5KWiD1VkpTwdaBHwgFUjkMPEXTIcLg=;
        b=dUk670ifCtYCyBCYGm0aYl9iUlqCNbNCcYuFP5w8CYyOJpspFaYlVsjaHQqeKVs19h
         BhV821YfqTmAYO1Wq5ouTJ//2/knh70BiqgoaFMUlT6FYGA3jPmtX7WoEeTs0JcBjr1X
         CrrXbhYAAiynptdR6BwjZNgNZ8gMgBqsDCTn+cgFhC7ZeII1rYQ0S61IpeUHfDCer3UJ
         4yz2N2aEh7kzali/ULfHMZ/OYQcLewjDxlGd6gs2X83vk9Jorq15aX2Rs5H8FOpn39Gy
         TTTH6u9HnBCCz03rCUCfIgrBgWz9mknQlj92ZBjrd/HUp7keO15cKwu9XKKNK/9H14zx
         PeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363370; x=1756968170;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwovs+ILDIZvo5KWiD1VkpTwdaBHwgFUjkMPEXTIcLg=;
        b=H801CiRKR4lG5AtmoyUwfY9tet9bdAXyL5ZWRLG6kdMshO6B4Koh/hrT0kEThbdI66
         +CG4BOWFO9ybJtIpimu+aps0rF3ETTt8YJvRuNxEHw8AAwGaiq0dYWKlRPVl8efK7S/J
         kHwuPKzIH+vRihLgtXkM7lFXEfG9XhAvuFxX0vFQFUlR32fbamJs4Y2+TOZJ/9TMHlYT
         zSjd7Uf2uBD51/G+bGDa2e4CXWwlf7WYzIT/n4KWWNwsq3IRra8rYSex2OvkJ0Q6mHgc
         Pw23mtYicSLYefJkKByoC7cJjV+mmNa7F90ya4SuJdeWl9ATw6l8TwsgYpZeBBZxJH6z
         refg==
X-Forwarded-Encrypted: i=1; AJvYcCW86JVMHeZzO7hdZ9N7xR/QoqRzqfsoFmGDW2AipZ7m0yEHTxwBxJ94gEGyHMB9qghcHPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2LunU2GqDGv+amewL/x/46xVwE6th65wlnMEUQx4G4kjl5IG
	Ob6hVEXCrL4q5S2a/y3uqvmVAFT4QFRS1fgfErY7umnkrlbvLYcPyrHxZEM6emYodR1o/xB/uYQ
	cmj7FKLyPVH28tZ9lD05ricrNU+ivpZej5C7piJbsySWUpTpuWv6YjHrenr04dgk=
X-Google-Smtp-Source: AGHT+IEJWAZ8U3pNiZz2chtMdPodMKlH+Jt279rvKHyjhbeIPWDzwa/MXC3ASB9p1iltIjZDCtXjUaWYffQg
X-Received: from ybex191.prod.google.com ([2002:a25:cec8:0:b0:e96:e0af:375d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:5408:b0:e96:ec6a:26c7
 with SMTP id 3f1490d57ef6-e96ec6a27b3mr6233243276.0.1756363370216; Wed, 27
 Aug 2025 23:42:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:25 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-8-irogers@google.com>
Subject: [PATCH v1 07/13] perf parse-events: Add terms for legacy hardware and
 cache config values
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
X-ccpol: medium

Add the PMU terms legacy-hardware-config and
legacy-cache-config. These terms are similar to the config term in
that their values are assigned to the perf_event_attr config
value. They differ in that the PMU type is switched to be either
PERF_TYPE_HARDWARE or PERF_TYPE_HW_CACHE, and the PMU type is moved
into the extended type information of the config value. This will
allow later patches to add legacy events to json.

An example use of the terms is in the following:
```
$ perf stat -vv -e 'cpu/legacy-hardware-config=1/,cpu/legacy-cache-config=0x10001/' true
Using CPUID GenuineIntel-6-8D-1
Attempt to add: cpu/legacy-hardware-config=0x1/
..after resolving event: cpu/legacy-hardware-config=0x1/
Attempt to add: cpu/legacy-cache-config=0x10001/
..after resolving event: cpu/legacy-cache-config=0x10001/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 994937  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             3 (PERF_TYPE_HW_CACHE)
  size                             136
  config                           0x10001 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_L1I)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 994937  cpu -1  group_fd -1  flags 0x8 = 4
cpu/legacy-hardware-config=1/: -1: 1364046 414756 414756
cpu/legacy-cache-config=0x10001/: -1: 57453 414756 414756
cpu/legacy-hardware-config=1/: 1364046 414756 414756
cpu/legacy-cache-config=0x10001/: 57453 414756 414756

 Performance counter stats for 'true':

         1,364,046      cpu/legacy-hardware-config=1/
            57,453      cpu/legacy-cache-config=0x10001/

       0.001988593 seconds time elapsed

       0.002194000 seconds user
       0.000000000 seconds sys
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 70 ++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  4 +-
 tools/perf/util/parse-events.l |  2 +
 tools/perf/util/pmu.c          | 29 ++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc677d9b2d5a..5c4dc12637ef 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -860,6 +860,8 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG]	= "legacy-hardware-config",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG]	= "legacy-cache-config",
 		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
@@ -911,6 +913,8 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		if (!err)
 			return false;
@@ -1068,6 +1072,8 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		parse_events_error__handle(err, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
@@ -1090,10 +1096,68 @@ do {									   \
 #undef CHECK_TYPE_VAL
 }
 
+static bool check_pmu_is_core(__u32 type, const struct parse_events_term *term,
+			      struct parse_events_error *err)
+{
+	struct perf_pmu *pmu = NULL;
+
+	/* Avoid loading all PMUs with perf_pmus__find_by_type, just scan the core ones. */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (pmu->type == type)
+			return true;
+	}
+	parse_events_error__handle(err, term->err_val,
+				strdup("needs a core PMU"),
+				NULL);
+	return false;
+}
+
 static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_error *err)
 {
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG) {
+		if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		if (term->val.num >= PERF_COUNT_HW_MAX) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, err))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HARDWARE;
+		return 0;
+	}
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG) {
+		int cache_type, cache_op, cache_result;
+
+		if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		cache_type = term->val.num & 0xFF;
+		cache_op = (term->val.num >> 8) & 0xFF;
+		cache_result = (term->val.num >> 16) & 0xFF;
+		if ((term->val.num & ~0xFFFFFF) ||
+		     cache_type >= PERF_COUNT_HW_CACHE_MAX ||
+		     cache_op >= PERF_COUNT_HW_CACHE_OP_MAX ||
+		     cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, err))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HW_CACHE;
+		return 0;
+	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
 		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
@@ -1180,6 +1244,8 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -1321,6 +1387,8 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
@@ -1359,6 +1427,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 34a5ec21d5e8..7981a5d468fa 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -83,7 +83,9 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_CPU,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
+	PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG,
+	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 2034590eb789..b5058b6b49d3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -336,6 +336,8 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
+legacy-hardware-config 	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG); }
+legacy-cache-config	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e590de26a7f5..4f5e09a21a82 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1535,6 +1535,33 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 			pmu_format_value(bits, term->val.num, &attr->config3, zero);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			assert(term->val.num < PERF_COUNT_HW_MAX);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HARDWARE;
+			break;
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG: {
+			int cache_type, cache_op, cache_result;
+
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			cache_type = term->val.num & 0xFF;
+			cache_op = (term->val.num >> 8) & 0xFF;
+			cache_result = (term->val.num >> 16) & 0xFF;
+			assert((term->val.num & ~0xFFFFFF) == 0);
+			assert(cache_type < PERF_COUNT_HW_CACHE_MAX);
+			assert(cache_op < PERF_COUNT_HW_CACHE_OP_MAX);
+			assert(cache_result < PERF_COUNT_HW_CACHE_RESULT_MAX);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HW_CACHE;
+			break;
+		}
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
 		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
@@ -1926,6 +1953,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"config1=0..0xffffffffffffffff",
 		"config2=0..0xffffffffffffffff",
 		"config3=0..0xffffffffffffffff",
+		"legacy-hardware-config=0..9,",
+		"legacy-cache-config=0..0xffffff,",
 		"name=string",
 		"period=number",
 		"freq=number",
-- 
2.51.0.268.g9569e192d0-goog


