Return-Path: <bpf+bounces-21111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38FC847D48
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC661C21389
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B985130ACE;
	Fri,  2 Feb 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2SurpQR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B412D778
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917279; cv=none; b=pk3MTd45rgugQ9fhcGdXovx4sj0A6qFMJWjkrWaNNmDQQyW7jCJJejMR4r2YSeugPb7b6uezDBuUSzWoVaYw1X3Gg+S0hoQdT4VL8Q0t5Jd0K4Pw2mW6pW9O8ynokroqj5JOope+1oF0zQbpWzVEQYPoC4Yv+GqliZAHhOlzRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917279; c=relaxed/simple;
	bh=2CEX69l8jHviwD08AVVrjec2O+3gxN5VKnRqORpifeQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MchgCXk4d5rH746gdBKdg3fffxDUwGToXCKlX4dQTr5BNkv6N4gkNUsfF0xTAaDLjKze5BUAY7ZwaB4ceYErVbBBqEq2L/FQFhMQaR/FEqkiS9sVOPX9FZsbtuRCo2QDrmFSDudyY1WDZg940dgOQcCysszO0+KtrCxyFBUWwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2SurpQR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so4754890276.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917276; x=1707522076; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xzvhj+a0qyhqfnlkJlD6nNip1T9+Dz0mvAMEktGGdDs=;
        b=Q2SurpQRaQR+Y1ACtUW51Dydq5v+1OzPqkkPVLGHwTb717kWrZcZfvskPLtNK/MhLU
         n1o+FZ5aOx9PFmqJBzmUBKJBCU9L1XQtaZg7mkx+CWCD9R2uzO4Jx7Ck+xvCkq3na/EY
         h9eBZQtGcZjsCWJ7HF2HFeteZTucJ++HtL79fNMqU5JdcZnij8i/wUqB44at2bvUzJVx
         BQ5eptnmMoCBQmlC7XR+o+o1WcaGq2/6ppJh8Xg07JNteT0AA/wYWKwhfhnc1PEM+mG5
         Z1l/L2AKBdjdg3r4Y52zKLvSeT43gSbNGqfB3LBmbKU2CCLWwEVjPjt+LS/M/+H2HMmF
         Igng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917276; x=1707522076;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzvhj+a0qyhqfnlkJlD6nNip1T9+Dz0mvAMEktGGdDs=;
        b=wE4p7hT62W+KrZlVBtfJ9DmVatAhCetvN12o0uVqbNAuR9qpRA8TE2lh+0HelyKRBK
         N7P7Mo+xTMF8r/gJ2bnhN29rukyVhPXbTWux6k9iQauehuLy9pRzrvzjNtS3T/b5Z1vl
         NsTJKVS4uM1C5Httgi3JtgiqR7H7oJxkC/53safIWyO9Sh5LxF7HgpL/uMdDjCdrqARC
         MMbgaAr6qK6KBjIVVsKXIFIxCHxPNa2T5D+mWNtgBZoP4D3JZnjmB6xzgl9fYjJ8xj68
         WnCAIoVd406IWUUBIVsKdkG+TmvRgUUmMzMjfJba6sQH2fTSQfwf86hAfK1sxXiWYpzp
         9wvw==
X-Gm-Message-State: AOJu0YxbmgNtzygRuNzffL6Yxc02456NtBKdMRfSJh0JmBZBRDEJVS8X
	5ssxY1/e05AElovK1JeCegPVExc2OR8WHpL9yPEpQpxRB25vQwuhUW6lr5q3e09bqFBZ8I+kzKW
	eLDL8hA==
X-Google-Smtp-Source: AGHT+IH1P3pzKL0QWpOjxn7DF+fg6zdcOTDx/JJDNSMOI0pZaXnlYiFdp7LpbTqNMeVndnj73uZ3TS4lpO3f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:138e:b0:dc2:1cd6:346e with SMTP
 id x14-20020a056902138e00b00dc21cd6346emr2454938ybu.8.1706917276279; Fri, 02
 Feb 2024 15:41:16 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:52 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than iterate all CPUs and see if they are in CPU maps, directly
iterate the CPU map. Similarly make use of the intersect function
taking care for when "any" CPU is specified. Switch
perf_cpu_map__has_any_cpu_or_is_empty to more appropriate
alternatives.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 114 ++++++++++++---------------
 tools/perf/arch/arm64/util/arm-spe.c |   4 +-
 2 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 77e6663c1703..07be32d99805 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -197,38 +197,37 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
 static int cs_etm_validate_config(struct auxtrace_record *itr,
 				  struct evsel *evsel)
 {
-	int i, err = -EINVAL;
+	int idx, err = 0;
 	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
-	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
-
-	/* Set option of each CPU we have */
-	for (i = 0; i < cpu__max_cpu().cpu; i++) {
-		struct perf_cpu cpu = { .cpu = i, };
+	struct perf_cpu_map *intersect_cpus;
+	struct perf_cpu cpu;
 
-		/*
-		 * In per-cpu case, do the validation for CPUs to work with.
-		 * In per-thread case, the CPU map is empty.  Since the traced
-		 * program can run on any CPUs in this case, thus don't skip
-		 * validation.
-		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
-		    !perf_cpu_map__has(event_cpus, cpu))
-			continue;
+	/*
+	 * Set option of each CPU we have. In per-cpu case, do the validation
+	 * for CPUs to work with. In per-thread case, the CPU map has the "any"
+	 * CPU value. Since the traced program can run on any CPUs in this case,
+	 * thus don't skip validation.
+	 */
+	if (!perf_cpu_map__has_any_cpu(event_cpus)) {
+		struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
 
-		if (!perf_cpu_map__has(online_cpus, cpu))
-			continue;
+		intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
+		perf_cpu_map__put(online_cpus);
+	} else {
+		intersect_cpus = perf_cpu_map__new_online_cpus();
+	}
 
-		err = cs_etm_validate_context_id(itr, evsel, i);
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
+		err = cs_etm_validate_context_id(itr, evsel, cpu.cpu);
 		if (err)
-			goto out;
-		err = cs_etm_validate_timestamp(itr, evsel, i);
+			break;
+
+		err = cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
 		if (err)
-			goto out;
+			break;
 	}
 
-	err = 0;
-out:
-	perf_cpu_map__put(online_cpus);
+	perf_cpu_map__put(intersect_cpus);
 	return err;
 }
 
@@ -435,7 +434,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
 	 * when a context switch happened.
 	 */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
 					   "timestamp", 1);
 		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
@@ -461,7 +460,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	evsel->core.attr.sample_period = 1;
 
 	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 		evsel__set_sample_bit(evsel, TIME);
 
 	err = cs_etm_validate_config(itr, cs_etm_evsel);
@@ -533,45 +532,31 @@ static size_t
 cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		      struct evlist *evlist __maybe_unused)
 {
-	int i;
+	int idx;
 	int etmv3 = 0, etmv4 = 0, ete = 0;
 	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
-	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
-
-	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
-		for (i = 0; i < cpu__max_cpu().cpu; i++) {
-			struct perf_cpu cpu = { .cpu = i, };
+	struct perf_cpu_map *intersect_cpus;
+	struct perf_cpu cpu;
 
-			if (!perf_cpu_map__has(event_cpus, cpu) ||
-			    !perf_cpu_map__has(online_cpus, cpu))
-				continue;
+	if (!perf_cpu_map__has_any_cpu(event_cpus)) {
+		/* cpu map is not "any" CPU , we have specific CPUs to work with */
+		struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
 
-			if (cs_etm_is_ete(itr, i))
-				ete++;
-			else if (cs_etm_is_etmv4(itr, i))
-				etmv4++;
-			else
-				etmv3++;
-		}
+		intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
+		perf_cpu_map__put(online_cpus);
 	} else {
-		/* get configuration for all CPUs in the system */
-		for (i = 0; i < cpu__max_cpu().cpu; i++) {
-			struct perf_cpu cpu = { .cpu = i, };
-
-			if (!perf_cpu_map__has(online_cpus, cpu))
-				continue;
-
-			if (cs_etm_is_ete(itr, i))
-				ete++;
-			else if (cs_etm_is_etmv4(itr, i))
-				etmv4++;
-			else
-				etmv3++;
-		}
+		/* Event can be "any" CPU so count all online CPUs. */
+		intersect_cpus = perf_cpu_map__new_online_cpus();
 	}
-
-	perf_cpu_map__put(online_cpus);
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
+		if (cs_etm_is_ete(itr, cpu.cpu))
+			ete++;
+		else if (cs_etm_is_etmv4(itr, cpu.cpu))
+			etmv4++;
+		else
+			etmv3++;
+	}
+	perf_cpu_map__put(intersect_cpus);
 
 	return (CS_ETM_HEADER_SIZE +
 	       (ete   * CS_ETE_PRIV_SIZE) +
@@ -813,16 +798,15 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
-	/* If the cpu_map is empty all online CPUs are involved */
-	if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
+	/* If the cpu_map has the "any" CPU all online CPUs are involved */
+	if (perf_cpu_map__has_any_cpu(event_cpus)) {
 		cpu_map = online_cpus;
 	} else {
 		/* Make sure all specified CPUs are online */
-		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
-			struct perf_cpu cpu = { .cpu = i, };
+		struct perf_cpu cpu;
 
-			if (perf_cpu_map__has(event_cpus, cpu) &&
-			    !perf_cpu_map__has(online_cpus, cpu))
+		perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
+			if (!perf_cpu_map__has(online_cpus, cpu))
 				return -EINVAL;
 		}
 
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 51ccbfd3d246..0b52e67edb3b 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 * In the case of per-cpu mmaps, sample CPU for AUX event;
 	 * also enable the timestamp tracing for samples correlation.
 	 */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_sample_bit(arm_spe_evsel, CPU);
 		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
 					   "ts_enable", 1);
@@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	tracking_evsel->core.attr.sample_period = 1;
 
 	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_sample_bit(tracking_evsel, TIME);
 		evsel__set_sample_bit(tracking_evsel, CPU);
 
-- 
2.43.0.594.gd9cf4e227d-goog


