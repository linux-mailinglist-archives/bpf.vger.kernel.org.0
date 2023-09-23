Return-Path: <bpf+bounces-10671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F000D7ABDE4
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9EA4C282A2E
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F47F9;
	Sat, 23 Sep 2023 05:35:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E4C4C89
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:56 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2BCE8
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bdb9fe821so50462877b3.0
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447352; x=1696052152; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JLMR1XL8zAjwZWVAlK6A4BDEZJsECGT2sz2xABlKYc=;
        b=NSUJS5aNzLfDWHxLQARpRVVvDRT53eBlVVXHiRc2Nudz44dSTtwVLIF+b51LEQmtOz
         sRBdMAINcll4En1D9+a/nBy+LsWOYSib2lhmtHiQq/pnbq/NyOD8p04+aMPATmoC01uB
         wDFIeCViyq7tWj04Cs2mXJAKvQ/F4tISFZQxr3FrFp+KXaOS8y+u1JGTUmbVKDYYloWn
         UgfsfSKSYBbm/Hv2EnAgnW4T++9PLD1VusNNEqHZdYLJvzk/87BQ+n8TFCsIEzxlQDSa
         4qZxi4xqMokew1sEBxCo/CTf4I7a2DRv4AqhqWVVqE5X5fQenCALvcj3AwzbEywCQyoO
         kHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447352; x=1696052152;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JLMR1XL8zAjwZWVAlK6A4BDEZJsECGT2sz2xABlKYc=;
        b=gSd2wRy4s3Jo9e67rTVpi4a64UrU0QbtK7oSVNQWNQqQTHkpKXpD1YOnp3Z6Yjeq1w
         SgrK6InwthCg5Jpq7J8zDd5TWaxCt1KxWfi0HbuxH1mERKS+H1w5YsxvUicjsbS3ceL7
         m3tZy3+o/iIa2MgrmUlwPqjvaB+G7SCrXJ3vetq5cwMEOzaieaWjzY6PxqjDx+y2xX42
         1afE8U/DBYZfBomhwj/cHoKvOHso8bIHLKSUlfMnzc4Ox2liB13Gs7+cF42khlO2IGuN
         cvjZ50Od2QonoQthBK5LMcBWX1/A0JZkieM2s44QPhWLQ0Tggnhbbf+l7AZmcvG6BLmb
         TtdA==
X-Gm-Message-State: AOJu0YwIRHT4oZixrIOSlhcAxoW0VDcj5dEWQbqsU+epLOC4GOj0IyDY
	amVzzhZZZfACboin4VNmWxNjJ2wOHnrX
X-Google-Smtp-Source: AGHT+IGwoVliXHNo2Ezm8GW+6WCcr1eN33xbWzqXWDeiL+JMjQWZaBaqiW/AxKNeH9OmHAU2FWAtbGPCLBod
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:1105:b0:d81:6637:b5b2 with SMTP
 id o5-20020a056902110500b00d816637b5b2mr14384ybu.0.1695447352596; Fri, 22 Sep
 2023 22:35:52 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:04 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 07/18] perf env: Remove unnecessary NULL tests
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
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

clang-tidy was warning:
```
util/env.c:334:23: warning: Access to field 'nr_pmu_mappings' results in a dereference of a null pointer (loaded from variable 'env') [clang-analyzer-core.NullDereference]
        env->nr_pmu_mappings = pmu_num;
```

As functions are called potentially when !env was true. This condition
could never be true as it would produce a segv, so remove the
unnecessary NULL tests and silence clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index a164164001fb..44140b7f596a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -457,7 +457,7 @@ const char *perf_env__cpuid(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->cpuid) { /* Assume local operation */
+	if (!env->cpuid) { /* Assume local operation */
 		status = perf_env__read_cpuid(env);
 		if (status)
 			return NULL;
@@ -470,7 +470,7 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
+	if (!env->nr_pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return 0;
@@ -483,7 +483,7 @@ const char *perf_env__pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->pmu_mappings) { /* Assume local operation */
+	if (!env->pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return NULL;
-- 
2.42.0.515.g380fc7ccd1-goog


