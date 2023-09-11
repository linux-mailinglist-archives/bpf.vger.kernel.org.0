Return-Path: <bpf+bounces-9671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CE79AA73
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16E02811F7
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D837015AC0;
	Mon, 11 Sep 2023 17:06:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A85A950
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:06:12 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1C123
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-570428954b9so6260813a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451971; x=1695056771; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Vzz2XipswXqhRAZU8hIAWN5QKsHwhXA4M9PtsNSBLg=;
        b=YWCOnLA3d4/1GNUUBAPQ7IGBWC9j9mXhT7x0i2jwYLaTNsKaNXktq7Oo0GS4HN20XH
         D1x2yETJaiV4uDvGIoS6zXvlugijlRvIJMEKFnAIepyz6nUx7atxJAvwCSDeR4p3Z39S
         qan3tfA0QYt6XRy30ikBmsZB/MfvX23i26yLDzClGhRoX0rt0IlLIvV+23h5ssKYpBKd
         B84NpEqQnuqrdbVuNLHb3OIWny4mgBoXqMOjFxlTLcPLl4cUHSE3nNhNnD4zy9YAwE1C
         YgAMxrRyzLkrSrjOpIlSMo2bcifnDylyzpaGeVxDEi71j5LffHk6ae0AsuR3LnEoMoN8
         j6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451971; x=1695056771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vzz2XipswXqhRAZU8hIAWN5QKsHwhXA4M9PtsNSBLg=;
        b=NH+VQJhP2BV4FqaTm67Kn5Y9tGgaXXgLeSXTXfAl/FCOe3tqX9Ea+JwMOsDyAz8o1D
         PpVOwt/gfIeeLKh7s/arsd60e3o1zqydy+mP8EDAdanYuW7i3XNi+VPSQhXbrGTKw2QW
         B+8g+g1zyYUYK7bm8vA83TF/gCM+OQOZlFnjCkM15eb6FeD2Vp3jKvGdbAdKjMO7JHE2
         Jb/X1iCh0CUMKJUxus7X9iqYhXXj0SlOWp+VKV67oxJ7trAiFM0uPfMKUAfEIQAoVo7s
         75JtcqMvd4kLKkEuduIwFHiGAarOQpnLu5GqfxMJoW+dU4vNQzkPF04/EtVNKcAEjcBU
         24qQ==
X-Gm-Message-State: AOJu0YzMfaMqM4L7JNplRtcO2TEUGlXipBFo2v+d4twNhno7z1C8tzmh
	0Vdc9O1YooOC7xccdtwFy1lCF+G9a3cO
X-Google-Smtp-Source: AGHT+IGIhSAWZ1imjQEKI5kVl5ekILjaw0OmXTbC9BInGiGxTOTdQVla++ZMTYyGVj4IXpyev+Ua2Gvq2EsG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a65:6ab5:0:b0:573:f899:b6f with SMTP id
 x21-20020a656ab5000000b00573f8990b6fmr2287578pgu.10.1694451971254; Mon, 11
 Sep 2023 10:06:11 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:05:57 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 3/5] perf expr: Make YYDEBUG dependent on doing a debug build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

YYDEBUG enables line numbers and other error helpers in the generated
expr-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 6c93b358cc2d..e364790babb5 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,8 @@
 /* Simple expression parser */
 %{
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 #include <assert.h>
 #include <math.h>
 #include <stdlib.h>
-- 
2.42.0.283.g2d96d420d3-goog


