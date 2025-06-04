Return-Path: <bpf+bounces-59665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42FACE3E1
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D1F3A4E93
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBEB1FDA9B;
	Wed,  4 Jun 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/UYpurF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB21F30A9
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059162; cv=none; b=fHG0lvghcznvfmfCQ0k8hWSgwwr5uPYevb1alaZfA4oBER9JRZBs7dVD7dOwrPJw8O9m2+WOO7nZYIYlngK28N1ptveYzTCmLzVy1crsCESGQ9ECL5a/E+L/gTO6378VPmAVE/AScwA/9PQgNMEbck/h3/wE2qcFC8KPaSL0Syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059162; c=relaxed/simple;
	bh=mj6O7f7WcH/zJTyNj5dVGJmYfITex5422KtPR0vbY2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DeuTEskrjtPkgutOXUFIS1dN68GhkzEcGq/+z7tosb9mO76jlhKJskECJs59D4zMNkxeCU9wFHX/MM03RDOpbmog5W760+Qc/Hsmog/EvHK4mInEVxlW055xxGGxAqqmLKGlipCuof1UXASzFOBEjSyNfWmDRahwAaBHXEaQe4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/UYpurF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so112228a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059160; x=1749663960; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cr8AU18vrh9A9pbk1lgn8Z0KqD4pWB6L1KR+gFE/XN0=;
        b=L/UYpurFMFckJRvZrZPVO29Iwr3/Q6Rdfl4st/QRvnlqz/MfCvqG4TPr4Ql//Dce7v
         6iCU3CpsI9sV7HZFrsaKzAaMtW/tgjD3ijJoTpB22fV8A07DGwlcTflXXHjsqKmQZ/Kb
         W6zBoF+EZm9qoVlzDPoDdrcnvgehYjwMgwD4Z6Y46GtBSF6slYpF+4kP8dW+em8JBJeY
         TNFlaxjI9PPDV+mdQdr9cCgXXxmWQ93jG279+S9ZtIg9K8pioH7c3mcpUBrEuj2rVhQe
         M/rRBux8gF1U+AyWTli3t2E5QDMy/T0xcZTESO33WkNGv23pn+Nr+XIlczEyvYsESDvt
         6r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059160; x=1749663960;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr8AU18vrh9A9pbk1lgn8Z0KqD4pWB6L1KR+gFE/XN0=;
        b=a7hldSIjjr2oPwKUYv0ul9kReFsrrVO8afSvPVPscsQsiP/KVCl9MQNKElCKn/QyQ4
         TXxanXWKeZkrloEvRGIU0ZcQXsZLQ+Nb0z/Gcrc4rvsLhHb35VX0dgol1k+DCJDWYCfM
         /bETCuMiKbteqwoLcDDAuB8Kuzvs5h/BCk1uhE01LkTp2U89Vmz8CdjFGPU5qTIYmi8+
         2R4OqOusLRaHLyH9hp5nLj6L4w/H4uioeyZ8QIB1MuDsP6Nys0L+pl15LVCfm06E5CwX
         tC16Zm8kaPPedSxZsYFJiuHAbs/JD9O5etE0ALNLv//mzgtIjseyQpwvEHK+PX3T2/JM
         q83w==
X-Forwarded-Encrypted: i=1; AJvYcCWUTKr5CWYrPHkdYfFOb9yauVbJPU+m8n3J/t5LOZvJj/py7nxyM36HKZoHhoxU7Zr8ql8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBQ6TpERBuuqJIFYUfSwKLZ/gOlCHz7ZfrUF6KDkbCkWen5sG
	UYVYgqOsHg9s9Vm6fT9PQDcR+Uhy2/Rye6V2OV7+DR/oFVJ8dkzWDKGjRXxo6D70jKaapWvY7EO
	Zdbo8TqImzg==
X-Google-Smtp-Source: AGHT+IEOHpDk1MKKyIDD4q4LfRorilSCWNnk3I7uuyrrodCqLKuvammmxhdoTFNTJO57M9BNCXCFuWEOQX2b
X-Received: from pjvv11.prod.google.com ([2002:a17:90b:588b:b0:311:1a09:11ff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5544:b0:311:c970:c9ce
 with SMTP id 98e67ed59e1d1-3130cdd981dmr6224022a91.28.1749059160074; Wed, 04
 Jun 2025 10:46:00 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:35 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-2-irogers@google.com>
Subject: [PATCH v4 01/10] perf parse-events filter: Use evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than manually scanning PMUs, use evsel__find_pmu that can use
the PMU set during event parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2380de56a207..d96adf23dc94 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2564,9 +2564,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
-	bool found = false;
 	int nr_addr_filters = 0;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 
 	if (evsel == NULL) {
 		fprintf(stderr,
@@ -2584,16 +2583,11 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return 0;
 	}
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL)
-		if (pmu->type == evsel->core.attr.type) {
-			found = true;
-			break;
-		}
-
-	if (found)
+	pmu = evsel__find_pmu(evsel);
+	if (pmu) {
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
-
+	}
 	if (!nr_addr_filters)
 		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


