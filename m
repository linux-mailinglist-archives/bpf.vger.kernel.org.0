Return-Path: <bpf+bounces-44700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59C9C6691
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E939284A94
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7A3A1B5;
	Wed, 13 Nov 2024 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfHH/dw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3905101C8
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460811; cv=none; b=JqPsBdjfLSPRDea4gbL9xcdxLhX0O3QX8UwYpY8bdPJ/NocpmnF2D48C0JEhOhwX+YSooH4AZp1/8JJkC3iD2s2FyIceEeSrv4DOoLkbtQ2kXbezRVLQdIPBrdqxq9SBD/Bl+O8/Jy75ntKWVbuo5BpyTR9oXVL9sVWBTR2aNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460811; c=relaxed/simple;
	bh=B7d98v7iu0iWOBZyEIyEkLDh3BJYarsXgjBWdS7mWck=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=CzcTx5Fb6CEuDDPgYvDUmn1ihGPClLWkNxLSRQntxkFo6xLHq3bssHbdVyS2mHuRkOUClkfc0TWgJbFX2w7zTDXWmtgjLFKaD2DBTbAXC0NYRipF0/8sIgJtWNHXXBGGI4jc6Tst8Cyf0iriFTGCZ4Vj6TQ+ByCCuUhVXbXhaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfHH/dw/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso121051567b3.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 17:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460808; x=1732065608; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FC4iZVDfA9Psn4tr7/IlUA8D28Id6h3cYjGHLa1EkkA=;
        b=sfHH/dw/DzzuXMProSeVBFMg4H3TTqh9gwJubt7+SdXUW0BAydq86qkgKMAGp9FUlH
         NR3/C23wSHahHo0Z3LjmwlGaIzyTQ9faRjlBOTKiZGlZYC/LFGDwabvJUt9lY7NpiPDy
         3M2HNbroms47tOH6nZXJpHZy73EUBGLgokUa6W7ZModpaDkg3LLC3a425Ogixf/4hO7y
         hskrmpT2yUJmE5hWro/e0Y+hdBxj7OeZfbdvliWz5FNSXkvtVmIZFevDUJ5Svom2Gzc2
         2tIyccM6ZeAYlolnxEOK6+pdVxzjGh56kPnuvOoOXH/5MqR9fVQknS1c3xxE90cV0UFu
         KebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460808; x=1732065608;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FC4iZVDfA9Psn4tr7/IlUA8D28Id6h3cYjGHLa1EkkA=;
        b=Rz5u7ZVTFGfEVSMIQX9YoE48WZHoUZOJPeLxVz0nuG7xJRWzwe641gMiY25fiR7Dsw
         XIP5ZHou7y+i6p+5bPGMTsNJkR82QQcxwTWM+3iIN2B6HuvH187kI+UZjC8LUcxIqbyS
         g06KXeyHU+wVf7yqN8v7Jo4wDqkE5e2p0DKchscTCHH8JkC11pHX4BmA4gyqkGBG8/ND
         u6nfPAaRFXdH4JsDZ+Wt/t7RMrkT8mx5KQF9/G2Cl0G+EotAmvc5iWEOMepwa8aqwXEB
         1iqDOUsXMKZIVBGgS3PHftfrrDTWi/w9lOiyPBDh482hI+LFIFFaKvDIUkfFO3RBu7DG
         I3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP7zcsNSKMATMWWkGyG53ktYaDzmJ1t36IIkdX+tlhxoIp20UtHGmQRao37tW+tNt+ItA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TP5X/Ajb0tcee3Cim4ZWU5zIQl51zX0YB6g8G5app5TThVBW
	smk/SNvk3NR/zUpka3RBVzTlzhRSZYTTSPTOcvarM6rvvJebmGFxdXy+Ux9csHlZhh04hPEtkg/
	L3BCacg==
X-Google-Smtp-Source: AGHT+IHQdiU2SrwtVR+AvueKM0JcEmUAgblQMa7cSJ8NhDUSuWmdG8+8IrNvddFFnEmCZQCBQ1wOK5Mhdc8a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a25:d8d1:0:b0:e29:1893:f461 with SMTP id
 3f1490d57ef6-e337f78051fmr54936276.0.1731460808514; Tue, 12 Nov 2024 17:20:08
 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:53 -0800
In-Reply-To: <20241113011956.402096-1-irogers@google.com>
Message-Id: <20241113011956.402096-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113011956.402096-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 1/4] perf evsel: Add pmu_name helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
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
index f745723d486b..f0059a1f62e3 100644
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
index 04934a7af174..5774a9d4d725 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -232,6 +232,7 @@ int evsel__object_config(size_t object_size,
 			 void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 bool evsel__is_aux_event(const struct evsel *evsel);
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
-- 
2.47.0.277.g8800431eea-goog


