Return-Path: <bpf+bounces-6173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F522766487
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE74E28246C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF88C8CA;
	Fri, 28 Jul 2023 06:50:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8521BE78
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:50:04 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0263ABE
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d0fff3cf2d7so1710501276.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526996; x=1691131796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCTbKLxJE0e0fl2gNVl7kq0Lz7zE9dDnQokd98Af9Ns=;
        b=X3zNA1RyzLTULsNbdzaguab4z5QUbvoNMUV1EWAEh8ykQMS+N/lSrXKHrjXCDjAIW0
         b8fAsPrrPrZUyGp2r2JOgYtx0Iyu2JRCxWsXHm0VA9DEhKb90ArH81bKpFGytwmaegL/
         ahLqi1dWB0gpwXhL71JAr4ayzjdZNvmRpaOg3DNpfus2x79fe2cK/zPF8M4yzx8dle8/
         lgYRqJGe5+65cNJgMBcb6mUsE4h8lwi7sFbN5W2Ys+inxantP8VFhm0mjMLMGq0MIX+3
         Q2qJAkJzldydQMadbHTKbjY/T5QuIThGF37ugL0IfZXuyIkE+c2o8kYT/YKIo3X65Ptf
         4j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526996; x=1691131796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCTbKLxJE0e0fl2gNVl7kq0Lz7zE9dDnQokd98Af9Ns=;
        b=TtFAaYejuzaL1XzDH2Qx+H0fICRW1c8/QHb0SNOpHg/MCIrCQA0bnV5vJ4bQ09wjRJ
         5ZvkRmZaIi2Ca7i2OPBckMpj9fbfQ53A9D17YOmtJpJ2P+QAHe7rYK2k7YZJK1QiQii5
         1L3Vq8otP/iPW+HC7uqRwrilVVkLZPgc1FBb6bbLBPVJznY7u/fD7Sy5vraFOIlKAVO8
         vXh1gd0F5hpjjup2qo+UnIscDud6vx40L5iSmX1ve1n2sqfpUZb61HM2HU0v4CKA7yfA
         Dzt8mNsozU+qXSIkpo/vgoTcnBDzzQuS4ez3fqsSMUf7KfyG47mro3XF1aBREyfrcKE3
         Cc/A==
X-Gm-Message-State: ABy/qLahQYoy1rDRyfae7U6ekF123t8tguTs+Y/seXnsCeISTqls4TJM
	CwRkb5hutv7L8C4A76iAFIWGh8BrjyJQ
X-Google-Smtp-Source: APBJJlF1VBO/nA6o0F1Sw4iDyXLL+nD10wzaY2iHSF0gHcJmj7AOkP0CJ29sQFCewflEsjHmJprWtoE0EOv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:7392:0:b0:d1e:721b:469d with SMTP id
 o140-20020a257392000000b00d1e721b469dmr4543ybc.7.1690526996428; Thu, 27 Jul
 2023 23:49:56 -0700 (PDT)
Date: Thu, 27 Jul 2023 23:49:17 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 6/6] perf build: Remove -Wno-redundant-decls in 2 cases
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

Properly fix a warning and remove the -Wno-redundant-decls C flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          | 2 --
 tools/perf/util/parse-events.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 20aa8545b127..b8f1e9ba8c6f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -312,8 +312,6 @@ CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
-CFLAGS_parse-events.o  += -Wno-redundant-decls
-CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
 CFLAGS_arm-spe.o       += -I$(srctree)/tools/arch/arm64/include/
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 926d3ac97324..ac315e1be2bc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -35,7 +35,6 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
 
-- 
2.41.0.487.g6d72f3e995-goog


