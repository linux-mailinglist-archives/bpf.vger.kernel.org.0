Return-Path: <bpf+bounces-47118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B39F4A64
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 12:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E7D16F1F9
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65731F3D3F;
	Tue, 17 Dec 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2/WpRPy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4A1F37DE
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436596; cv=none; b=Tmm7+jkvM9rP/1fH2mad6Sh2n1iiauwvdVKVtdJ847F4vb+RgsfhyBMR9e/g5eBT9tFp8aXB1s/RSMsdHjBQAbjlOaphozlvrPmP+XvGjjQCnItV9Qxr0aPNQ8wtPIzbxlR538CzCPamJMWMg9ztOHS9HXMYvFihfyLXgmA5Mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436596; c=relaxed/simple;
	bh=EXhJJH3GTtw0Pc2COLLlPSCssK0z09b5q0z1Po3tSGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyAyNeqpMq8cVMsAaDGw++HVHUwaxO35ghTJVA0QzKOf8/tjp8BtSNwoxqU0zkBKdd+T/DD2ID3uGNc4/mWscG+f3blwdKhAFVjWOoWgJOP5I5gSlBY0n1NlZKqwZ0n83GDaka0d61NJd9zS7j75Q4Vxo7DzRj15uvFIknelogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2/WpRPy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso36005345e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436593; x=1735041393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52uSj8E/aVB15WhaSRtD8CBQxo0ybh/UWrgjS+bPGCI=;
        b=A2/WpRPy+ASNIgFlgSyQbT+bufsa7Op61vm4V/XpNAp0LTeiXKNxLxu2jouc/FbYkZ
         oDbg51WJEWVqKsqq6/GHX1SLNgK0aN5dh/g8T801tSMCHgjPFaWJpu2JBGrRpy2uZy29
         xr7bQdluI4Mag7hQ+vSKrvAP2llNX3k1rgE7exEcB7G5CuMZ8peOzEN11QnAiPZyiOOk
         BnFjTkKANCG3sjLr7rOyKZfn/k0m/X8h6aplZJw/oi7FxkanhL3vEFXIp0eBh4OmG8Z8
         IiXUXyIVkOhtQG+8oAME1ETFaaemi7sdNjp2fghmr6BKlpWMOOUAlgSgz8x3cBLnsxb5
         O9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436593; x=1735041393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52uSj8E/aVB15WhaSRtD8CBQxo0ybh/UWrgjS+bPGCI=;
        b=qY0kraAZZvzzpqyEC5fVl3Vif7IflZ432D5rIg9iJQV7k5VItmHje1wjUdgEDSrqxt
         djTFCSnph7i44oy3tHXVIvvhheFgRoZIiTfbP2VVNi9V96S9/R9dYhiV6WcfGtggBI6+
         VbgjZPsewzcP4aDyiKzExYyetLND6v+ZCnMOCXdIFGXf81oYNx8vb5uAMAeHZdD6e1Oi
         FIegwS/h/8q6BWkCtBTqcmJI/liN5D0Y/SElWEMD8U3RzpvwOc29Cr7E095u9sWnGv6q
         JbCgE0CXN8j7acrbeUfDtV5ptxWCQsd6gQnUinajDc31P6/PfhMtjuw+WXxCu3W3mj/5
         nx4g==
X-Forwarded-Encrypted: i=1; AJvYcCWg8/nsmhmFQbv4dosSqnN9j/JaJOcDiUvsPHc95qFjY6wLb0lOT0KOpdGovdib32CLNBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiheCxRmIisdacz+wdV3Ew8O1S3wh7QqcXBlUaUCA6gLA/KvVN
	aiUkqG+BwRZ7u6OYDcJr3T8viu5G/HzmtaagCrAxGUyJvew9/oqnoQNBIVy5qeU=
X-Gm-Gg: ASbGncsUDPMrLdSFxh9mfiqgKIDoValB33NsQuVRHkc1Cwt2w6G2mBaxEQQwx9KLCLp
	L6mLz4ToZa98Uaz6T8IdQb8xRjthWI1ZvKPVK+wMjAvrX4h6xGGoxRuoBeflcd6kLBAvZgdBH/O
	mLY5uP1p9oDo6jqOiloNqRAezIGtkyexic6J12Ou3L+9cc6LxspnKPETJfvhoBo/ey4ZX0QCN0X
	rruoccUhBziZ0afRO01NoU3r+UdEKn/uyaql3fcojB55OMnl3OoN97R
X-Google-Smtp-Source: AGHT+IH2s5qUAf+fpkuqgPU2+mVf7/GWHrtm3hb2i29uW1limYKT3R5Wn/YlSCwzGGbUSzG/NCKU+A==
X-Received: by 2002:a05:600c:b95:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-4362aa2e539mr159531685e9.13.1734436593037;
        Tue, 17 Dec 2024 03:56:33 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 3/5] perf tool: arm-spe: Don't allocate buffer or tracking event in discard mode
Date: Tue, 17 Dec 2024 11:56:06 +0000
Message-Id: <20241217115610.371755-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer will never be written to so don't bother allocating it. The
tracking event is also not required.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1b543855f206..4301181b8e45 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -376,7 +376,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct evsel *evsel, *tmp;
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
-
+	bool discard = false;
 	int err;
 
 	sper->evlist = evlist;
@@ -396,10 +396,17 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
+		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
+			if (evsel->core.attr.config &
+			    perf_pmu__format_bits(evsel->pmu, "discard"))
+				discard = true;
+		}
 	}
 
+	if (discard)
+		return 0;
+
 	err = arm_spe_setup_aux_buffer(opts);
 	if (err)
 		return err;
-- 
2.34.1


