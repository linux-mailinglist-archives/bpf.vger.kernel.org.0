Return-Path: <bpf+bounces-47589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED89FBCB8
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8132D18866F3
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0DD1C5CBB;
	Tue, 24 Dec 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fj+jo9AR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7771C3C1C
	for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037085; cv=none; b=Rne9sJ7P7hTpFv453+jwH66SE6XQ8AISSh5gXZqSb32cPIXn/vMIYOxm/IYDzthgeAWG986i2GPYmMcKqmu0BytxlpVk4+P3IIi8JJ9gq1aMjawhq+3jm5Sua8I1lw2MQ74uPHYAR7bJ2r6CRt86vf6zDsvYF+wdCDj3k/KIxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037085; c=relaxed/simple;
	bh=qhgx69uA8IiIJxSynCovT2xN+mUPia675m5YqlCbHk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWF0QEhlhNQfOg/4sL4cJfrH2nzZGm8JAuFKSIrQQ+pZ4nysVjiPPEkeBpwKFE4sSM87BapbC/Mwl5ae2zrtc/7/HP9p1QARtFju3EYy9oEl930N9YV+sTdB/+prbALX3zK8u8vEnqWCLY8Pc2fEsWW7JKdWPdafp4SqG/Z1tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fj+jo9AR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862df95f92so2296228f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037081; x=1735641881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Qn39K4UzsLsLGtfNH0/R87UIS/L19Vs2Fn7/eQxwo=;
        b=Fj+jo9AR56Ge6LtIX4cQQPclPJphfaJSE3CgAURjchgW4dgpbfMi7P0XJq7CBiGPpL
         Le5t6AfOLtBndvCCblsP9xceK4niIvaBXe2/MUEKiteNXewfNpRHrQXBpUJMeG0RckU+
         7GzxWekImDqRqo6XV/oPgjFEKCgKP0X5atxdHqHD2nHNBdEo3wvIV0LJ4HndjtCfzqxP
         bS/0vie2oblVpKXeQ7yrwqPLduKr7GEDwT03vdrK+XryenEUz2CCUpJF+dwZCxBVGC7G
         57jYN07X6xROOgBOYdpsqQFc0OsZDKkMDX1Kthxj096V7nnb8djJh87RPY9p3QhA2OnE
         zGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037081; x=1735641881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2Qn39K4UzsLsLGtfNH0/R87UIS/L19Vs2Fn7/eQxwo=;
        b=Nza6OV21lq5fqmU1XeX+XidMPwEdGT/uYcbCCIaiz4+f/AgXOYLdVIBjIpWpqkduIH
         DUKPtuTxBDOZse7p++/QzWBQVzSMAmzH+AbJVC6j1w1Su6KO2zAg9TTzUkXXnvS2LQmp
         ZbsM8i2r/kmH2TcgWRBB763EOvmPj/Xvsvqnuk5uIiRRFCHqv5km02qBjdUecZD76WzD
         cJZkvsORSLr1BzM4ZTm04gmulHGByO9JYu5/8a7QzOfWFYgBuSYT/jU7gW2zng5/mtxc
         1cPdNpNmTrHnNnL9pmRNLmJqj2lp39RwyGuSEDxBzjZWw7+kG+x5LjHEcXgGOiyzZNFT
         bvtg==
X-Forwarded-Encrypted: i=1; AJvYcCWL4ZGOdM179zCfZOMioAZ8M8lm2UTsVtO4OjoTucNFJODV1fi+oWHA4Hmd9kkvsPSbORI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwprfwfKP8e+W+WAZExGdslHvrYBXo/f3y6aJY9ONwAWEDNtz9H
	OXV/ylx+vDMqD4oGbWJvwNsZth8VCNWLW1xBI2DuKldRe1wlqO5IHCSvGsEuO5U=
X-Gm-Gg: ASbGncuXGcU0d7WMKAuR5mv/EMkwHqPo1aEj+FpVWIa8A/wT1eSQPU8BMKLuG01EMyb
	g2reMmPK1JcSxE1UdoexLk7krvDs8lCR3N682/0lRY/S+ZDxW5TtK6cJ7srRxSvCbcjNY0WFD79
	1VlTCbvZ6xuGgWxs0thQF0cP1W62YTfN1PVrd6bs4pCdcPtVLVPhypXRuSeOrLgFtiHvX87ba6d
	CNr6QRlASUkr3jlvBfpwCJAO0yFTDedtlGPmaMCIrrsEKtT50HlXyQ=
X-Google-Smtp-Source: AGHT+IEPwGkn3TrrCW7UYR3VV36eBnjzsw1wNAbjqFQScWTBytZf17+BoI5sSqfPq7qT3qahHgFAcw==
X-Received: by 2002:a05:6000:184e:b0:385:ed1e:2105 with SMTP id ffacd0b85a97d-38a221f2f0cmr14225299f8f.26.1735037081570;
        Tue, 24 Dec 2024 02:44:41 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:41 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/5] perf tool: arm-spe: Pull out functions for aux buffer and tracking setup
Date: Tue, 24 Dec 2024 10:44:09 +0000
Message-Id: <20241224104414.179365-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224104414.179365-1-james.clark@linaro.org>
References: <20241224104414.179365-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These won't be used in the next commit in discard mode, so put them in
their own functions. No functional changes intended.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 83 +++++++++++++++++-----------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 22b19dcc6beb..1b543855f206 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -274,33 +274,9 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 		evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
-static int arm_spe_recording_options(struct auxtrace_record *itr,
-				     struct evlist *evlist,
-				     struct record_opts *opts)
+static int arm_spe_setup_aux_buffer(struct record_opts *opts)
 {
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel, *tmp;
-	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
-	struct evsel *tracking_evsel;
-	int err;
-
-	sper->evlist = evlist;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
-				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu->name);
-				return -EINVAL;
-			}
-			opts->full_auxtrace = true;
-		}
-	}
-
-	if (!opts->full_auxtrace)
-		return 0;
 
 	/*
 	 * we are in snapshot mode.
@@ -330,6 +306,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
 			return -EINVAL;
 		}
+
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 	}
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
@@ -355,14 +334,15 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	if (opts->auxtrace_snapshot_mode)
-		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
-			  opts->auxtrace_snapshot_size);
+	return 0;
+}
 
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
-			arm_spe_setup_evsel(evsel, cpus);
-	}
+static int arm_spe_setup_tracking_event(struct evlist *evlist,
+					struct record_opts *opts)
+{
+	int err;
+	struct evsel *tracking_evsel;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
@@ -388,6 +368,45 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				     struct evlist *evlist,
+				     struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel, *tmp;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
+
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_aux_event(evsel)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
+				pr_err("Found unexpected auxtrace event: %s\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (evsel__is_aux_event(evsel))
+			arm_spe_setup_evsel(evsel, cpus);
+	}
+
+	err = arm_spe_setup_aux_buffer(opts);
+	if (err)
+		return err;
+
+	return arm_spe_setup_tracking_event(evlist, opts);
+}
+
 static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 					 struct record_opts *opts,
 					 const char *str)
-- 
2.34.1


