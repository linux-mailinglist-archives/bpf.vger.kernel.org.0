Return-Path: <bpf+bounces-66796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F902B39407
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF883B00DC
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA82C2357;
	Thu, 28 Aug 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3/0YOv1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86C2C1596
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363382; cv=none; b=BjYBVT14/ehcpiUjJ9Sb1HlSqKSoDOTtGzsmeqxFBY2opOnWG1aU/s7pIqROLYZ/R2EqrX5IKO0dGy7Zd77vdoh9hCKLgsyX4TXE+YN59g3a2OEmmu3RdFP6mlDCmZJMDfELHeY+Q2QD4IzouxC5+SEdmFCbg3Yq3AVS/cpTT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363382; c=relaxed/simple;
	bh=zCHtipe3FFEhxU5sc7D2y2ZkMor+1wVxd4gniTZLH5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SsQsn1fRUF55J0fZLO6rQJkC89iseHUX1Opu/dN7VQ8SxYmpmdzm62aZScarLPCSKQlJKjyY155wK/Uu3FvGVuqMI9G94N91+m4allqvkFJ8Y8RlcV/86FRBKCSTWhNyva5HoQClmQucU3xcviVRGw5onjhXMckc+oGMBvKXITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3/0YOv1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-771e1451631so1349882b3a.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363380; x=1756968180; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFnyAfmB+YyepyVuM/OrsoORiE8FNGZTxzVIf9Uoa/c=;
        b=G3/0YOv14+kSgxSRKIVhYRi2WYy9O8eNUTCA0nzKLQsOOdXfLLjcEVrjPouY0pGIcy
         4P5ltNrSPuZSgLKaYd4hAEfo3pKPb9uOuI2/vND9i5+/25ib5WHi1NLlKNw8sHEaVY+m
         w+3yrqNEmloLnhVugM17iwqrlfAahdMFTKRcieaIONRCQ6kMdoGniscSLDGIfZ5F4TGi
         /POeOw/62WOiXI+Qps0SgWHBpC/RGmjRgX2tIPutmD/9HLLq/qjsjw03/InYwWLAcfMh
         ai/CJkbzCnNGPDsVNifNn0Aiuh8HOaJy3kLVR2Y0G/pJMEgUsMfCkOIhsTCdIBuLXjfA
         G9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363380; x=1756968180;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFnyAfmB+YyepyVuM/OrsoORiE8FNGZTxzVIf9Uoa/c=;
        b=GbQ5fdFZ4hnhN+BdBg07/NMVHDLndDZo0UsjNy+EHrfdejRyPsCTKSsPRL8ImiqMx5
         CfWTOnHBUEllsv2l1PQvF++r2022ezi2zgwuFaG8Q9fclzA77HsWD55YqmEYmeT1uggY
         rxQ33TeHt5/7M5xqREQ4r9i2T6On9psk+54JXvn3KByBPmJOh3Se6TIPQuswwB734QbP
         ax9OGhyzAtaHK0dmmIXh10MKeCU7vfj5eXt574TpCI90s9ENdd1ZHaUJOdxJ6QT1CGfx
         4dGbQRt7+n+ay7AQMlnDw4S9sZI+vO35JlFkS7kP3b23wTarAJzgnNgl9o2xJlFf50C+
         Ri7A==
X-Forwarded-Encrypted: i=1; AJvYcCXUxF68RovwVot2N1C5tSmzkf5zrQPDzbv0xRZ+5KBo2/lmPqnnXHB3ZCabx2yE0m2gKkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMazg1vpH91Ud5ZZXuzGyvjDkkCCSsM8NoGbRgy0/SD41WWsiV
	LbcOu8chsA7gyy8gl78vbI/WqWTpHygLYtjlQqcj246Xfu/6qQj2inoDGPYxqtMQO82iAzzmzZA
	kvGruTXBIvg==
X-Google-Smtp-Source: AGHT+IHoQeg0Bg9SoNQFpfmY/nGJPQ2zQJ7QZ4yW0yRfMNkLSZVJHGX2w49Wzr/+Tlv1ScNNuKPbuX8hGgPm
X-Received: from pgbw67.prod.google.com ([2002:a63:6246:0:b0:b42:2a0a:373b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f8c:b0:243:7617:7f98
 with SMTP id adf61e73a8af0-243761784a5mr19705142637.27.1756363380073; Wed, 27
 Aug 2025 23:43:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:29 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-12-irogers@google.com>
Subject: [PATCH v1 11/13] perf print-events: Remove print_hwcache_events
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

Now legacy cache events are in json there's no need for a specific
printing routine. To support the previous filtered version use an
event glob of "legacy cache" which matches the topic of the json
events.

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
2.51.0.268.g9569e192d0-goog


