Return-Path: <bpf+bounces-69334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54511B94323
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD282E285E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6E29BD80;
	Tue, 23 Sep 2025 04:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dI+k7yy1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AF2765E8
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601161; cv=none; b=On2wpQz9AuO4XNOj7fguVdCMbaD+G+JoRCvjgwYxu263YzA72EpiepIYiDy07Hgh0nUunBTA8u4mCmeK3UPSO+96IIcShTAGRu0mI5XfupQcZ4LU9uP8bPctrRFMWGLoY4jwOd2ukmP114MjDldgRBp/tf1yHVV8xpSt1gjyLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601161; c=relaxed/simple;
	bh=leffwGmca9/Uyf0CB9QUmGZNZruy/wn2a//pTjcSms8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIYTkcLuix1XVkbcs4Pbua8AMhSozTAYNdAs99D0eSoFcmM3i6vVCl0albuch4G0D40cah+ul0aAPi6RsbZGGms7uQ5ujLM+puQUjLs6kHINa//XPo8HRSm83GyNFGGyfGARjxOUpP3GeLHOVRG9uFnqHh9QeF1S2B6PGXZ54NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dI+k7yy1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so8260531a91.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601159; x=1759205959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Y4y6zCTLXlY4E+9adeVkHim03GuNEJ4UhBVjyN7U8=;
        b=dI+k7yy1JpgLkk1ctkY72e6snekB4sPhXniEFtpbVeC/SFTo46m6SKh0p2nN+OfzNj
         p/i/6B8SOC6420ikzrzjoHEJFEKLxG5BszVY3icJIW5AXUpO1ZiwtLx+axr5/Fl4JpGs
         CufWdg8w84v/gxc1OLwjDbnHt+/ukAVxWbtksRfop4BBcVtPgb1l+tbvv9/rmCC7WdZj
         HyLzyJzPbYndsDMKTO+BTzCCvb+JLjZX2P3DGH3Fc3StqDoq6LGcHK292gn1zl6ao0fe
         yOi1yohxpXJQmyPsIyUyFK0B4/EAQSFGJ4aQ/D+6ln9+5DG/VHmUviBEDlchHMdkB8Rr
         q2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601159; x=1759205959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Y4y6zCTLXlY4E+9adeVkHim03GuNEJ4UhBVjyN7U8=;
        b=SROAnT5ZAiOWh85BfoaBNHLGVorAYo96vVQ8ykSln7DMfwxZD6vWLE4vDMOCBs398N
         1NIUElI3NNWovD835u/FoANeHmv/NyilQENK82ki9jxTVCWpm+/dtyKgjQTvuiPwZH8U
         bBfjlxhpquRSkcToTfhM6vV4tc7FVZwkGptFs/IJypmNZZgZAajgdvyUqOns6iSMcchr
         lLzFY7a2+pvaMrCROHLdiKQA560Lbmz8JJe1gvr4g6CKSw0gKrnqz0wRaFEt1fg9cO7i
         BcmRZfpZx2sRZUKSAJMTMW4nSbAsf2VXXsu76jgk1je7zYZsKVZCY0jAx7aVp2JXKT06
         ypIA==
X-Forwarded-Encrypted: i=1; AJvYcCU+SW9BwMNAXNEr0l7Q1RY2cvrwrwmTHS/C482VHIWeWmDWkCfES8vZUSWWwtWWCEaSe5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQn9moggX0qgVOJ0CtoO6bI/5lDuHkMuWZ+8JciUHLv/n1/b2
	iX5usiQceDLSGCJHX5Ka4uWy0DVGPmuDZgfx8P/T6Rpbp7RINavCsreGcTFoR6Ty0Lh7EW+CDis
	I2eot+3/eTg==
X-Google-Smtp-Source: AGHT+IFQHMNvvonDo8L/b9c5DdxnKj9NxGGoiQ6I2ZhXxlOoKyPwa//pfYXEkZSW9rmNlgk1r6x1rfrU+NK0
X-Received: from pjbsp16.prod.google.com ([2002:a17:90b:52d0:b0:32e:6111:40ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f84:b0:330:6f13:53fc
 with SMTP id 98e67ed59e1d1-332a96f9ea8mr1568407a91.27.1758601159212; Mon, 22
 Sep 2025 21:19:19 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:33 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-15-irogers@google.com>
Subject: [PATCH v5 14/25] perf print-events: Remove print_hwcache_events
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

Now legacy cache events are in json there's no need for a specific
printing routine. To support the previous filtered version use an
event glob of "legacy cache" which matches the topic of the json
events.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 16 +++++++---
 tools/perf/util/print-events.c | 55 ----------------------------------
 tools/perf/util/print-events.h |  1 -
 3 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index caf42276bd0f..b6720ef3adf6 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -652,9 +652,18 @@ int cmd_list(int argc, const char **argv)
 			}
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
-			 strcmp(argv[i], "hwcache") == 0)
-			print_hwcache_events(&print_cb, ps);
-		else if (strcmp(argv[i], "pmu") == 0) {
+			   strcmp(argv[i], "hwcache") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy cache");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "pmu") == 0) {
 			default_ps.exclude_abi = true;
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			default_ps.exclude_abi = false;
@@ -707,7 +716,6 @@ int cmd_list(int argc, const char **argv)
 			default_ps.event_glob = s;
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
-			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 4153124a9948..91a5d9c7882b 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,59 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
-{
-	struct perf_pmu *pmu = NULL;
-	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
-
-	/*
-	 * Only print core PMUs, skipping uncore for performance and
-	 * PERF_TYPE_SOFTWARE that can succeed in opening legacy cache evenst.
-	 */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		if (pmu->is_uncore || pmu->type == PERF_TYPE_SOFTWARE)
-			continue;
-
-		for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-			for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-				/* skip invalid cache type */
-				if (!evsel__is_cache_op_valid(type, op))
-					continue;
-
-				for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
-					char name[64];
-					char alias_name[128];
-					__u64 config;
-					int ret;
-
-					__evsel__hw_cache_type_op_res_name(type, op, res,
-									name, sizeof(name));
-
-					ret = parse_events__decode_legacy_cache(name, pmu->type,
-										&config);
-					if (ret || !is_event_supported(PERF_TYPE_HW_CACHE, config))
-						continue;
-					snprintf(alias_name, sizeof(alias_name), "%s/%s/",
-						 pmu->name, name);
-					print_cb->print_event(print_state,
-							"cache",
-							pmu->name,
-							pmu->type,
-							name,
-							alias_name,
-							/*scale_unit=*/NULL,
-							/*deprecated=*/false,
-							event_type_descriptor,
-							/*desc=*/NULL,
-							/*long_desc=*/NULL,
-							/*encoding_desc=*/NULL);
-				}
-			}
-		}
-	}
-	return 0;
-}
-
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max)
@@ -434,8 +381,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
 
-	print_hwcache_events(print_cb, print_state);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index d6ba384f0c66..44e5dbd91400 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -32,7 +32,6 @@ struct print_callbacks {
 
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
-int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
-- 
2.51.0.534.gc79095c0ca-goog


