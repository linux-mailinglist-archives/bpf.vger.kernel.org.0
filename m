Return-Path: <bpf+bounces-69339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14C5B94347
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275C016C545
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6B2C3769;
	Tue, 23 Sep 2025 04:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKvZoDtc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3E2C15B7
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601172; cv=none; b=BhLp/6pRSqtIXzepOcK4SRZN0tJpOKFDc+5VQBQZxCEjI34VkEXJiXZREShewcR9C2FfLjeQfK2LDrgOIO6JQDDAAoD5Yvwig4Y8OFkgbWzRaXV5bEIzrt8iI/5CCcwneRf9f3YjGAwA22V5hquaRjpJsWP6l9YHamAfgmmrjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601172; c=relaxed/simple;
	bh=42iBM+j6OaHjeb87rjIgQvbVIu0m2YAxZp+bcUWwqIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iT39pVWPHSOmmjTKqY6wq1FaNO8jQMlbfFv8gKmZTMt6ikjW6eaaD3cRPJpNZZlIFmNznUmadpxOX7uMLWWgHHMjgV2AK8t5mDzKPMcfgUrzgdnEUnC1i0T5yfhMQPsCY383JrCTS8L6TjFDvEMb62pm/ZeKeL5ZgGu6mDOwIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKvZoDtc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f2d29dc2aso1501486b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601170; x=1759205970; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=hKvZoDtcdwBPAan5T2DrEj4d+X8aBKozt49vTB5XfjoYt2zvcuXegWnc9LuQ0t8JKn
         u1nDpUfC/1Jmc+gkhhxqzq8xZq2FOKWHTRDE5229D2Fb09puCIPtFER2xnZ1ajE07rxp
         lNvd10t8Lo+fFp8UbNsCFKaZJwGB9fQIu6hTxqOSaxlO19SMfUETs5p0IZV9KVMxP+wh
         2AraBYn1XWjrN+2z4v7pQGS0qLXa2a4UMrjzPOlYxLGb5KZnDtuCEOFoz7HpPJF4c3Fg
         oz9rxJgQ97W0ufq/Utfc7qKyA1Kk1fCgN6P9KqUdlWTadOijIF/os1w1iKMrw3Fz9VYf
         QNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601170; x=1759205970;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=Ys53cPs5vkVZG7mGgI9UhAIvyy61IKKG//Q3XYK9GoxbmKmQKcw9drY2IHDiOqi7pU
         EdZmK7tOXc5Hn3FGTCKMcn/l8NmIK6Mf8JaAjSMcI8JRKFDt6UFwsdBPO5tDQp9a5BhS
         GfZymiw+/I2MTw7EPI2nGI7r3XRhli2FzUhMSkUIG8BBvr8C7ezlupokVZ0YjXrMPEeg
         XkxcyqH0BgKp97k4hcnDkY5L5likJntD/ix7UBAGcHaI/vnoaGR15C/w+C4buJZF1A4I
         WPVCULB5yEg4k3+I/mWK8TLf/kKRYaOfGpBaFWmUiRaiUUZsTlnwu72FJiGGYGqlIJa5
         lVOA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFsIejH92Gnq7/TGw1rlM2ZbgvyJB1gz2sVYU8//bQOhIp8z7q4EixoVaS8q6U4efjMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+rs8t+wCdfz/7ptdVQPI6P8Qmllr4zVx3xvGX/n08PXqnOCN
	hm1q5J5buJK8hhY69CsI8dtEv53zj01pfns716Bi1EQbKXIiY1vagubqF38vht2f952a5gMQFjp
	+H94bqXgs5w==
X-Google-Smtp-Source: AGHT+IF0UoFkxTH6FU00wEtyjymwn+KsC7TsbR+8Lhcdy4noVLIgU/fBCTXNE1X42uS8iAeiRcTzZy4xoEKs
X-Received: from pjbsb16.prod.google.com ([2002:a17:90b:50d0:b0:323:25d2:22db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748e:b0:2b7:e136:1f30
 with SMTP id adf61e73a8af0-2cff213742cmr1861087637.55.1758601169838; Mon, 22
 Sep 2025 21:19:29 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:38 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-20-irogers@google.com>
Subject: [PATCH v5 19/25] perf evlist: Avoid scanning all PMUs for evlist__new_default
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

Rather than wildcard matching the cycles event specify only the core
PMUs. This avoids potentially loading unnecessary uncore PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 80d8387e6b97..e8217efdda53 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -101,16 +101,24 @@ struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
-	int err;
+	struct perf_pmu *pmu = NULL;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
-	if (err) {
-		evlist__delete(evlist);
-		return NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		char buf[256];
+		int err;
+
+		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+			 can_profile_kernel ? "P" : "Pu");
+		err = parse_event(evlist, buf);
+		if (err) {
+			evlist__delete(evlist);
+			return NULL;
+		}
 	}
 
 	if (evlist->core.nr_entries > 1) {
-- 
2.51.0.534.gc79095c0ca-goog


