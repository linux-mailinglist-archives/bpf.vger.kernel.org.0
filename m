Return-Path: <bpf+bounces-10673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2E7ABDE8
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9A7B21C20988
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB831FDA;
	Sat, 23 Sep 2023 05:36:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CFA53
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:04 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763651BF
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5924b2aac52so52333067b3.2
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447357; x=1696052157; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gGdTy/Hpx4ZQLMYPilsnkHUZ9OACUdEplw6hC2pVSI=;
        b=VECHTX8kH/m85pfQg57m3iGB7ST5r0q4pSlbk/RBPLUEh9xIOTdPwJzZtNhxzcXt1D
         +ahbfZbBP3JAFkixzvlI0ewFZW4GlcunjGpWryCSEeMK2+qhtVkuiiVYR5COoTycUKpw
         0uujQVhzYlIEO85f8NNW+5z0i7m+KPQQO2KVZHc0qTvzqZaLz1P3XPcN86MnWnjwlwxU
         +P7VSh9ggnno7K+uzXPag31BZKf4vHqJ2OikvhkPXwD9Qj6YZGcjd5XDCIfErmi4roys
         wX5KxzNtqcQPPlM/nG01lfZVdySQTQhJzYVjmcMgA/bMViIA3iRa0TQB5mxXlQQYL27t
         n33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447357; x=1696052157;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gGdTy/Hpx4ZQLMYPilsnkHUZ9OACUdEplw6hC2pVSI=;
        b=TQaCz4/ndTYgVni3pkQQcATNTdcdT4Pd3T8MUhZXqiPqnxYcQ/ExnlPFZwXkwq+ldk
         waUvnBVaALkMN4+s5NaGrWV3xy2qLdNBz01HDZ3n0AmqeUxPwc6p3I+ghyUFzhP30nQN
         zqJJ8EEAYbm7w5k5CWdLN9m+6Iq5KZ2eIn4kCAjxo5DQwjupbv+GhX6Xme5MxaF5WLW3
         xRcv5DVolca0onTNHSJhXpKhSn+EXLchQOpkGRImGvwLqBgTXCFpIpe2NCNP9dy9ISUS
         /c0xEiBWdX1Wyi09plKZwElNF5BwkUgCh0eEEaj3+Ht9H67mOQmPa4zlVF76NfvwWktY
         P90w==
X-Gm-Message-State: AOJu0YzKc8b6IXMFHsq+LM8d8idYGXP5QO2C/0SsnkgOxPyd59BNAv8U
	mHmXb6IbkHlGVXyR8K9pc8jdN8GjFPhh
X-Google-Smtp-Source: AGHT+IHu3H0RgtYZ8l9qpPGoXpBjWqmDv48DSjpHsFtxnOifuDQfmXQ64ydXe7XcESUrtgiyDqPuQqKHNS6T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a0d:ec52:0:b0:58c:6ddd:d27c with SMTP id
 r18-20020a0dec52000000b0058c6dddd27cmr19945ywn.6.1695447356813; Fri, 22 Sep
 2023 22:35:56 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:06 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 09/18] perf mem-events: Avoid uninitialized read
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
2.42.0.515.g380fc7ccd1-goog


