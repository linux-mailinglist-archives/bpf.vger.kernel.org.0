Return-Path: <bpf+bounces-66854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFBB3A675
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C5F7B9F18
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3532143E;
	Thu, 28 Aug 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKEmZgiE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D33375C3
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398781; cv=none; b=KP+Ge/KaM6AD/s9VL05mryb3oYFHEUF4FA3VZtAjau3KUPgvwakJFdayKubFDl/2yobl+f5Zds+rQfwsh/e6/wlm3Uu3jnCi6WjxBTC78fkmjulX6SxfJfwrWee2zt6BGFkClaEaSmamFZDWxApvBBEWAJ2IictUCmvueg6/w0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398781; c=relaxed/simple;
	bh=0zqV6CbNYVpTyhSt89edbzoGOnGXhwH0XcEa9E5x7BM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IAXYhIOywSSlCeItb2KEAjnQ+0zlmNCerbvcV30PJ7sbNM3eYNAHXpwc9/gu3DyS8Z1k5Hw7QFfbcQnr/yEeIVJtnfo7a0CIZJg9YuH9ymmHYJ/BBDozi77cOgMuOpnM6rduno69Z0+t5R8k9/tiFAgiQdv+bxDZqREGkh5Sf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKEmZgiE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-771e2f5b5dcso1673988b3a.0
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398779; x=1757003579; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXhopSoWurUMrcNeN5Lg/uOPd2nHt4BTp4njBJeUSY0=;
        b=uKEmZgiEBww2rSEpnaHfmizYIhDLvAPQVVv4N5sj1pCzqCtJfoTXX/TcD94BX9zT4+
         QDI4tPf8OhZUwZZJz+Z5KzrljG7jeKlhOh4/8jzph1AxXfvkr65AzHoT7eKp3CECnovu
         +3VRUu4mOHL927kf8BBSphw3yiN3I45mnRAtvLCcMb/D3CURdcZGYdJd4eysqTXeggu2
         cafvWUG+UW794GMynQscQF1cUqkolrg7WBzBmIvQGVZ+fxpVPwOoBhDSzeIIaOB4+5He
         dS94NVKa04shN+Iw5jtjB5POhTJncDK1BBhr6xcy5a1md7lNUteMMvJOg6BQpgdLdm5O
         Rulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398779; x=1757003579;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXhopSoWurUMrcNeN5Lg/uOPd2nHt4BTp4njBJeUSY0=;
        b=q2vfLViGgq7Lbmt0J80OAoPrALrwfgKhQ9/esz7Nr+l4wL2vWEjmcs3zlPK8yz34i2
         r3ho+FSLKezXe13uLoCaOPc3R9VEA3fSgaGxnqvX/gQY8jNN0R+vnHZp9trZo3/mglJf
         9fNYcEf3A4d1PonlhIaQyH63Dh+P7jHYpAY01ww+CvvPKTaZkE5CGpf+nYytF6NVXF9l
         8ScbJ4exQ1WtWtxjuJz/6Rh4ykESshqk4E/pdHDdQUfFLWrvtXhGtISoJ5G6nXqgyZ7q
         /5JBTwx0lWalOtY3f8Zj+AfrWXHQbDeO/1W14kCSQ2dzKtNslP2O5zv0vA6DGnv3gZWJ
         KSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqPhxXFc+nxlY2kiN82eheOQXzQ1cCEm7/ehgMdxN8pCDbUEuLJ/PqaCN9jmmDj0QR7W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8VK7fqbOavQDXBrTf7cjVlJIdVbEn1wNszq5I7NRDDiE/ibk
	P+fMJdFqPZbHIpdEeBlNrfWR8bZfTcblgmMbyIeDAd+KHSfCLMm/cUOZsHNMVzNu+pcoGN5+t6U
	lBYGQGHGFC/x4MkVGBg7w89Pt4ixJAprKEOAjIff+Z1fvzLIo3J0tc5LI6KhxTfg=
X-Google-Smtp-Source: AGHT+IHzWS6DKNUpS7huIFZD4Yq0SOpX686vDR1VhwhHSJsAjRdm88/2weJL5itbAS1vI8Qqi5tqQ9jda48U
X-Received: from pfgu25.prod.google.com ([2002:a05:6a00:999:b0:76e:8d8d:6652])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:390c:b0:769:93fb:210a
 with SMTP id d2e1a72fcca58-7702faac2bcmr30989052b3a.21.1756398778633; Thu, 28
 Aug 2025 09:32:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:19 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-10-irogers@google.com>
Subject: [PATCH v2 09/15] perf parse-events: Add terms for legacy hardware and
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
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
 tools/perf/util/pmu.c          | 30 +++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 37aa392ddaf2..be3e86e7b157 100644
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
index 660303e591ad..a64f0741cb4b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -82,7 +82,9 @@ enum parse_events__term_type {
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
index 36b880bf6bbf..f718eb41af88 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1532,6 +1532,34 @@ static int pmu_config_term(const struct perf_pmu *pmu,
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
+#ifndef NDEBUG
+			int cache_type = term->val.num & 0xFF;
+			int cache_op = (term->val.num >> 8) & 0xFF;
+			int cache_result = (term->val.num >> 16) & 0xFF;
+
+			assert(cache_type < PERF_COUNT_HW_CACHE_MAX);
+			assert(cache_op < PERF_COUNT_HW_CACHE_OP_MAX);
+			assert(cache_result < PERF_COUNT_HW_CACHE_RESULT_MAX);
+#endif
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			assert((term->val.num & ~0xFFFFFF) == 0);
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
@@ -1923,6 +1951,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
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


