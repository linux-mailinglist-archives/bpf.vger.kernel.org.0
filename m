Return-Path: <bpf+bounces-11500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634A7BAF22
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 258F728245B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112E43AB9;
	Thu,  5 Oct 2023 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="th/zkdUV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D843A81
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:37 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3FD69
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a4c68a71b2so23526457b3.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547368; x=1697152168; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3q7J1zaKrxcJsN5cKPHsdKPNVlGGTILkxMs0fP/b8pI=;
        b=th/zkdUVIH9RNTZAxrSbaoNWz9FU7rplWE/5lMyqV9j6eK94Xs8BYTH0egZpLx5m/0
         Uv/SHZJTdT5NFRxBcipJKQaM6joZ0nancKx2wFtQomGJ9cDUbgP7TrqSqNM2+VHTue7F
         SPHtbuJPSedwcCcVlm2xqRHu65Zv86ZYPnN7Tbl/c5sWgS6xUEbrmfmA3f19P9eXKFex
         5RQYTfc5PvE18ZMNNhYzfGqJuL6FAoJ+vyagfyk9nfpJBdz0s24E3yf2hZjgHTmA+513
         49Lhsg40XkF1tdZhmhIpQwae9c/7sEMuKpqTqHhPQftTeuSJMVWJeo14InAbLRRdFT33
         UZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547368; x=1697152168;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q7J1zaKrxcJsN5cKPHsdKPNVlGGTILkxMs0fP/b8pI=;
        b=gfwIxwsOytN/PU/xilGdmEytaLSiyDTClRZu9oJJRm9SmdLq/om2x8swjuVmAbaqFe
         DrfjoNtwckb67gSnpu+tCI71T70ixH7zR//fOCkl20xpnCpSMPFISc/HWgDg4Pq317eh
         3LKe35/3y07pvQvDzZYl3c1576HBxYQ7DgHWfx/J3Dbm4tC+KbkO+ZtOQdqnWPxWmqtS
         EGCMzg0Yo2zsPPO+HHUqadf9t8bW1qBFSY1utzq5O8HhvEccck8dao72MAh6cnmbU1He
         FfrlowsIe1EiiyIsstKlAppzka1FeH/9Aw17RWfEk5QDSSkgz0nAhBubLMuDQv+p0+vS
         3FNg==
X-Gm-Message-State: AOJu0Yx0WgMRraVQAGzjnap3Ojey2R71mZnH3NkB+xHiHcK5yow6EQpi
	SuI750e81EfcYSJg642QolafrcpXD9UC
X-Google-Smtp-Source: AGHT+IEV9eKUl8jHouya/2mrGEIvTy7eAbccM7CjR+efeiDf6wWkcXilTE2icrLHqdeRcbaf181kT4qfwnl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:a8c8:0:b0:592:7bc7:b304 with SMTP id
 f191-20020a81a8c8000000b005927bc7b304mr115386ywh.8.1696547368133; Thu, 05 Oct
 2023 16:09:28 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:46 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 13/18] perf svghelper: Avoid memory leak
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
2.42.0.609.gbb76f46606-goog


