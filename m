Return-Path: <bpf+bounces-47590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B69FBCC2
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704AE7A3916
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BC91D6DA9;
	Tue, 24 Dec 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcPN7DRK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFC1CDFBE
	for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037088; cv=none; b=d58gw6sWvbEI4GdagnzW9jIbou++wkUoBWVUe6D+7PeChwECysK6qT+V6IeElq1aHLobyvGuzPOOKY1gvk5uHulR0wyYb5R50VmJSTPWBjMnaIqs8nE9wJXWEOzvtaVu+dR8Ossfxb7AF6DsTv967LvZPfq/4dVVMD3MeNsoBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037088; c=relaxed/simple;
	bh=CzVsVOj5aHsPQBr+aXqDtSSnmkuppLx5203C1dQxOOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+HwnnmhcBSLz/R+O23ec/LDl+dk+vU6c44XsaUcyUbNuWx3Upys0ifuXBm1hxa91Of6g9Dd52jMre7VYsUArnPsz7p292QF7QOAU9uyBTCIQs6qeTBffHZDDP4l3CzBaID4JBfEEZTW+hFb0g6MViP04kYOoS8Nl14eru9oUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mcPN7DRK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2383303f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 02:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037085; x=1735641885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmWclsqjoRWfqPrE0WD8+jPpX9G+TTRqhb+EOtWuV1I=;
        b=mcPN7DRK2TWJCExPow7gWFvtBzslqpINOdk1nTh6LyyUrFsyLDYGsgmKyXRBVO12Bl
         1GFC8MzOi3hhs9C9+7WRi5dLrGbwxGsARMyJzMm440aFuaKYdq1yb3jn0DBBX2QtdTLu
         O6VnRDhJQ2RzENZVmt078apymMJxJvHhU2w8wBbfT0rZOjPdOkx0AkIjffaIW+9Lu99K
         bBEwTpDF9vMfr+xXjraVuM+w7JsV3F86ikryHq9KllC/RDCiflxYHjoU4HNWbiauOmNX
         fWCHWdRfTEOMph7emunPqSy6WrMF+jCB2E+B9Bru9fsAzcoEf/JDir7FtM2OM6Bl4cZz
         rxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037085; x=1735641885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmWclsqjoRWfqPrE0WD8+jPpX9G+TTRqhb+EOtWuV1I=;
        b=ZhHiY2uKIwHB5/pZc44oFrBzQAC1fuw/3GE8IIC3IqiNxOp602J74i5T9qkVUZ7qob
         WXj6ESLUegXUrv9trALjeguKIj8054bTayom++lSY7kIpjZKcDa/bPleexBMLv4vPpbK
         SnC1Yp6nykYAl5t0UsWphLgHvqSE8ytdOHgBpxHUq37fm7uLMRRGWQ/tyt6feZ+vkxrV
         pDpQaNfSM7zPRosB0OV6RnYsT/Q67+cZMKwLeMiaiEJQ4vD2CBOPvCegvrwUGMxu/3xC
         DjP6SDJM+PzI02pQYSHtOYXpVp0j1p89ulxpWrQfoIzPQj5YWTswOuhvmYPm7Rt7nedf
         el+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2uyEInc8hWM3mY4WA4OGzlxSeYZ/cOfdJfcXjjvke/c46ek0FdJNHkZtGIqjC60Py3hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0a3DzYMRu8eow/lKVTVz1IGRLtWIw0UEfYk/91KLATCEDGhL
	jhUMoG2LofRqW4RfFWSokIsN1g38iCBIElsB7jjzaDQCdtBlSO/r41orDE/B43o=
X-Gm-Gg: ASbGncsvFoWEh3bYIrbjn8Pwh0oyYM5DjbRNCynMpCezUzfRpNpw5Xb/EMJ3tTgzl1S
	oPcK4s9pzNJgCPz3L9ySqd1Y8KTq2g4A6/F3dWtmBTb4MGgR4oZsJHaUOa7Mf4IbVr2YzgjOf+6
	p2BnXXrNO7R4YQ5LSwl3XLV4l1R+Ju0ZvirbkoZ0svKIAfNi1NOzon6a0NTSxv+/+qXcAo+tnNP
	q59tDXE/if5+E2rbT4M862q1s0oMlcSMIIJFb0u2Xwc0oUAuk6SHoU=
X-Google-Smtp-Source: AGHT+IHaBv3kwmR23DfMiPkW/ULQn6dCN6owu8F2AwgaW5A6C+1/Tsu2gsMP3xZT9UiCfrjTvu25qA==
X-Received: by 2002:a05:6000:490e:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a221f16d6mr14526536f8f.9.1735037085301;
        Tue, 24 Dec 2024 02:44:45 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:44 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 3/5] perf tool: arm-spe: Don't allocate buffer or tracking event in discard mode
Date: Tue, 24 Dec 2024 10:44:10 +0000
Message-Id: <20241224104414.179365-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224104414.179365-1-james.clark@linaro.org>
References: <20241224104414.179365-1-james.clark@linaro.org>
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


