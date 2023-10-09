Return-Path: <bpf+bounces-11756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C97BE9D3
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56BD281B10
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124523714E;
	Mon,  9 Oct 2023 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPZgNN8l"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6436AF4
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01082133
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8486b5e780so6194019276.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876787; x=1697481587; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=HPZgNN8loVefaOMfnRHnLVQVv2af1+7RIMbdemt0ihqTnrd+eC09lwm75mFfpYfoK8
         VuM7z5hvPEqcV4xKoabEexIrQXkuMOBoXOzdovVPUOYM7Co1+/FnIRdDj13p3os/Rw7s
         NI8p7mPr7mM5ZF4uZ1mpG8YUhvyXuFinhqEKXJ+MQu3lrzW6kz4bJP3lMkttN6Hqxorz
         mHe7KnritTalDR6fFTBGMfrTMXulwEzrUJ6mji+Y2of/4EV33s2AeShAbwxSMRJ+d02t
         dZitQgZz34BI/Fy+TBjVTcAzYr64CsOm6jp1TlVN3L0JNxAf97JGub/g2KK4QBxJEYCZ
         lAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876787; x=1697481587;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=ZG5IBIQr/dE5G9rDGOwM77TW8uBLrwBDOea3B1aW2DJZs1SpXZZUGkjbDdnpPa6O2Z
         cp8ea0+27F5Kzdu3fDbQjpKLWKFKESMlcHypA3BGJlWPJjtMjZXOsNVvC/JMX98QcEU5
         yETbu45idpTrwrTotjEKEMav4BPLNpnC0LQUDrq6cMWs6D7uDjyWJTbeuTKSMA1Zs7a3
         ob7NPb9z9jXMrjKR9SbqMme9eg2k0yB/iM99EsgR4mrfqQnKho+TJDvV1vYHE4dpS3Zn
         4jT7APgEPfJ1ls4BgC+0zsbAirmV+oeIan6P3jhl8sNFI9ph70AbtJp8bo9pY2UW3CH6
         AObA==
X-Gm-Message-State: AOJu0Yy+C/BjZ+mm8Geh+Dr5OPfnsgweyzhnDtBOldcDoer3XaXbzPfs
	EC95dkz1irYj62EwVkID2LpbcHfhBnR6
X-Google-Smtp-Source: AGHT+IGpysIorYdi8kbri+eoNngVpsBmCut1uHA899pI7BzlPq5MUUHT7YyMhz0NTaD8xsX1mPms8KyxGvsu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:c243:0:b0:d89:4d2c:d846 with SMTP id
 s64-20020a25c243000000b00d894d2cd846mr246744ybf.12.1696876787012; Mon, 09 Oct
 2023 11:39:47 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:10 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 08/18] perf mem-events: Avoid uninitialized read
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
2.42.0.609.gbb76f46606-goog


