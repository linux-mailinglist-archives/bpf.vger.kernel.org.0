Return-Path: <bpf+bounces-9673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A779AA75
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ED31C2098A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CD015AC8;
	Mon, 11 Sep 2023 17:06:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B25156C1
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:06:19 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2EA18D
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so50970727b3.1
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451976; x=1695056776; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRCYGoTjjcBophstCTgDgCPllSE9scm8ZFVfCDuwbMQ=;
        b=4EHxcPJv77hNl+7rXblAISOV1A5jk322xPjjLWmpMWPApLC5mtbFAJjcNlH/Cfg0CV
         O4Jx8u2UoxHzmuqKrimsynrN06cQkxtX9fXVdOuG9E/J532NH6RydHBMGQY+rkPG+3oV
         QoxZLzbBaS13lijfJ3LnmNyuamfwOYCRAEXIFm0FqN8XcR2ig4nOfKPAzoZ9+kXJ4LlV
         V+dfaqvgUx9ZjdZxbMIatpcOgN2WIxC+N9C1zcBsPvrLDZecvVNpXcKhf890rtMsPmoZ
         KtaiiEx1kJQHQoIH1if+RJy+7cRTz+g2OMSdGauz2KRabhBA7SBJa7mXVt8034MJDPN6
         r5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451976; x=1695056776;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRCYGoTjjcBophstCTgDgCPllSE9scm8ZFVfCDuwbMQ=;
        b=aFHL5S41ZRvynN380PqtVcdV8XqRgAjNh964/JAtng8UHbZcOOcMqkXu1e4lOEBOgf
         xauaENnb6SUyLJYZ20190Ro0U+P24WcjK7qMZpA8GmxGHmiPgpXvXEqIE9VyaNNAo5cY
         5gV316/S5FGoXsWB65raHEZEf4dUQ7ku9pypacT5ofsi11xgjHAr2mFK7pa3Vr9wqV6o
         4L8uHqNBaf4Oq4ObWQOcPh3T1SgSGP6FL9Q1iuiQy4+CBffU8ATvzoc/K1ewl6o7OXxf
         pom9pLtT+ONzSwI7H74QtCdTAeyDSA0SXJ+VnwRKi8B/+Z30w3NnQUgynjc5qo6tiknI
         pt3g==
X-Gm-Message-State: AOJu0Yy0behNfBT44f1KmMSJFI5gc5BFioxWB9hugMB1H4ItkFqlCqGU
	uft0sjwSL/vMlwn3A8zQ2VTc/TWqG720
X-Google-Smtp-Source: AGHT+IEYtgLkZOmrsQVv+5dnEAGGCmzF/e5/Bc/ESvtcLe0YzUoWzx6RXlKagJYsvqgnlYoolnqNvo6bX6Qr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a25:aa73:0:b0:d72:8661:ee25 with SMTP id
 s106-20020a25aa73000000b00d728661ee25mr214482ybi.2.1694451976506; Mon, 11 Sep
 2023 10:06:16 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:05:59 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 5/5] perf bpf-filter: Add YYDEBUG
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

YYDEBUG enables line numbers and other error helpers in the generated
bpf-filter-bison.c. Conditionally enabled only for debug builds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.y | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 5dfa948fc986..0e4d6de3c2ad 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -3,6 +3,10 @@
 
 %{
 
+#ifndef NDEBUG
+#define YYDEBUG 1
+#endif
+
 #include <stdio.h>
 #include <string.h>
 #include <linux/compiler.h>
-- 
2.42.0.283.g2d96d420d3-goog


