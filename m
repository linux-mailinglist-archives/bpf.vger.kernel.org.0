Return-Path: <bpf+bounces-48481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B83A082B3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE881889B7F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C50205AAB;
	Thu,  9 Jan 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eH4BThZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF02054E4
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461286; cv=none; b=GZxafV/ZaHLjXcNMXogWXcQYWzGvujzIwbUChKgNId0DurN6aTd5gshGCwNyLlIuBY1bftyBF4ArZud8CPw7lVreZPEA9NeuYPkA4btlvid0qqO14aAGDi2LelH8MjQiPtVFfnNW06Z0S+nX1XwzGo9bhkbYV5KgNULqVmpA6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461286; c=relaxed/simple;
	bh=3fyRdYULzCN3MTYnfAQ+Nm9siIjPNFw3tb7woOJt0Yk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=WnF4bTLkJOyNdFWnB2KONV/8aLGomXHh7oCIcd2ExvslBwKuOO2g4E89ucRsw3LDTD9Ipe8u/LSgC96zFWaLwClpHoY7wEUGgKwAw1kjjEDTWoHnRySnh4Tug4M/Y61lejLVYRECXF77xZRfIftwn4FIXt5cDRa9lIIPIGdGAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eH4BThZ6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39fd56398cso3361074276.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 14:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736461284; x=1737066084; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuhWWO6Q6WZEB3o/osEw6pkCcgeBn8X4yXFkO6XvAnA=;
        b=eH4BThZ6QCzHbOLvryy8yiN/sZqkZwNe+uSYEq1MIvmLBv2jGl49t1do40E/DPrbNm
         RZtlf6/oJUMajkC07XKjGGvNb7oCNPAprJKYa21w+msQ3/Wxbmmk33SKIVogkUUSVlzD
         +KLh1k+53D514QtxxJeoIeb1YazvGAkadHPJGvymbvQ4FMFBC1tQdX/QSBY39OLD4wLN
         iabIWSzV87xunEHMvQ5Mj3FRTs8M38BaIl5dvKGl8bbhZl69DcLmU3PxlN2pZO/bKLIY
         oN4CZsdWcRv/L3JpeeupNV+gNUkSmVrzyKBSf6I0rSFT9uog5QqbpeInbBguuwWQrOdr
         Y/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736461284; x=1737066084;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuhWWO6Q6WZEB3o/osEw6pkCcgeBn8X4yXFkO6XvAnA=;
        b=f76ncVChNLVrT5RN+nuxaGUyCdT9BNb+DS5VclK+awABU5aU5QsWtUUVrl2UbhNaDO
         1pZLyrER5hdMrgHDrHuD/MXRRiwclnuhDYdYX39HHuUDdQzXU8ycRrh1njoz1Ngn9Zyr
         FUjEP8GbQbCJrUt7r9j0yjrfvBKpcaiy1tcKrxE/Y74N1KI00m4Go2CF+Um/qHZCV7Jy
         ZF1rHboXbw5L7vzlnEjQtS7Ly0qiJchIPQzNp//Y/CGx47FxkOP6vGaT2ev88b4s3TIb
         nJsfHUY0jVX17dY50n6Te3ZSTAl8vwW+90G7kZZSfXwpSVZPkWJjayqxPkCsVxQwE9CJ
         yr2A==
X-Forwarded-Encrypted: i=1; AJvYcCWAS/EbAQpxbl56vSOF0P7JpkLRM0EfWn2Qd6+x0AMmcCiF1dWV22COp/O4c28loTOXyrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8tqslBG/9Gtm50y31/JaHDshhUnGFx4iiWKqTVIQrZ4UDI5m
	g10exT6V3zTwoEm5m6IAeldRW/isTyeLqbnZ2ZwSZ/RsboqQphKslerzH72PaTlor9XkG25Op5P
	AxPO81A==
X-Google-Smtp-Source: AGHT+IEiDOmJm22fE+a1VviBu2xKodkwuLge66gjDYaGITLNEuD+cAMnJj6OhIIJzoCm936tjQ8xgSbqHO8m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:7a45:0:b0:e48:4eb:2653 with SMTP id
 3f1490d57ef6-e54ee1653edmr17157276.3.1736461284133; Thu, 09 Jan 2025 14:21:24
 -0800 (PST)
Date: Thu,  9 Jan 2025 14:21:06 -0800
In-Reply-To: <20250109222109.567031-1-irogers@google.com>
Message-Id: <20250109222109.567031-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 1/4] perf evsel: Add pmu_name helper
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
index bc144388f892..026cf9a9893c 100644
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
index 5e789fa80590..2dd108a14b89 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -236,6 +236,7 @@ int evsel__object_config(size_t object_size,
 			 void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 bool evsel__is_aux_event(const struct evsel *evsel);
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
-- 
2.47.1.613.gc27f4b7a9f-goog


