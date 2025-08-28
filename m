Return-Path: <bpf+bounces-66853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEDB3A66F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984681674D4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC9322DAC;
	Thu, 28 Aug 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6Cv36DM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC88334736
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398779; cv=none; b=GEr/SACltx8xQkzSZZhNUU46NEX6Tm3UsyuEIsKZNPiGF4jbOFQyKOaaOCqsFYexYlnPvkwywAfnbNaPGNC1IYcOhx3J2ysWGq6CXB3G0mcBnVc+rERJo6N57eFIilVEE5Gl9aFPccr1xSt9civRIlwZm6h1gbQutHbC8qOehdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398779; c=relaxed/simple;
	bh=+fCw9E0zStC9lJI/2pWnt73NRryaNZPcIQmzoUTfvjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Y28ao6oCd6yFll7HNIkmAJTR4z4+9hxh7MLLQLsqQuoiINQOQI2u0DJOl3WmlTrbDEjsv9BJUY/y7U8tK3q1duw8LN/zTYs3bUcCcBmY/bkW5jqRc4CkuTFI1omCFW0sXTzvbt41GCVCIM73snBUcfWyqYmoWQfsgp2Ue8uVUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6Cv36DM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7704769dbb0so1248692b3a.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398777; x=1757003577; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqRfHxs/ATgD/29kOhNAqjiBmhk8/trbtDTSb3oG9uk=;
        b=k6Cv36DMfvqDKwDCBr2wqNH3GwwCrRXkSKpeqBJ5iHJ1VOQcHx6yU1xS499ZhIICb1
         HZrrBmxTbCLG/EgpYcQ8bGSMhukLbIG/Pjfr6DZIc0IcoaAZHRXGTGIOGfqNZ8ZFqjeW
         h+xzaJ5A24AxOTXldv9rACGkUqGP08pw+rVWwXmf1BRjBC7SE/p/PDXHlb4jHIHQFJQr
         x0zudm+tIOc4+b3JbFMvYu4CjTKMTNXyCAV1JAcUKb8evf0zfBseshcBgjDomya0rdmJ
         rUDBfN54C69GFdlUABZnSbaAY9SrCsqZSOVYyM5/IYx+tsAHbwFvDPTb/PY4Pxm9SJqQ
         9LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398777; x=1757003577;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqRfHxs/ATgD/29kOhNAqjiBmhk8/trbtDTSb3oG9uk=;
        b=a54GTHWZPEW2GSDUGG9rHZA+yayUq/v7TaK/XTZolCIZ/0sQdjS4UzURE2vFCUhFS3
         fCtdFWHoGjkhiShQS6ro16wkHbIpjkpndPMWMhvMufUOv4rXtA11XYKZ2XmPwgiMKXnz
         3+VK72y0zSKWxHWQLDOHgvFh0lOKwCwaAg3nElzdQXWBax4u2Ei/f9jncWIltBdxmQHu
         cPunjbtqheC0vzxEFJhFibXtq9NFv4j4pM+aqebskgVrjGLtMISyIcLzg923sIIdyimP
         M/ROLZbmhWBAx5P+gHABlKT29P/nLIk9WjSSQ2D4ACp1II9gdR1JlOb+B6olZurZRL+z
         m1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHRmZIlvRMsKweUXzUWJ+15zx4XfS3k1dUuQYWCXLh+93uQwXZ7IYvBh1z00o4FFMd4Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq42YC6kOhBGRRDfHOdfLc8MYpUghT1+hOypXbZ7aW99EyVpDK
	dQ54eoxPhj7QcNy8h8x9Wd6TNtJAu3U1Hy2KXcFWjBFxie03VGHXJKanKqKpmZfmOphIfLe0bfN
	W0kS94SxiOA==
X-Google-Smtp-Source: AGHT+IFqAqtXwytBjJ9HAFggv6uFpz8G5fB1n+L066mtNrZmRCERndU1VZkqbV5duONMFP5tkKf3OORrxho8
X-Received: from pfoo28.prod.google.com ([2002:a05:6a00:1a1c:b0:76e:9a1b:e821])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1398:b0:770:534f:afa5
 with SMTP id d2e1a72fcca58-770534fb2e4mr21051261b3a.19.1756398776616; Thu, 28
 Aug 2025 09:32:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:18 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-9-irogers@google.com>
Subject: [PATCH v2 08/15] perf pmu: Factor term parsing into a perf_event_attr
 into a helper
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

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 818be59db2c6..36b880bf6bbf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1763,6 +1763,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str);
+	if (ret) {
+		pr_debug("Failed to parse terms '%s': %d\n", terms_str, ret);
+		parse_events_terms__exit(&terms);
+		return ret;
+	}
+	ret = perf_pmu__config(pmu, attr, &terms, /*apply_hardcoded=*/true, /*err=*/NULL);
+	parse_events_terms__exit(&terms);
+	return ret;
+}
+
 /*
  * Find alias in the terms list and replace it with the terms
  * defined for the alias
@@ -2595,21 +2613,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms);
-		if (ret) {
-			pr_debug("Failed to parse '%s' terms '%s': %d\n",
-				event->name, event->terms, ret);
-			parse_events_terms__exit(&terms);
-			continue;
-		}
-		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
-				       /*err=*/NULL);
-
-		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.268.g9569e192d0-goog


