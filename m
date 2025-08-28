Return-Path: <bpf+bounces-66896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49BB3AC51
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFADA02BFE
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F234321B;
	Thu, 28 Aug 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Am798Kkg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673634166B
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414810; cv=none; b=WqqAE1Gn+is35iJhrsjNQy5ZmHqNdMMPnQKMGTrMO8WFaVzFdIB8ASN1jIO3U0H4Jh0cT0X3J4Bik1zH/QpQL4qu4QfTLTsivWayZsxTvoI7ZP4Q80Jo93HSDAHWV5BouVq+ZasEAvfi3db5t+gXSnZN/rNHfgr7TNbOWCtLFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414810; c=relaxed/simple;
	bh=1YfEmHI4Uy2vFFO0+JK7swMQARnybRABQBKgXst1srQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YpVR4RdK+eXR5EHsBPTFEEIOIRM4wtYYHrXvB+FBwmnUFS/d0+QkfkCYpVJEP/qXLGI5zTc5wl0GRCyKUhcFRBYeExopHtsQSA/HwRvBfiZ1pn5zJoR0rN+oAkC3vrATYO6ohi5EMd6vpPYLzbsvnOupSoNJP/DzsjuGWcjcv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Am798Kkg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32769224506so1363475a91.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414808; x=1757019608; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBs0PRHAkWTSJvYcU2kUxuzj8mrp6f+56Zk47OKuWSk=;
        b=Am798KkggTztQ0gcShBiDJE46Ii0QEjzPFHpWW2SvGOzfWgjSXhU7KZ7ZQPYnA3I1s
         heOZzwZAg/A3JAbhkBs/ScCk0sLD3uC5/36nxB7+ANy+TV85wYSNouvSNSNLLRE4kd//
         hh4fcBaUmFzT/MkxVDMnMElTm3Gd3o+wG82rEnFSHDyGfE3qilnKc46MbzyhcDDLmxtf
         D+wmP7Kl9+lRydmluuntoAULPiaUYUHUDUpItU8F0MWC39n6UT+xreYKdJeLJ+ePJ3t0
         klC6jq1YGRFqOZTX4H84zh7WFsLvgqFdzZ5jKm1Uy4CjEBBh4f5DBWYLTEIEy/qtrrtk
         VzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414808; x=1757019608;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBs0PRHAkWTSJvYcU2kUxuzj8mrp6f+56Zk47OKuWSk=;
        b=YTgyWystk4+gmsk/CaEZzHStEYrS9/RFVpkvHjPmFZKonpzf03HAibhqyy4FpUdlmG
         cOM2FQ8DcFrCOinOMKPc2ntpa04exQCgLucA5Dd8zMMnaDg5oFIPeveEChGEp4U3oeDt
         ecnXGgfE8E9N+ARcCcFev486879e+nH0blyB+3oCvE9F3gRj2LCA8jmeLHPv/7h8sKqh
         OhJE+7RT7fzXkP7aZpwbLUeHjU0dw5ynvWCPDVTXl5ORtkT0Z+bWUN4UnuZFFE2Rpr6i
         /6m/7Av+2kqAG29crst+RquVoyzExvcBcGLmzYZAGFu+kzEcyqkF5vEQJg5+AabXHEja
         dWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvcSCCUhg0L+hN6TlA7dtq/wQ+H7AH32WlJZlbCBOYVXZ90g130D4/9t+XfS4YNMIHiE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzH67Zz+J8FYaf5VGEOYj48hP9CRdJtieABF6wB6rOMQAmbYH
	0NCBLo2ZHmdZSOSbSTJoTaViMD3M0n56pgTnDPBNCvvHkCHdrjB64FsXRQIz9iNbEevdPl5EDYf
	AvR9jTpR8Zg==
X-Google-Smtp-Source: AGHT+IGuPwLkOkQo0DJt7x8cNegFJuftnP1xNEIw9iOMCKI99ZduyIjWNQ+zrz0cmtgY1a9ytGVF8xuJp87t
X-Received: from pjx8.prod.google.com ([2002:a17:90b:5688:b0:327:5037:f8c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cb:b0:327:a665:da89
 with SMTP id 98e67ed59e1d1-327a665dc18mr5865595a91.18.1756414808028; Thu, 28
 Aug 2025 14:00:08 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:23 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-9-irogers@google.com>
Subject: [PATCH v3 08/15] perf pmu: Factor term parsing into a perf_event_attr
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
2.51.0.318.gd7df087d1a-goog


