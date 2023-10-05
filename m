Return-Path: <bpf+bounces-11493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF77BAF0E
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 83A7E2826C2
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A780C436B2;
	Thu,  5 Oct 2023 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eUm25P2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DA42C0F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:20 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2F139
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d84acda47aeso2096026276.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547353; x=1697152153; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=2eUm25P2a2eFfh56kz1uSlz9NaWL7J/iU17mHmso2A1+lo3PPSav85ngzAJo+E+Weo
         vrW/grBI1oJKqpACTbpHctclty+Yt4pXfeXX4zp3+TODPuLIfW2waNTf5z0Ey+LUCm5r
         9v2JeeiDyNer354S8plXgZL75bCuO6GU4CbxX2j4MhGU2OyZK1jrsAV5oUtek8y+qyut
         q4TKRPSZ+E1o1lmKNO39mbmi39d90sqNvtQgShhQQDa/hcti+cuseS4FSSkNPwiQI0MU
         WVIP/ruBpX+eblxV/SFy7WhQ4bBa29EIBN6/2ja1XHRDrkvhYZ0bF3KnbkticwIrduhD
         /VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547353; x=1697152153;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=Blnsn+JUYf/iY+hWwmE69+EJX8lxKLLABBNsDwhVFT1uHpzgRUyu/AxlMrF5ePE4Ga
         WmMU8/2Ckpp8iHVK1z9ZUimQ7SHfzHvYtbOlhn+WsIdKmBTKcSoh5nZyBeQYXido5/6r
         KkkzSb+XNRKfWeQu8a6YY4k96KpxRF4hYKeaMkncGG7GOM2+2/DYdqy+SXvhxAKvJgXk
         7njEBcyDJv4OYRhs+kw5pwuuPdLYhj/f2plhToh4sg/xjvMIucp5uI91yM/pQrkYQO/W
         4R9VpaltEWW0KOKfmKSaGMlEhglSBF1ja9hMdiJrDtUU4EPKDsrZhT2gDtAtjIl9VP/i
         K7Qg==
X-Gm-Message-State: AOJu0YySzYuysATii4Gj4d5aTuG4r6PTPs155FpcaCD3FDJ6qO1Xx4j3
	6f2ActyWr4s35H/tfvatq4dySDMgTsMO
X-Google-Smtp-Source: AGHT+IFQvzaYKByRTXdCNgbgMtf6ZQo0ZLONfku1Pyu5zu4z+Lcclzm0e0v4jTWzT6RLDSWWI+/6U4DHYIBX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:770b:0:b0:d0e:d67d:6617 with SMTP id
 s11-20020a25770b000000b00d0ed67d6617mr113429ybc.4.1696547353259; Thu, 05 Oct
 2023 16:09:13 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:40 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 07/18] perf env: Remove unnecessary NULL tests
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
2.42.0.609.gbb76f46606-goog


