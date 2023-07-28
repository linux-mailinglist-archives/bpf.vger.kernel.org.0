Return-Path: <bpf+bounces-6169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8A76647E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FF6282640
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0EC138;
	Fri, 28 Jul 2023 06:49:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59324C2DE
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:49:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842503598
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d052f58b7deso1759224276.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526987; x=1691131787;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhkzLjqRFF0tb62b0zCcrfbiHArZkxdbKwWW1/g/MaY=;
        b=4clqy47Iqnh9PeYyHrqFTBjZVVf2SsELiW1HtOdGDeARMMfpRfOc5BJg7RxKU+0K59
         RuhH+JcaohEwep2coSpp1uhn625qdWNvq18kjJeU1bqh4H+4r2JgRo+B/XHKkvIFAtAd
         R3kQBqwvyEa+TcMvRgBKHmm8MYf8+ukvA1ioGcNVQg/Gso5Ud9gz3tk0FPXR7o0hNTZf
         QFZB0DzH6H5VFQTA7uYQh+vnKMQhcU6NxtStCPkF6+G4gpUIT7bLYg6AmiimM+mPPiw2
         0cdqCrJgLMxv/olLDJ+/aTTgleRC2E7Z4U9KIdBIg2AKRYWN1ab8Va/7I+p7lyQfoMQd
         B22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526987; x=1691131787;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhkzLjqRFF0tb62b0zCcrfbiHArZkxdbKwWW1/g/MaY=;
        b=YWmRrnWSOXBxsAlxfWppb5gIAgzgsALpz7sIlukrpQpXvkuq+3XgmnzSicbhh1T95E
         lumS26L0aX48sdXBYrQs6NcONiUdGiDrhTmL+uOfS2ENS2Ky3mjLASdXSasEjagcmkm8
         oYK7+oXqS7Kvbst2WfHSujCw9xxlcH3rlVmDQTpgWLfM1wo1NtG/OS5jgu+g1TXDzyEk
         +Osh0IySW/6EhQ2Wf4xoy2LK7PF68iUbo5RYfdH8dCE0x3fC+GQLO88Em/kp82ZAqjPg
         HzgdP0b/nMicK7MJPyjXsLJy3r2I2zBW2xZN0JtUeif/fOr57cz5Vujms3LWzI2/53Zx
         izrw==
X-Gm-Message-State: ABy/qLY0GCpvbq5jlEJYqc8U3LbgA3tXqBEWqLa8VzrHo3DcI9KRU4Wh
	vOWRQ8Q4sa6JfR0TVyenfCxHCKv3IkCz
X-Google-Smtp-Source: APBJJlFItFzpwaYwOmttNt6LMhW33cuF50knjW5+ecNSk4vm9Ubps/H5m9OxllkRh3cs73v48l7MUO+HQmGt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:ae0c:0:b0:d05:38ba:b616 with SMTP id
 a12-20020a25ae0c000000b00d0538bab616mr4562ybj.6.1690526986818; Thu, 27 Jul
 2023 23:49:46 -0700 (PDT)
Date: Thu, 27 Jul 2023 23:49:13 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 2/6] perf build: Don't always set -funwind-tables and -ggdb3
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

Commit 6a40cd90f5de ("perf tools: Add libunwind dependency for DWARF
CFI unwinding") added libunwind support but also -funwind-tables and
-ggdb3 to the standard build. These build flags aren't necessary so
remove, set -g when DEBUG is enabled for the build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a9cfe83638a9..14709a6bd622 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -246,6 +246,9 @@ ifeq ($(CC_NO_CLANG), 0)
 else
   CORE_CFLAGS += -O6
 endif
+else
+  CORE_CFLAGS += -g
+  CXXFLAGS += -g
 endif
 
 ifdef PARSER_DEBUG
@@ -324,8 +327,6 @@ FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
 
 CORE_CFLAGS += -fno-omit-frame-pointer
-CORE_CFLAGS += -ggdb3
-CORE_CFLAGS += -funwind-tables
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu11
@@ -333,8 +334,6 @@ CORE_CFLAGS += -std=gnu11
 CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
 CXXFLAGS += -fno-omit-frame-pointer
-CXXFLAGS += -ggdb3
-CXXFLAGS += -funwind-tables
 CXXFLAGS += -Wno-strict-aliasing
 
 HOSTCFLAGS += -Wall
-- 
2.41.0.487.g6d72f3e995-goog


