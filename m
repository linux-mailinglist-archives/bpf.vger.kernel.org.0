Return-Path: <bpf+bounces-47524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C469FA233
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 20:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5CE165296
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90418C035;
	Sat, 21 Dec 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqQEcoTX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C11898E8
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809223; cv=none; b=D2fqAJiRilMVhpevxSTjshVfsa1CXxV0YCWSu6euibxchQhE14rzv9lnNSF9QxjZObM53XDEFTU+Cq70i3CCRfw5dlDl67oiByeBAJaftAfKYW3+/zrGO9X42yG2f4Oh2hqK2dfv0xBkKntKs/S9+v0ZizCrA4xZGh6pT7Ny5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809223; c=relaxed/simple;
	bh=z0BXIU+cy5J4APMsTNwNrDiG3aEgH1lNySzfDNpVA+Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jNeXKz2UWSER9Sbu4NmMGdyGRZ/mj0EexxOfpM7eJXu0UgyoVaH3FDxpApb28kBKQ0WTTmtYFImPNiVT0S7ILgKYGTn3TWJvX6UBOiZ95StImfkCHYiU9XJixrXU+j6sholpPdk9Jf4gXMC0MnpfKr13mHuUm8iyF5Mzc80SbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqQEcoTX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3984b68708so4214247276.0
        for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734809221; x=1735414021; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=To5Q6DXsmBuoVyAB+Coe+PRFSr7U5wanl+AgsMSjmUE=;
        b=XqQEcoTXhp/9f8BVzb08Zaz31FZtXl0B2dVcGvtpqPj3XXUpFhnaKskf8QWJYRx5mT
         Z5+m+UpQj8UYHyJDVb/No5a+xJSDNLCVIFq1WNU5fq6vwfAaDIOPbql8+nI4Cj4ZbWaJ
         pncvT6YvWS0AHIpQbRdp6t+KrWrmhJHGvnl7Pj8EQMhxUtdVyWgJ0msojFGteiNrPy1o
         36qHHkse74BsVKTQtMSWcx2geJvZHegcwDxa6g0q4vcwDNS4ZEdxxGCQ9S44wrw0jYXD
         myXPCqt9ALDvW2W4t0ODZSURkDw6A/0wjzp0iopboq4votGQIbqyhQPT3x/09CPXS6Fm
         08OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809221; x=1735414021;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=To5Q6DXsmBuoVyAB+Coe+PRFSr7U5wanl+AgsMSjmUE=;
        b=IoqRkLyR+Z5yHuw2+9lglxdt+BKfFQOcgCWXGl0hbi9ZmSpHU2oMHRfd73WTrMoG1I
         18TmtFyrXiYx/SlwHMw0UqYuMO5FTlIyJUinwp6pD3VT7ftphxeAZYRiuaeMQ9vqnTsQ
         Q3T7LD+8F3W0Tu4yCJU7zKAwj1PmBDCHc9geHXpYvxgniTd6LEedM/PR37xAaiK7cwNl
         jx7MkVALW7KCraMslxm04HUMdN4AsFzKJPH50kwA7GoKbv0ZrX+CxXfDjKvmw7Rfng3M
         j5X5LJy361kpLo5V8LsAVBoYShs/pdBTJJI9iGq05Fvk40tZyATry1GCqzd2onk3f7Q/
         t3bg==
X-Forwarded-Encrypted: i=1; AJvYcCWWeP858Z/LDpssORPtY2CJhjvGdxhYjByapzKc27w/yt+aoPo4fSJMNgAkqT8tKUy2uYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxpEDu85wkcPobVuWQ3jV1bzC2lfyYMMw5FJpZXm1TX0iVWir
	HOyRSuz5i0Qjy5WF1bdY1zyeZmfgx2WfPpj6U7EEgguDE/E2/6NAL/QPH4b9cSwMrK/QajwLGct
	+KuYxuw==
X-Google-Smtp-Source: AGHT+IFhFbpXLuh09c3OfbDr6j+ZeLOL/XrOzEbPkiGL/D7Eikc8Jn90QIx8Q+lGeqhu14rEJvLMbRvQzmio
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a2bc:ec03:1143:41ab])
 (user=irogers job=sendgmr) by 2002:a25:2705:0:b0:e39:8506:c03d with SMTP id
 3f1490d57ef6-e538c3cb14bmr16811276.9.1734809220613; Sat, 21 Dec 2024 11:27:00
 -0800 (PST)
Date: Sat, 21 Dec 2024 11:26:51 -0800
In-Reply-To: <20241221192654.94344-1-irogers@google.com>
Message-Id: <20241221192654.94344-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221192654.94344-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 1/4] perf evsel: Add pmu_name helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Add helper to get the name of the evsel's PMU. This handles the case
where there's no sysfs PMU via parse_events event_type helper.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/util/evsel.c | 10 ++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6ae5d110994a..109c4f188dec 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -237,6 +237,16 @@ int evsel__object_config(size_t object_size, int (*init)(struct evsel *evsel),
 	return 0;
 }
 
+const char *evsel__pmu_name(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	if (pmu)
+		return pmu->name;
+
+	return event_type(evsel->core.attr.type);
+}
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
 int __evsel__sample_size(u64 sample_type)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5ad352c94d00..cfa2660a06e8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -235,6 +235,7 @@ int evsel__object_config(size_t object_size,
 			 void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 bool evsel__is_aux_event(const struct evsel *evsel);
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
-- 
2.47.1.613.gc27f4b7a9f-goog


