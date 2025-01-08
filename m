Return-Path: <bpf+bounces-48253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED5A05EAD
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D753A1F26
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F71FECD2;
	Wed,  8 Jan 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhcEXKQu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547571FECBA
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346632; cv=none; b=JygunPv2mCX7Z0L0YwbxE6s/IL4zvonP7x/xolbl2IjLIKaGRL50pQniNC4TsT3aoAr5FWkAdg3X7w1DUFDzjwvwG/cNiq0xSumiD+Wvm6CyVzblAr71ahFaE2w8Hqn6iy6tQUpzql9YxdHxbNQaU+U5tP5ocnLrYKymTSxGxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346632; c=relaxed/simple;
	bh=CzVsVOj5aHsPQBr+aXqDtSSnmkuppLx5203C1dQxOOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2ZWRlzZWF1CfUcN0K82CcAALHKAr5SsD7bzBYJE6W5BVuxFZSP+7P2j/9J5zYwmHKYTohA7iv7Rk8xtHkuJ2YZEF+LEAP8GuZLAQqfJsSB7VFTAgV/zTShfCfzJ55Nb5Cb93fuwhdHE4NFKcMaJRyAbMsF84526o2WQYvACsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhcEXKQu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so6465451f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346629; x=1736951429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmWclsqjoRWfqPrE0WD8+jPpX9G+TTRqhb+EOtWuV1I=;
        b=nhcEXKQuRLML8xDCD4CRPPiPfMXV7gsgi4+dF+cuSh8DMHh+0WL4iVqPjsTSeuD0oH
         4FP1WSMkCvGPCwOGfYO3/w60OT7+5vsI5DTK7cE+uh/D4F9aRRkj4V7E2ehFhfC116e8
         DqUPtBciwNVEUIgBJF2/8KtGL5dJJ5Yh37pdTB0Hl5woDWNn7LvaDQ6VK3UFwrqbd8pq
         DUhp3FQkL73+7s6/UGCGOrM0ZD7qVN+PqFOGn9SVXy7N2+fDcFfuApwa1OAIwm4GDt6S
         VT/IQxPbnK6XMxyuP33z622HAbZnOLeSXeb2dloqDCbWng85QjGHADbfDoYzfoK8unZU
         j+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346629; x=1736951429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmWclsqjoRWfqPrE0WD8+jPpX9G+TTRqhb+EOtWuV1I=;
        b=qVR4/zwNfxoQwfj9ET8UuOu5ukviLJjKVQgjytnV7uNems7j0qF3sA81fM2GvRue5B
         WrADo8EKVzsib//A9yockPlw/bjgOPOJVUbLj86SBkAv+7PlV7TH/97/ryF1Fj7oW2SQ
         8dlP78e2I1mkmxYHlEUBLgqfEd/PS38Jo7HaCWHr51zc6Qcy4pg+JNnBmCVAyOp8Kfb0
         rvsHAYRjsRyKJvxFJov8F3x3RaqUCt5SjHkF1jA9eZSNsXsRebNw47viLYUXN/nG8xaj
         hAKYkaOxbsJF2O93ZSaQzyUVILaRtSG/1j62Dn9HrKee7epxRj72pOp1dxoV5aHq3lwE
         jGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyHnBzYd74Ty96ogmy5vy/IkdY5YOo8ap72vW5koOaDWdBRQZuJPWcLzJqMxTsT6K4NvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFXrwVIScBmAU3KQt2epOo818wlFMZYJpUmnyQ2A2spx6PnN/
	CQnwRjp8n+v0Csh9aAeoLTbWp+glD2OkzqL+lv72/rcDXSpm6+r0gv3suhYeRAg=
X-Gm-Gg: ASbGncsSqErTJLZj6Cl+IzOlllcVVWMU8UssxmipZQaKxC1H+UcxRLrDUervPDwpV8R
	OgSYLNDcCDIoVAZV/UZ/vLdRi+AYulkjKUIda8wccyNAMs7OmXzFN5olDpZHvH5ZAceXuNpK9W+
	bN4kHKbsnsMLbyA0F9t9XR+q+N5yP7LBx/UhXraCs/lvB7czNr4hkRXbRl+grvI3jjp8Rv2came
	z3WRFqCaRZM+S7o0sEADW2Z9Xy41kVGI1FL8uy7mP5NzsNbzcYJ5DaF
X-Google-Smtp-Source: AGHT+IFpLlgT8rIizotjQJSiOIRTNt4ClYlj0TJvrmATLoOgZqttqZSvaAwtMedep20NBlyPDrMhRg==
X-Received: by 2002:a5d:5848:0:b0:385:f7a3:fea6 with SMTP id ffacd0b85a97d-38a872da433mr2572275f8f.13.1736346628653;
        Wed, 08 Jan 2025 06:30:28 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 4/5] perf tool: arm-spe: Don't allocate buffer or tracking event in discard mode
Date: Wed,  8 Jan 2025 14:28:59 +0000
Message-Id: <20250108142904.401139-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer will never be written to so don't bother allocating it. The
tracking event is also not required.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
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


