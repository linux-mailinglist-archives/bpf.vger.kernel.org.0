Return-Path: <bpf+bounces-9670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2279AA72
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A0C2811ED
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A6156FB;
	Mon, 11 Sep 2023 17:06:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F8156C6
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:06:10 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629DB123
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so4527231276.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451968; x=1695056768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plnRe05PLz5HwJERoEdGb+td666IsNXhJdSMGYIgC0g=;
        b=35ZhUrc4mC8wm++mqZHj5N58Wb6AxXOh3zE4qdiZC4tghBatLr1k3SKhymondkzsrx
         Oq2mNCzHTuzyoQ/UlPgSr8ojbWqcsXRW27r5TWhl3EZlqhN5jGHagfeSvFhmt6LSoZCX
         Xi/qEY8aC+SDq4iytTM6njtvDHFRHIHmvjsdc+5sN46GyiN+UXL80R1/81K+5zlON7VU
         N/T0iC+Ev11w8bIaqI0uM7eT2rjciAXFybv9W4GRdPGuA2lGArXP4uh67hkL5GmCW19e
         4Dq1jk7UwastkrMk3B36KMLtSQ0LaXsTTLdJjcOndQlm9sJUNQMUsIVGNX6kdn7plXYW
         J1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451968; x=1695056768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plnRe05PLz5HwJERoEdGb+td666IsNXhJdSMGYIgC0g=;
        b=UX6WxBuLe9OQptHz+zzGjiBDK/TbzEI914yMkJnQdhuqBf4HKCG3Fhq2IVP8B0/vrk
         CeJ435OiVgWRgmJQRmVXVEkfJLsjracDgR0sc/fQl7c9axoLZN7gMtv52IaX9YcWEYz/
         zCXsRrr7l+U+yUF//UNLZxwZ16O0+RB/GIrMDsITmTSBTgKFXDDhz1U0HgwqEfSq4NIa
         G46ePQDSo2X27ZgWFJDNmkXJHWIv6iGXfLAYclojLF3noRK3mtwMNwjvQwYKvdDMesh4
         vou7ZweEq/Ol/MeqR8rCOyZqH+veJWeIsWJK0pB1Y4jqQYRJgMCyWnlBjzbNVixDg8Ii
         IW2A==
X-Gm-Message-State: AOJu0YxcXU1xNax6wY5a2fEHVtahiMIDYyTn2VOc7QFJU9yRwVBSv64p
	az8M1Cnf+xsgtxFJ/3SsYlptCKaNNsLP
X-Google-Smtp-Source: AGHT+IEnfS1l+N2qwMCzhtLFyNIHFAeL8hpCr7r2M2aEhvvJJ66Ru6k4JSQfK49zP5WGO8fpgWBl7gvJULw+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a25:4153:0:b0:d74:6bcc:7b22 with SMTP id
 o80-20020a254153000000b00d746bcc7b22mr217383yba.6.1694451968569; Mon, 11 Sep
 2023 10:06:08 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:05:56 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/5] perf parse-events: Make YYDEBUG dependent on doing a
 debug build
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
parse-events-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index ef03728b7ea3..786393106ae6 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -6,7 +6,9 @@
 
 %{
 
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 
 #include <errno.h>
 #include <linux/compiler.h>
-- 
2.42.0.283.g2d96d420d3-goog


