Return-Path: <bpf+bounces-5753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC60760054
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B161C20C49
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B23101C0;
	Mon, 24 Jul 2023 20:13:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B751094C
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:13:03 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AEC10D1
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:13:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d114bc2057fso1635461276.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229581; x=1690834381;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEagIzbSR+iB7PSrtUC5DfVnlIQ8QvGcLEq0hl6k6cA=;
        b=j2eqq8QJfxe5onO/aGVvaZmBZjt/wIF7SaMZOFFFIBmta/BHNLFdiK8Q22j/eX09oZ
         w0dHp+SS4oB8TAwI9U1Thqt3j09spPnfcwI5kYPTP6gIVsRyjJHjWvvzSLslo5YYpeoN
         c2hboVA2Xj41u9rSGKt+XtGy2WWpRd+D5CYDFN6InkvFRRqrqencUeV1GqGIh6jl61n7
         b0eNVnasnKfepEZSJY8N3RZ1gOgZfudCajlb88Bm5NjCpYtXm+lCAc1tmM9BAwtyUUlH
         y67MvoHn0sz9nUTZCUbw2FJ2VKENjbcoNmOlh8rmbn5beNZ12CP1T7kwYUaSKiKFCwFp
         ShAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229581; x=1690834381;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEagIzbSR+iB7PSrtUC5DfVnlIQ8QvGcLEq0hl6k6cA=;
        b=jxNMfgz41e4Up0ksFywU6kai8KKdVWJplC51kaJvtrxvBj+yAMKk3GaviBaaUjReXr
         HxxD19mLDpX+BUQi2b8m0w4cGnRXVQPq7mj79FB0hmPvbjsrKKPPKmo7vCC6BHZFxKze
         D0RBalWn3MPmfXRfqcBdXtcfPa4dJ3WvXpmUjRMvu1QO2mx26hpI3vwaTNQBq2eo6OqZ
         2IEGrY+im3IMGQDYYU3oID15fCncfF28dZECq+ZpNrFsHjYtcYRsaj1bR2//M9j15zAv
         S6OoPDfl/3XF01jxfK/5ngIiJm/bYZWYjQ09chgJNrQKaE3uhS1+P5fL5vJvg33bZad+
         6miQ==
X-Gm-Message-State: ABy/qLa2iCSDLl03acUrviKrHF0YfD7uCC5c9TKCbEnJL0qbrMXjQyvD
	WylSP/oIT+srs9SuCkixCvmsPg9qcNEt
X-Google-Smtp-Source: APBJJlGTgMXHdweJXUUP8uwI0itLY4YWQi+grIGikzrinhegW1hUjINBGxYjKS5buICDoHMRDOoVHCAWEx5B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a25:d156:0:b0:d0e:e780:81b3 with SMTP id
 i83-20020a25d156000000b00d0ee78081b3mr21789ybg.2.1690229580852; Mon, 24 Jul
 2023 13:13:00 -0700 (PDT)
Date: Mon, 24 Jul 2023 13:12:46 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 3/4] perf test: Avoid weak symbol for arch_tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Cc: maskray@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GCC LTO will complain that the array length varies for the arch_tests
weak symbol. Use extern/static and architecture determining #if to
workaround this problem.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 1f6557ce3b0a..5291fb5f54d7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -33,9 +33,18 @@
 static bool dont_fork;
 const char *dso_to_test;
 
-struct test_suite *__weak arch_tests[] = {
+/*
+ * List of architecture specific tests. Not a weak symbol as the array length is
+ * dependent on the initialization, as such GCC with LTO complains of
+ * conflicting definitions with a weak symbol.
+ */
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
+extern struct test_suite *arch_tests[];
+#else
+static struct test_suite *arch_tests[] = {
 	NULL,
 };
+#endif
 
 static struct test_suite *generic_tests[] = {
 	&suite__vmlinux_matches_kallsyms,
-- 
2.41.0.487.g6d72f3e995-goog


