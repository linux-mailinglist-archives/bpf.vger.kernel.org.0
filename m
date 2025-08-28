Return-Path: <bpf+bounces-66890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE0B3AC3B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C88189C279
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D542DC32A;
	Thu, 28 Aug 2025 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eITUPB/Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D752C2347
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414800; cv=none; b=VtArvuEnFAGFLE/miiR8/qXKkkU23bMQCRHIMJlrKxkvF7ydQ8YQ7IOT87EXqCvGpI6n9cozvHxuJeN20GwWbGOlssKerqgXwaEh11njigmiRvL4nMf/1Vt27+nTzKbX8Q3cCHGaF73s9mFZGlAOfZn27fPABpX2F2JRzTR58ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414800; c=relaxed/simple;
	bh=4U+L4Xwx8fMw/jYZx1FUstLXrkfwQ7cUJShrXuuki3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L6M+fiLcuid4N5JVy/0Xzg+SOjK9oAKKyT/YOKnALeh6Or06rFmTvb7uEzUjtRejsx5sPLW/APb6egv2F9uwTIIs1rbj6vPnUyI9NUy2y9/8uXcL/AoSb1DVvTArjNgr3c5j51ELR1/2Ng6Y/Jz1tOTO6IvnHGLv8S+60RzOVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eITUPB/Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458274406so25901915ad.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414797; x=1757019597; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5QvFyFoCZYjnxni8upUiYsAQGKLADYqIqDf8F+46ok=;
        b=eITUPB/ZFvFszpe0uVwcvdT3k2bk5l7eqwXCJ94Ztj/wLWg14zNiUZbtBq80Ssn4eh
         Y3TN5kGBFOpCtt5aiPgIbnILX2HzmPMFmU2C5DwTKAG23dTirfEoPLew5PIcTqUzAERy
         tjtYeZruEsRn6XH93kuR2oWPNnQ5OMutY7N0n/EVr2Tgl4WVhpt9zXKO/W2Y29mDHvCU
         V+NWDpdTrBtwTbe1eGA9YcPk9qyZqc3JzIla7eKv9jMr8zgrhUWNWAI2EPVIo06eIGbc
         IAbio79wAbgiCyj1dgsejyKBffW9sewNTtd4KHKjU4SfQGlm1q7fWetpl4GndCqYLsb+
         YhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414797; x=1757019597;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5QvFyFoCZYjnxni8upUiYsAQGKLADYqIqDf8F+46ok=;
        b=Tt19PUU2qZp/CxRfMTTfu7nxHsDaQR3Ul6NO+rx0xTMc912dqBdhcIsTEJitQf9lwX
         zT4L3ckHGcWsg11iNt9yFuYRAlJGDoo60y/aBR8zNNfdxz6jn3cP2pSY1i74qheFSPaH
         ZfSx5puJ5jqEaBw0Xpek7W8BBHf/cihjIGLXIG3Igdfw1zFWgYHGAMCLGkB+nh4GVKI4
         WsvTuWtudqPd/s7rWr0YKn6FKpiBOUGreYZlFDGPgPth8dFN/Mlak3fJDpoiAivji5yD
         U63Lnfr0yLgg/8x6RXFaQPeVPc/kDeQxahn3sMLH9NzvzWlQCUVSSDt1yBsvH4n4x+ba
         HsyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9NM/alaEBCv5IrA6pcEAsrqEIXhm+48KlGhk30/Fg9xomdn+XsN2ASiB5KCFIzg6096M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcxpFqUh18eV3qlOWBf75EEQZATZWuIlHfOjTurl5aqTwwxuA
	mdtFHs9jSF7YQd1MiBi5ZSZ5nciop74wN5OTlt0BLL+fedskLh0bjANb40ny/wGpVLMsbiWy3B7
	8nURcIZWVAQ==
X-Google-Smtp-Source: AGHT+IGT7VvNBOysikqm7Ip6z5MM9qYjsXZMh/F3vX+DAq2/r1JjBgr3kNz7krbG3UTwwZvNOtMhRC0tfCtD
X-Received: from pjbpa13.prod.google.com ([2002:a17:90b:264d:b0:31f:3029:884a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a88:b0:240:671c:6341
 with SMTP id d9443c01a7336-2462ee9bb60mr391361215ad.26.1756414796965; Thu, 28
 Aug 2025 13:59:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:17 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-3-irogers@google.com>
Subject: [PATCH v3 02/15] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
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

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..6ecf38314f01 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.51.0.318.gd7df087d1a-goog


