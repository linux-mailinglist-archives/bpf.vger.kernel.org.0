Return-Path: <bpf+bounces-66792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C9B39400
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F291C21760
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6627B341;
	Thu, 28 Aug 2025 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/ybYm5a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CF2882A7
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363370; cv=none; b=tTnUsmAo1I2CUwnPuZ9APHpYzX1odEvkYtZiIdY59vuAip5APx5uZ8GbD8CmILYKCTkUmS4/vK1BTv7zyvs7/9fXeL7KBfTRaRwVdiDa9LiJSj2MaUSu2KpimIKP/ribOsrPwL2erM1E1hfnEeiqlTK64u7uDPI1Xm+FM8/XxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363370; c=relaxed/simple;
	bh=5koWobhFKzB/i1OAVyIFe0t++WfN/R7tTbQmx48qFnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EbOPshKVTEjhfQkYznqzg7CpAfoLEFQAUw/pXI4CvRwUge6RgwbQQmQgHypjO0QAhwPJgdDpccF2aW750CQmthDBlCuzPUWsnJQzqg84jVa4aiQ8+7XC8GrVvaTH6pEAaAa8et1dOqtCy0cUx/cFUfrKtcOtWB2lgbPn/WWGdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/ybYm5a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b00af618so379237a91.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363368; x=1756968168; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSMhtCRMX1JJ8a2M6HYUBkzFAQBtsVFer7zAsyKI4O4=;
        b=b/ybYm5aM71jXGL8iGZxxyOW46CEtTBzcTVWCvOSiz88EHQUvZKbkttTnIWoLVxvMI
         0uED7fYObzIdpzrllCaKO2qNILxz7Pd/lWq9FD10NDlAUPol5+ie1/NOmatqcX4Ip+nA
         I/4wftJy9IbsceYuI3D7Wxm+VgR/F+fIx9+hnbR97H0imAcIe9eyJTHsPIQLjJIq7ieJ
         l1WieAerk2rHbvKQHWKbrEGOsv2ZeLdsNAwFW3oHVbrq+wAz/kzCi7uA64wqbuOgEEsb
         hC/L8/e85KWKTEaUxAZJPMIaHdoeNzjhHQUqNmaJoNBQD7SWUjSievZD7LB6FsH18/4U
         sLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363368; x=1756968168;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSMhtCRMX1JJ8a2M6HYUBkzFAQBtsVFer7zAsyKI4O4=;
        b=Czihf4hobNvwjjdgDuG9Zf7z8EtK8f8BAMuRQXzSbP+JF177IGXszmDsWb3msNHLEy
         AIcma4PZUxZ6UlaKvj7I8JJltGcMlnfK8bJiho5aE29lAVz3DpaM/GdhJxpwdBfQtcdB
         AW88e3C5veVWWlHvvHN7WKa2luLbfQ0ssgV7khQYUETQ+KIYJLvPFf9V1yvnIzEEVyRA
         DfiUPyCvtmZFcNUm7E+hgF5aLJqMdUD5QYF9LvA8JWAt9NXXGbHFI1mN/96LqytQla6P
         R5r9SICesLjRiSq6Yl1vpIzPxZm5q5KjBXYCCYvp2RurGQJyYyd3xt3IDQbfhdZAtIiV
         W70A==
X-Forwarded-Encrypted: i=1; AJvYcCXaDRBVOWxazLw+e5MGkaZXio5IyN9hmVv/h1dvBAaJIHo+2izPLq3crTFs8CSsJkW6R34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3Wz4E6SYQUDjFui5h+GKrdxMzV/g7A1q77IPo824/hlKJb2f
	0hbw1lhQkrOxQ3ADqyq9YoCF4sp1AMZu5GDdxL9lZR8mjHsprSIcZ/fphI/gzAF0Ju1Xpj1Conq
	1TfXHhwuAtw==
X-Google-Smtp-Source: AGHT+IH8HcjjRK1HgbbucgHYh74YcyS5gY/Fw9YglOPLN7eSqnlPft8E6lWMp2zvZmV4LCuilyL+qsWiUvLz
X-Received: from pjbsv14.prod.google.com ([2002:a17:90b:538e:b0:321:c23e:5e41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b4e:b0:327:734a:ae8f
 with SMTP id 98e67ed59e1d1-327734ab092mr6455393a91.12.1756363367923; Wed, 27
 Aug 2025 23:42:47 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:24 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-7-irogers@google.com>
Subject: [PATCH v1 06/13] perf pmu: Factor term parsing into a perf_event_attr
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddcd4918832d..e590de26a7f5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1766,6 +1766,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str, /*input=*/NULL);
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
@@ -2598,21 +2616,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
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


