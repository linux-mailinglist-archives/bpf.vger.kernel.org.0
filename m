Return-Path: <bpf+bounces-16122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432C7FCEB9
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E947283538
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1524101D4;
	Wed, 29 Nov 2023 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sI5pIGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD11BC8
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ce16bc121aso68651007b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237759; x=1701842559; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LT6pUkq6nOZyulqCEeWY4llreF+FWbGDdI1GlLo0K+Y=;
        b=3sI5pIGvs/fAI6Opb6EAFgnk3xrzuTRPcS9vxNKmuSZNIyPTDZC0jOo3c14GBriIXC
         Q2RnZlK7OaUe1ia7sa3p1SNKl3gSeuMuWPsaDE9xjqcGmD3OwrHAdkM+yhzhWNCMvmkR
         9gpQWR6Z+ESxHMpgRoxvi+XFHtqQsCZXpPKGdxoBbDMZGf6BBCaJHa5bL57ZVbO8tcY0
         D7OfQgQbecbOXAbOwEmskBN9GUiVn04u50jx44iSqT+yt8+p1/Uvqh+dlwlc20AgS3SE
         /Kr6+ObDr7si897Ss5wEV6AE1jvv6y7YPJLoUHq7vfkGvjB9nhRPcT2ljWrRsjl05tRN
         SjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237759; x=1701842559;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LT6pUkq6nOZyulqCEeWY4llreF+FWbGDdI1GlLo0K+Y=;
        b=b8d5ZT5+wQH4MJx/s4T0BbYKeJqRvttzMoBo0Zor5bRsvxa0I6+2le7XmZ+LOuvb8a
         6d8TtbBZcnbxc+GrB4BwWfUbP1bdgyPkpNLqBOOg1ZGaNJNX1PuQPpO71s7bx7EiOLmW
         nwv7kAYpMSJSbeaLJDonaYhEOuECn52OkiK9yszk8nxzypKgSgLstqAF62HIFFEmeK5X
         CgDbN8bx2Sv7LVxAe3kTP7zqswuzVh0QaWYRfuL166bOQS0r5iw9KccLeUgIz2ii6fQc
         lB5pK041UnCUUAfTlpERzX7ZAzQq9C8Gi5d6RS3gVyci2ITQC7WAVvZg80u74ngrx+Gm
         E58A==
X-Gm-Message-State: AOJu0YyHjYfI8zkmkxDjIq73rmkUi+RDV6XnvZPE5PkluReSTtxXvVk0
	3z48W8hhTrCIM61DGhFDUG9mKQivjfu3
X-Google-Smtp-Source: AGHT+IHcLhZcuRAnfvMJq6pSrYjIxfVYzDocHNgvrzM6qynXE4Nqh8rL8wha0ZAZQAWY4sv3ZhFZ2JZcU4oz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a81:9b10:0:b0:5ca:5fcd:7063 with SMTP id
 s16-20020a819b10000000b005ca5fcd7063mr598732ywg.3.1701237758929; Tue, 28 Nov
 2023 22:02:38 -0800 (PST)
Date: Tue, 28 Nov 2023 22:02:07 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 10/14] perf top: Avoid repeated function calls
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

Add a local variable to avoid repeated calls to perf_cpu_map__nr.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/top.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index be7157de0451..4db3d1bd686c 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -28,6 +28,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	struct record_opts *opts = &top->record_opts;
 	struct target *target = &opts->target;
 	size_t ret = 0;
+	int nr_cpus;
 
 	if (top->samples) {
 		samples_per_sec = top->samples / top->delay_secs;
@@ -93,19 +94,17 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
+	nr_cpus = perf_cpu_map__nr(top->evlist->core.user_requested_cpus);
 	if (target->cpu_list)
 		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
-				perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
-				? "s" : "",
+				nr_cpus > 1 ? "s" : "",
 				target->cpu_list);
 	else {
 		if (target->tid)
 			ret += SNPRINTF(bf + ret, size - ret, ")");
 		else
 			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
-					perf_cpu_map__nr(top->evlist->core.user_requested_cpus),
-					perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
-					? "s" : "");
+					nr_cpus, nr_cpus > 1 ? "s" : "");
 	}
 
 	perf_top__reset_sample_counters(top);
-- 
2.43.0.rc1.413.gea7ed67945-goog


