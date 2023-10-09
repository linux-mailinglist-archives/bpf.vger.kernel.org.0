Return-Path: <bpf+bounces-11754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804537BE9D0
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EAF2823E4
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95318C20;
	Mon,  9 Oct 2023 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFk3wZEK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE91A701
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:45 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC14FA
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a507eb61a6so73204597b3.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876782; x=1697481582; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=OFk3wZEKRbsVyMjM+9CyBIeNKC7CQOS4Q3CWIkEQeGHzOExrefIAwk74TnX0ULOJ7g
         gf2IuNSvlsl6dvg/i0SupHeYkkjvTdsN7bOvIrT3Z8mPfIqG5UwbhXnLDT9Qzb+ofA9o
         HyUTVuUVnDK32cxvmyg8rgr7yhi41QWGmryGHjD/04A3i5Ndq4WdtcKveOiTnf2Z/Ids
         fxdQrTkfCCthLonmrUPnKPeMCQ7gBZQeY8Orn3AIDZnPR/NZdyg+syaOlLsXOnLfPYyq
         8iz4w7NCFe1pxo4AUhRpECmwBxRKhlL6r7B7HFXOLzS0b+sH04tgW4CxBktzn0hfnTYM
         FyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876782; x=1697481582;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=Pa5hbfrV8Nrz5u67VUpGUZwhnRgMfMtku71tado1NleU4Qu5+QxZ3WAL9ZX1DN2eua
         u5rmBrR40Taskdi3d1E1FQDfB3B+Z8Gpa6tt7TgYS/ybvTABo9BgrL44MAUg1nm27njL
         AJMDWZd4iQwFM1/YbU1sZ6eZq9HJGAyJL6RUiWZ7N7Y0Givw49QSrb+5xeBo8f9sqIb1
         vYT4rg538+xNOky8qr5T51i4IfCJQmZt/PacXX4ECO3T9G1BBOKZwwYMvwX1EchZhY9q
         HWXH5+3eBKmnJIGNY4x1ifWdTKCzKHsiE7OqghyEKBVLOA+p0YiAqsmANh4S2u9NAiPX
         7xEw==
X-Gm-Message-State: AOJu0Ywpei7pxtWsFUAQFL84E4gt8ZKqNJMoklmjMWkhO0gH7LgrwDnw
	tduyVWUC4aXtzhLQpsz5OAt1IaaY1vRd
X-Google-Smtp-Source: AGHT+IFF5Ce3xTASsAOk8I7voMtqVFZ/Fie+83QxW2GS/qJ0vRq1xrYlGTONWtgU9T98ME4DI6ky2PLg0Jc+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bc03:0:b0:59b:c6bb:babb with SMTP id
 a3-20020a81bc03000000b0059bc6bbbabbmr297631ywi.6.1696876782479; Mon, 09 Oct
 2023 11:39:42 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:08 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 06/18] perf env: Remove unnecessary NULL tests
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
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


