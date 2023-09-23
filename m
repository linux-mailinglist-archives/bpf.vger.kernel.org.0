Return-Path: <bpf+bounces-10677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB07ABDEF
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F0755283004
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E246AF;
	Sat, 23 Sep 2023 05:36:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A7A53
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:26 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F76170F
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d84acda47aeso4920118276.3
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447366; x=1696052166; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lP0CZzDRsMehpIV0W6qVRwyai9STrfRNe8AVt5V6Hgk=;
        b=idybEtf6E9zqATWwOS3c4cWkW0lURrMrDuD/rX+I8fp3cJWjLPO2CkfrguM8a+uk3C
         IQjor63Wj63pgny1pbWYcvtP9qAjknFXLBG8yDKNPhqWwSYPO1qeR/JhILzKzFzmJX2/
         slTEu72lGHJOm4AVZxdw3LA00ARizD2ZrAhA54YFHTnKzgmw8+MwGa6reNqiKpQa/KL8
         wO8MVJufRINlovSmzKP5pcNCS1/jjQJxASIDwe6ZB8Q0ICl880Lr8K2HMjs6IX20+DZh
         3ohd5H4290LLl0PNzdcmkjtOIzG6b0j7gyWGkc4x/KIxVcrBl3+JKNb7MqQkk8Cc9GwQ
         9qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447366; x=1696052166;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lP0CZzDRsMehpIV0W6qVRwyai9STrfRNe8AVt5V6Hgk=;
        b=FRCwES2VMkedLooN7jeDp1xU3nI1QvSFZMEvv3Rdpxlvpq4mq2IVeqRX/RuBKkPY5f
         mtEWz0cd/sLcRJ12YYjOikRET3T8wPETpexX8XPiw0of6yTB9Cex7y4wRF4/ik9rRsG4
         +iQH83lEu9Ojouz45kr0SnioHXv+aJyb6aqzJ5ayzsCJ5W85D4cGUqB45kAuz+LsCVhu
         msrq/xgIPTBakS6cIXyDzQFKQDswKjIJhNTRWATOgijiVSmXFeRc24ubfkSSPyovHzsy
         COMvBiG+J88soaicCXgySOkchggceN2Mjw+rp36rhWh5iAezU4XbrFQfl7VhBkKOQe9p
         hzNA==
X-Gm-Message-State: AOJu0Yw/RakKJjGIe6sQxwSDjLLBiaDJVWFCVS7vsygy8ayhgaPhaxGo
	iwVg2rlVCbIeViF+1bCrkm5/R6t/EH4i
X-Google-Smtp-Source: AGHT+IGdqprUHXLHeZlwQEnyqkBR7ouFdtc/hDEKXB+YundtzyRDtuNFuTKtwqpwNev1VOexHXen0ztDFEGv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:403:0:b0:d7a:bfcf:2d7 with SMTP id
 3-20020a250403000000b00d7abfcf02d7mr11997ybe.6.1695447366091; Fri, 22 Sep
 2023 22:36:06 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:10 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 13/18] perf svghelper: Avoid memory leak
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

On success path the sib_core and sib_thr values weren't being
freed. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c   | 1 +
 tools/perf/util/svghelper.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d4b22313e5fc..1b40b00c9563 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2463,6 +2463,7 @@ static int parse_call_stack(const struct option *opt __maybe_unused, const char
 		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
 		if (entry == NULL) {
 			pr_err("Memory allocation failure\n");
+			free(s);
 			return -1;
 		}
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 0e4dc31c6c9c..1892e9b6aa7f 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
 	int i, nr_cpus;
 	struct topology t;
 	char *sib_core, *sib_thr;
+	int ret = -1;
 
 	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
 
@@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
 
 	scan_core_topology(topology_map, &t, nr_cpus);
 
-	return 0;
+	ret = 0;
 
 exit:
 	zfree(&t.sib_core);
 	zfree(&t.sib_thr);
 
-	return -1;
+	return ret;
 }
-- 
2.42.0.515.g380fc7ccd1-goog


