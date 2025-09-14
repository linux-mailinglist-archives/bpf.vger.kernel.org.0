Return-Path: <bpf+bounces-68337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B8B56B1E
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F87188F9BE
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0662E7F00;
	Sun, 14 Sep 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPEd1TF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A82E716E
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873522; cv=none; b=TKACtuoqSyN4sXNzT/89upO1RqotPQQ3RwRc5JBLsPhfKHKqwsdxkrno4ohbaEGn/2a/2JLOordEE6RpzY0ZVlbA+678T1OgS5q/ZPJVq1xU4qWr9gaQ4vJFrLy3m/S9X4Bz8kyD6eN77Gv7ehyYMzCDRk8pBQSzmiqhGItE6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873522; c=relaxed/simple;
	bh=h4sXefZhOxCEKIvBSymmqcVW8M/ts7r+91O3C+eEVL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=n4zLefHrW9eN437PQxRJovbLpH94wJNAIZdJrYYINiNiU4IUV5zesnR5NN2T81jOIhBmlZNNUv+Q8uu3P4ViF7EeJjXZcMjyKb1MfEZu4p0m6N7sSkDJWsv73PHariTOnaP3Y9/xGaKbXwC9SfCXKUAU/WcU8+BXmpz4mpE3Kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPEd1TF/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2665e11e120so2281415ad.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873521; x=1758478321; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjylI1Ng5NnBN9pwU555o9z4A/tVaFnze9kkfZFImEo=;
        b=EPEd1TF/g+sUy8vUx5BrC3+BRQNE5M2b8/f4tYYAQXrzJPfVs1jpnEDjBfkiuEI4ab
         t02kCy2Igs4rm1q7+s/hEBNvqNQZ/hKk3CESncvBjcMccjtU0a7+bZ1EQKLUhNAfzcoH
         tbSiRy2vwoe4g9KU5gIUKAVFiXlpLzWujm7VPEMFkg8ssirvlSPMQGWeTH26I++yfFji
         1Qs8+wtYCdw53/8Nzr1aZQ3ATcB6LhVT4+e1UtYjNkHyTj4Hjy7JW7Uq91f+elEwSiO4
         9mI/WnNF6ya27hs7Sp1bQcSZthAdcznwlzUROj5IWD1ZW1avU2unTlaJqbFd8Jw5Ffg2
         0/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873521; x=1758478321;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjylI1Ng5NnBN9pwU555o9z4A/tVaFnze9kkfZFImEo=;
        b=puD7kOU2JnLjG63vBJOuIaR5y5IBUFJpdw75+TIeB5GwHccgrlO4R0Csl+8BryD7Gf
         0q2CkKbMyuDHVtZd83gEN93930UK+iTmsFRbyf3pyZsxoUmcm5SXMMxM3y2Oq9mxG4F3
         VZrkPLPs8OIhPIttdbl2MCnVNKieytWvd78bcmu7F38jlQxz67DlGBR9QZKa7xgMV/SL
         j8EprAVuhVG8NHMcglfaejafOEdmSzw5BSKXOXES4BVO3tGs/iCkLv1j/V/eNhkfipdK
         UpgCnEOUg3L8GBuCCbGujfUMMKjgzgCAuT4gwt0Q+KRiaAnY7BouvuhJjM25MDyi7V1k
         7e6w==
X-Forwarded-Encrypted: i=1; AJvYcCUK2zUXcWCZHAOUEsGbqk+/l4HtRnNRoZchu0kjqMWxK3qLy9WaTFX7HFp78m39UDbBLQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEMsPW3wdlVbnQr7PCV7S+YwukfAa3MZ5Jd/9PeJs+ZhYCbR6
	3zReex7vnYzRqMeI2wqcfiVs3pLVybgTlkxgIHKVnPpPyCPAYvSHpyor/zBGkhZVgZz7xXR0QLa
	3b2MJBEA8EQ==
X-Google-Smtp-Source: AGHT+IGnn2xJFltc6k0PjS03jSoP/OrGc3R18b/p/EPkWiXKByR1WFESRAYFW+wv288N7SKObI6ml3yvLFPW
X-Received: from plaq13.prod.google.com ([2002:a17:903:204d:b0:25c:8c4a:ec84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c6:b0:25c:4902:7c0
 with SMTP id d9443c01a7336-25d23d1bb3bmr127571745ad.3.1757873520615; Sun, 14
 Sep 2025 11:12:00 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:18 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-19-irogers@google.com>
Subject: [PATCH v4 18/21] perf evlist: Avoid scanning all PMUs for evlist__new_default
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
2.51.0.384.g4c02a37b29-goog


