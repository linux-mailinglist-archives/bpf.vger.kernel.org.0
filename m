Return-Path: <bpf+bounces-6168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646F76647B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73A81C217BB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21736C15E;
	Fri, 28 Jul 2023 06:49:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8917C138
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:49:49 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538D3A97
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso30106167b3.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526984; x=1691131784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C14Lkth5YhYGrilJLa3as9gLOwkujqv4yqaGCfXT1cI=;
        b=pTjgM814griVQd95nxRaERmRO4ta0it5y0NikLDzqte4Dxn2OcWCpUMVSOvdBGreHj
         PZJRS4r4rVxhf29d7VG6q96fZkFs1VfPbiGyiQrPDC6Q9vUxd2rIephumHnoDhePDv2s
         dZbeVLCAvL5Q+Mv4ZDP+F2ec55M3eGwo3vCBg8m30lXOcsi/8UbFGTLKyJw4IeRjmbFD
         kTV85zxQ5M5/yBE4/QrnJEK2Mn1TnBXO1PxDUJWAlKuX+PuB0RRx31rFWa82I+LvrfuM
         iww3QIxpJUoNGzIl7w8eydhXRjvGgmD818Sy6noQENKa3nyDJQixl0m0FI6X5wuwbhVr
         Gg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526984; x=1691131784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C14Lkth5YhYGrilJLa3as9gLOwkujqv4yqaGCfXT1cI=;
        b=W/68lNtcLxq6MOXEIoQnfc38UuoS7t6xMDgMSVafFC+D7FKSPNjsoNj8xH91EmzDHq
         qI7hHQU/gE1eYqz2z30crmDnxsnWQBXUZigjFrzsqsHqjlSfr+aBXUkoHHF11taDkd1m
         T1kg1vV7wknETTxPeY6sXe0ZNp4K8d6+uhWrYcbzg6M8VcqQKj9EQ4LMFzb8PlqiXyV1
         vvkHjiouMEsuIi+MslBUAbb/Tv+I3C3z3kVHWy1cjVGa8F7dHwFzLCVGejK4VHvDITrK
         QF63bVZ6pZB5j0UCTrBAW3wXxwtMS8FewsuOYP1xTC1QzfpJWBPXVpB2Gwn8w+rdnxkG
         nZXg==
X-Gm-Message-State: ABy/qLYJoBQf1XykYK6xQDwsO2UrGlPAOihN4OYCG7iLtKfS+JobO2JV
	4xKofPI1WHZjqWl/1By9dz/eQtwMMTJ/
X-Google-Smtp-Source: APBJJlHY5OrUkocwZKG462E8XmaFPEseNqQWvhpbV4IL+1aqabtUQ0n/nVuKjAoPgqFX/ErHS1qmqEk8D1gC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a81:c509:0:b0:583:9d8d:fb0d with SMTP id
 k9-20020a81c509000000b005839d8dfb0dmr10517ywi.0.1690526984540; Thu, 27 Jul
 2023 23:49:44 -0700 (PDT)
Date: Thu, 27 Jul 2023 23:49:12 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/6] perf bpf-loader: Remove unneeded diagnostic pragma
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Added during the progress to libbpf 1.0 the deprecated functions are
no longer used and so the pragma can be removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-loader.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 44cde27d6389..8f4c76f2265a 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -32,9 +32,6 @@
 
 #include <internal/xyarray.h>
 
-/* temporarily disable libbpf deprecation warnings */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
 			      const char *fmt, va_list args)
 {
-- 
2.41.0.487.g6d72f3e995-goog


