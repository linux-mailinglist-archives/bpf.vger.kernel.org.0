Return-Path: <bpf+bounces-16123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF737FCEBC
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F8EB21B7D
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75609DF40;
	Wed, 29 Nov 2023 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4zY/nC+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D061BC3
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db49a6b9be5so4171606276.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237761; x=1701842561; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DVMbIRV+NQmnATStJOD8jb70rfi854C2wLg/boNolQ=;
        b=a4zY/nC+0QtkxYXQUOj8uwuD+fonU+1WoTol7K1a0yha0+XUCYnbvn4CPLXb5tK3aH
         vJt/cKfnVcxmP24DjxQnvxwPtO54xENEs+k/qZd9ROc2TF5IAIZsRGPE6rqvypeJEiG1
         /HC/F5uEqO9iUVYIaSciOoD6+UV7MLN+sOphw68wcXtTHGYqLcijMEeWKxuAvNeaXwGN
         QBiCewTJkOcL76fD7sQPmI4XVSgN/ON246iDDGrjvUROdQvoI9W7COlfzGYRnikJSRDU
         iriSFPigvOQ04ojlxspTj8iOOcmdZHREqd64sZtPw1D/xJXdMW8dhTEOr8jdHR2n5+Nl
         YqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237761; x=1701842561;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DVMbIRV+NQmnATStJOD8jb70rfi854C2wLg/boNolQ=;
        b=fnbkCk9lTEPscOMAdnVFqaMyo5f1/9GaGwHREMPWr12jeIPY+bShQd5sg0pEwuEyu9
         DKPnxnIq+Y4BgCFEPQypflq+/XAWF75AzE6Zso1zayIMCopu8pZO3NIZ80/F0lIjykfR
         jG/Wpgmttt/NBpsAgHHpLZgNFQqoYmkM++xkx5oRItYZZLpFSHgdJ4tHN0PJhS/NJpsx
         B/NTpDEgroJQdeXdgebqe1o/OGKIddWkD1q8sKTuapX/sE/CFIi9XJPJ3htLbJ54kJB6
         lffkgmbkEZbqgqVehbKs6m462z/t+rp4j1ZH8ZVZLOEdkAJxVgMLLdZpSjlRhrrN5aYc
         zz2Q==
X-Gm-Message-State: AOJu0YzBdps4GltYWogHCPESJxANUw6fWF3Fvew/5nqk5yq2RKTYcj+3
	3zngt2sHgCBQ+YD5rMvcCpScwAR5GIzU
X-Google-Smtp-Source: AGHT+IHJMRqYtdqiq8wS3BvtGG3WjhuhilD2hoypqMhKE4FVBpXobXp8Db6UyUfeaAWJBMxnRYUQrmZznlQj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:e4c5:0:b0:d9c:801c:4230 with SMTP id
 b188-20020a25e4c5000000b00d9c801c4230mr494820ybh.5.1701237761085; Tue, 28 Nov
 2023 22:02:41 -0800 (PST)
Date: Tue, 28 Nov 2023 22:02:08 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 11/14] perf arm64 header: Remove unnecessary CPU map get
 and put
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

In both cases the CPU map is known owned by either the caller or a
PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/header.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 97037499152e..a9de0b5187dd 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -25,8 +25,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
 
-	cpus = perf_cpu_map__get(cpus);
-
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 		char path[PATH_MAX];
 		FILE *file;
@@ -51,7 +49,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		break;
 	}
 
-	perf_cpu_map__put(cpus);
 	return ret;
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


