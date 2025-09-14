Return-Path: <bpf+bounces-68322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A86B56B03
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5CE17B07C
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1592DF125;
	Sun, 14 Sep 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+no/hoQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAA2DEA6B
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873492; cv=none; b=rP+MFjcpsXh7qoWHDMFGXLPkmMkHCqC1J/J37l7O23c5AmL9tm4Qi8yTM2Tuy3nnGt8ICACFv4djyIRiReOzMZPQxQ2vcXlq0A3+IVlqET+ndXPT84sOe6FmI9exZ1MvpgkSQFEfwazuVRSuzC7ezfiMfe7IL7l/xQSzOvsjFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873492; c=relaxed/simple;
	bh=MzbOrRB81V3a/DICE3YLMrKiA/UYkoE3SQM5vtH5Elc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJaeDZgeHidx5876Y1zaVs61f/ZDalY0I5PYHERGEjevgb/Vw5g47xyFaPHyguabOU/AzODhMaeuHBnTAKbBUS+HPQ+qUarzbVZA3hA5APGOMkD4Qa2DcP/XH28KguzJnXKvC3gk5LYovdUBIrMEb4crbrnljweCRKUsAObpBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+no/hoQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so1441012a12.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873490; x=1758478290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/8NzEKabySeuJN7szepE2Zk6AAtH+l92Sib06TJNws=;
        b=j+no/hoQNjaXzKoaVchiN9Ws8oqRSc7yQ8AYM0vG8a2NybgdHPSeqUoOIwMOVaRuIG
         aYqu/eJ6vyMd8rPIX7hjAHULxxqt9N0gWgaGLBVTYOwqrEDUTTA5yUIWQbZjq9fipNWj
         VCjN0nwOhY8vdywvuR3O3IlYB/6UYNYEGSablP9iIspb992E9wNxbue2a9WoP1CITHvc
         0b7jhPbXuHSG9xrfSrxHfGCl+lwn3OXJAae2spoyARqX+ZSON7XlYoQLYj8+1AOv9N8b
         fvBs6aRi8IYaUDruGmqlcYB2TtgASjxDy1kd+dgjiXMXkCS8G4dDL/IBHDALZtlmW/Iy
         soqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873490; x=1758478290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/8NzEKabySeuJN7szepE2Zk6AAtH+l92Sib06TJNws=;
        b=cbKKmNXYtNO2TAQWgkV5oWS1VHgnoZWJ7HLlyIOe2fotTC3GqQavCxUfJlRC7IpYz4
         AZ2Wiv3PYkIVelShz9MRNr0XaDX+rHtKUI7V4krPXjQN4nAHsdPPhjSADtcx7J3irSL9
         QS2BVmuic8sAMp6B1MXtyTq/pgKPj2VVs5t3Fr3FQU4zrpiOMRvd9Z7bDLDh/9A9dA89
         IvvGO9vJ5QjaqRnHW1MEzebmZngaJXuuXgaATVWWnrfUPnp6hnNp6WVhkxqZFpumIZ5s
         JmTZia1Lg24z6jSiWe55TiY0qRIylZLTBGA319K2VczXewrs7E6JTQH11q8fuYLikoOh
         +khw==
X-Forwarded-Encrypted: i=1; AJvYcCWWW4zErLfy84jzLYVztHR2zQS3VbCD30zYgg8YtSZus7veLWwo0/LMDfrezl/Dy8mIZPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUZr8V2XySbYvMF7x2sPqTWxHLW5uF932yMyGI3UnOOC2v9Ze
	AOIAYKqueK9CMAlfMQvv6lbrgIrrDxRPeGzU3IPnD2Z6nC7H9EqF8EqvGg9Rn007CtoYq8zZj1p
	CEhHAxYXZFQ==
X-Google-Smtp-Source: AGHT+IGT+j3eO3ei941mw44W7Tk+ylCm/sa/Sg9HVaFHN2KYQYZ7DRkpOyH5nEeymXKlLYoO47ew63TgMD2q
X-Received: from plok6.prod.google.com ([2002:a17:903:3bc6:b0:266:d686:956a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50b:b0:25b:9879:cbd6
 with SMTP id d9443c01a7336-25bab92d3cemr147906915ad.4.1757873490075; Sun, 14
 Sep 2025 11:11:30 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:02 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-3-irogers@google.com>
Subject: [PATCH v4 02/21] perf perf_api_probe: Avoid scanning all PMUs, try
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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
2.51.0.384.g4c02a37b29-goog


