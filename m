Return-Path: <bpf+bounces-11495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA77BAF10
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 352C12825A6
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B943A8F;
	Thu,  5 Oct 2023 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iR0P4IS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B443A89
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:26 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C1BD67
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a20c7295bbso12973057b3.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547358; x=1697152158; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=4iR0P4ISPLOMMxrMSLXIeqoVzLlvLx47CT9TvLhsx6NwX3CyV8PYkzusmYED/x1CQr
         XIiT8F8Sh0OHiDk/OJuNuTTaCE4NWInqRbV8Y5WyzSLTm/Ye0/rPrCsBkxKU6+i7z/DA
         K6rwMg0yn6X8CXZlEQez7tK6veJvjS1NEBlfSXUdSLsqeaQ5IvzT/sNf+I/SLSu02X9t
         jyQfExUiXT7DB34xQa69AGs03Ac3dauAqMumBPJPzvZjGxm7rSLIsFC36gvGhG1pEOkV
         3JfvcMvlDhFywthUqQBMFIVnbeBl0FoK7MLHR/TcYt0lweXIRf51Xup96Yjz+669UHdJ
         4/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547358; x=1697152158;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=L0fVJX5u9qW5CgfT6PZZsrlmOfVrvDhMUAAhqD/4tAGPHZ9lAFGrEmRX1bVgMDW6a0
         05/CFL/LIMKfxvS9RtR3ADG6oqefgTtKMTDka79rrVYb1/Jiovk5WfrA8ewgvG3BuD3+
         lW2XVfgRHYiQFcY6ZYrLY+Q/W8/7CCzn2VgvXJ47BwWnoa5qGRgvOw2q+nnSF5X+ulBf
         8g98IS8+nxL+QtKj3L3CkaK4qsQsEtMrF9ZD6I7xR/5W6nwKQIGxpc21f3xbjepmbNki
         XLCStC9g0Cv6gATbheADCsBnjcKv/H38wr1HKzOPHt1xNJ69E3TykWJELd3D3INfEV04
         FxHA==
X-Gm-Message-State: AOJu0Yyy4YjSuL0OSwTfZstfo7YMCCkpWCQKNbBMYTdbPY9ZGG6606ZD
	da8IkFKIChkj9c42NMd+lQAhuBB7sASG
X-Google-Smtp-Source: AGHT+IHZIti6IayoNIIvrlr9f3twKSIg0zCXbRbou+pCuTID4omq25jI81Q4BzjSR5/jxW+VxluvDukpej+F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:690c:c90:b0:59b:b0b1:d75a with SMTP id
 cm16-20020a05690c0c9000b0059bb0b1d75amr51537ywb.4.1696547358196; Thu, 05 Oct
 2023 16:09:18 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:42 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 09/18] perf mem-events: Avoid uninitialized read
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pmu should be initialized to NULL before perf_pmus__scan loop. Fix and
shrink the scope of pmu at the same time. Issue detected by clang-tidy.

Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 39ffe8ceb380..954b235e12e5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -185,7 +185,6 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 {
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
-	struct perf_pmu *pmu;
 
 	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
@@ -202,6 +201,8 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = perf_mem_events__name(j, NULL);
 		} else {
+			struct perf_pmu *pmu = NULL;
+
 			if (!e->supported) {
 				perf_mem_events__print_unsupport_hybrid(e, j);
 				return -1;
-- 
2.42.0.609.gbb76f46606-goog


