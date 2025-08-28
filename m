Return-Path: <bpf+bounces-66846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93853B3A65B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162F17B8B97
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17207326D54;
	Thu, 28 Aug 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQzWjkVH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1298322C8A
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398767; cv=none; b=SPN/UfD/TMguZ9xosnNzf3ofTR3TXLl9JXe6wL8WD6qpegy6ftI30zm4/9c/IpwgEmC3UT/slRLvsizpXeOvwP6IwllU2yY9NPoYTgCCY/gB8fEe6HH7bRoxM1zB6Dbh2fUnaepuMPtOqCFOp7qG4pApeH5w+Ksxc9wmga4DclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398767; c=relaxed/simple;
	bh=nBsGDyfGV/YwlVsRPVyPqun5rVk7VjpidpS76C7cgSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DrrwT02vajlS4683d2/KzC9sSjda6yPb1M11NXORILozm/IJy19GcIdk+N9M8IBtIixxPwipp+bsQjkDmwv8l2hbOzuVGRehEphW/p/3r7Q+ai+PlX5NKsTi0+5NmoLx57q5LrfV946FASvOdJVRKYO222o9sWlUFfDPFjfEgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQzWjkVH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248d9301475so14303505ad.0
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398765; x=1757003565; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOQ99xgVI8ZBcLOUqTlIwSjxWz4nfhGrBQ3qwqf0K9I=;
        b=RQzWjkVHdhBG18z0x5/cOvG9T92Zm37fTQ1LPdBi+T3tk7+hVjje/8Z48bpPAFy6kd
         awQEygx4GzL9VKx5FryZzirdUOA2DxmklMYVR8IztO2mb+d8DjcS/+v5x2d0mkyODKjW
         Y+pqPEOcu/rL8DMHRQbHJFcUyuub8vL9L0aT580dmE3WKlJpzVmPF43h9hoMprlgti1E
         w3X2T0yu7wjGaqYsonOFDtkxbjF1npSTFIw1R+1rtVqwHSYuGiWjtEXUamv2ZOHopL8f
         8NDyMW8DD1p6aCf+lPKHcRqMA2J8IejA4xeVq6OxnPlkQ87gZKhyswxL+QpmFLr2/GFp
         9bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398765; x=1757003565;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOQ99xgVI8ZBcLOUqTlIwSjxWz4nfhGrBQ3qwqf0K9I=;
        b=tY3/3vk19PcpfB48Nxq72KPAk/95PXg7gb5Ytz05PAv27NIA+Z18LgbxeexLMfktvW
         j+9I68qJNSbt88QhlYaowFQwIyW8v5GsnazFVmgWq0ciTD6Fxt0xIEbrjuVfII2tudC8
         2cgl7BHG2wgY9cw7XZ8j1a3AhxUDsHv/NuDbm0K5qoRhAZx7NxMLU5V+uRUuIWef8YQN
         /+oiFJgZ6yl2eEF6D+yNo5+5LL+AueqAeYB7a1bRZc7CLdHADsSa8eXYFhD8yvGh+mmH
         x/usubZfSOFIByQ5zVuw88tWQwkO/hj1yZBIYILbU89VGYofnWrjin79zRM2kSATFhV/
         9Z4w==
X-Forwarded-Encrypted: i=1; AJvYcCXEOTX2ID6mlzgE6rGyOdE+R2FXhZ89SIxTo8wDs+CNRd1K+a157wb0VS1uz0nzZmcbYTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjURQF0ZrAlqiH91R4ywBpJWnE1fkAdvTMn0/X0ixmY3RNFQm
	wJEE7LR/I6O9Qh3tGXu4FNHwZIRCkufmSOyqBD4R6+hdQ07IbE1PNttnUEPNOXTdac9N/TZUuj6
	AUJkt8Xm3tA==
X-Google-Smtp-Source: AGHT+IHA3vWe6uuxFHk23cIlVGCY30ONKcmjL9XnxSed4zPBlzwzdH5nz0RTrAs9zkskxHVBmZ/g8Q9trcYI
X-Received: from pjyf15.prod.google.com ([2002:a17:90a:ec8f:b0:321:c441:a0a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64d:b0:246:ae6e:e5e5
 with SMTP id d9443c01a7336-246ae6ee83bmr186912095ad.8.1756398765046; Thu, 28
 Aug 2025 09:32:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:12 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-3-irogers@google.com>
Subject: [PATCH v2 02/15] perf perf_api_probe: Avoid scanning all PMUs, try
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
2.51.0.268.g9569e192d0-goog


