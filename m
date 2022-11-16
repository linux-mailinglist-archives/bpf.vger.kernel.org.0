Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD5762B3DB
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 08:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiKPHWT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 02:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKPHWS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 02:22:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1984CA18F
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 23:22:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so15216971ybj.8
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 23:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NO6Jy27duk4navDIf91BiAlCfPwecqqBj66fQCAI5+k=;
        b=Pr7mjdcYb4qAEw3uOgulSRygcajgBXTmQtAjMOaT4ntJSmqQPXKpb2/w3lKfSLncYU
         iJB3rB6o6rbI5+Ulkzx5Vle1i67dxwFL9s45ZSE+3wwN4PQCTR8uR59jgQdpzQtvX3ln
         9CeyrdspkbVCWBDKJySYuge6+beWXNM61UM6BnQtSL8y7boc8j/X58P071TDKAGD3pJ7
         esUo7Cudp+Jg4L72D+3gQ2eeI/UxkEUfSkPmPJU7Jvh3zTG1+mlSvI7jspnqocGA/hSZ
         TYbBphk5VzKjXeQHjL4fvvRAr0aVHQAi8WtOY8wpCklTel+uGRpCJI5S7ZLhekCsnQ56
         HteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NO6Jy27duk4navDIf91BiAlCfPwecqqBj66fQCAI5+k=;
        b=iB/SimcaiEOm0CZV0MhqS6vwoKYExU/8CygfAOSnLZOBmNdUpHuC5DtjbmLfoZr3f4
         pk4SGAJblp2VXh4jXT0hjXIG1Aka+8dNx5W2IudAkyazbHvQSMCMP0CyOZIIer062wjC
         sXEHt5H//yd5IGffrNy4ZWY18tPgrVLJphKZmDqKknUWvyD+NnBKiuKiaTDIQ1F8A8qi
         htneOOnv6v3Nw4FqnbMthGQ5VJqye9IbgzFFf6rtMP29bM6LcYcW1of+ZrkcMM25BMI2
         F6PbeMk1CSzyNwcdhkoleMlIPZc3rGNiLWwW3hj1GFriqLrr4Zzq2kn1F3C05PhUu6tl
         eclA==
X-Gm-Message-State: ANoB5pn1+JtPDfjXayv1OdzVuXh2g3/YSI15OzF4/5eRygXMSwDlD6W1
        492DEbU8QcjuNQaOtfF3T3u8HZBS/hMV
X-Google-Smtp-Source: AA0mqf6/s9UDBseMvwO0B9sUanmLV3Smc5IQvElHLCvgzuhy8jQ9dnTHlYJUB2ggKxcTcdYTeeB/U7gLdk9m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a25:2fd6:0:b0:6bc:738d:65c9 with SMTP id
 v205-20020a252fd6000000b006bc738d65c9mr18993829ybv.521.1668583337411; Tue, 15
 Nov 2022 23:22:17 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:22:11 -0800
In-Reply-To: <20221116072211.2837834-1-irogers@google.com>
Message-Id: <20221116072211.2837834-2-irogers@google.com>
Mime-Version: 1.0
References: <20221116072211.2837834-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 1/1] perf build: Use tools/lib headers from install path
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch -I from tools/lib to the install path for the tools/lib
libraries. Add the include_headers build targets to prepare target, as
well as pmu-events.c compilation that dependes on libperf.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: bpf@vger.kernel.org
Link: http://lore.kernel.org/lkml/20221109184914.1357295-15-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config |  2 --
 tools/perf/Makefile.perf   | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a7f6c0669fae..9cc3c48f3288 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -349,7 +349,6 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-INC_FLAGS += -I$(srctree)/tools/lib/perf/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
 INC_FLAGS += -I$(srctree)/tools/include/
@@ -367,7 +366,6 @@ endif
 
 INC_FLAGS += -I$(src-perf)/util
 INC_FLAGS += -I$(src-perf)
-INC_FLAGS += -I$(srctree)/tools/lib/
 
 CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6c1a2a3ccc38..dd096aba4430 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -305,6 +305,7 @@ LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
 LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
 export LIBTRACEEVENT
 LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
+CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
 
 #
 # The static build has no dynsym table, so this does not work for
@@ -322,6 +323,7 @@ LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
 LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
 LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
 export LIBAPI
+CFLAGS += -I$(LIBAPI_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBBPF_OUTPUT = $(abspath $(OUTPUT))/libbpf
@@ -331,6 +333,7 @@ endif
 LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+CFLAGS += -I$(LIBBPF_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -340,6 +343,7 @@ endif
 LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
 LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
 LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
+CFLAGS += -I$(LIBSUBCMD_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBSYMBOL_OUTPUT = $(abspath $(OUTPUT))/libsymbol
@@ -349,6 +353,7 @@ endif
 LIBSYMBOL_DESTDIR = $(LIBSYMBOL_OUTPUT)
 LIBSYMBOL_INCLUDE = $(LIBSYMBOL_DESTDIR)/include
 LIBSYMBOL = $(LIBSYMBOL_OUTPUT)/libsymbol.a
+CFLAGS += -I$(LIBSYMBOL_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
@@ -359,6 +364,7 @@ LIBPERF_DESTDIR = $(LIBPERF_OUTPUT)
 LIBPERF_INCLUDE = $(LIBPERF_DESTDIR)/include
 LIBPERF = $(LIBPERF_OUTPUT)/libperf.a
 export LIBPERF
+CFLAGS += -I$(LIBPERF_OUTPUT)/include
 
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
@@ -691,7 +697,7 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(PMU_EVENTS_IN): FORCE
+$(PMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -774,6 +780,12 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(rename_flags_array) \
 	$(arch_errno_name_array) \
 	$(sync_file_range_arrays) \
+	$(LIBAPI) \
+	$(LIBBPF) \
+	$(LIBPERF) \
+	$(LIBSUBCMD) \
+	$(LIBSYMBOL) \
+	$(LIBTRACEEVENT) \
 	bpf-skel
 
 $(OUTPUT)%.o: %.c prepare FORCE
-- 
2.38.1.431.g37b22c650d-goog

