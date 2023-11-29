Return-Path: <bpf+bounces-16124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC87FCEBE
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75367283573
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32945101F0;
	Wed, 29 Nov 2023 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZfJJGiR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2F01BC0
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d04540d5aaso47810337b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237763; x=1701842563; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hx1FXofSm6/tFgZiy1TvVwbEYJz6ssRcV+dGOMGcvW0=;
        b=cZfJJGiRnIlA8GdwUq/oU0RlrfPGoiItm5nZ2HcpyvEr4tVzQOY/2hl5ZythbdT+xr
         v3AT9s/llHVuRpVJRf7Qc/GqfPYyTA/X0nQKUlk/EK/NhDAagPZrdlyhQMNNwe9g2O/9
         c8Npi68QpzjfSqfMeQRSSnGhfireqB4MBtCNovKGuweTbegohaaKkD1ojALt55jSmJGJ
         GwQweBtlnxWbsutlbZYItnHsP5w+mfkrq9M2F28Pv9trvcBGUNsbxJaPDjxRT3TtBDM0
         wnYjHsPC/wcRG6vtupUxyTAVL94FpTEL4H5JYlC1kVBOwjuC7ey/JUUOFU4vpztW5QA8
         iRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237763; x=1701842563;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx1FXofSm6/tFgZiy1TvVwbEYJz6ssRcV+dGOMGcvW0=;
        b=OygDGwo27F57tT7dClrkzNgr7qeBVeWH+br0jxpUL1aB8tWpD7YSop2K2IhNVkEKcz
         SF9+/vrdZxUKhXbyU2R85v/gIbFq7oHQfVy/+cD062PXeX0Q3eQRc6eqajtmL1Eqx64O
         O7OY6vysPm2FjHKkRHyq3RBUZSiSUchLJOouit5xDMLB0NSG75TA8KwCRR2fsMrSKyaH
         ekwGo+VYDijjEOIEg36Sb9sQvzQIEVFe8LaJEpTsZw2xQ3QbaDUN+ghqu4133fB2n3d3
         0UEdhKKiNQvlijLDqbU/Jzq3cu+ffuxSS+71ZQLu3GrwHdgjydCdZTmUQPq020PXoBGm
         ou+w==
X-Gm-Message-State: AOJu0YyUlKq34ROR7GcugJ8InjSGzMFCVWnyadNF4hm9kwtyeArYxuew
	mZeI5bip+FV6jsqWRNn7QxayevB62vmY
X-Google-Smtp-Source: AGHT+IFkHheFXSho6uLG11gC+NuzV7oPEGtX6gzG3KyX8XN+0sHsL9fCMoG1bThASPDwSTf3YxUPIjvReV9+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f0d:b0:5cb:e3c9:ca22 with SMTP
 id ev13-20020a05690c2f0d00b005cbe3c9ca22mr465449ywb.7.1701237763521; Tue, 28
 Nov 2023 22:02:43 -0800 (PST)
Date: Tue, 28 Nov 2023 22:02:09 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 12/14] perf stat: Remove duplicate cpus_map_matched function
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

Use libperf's perf_cpu_map__equal that performs the same function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f583027a0639..8e2f90b5c276 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,26 +164,6 @@ static struct perf_stat_config stat_config = {
 	.iostat_run		= false,
 };
 
-static bool cpus_map_matched(struct evsel *a, struct evsel *b)
-{
-	if (!a->core.cpus && !b->core.cpus)
-		return true;
-
-	if (!a->core.cpus || !b->core.cpus)
-		return false;
-
-	if (perf_cpu_map__nr(a->core.cpus) != perf_cpu_map__nr(b->core.cpus))
-		return false;
-
-	for (int i = 0; i < perf_cpu_map__nr(a->core.cpus); i++) {
-		if (perf_cpu_map__cpu(a->core.cpus, i).cpu !=
-		    perf_cpu_map__cpu(b->core.cpus, i).cpu)
-			return false;
-	}
-
-	return true;
-}
-
 static void evlist__check_cpu_maps(struct evlist *evlist)
 {
 	struct evsel *evsel, *warned_leader = NULL;
@@ -194,7 +174,7 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 		/* Check that leader matches cpus with each member. */
 		if (leader == evsel)
 			continue;
-		if (cpus_map_matched(leader, evsel))
+		if (perf_cpu_map__equal(leader->core.cpus, evsel->core.cpus))
 			continue;
 
 		/* If there's mismatch disable the group and warn user. */
-- 
2.43.0.rc1.413.gea7ed67945-goog


