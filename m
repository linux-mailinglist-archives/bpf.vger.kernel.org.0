Return-Path: <bpf+bounces-20906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27588845036
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9421C2304A
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296583BB2D;
	Thu,  1 Feb 2024 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJ5BXYP0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185D3C6BC
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761377; cv=none; b=J7PObXqa0fGOYzyELOPWKy53W24ilb72hqk3Bt1tjGPJ7+S1ziuGoU4IAJickiNVyr0plI08QR+uUZPcUhcc7ZTIcEQGAhTxVmsNREu0aChMAk5DSj2zoidaLDX8MF4iaFpebRDlw4Gq7SFRu7IbwDrJPvlGv6nzqUFhFRFV7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761377; c=relaxed/simple;
	bh=sM6e4GJOdVtgwSVAwsLzIbgUpUVCVxBjp1/mDPrXzxA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eG77weuhPBso9DE21DdaFzad7WlO2kqCnP7SO0/8W7qp972zSz3U0iSz0q5kNU+jeCMHFPixvZYS9mUpMVeHR0MR5kYzaQUU9FDfY3l/m3zLog2xM/Pmr4NXH27FsEDxNx/rzpPox3DSwQDJ0U+of6eN/I1otCyw6H78eAOQk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJ5BXYP0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604127be0a0so10704977b3.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761374; x=1707366174; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JXSUMX5bbfgnckmTRSZnaB9bhkcugUHtNJBG9b4Oo4=;
        b=QJ5BXYP0VM7KLbvbyyPr8hcLsap4dW0LPX3aPVHFjUg1pnNcniUzXW75tV7XzDssKH
         kpP31oxRoTfg7N8lYODWE3A5gE2tp1euUyAKTryMN0c030H87na9wA4cuaQGHsZrcon9
         USKhntQtmATztQsPhLsfFmQi7FEFVeOerKTFcnPgvAHkehtvZn2cbGdLVbpAHjFqMcSw
         wUI7YIrIxOJl/E+qcFFIBxGHVlH8bAm2wfM2/EkgC/uDcd1hjtw1FuYHN97ocH65I9va
         B9f4J48EKYWlK4NoYf3swTX8FGFWNe8eHHIXgtCa9pnwl1qG9OB3pz+YPITGrq0IcLu8
         TRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761374; x=1707366174;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JXSUMX5bbfgnckmTRSZnaB9bhkcugUHtNJBG9b4Oo4=;
        b=RQFDeHRCg1ci/zj2w93pzurPVuCVwfzo/VHZrw7sKR64TsZ47LvCcdn1dTSl3Lt/04
         +N1s2ne+fr8XYOcC4GHE2+KpQDYtV3xOeAfguIyjUf0OORSQvebieYiX3tUx/o5Fq6zV
         aav2WRTKQqcXzwKN+czyHnGOGnWHYSqw2R/H7y7mUSN1+S6uBfAPOq8pPP+Z3Vpb7oD7
         hoRZRqrVnTIcNJ41l2Dhpn9QLkpcu5zsF2hIr6BeXB6Mayn3V8fWEr4BicVQuprA9ZZj
         lOIUfYHbkZ7YGbIsAKtAtwATj+YxCfOfFMrE1ynQCnrkYAzV3SVEPUDac4I2WRevarDX
         TwDQ==
X-Gm-Message-State: AOJu0YyxHLShg3/IlcPs/uuao8ayN6Q19mWYJKYVziRuejwxyQkZmJpc
	lcMxB+2DZ4QA+Pwv1/lccrFBBq7WEAv913WS/pDeIIRPaJWPCpVQbrzQwwhN2g32yzNz3I6KPqp
	8AiJqoA==
X-Google-Smtp-Source: AGHT+IFTJVPGgTJjz0vfAK3znBckhM+C3f96ATL1D3c1AModrSqCIkbFIqSfHTHrXRFHdRJrEfI2dhkZAVZt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a81:9a92:0:b0:5ff:a41c:1d19 with SMTP id
 r140-20020a819a92000000b005ffa41c1d19mr780347ywg.9.1706761373658; Wed, 31 Jan
 2024 20:22:53 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:30 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Potential corner cases could cause a cpumap to be allocated with size
0, but an empty cpumap should be represented as NULL. Add a path in
perf_cpu_map__alloc to ensure this.

Suggested-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101@arm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ba49552952c5..cae799ad44e1 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	RC_STRUCT(perf_cpu_map) *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	RC_STRUCT(perf_cpu_map) *cpus;
 	struct perf_cpu_map *result;
 
+	if (nr_cpus == 0)
+		return NULL;
+
+	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-- 
2.43.0.429.g432eaa2c6b-goog


