Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6C623305
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiKISwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiKISv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D419022
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:51:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so17534918ybc.18
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRpn0P3+fcqOignA9YAOhkIfzWGGy39oUBEKle0pWl4=;
        b=Gum16eZlyNc399k5d3tx6ll5pKDYbio/60xDhY7KrQQQTJnfdPao24XhCFCL0DMhbb
         qhuhZ7+QZdM51F5m8K6I5jt9r9MzyOXKsVF+cvGL4mDrk5nJJGXlDfNVBFYHudWU8kws
         3Nn9958gEw2UiddLZMUkOrS/YkoQSsNfYzdla3r/4O/X9rWeSoKUS/H7hEQJVLptlp/l
         YwNPr3UBMdaXuQVTtJz84Zp0qOCOuxwEoiq71oB/v9GMwFWXXRSUuvNFUah0aAJUYwlW
         5roVXQcMwnPiM6w6Ips7fTqCM/mflO0K0aLpNUtAyNtVBeOLRRI3QxrVm8FzFGlE8N1d
         gL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRpn0P3+fcqOignA9YAOhkIfzWGGy39oUBEKle0pWl4=;
        b=7q6hFeA8zo+FUigj9uczZCrYFd0J18xs+CPVTQdyoMFERNg0yy9WUPA36nVIshSN9G
         PyK7IFCGZE980i9Ct28R5tAydddk5J8GCjoPpy8TFdn+QjkKtkLAZq/5lpjNLXw18sBI
         sFE1vnuUD2Hl32d/VphySi/rWPdSTWjH9gmc/m4CV8+kyUyz5Tcu6SYq5LgsBj+bl8q8
         jJdzGYNE81Aua3LkIUiJuVsSXzSNeyerMTm4QfG2HdXDd71ogXNNpMgjKQcgpiZ9I+tP
         OZ37bsZFVZ8WLuj2H6AoM0rz0KY34ZY2ZXREKx8PAXuMPJj6APkRMrrR1mYrQDiCf/MP
         QsUg==
X-Gm-Message-State: ACrzQf2PDeSA5utgZjMRgfqxlTrUQvA36YDiwXA0f2T8T7IjCalXDZa8
        uxnv+bssnJN7dZfZV4/ZE9H33j++hHWH
X-Google-Smtp-Source: AMsMyM6UYHYvI9oRglfbF00i/rXNWsAuwQ6/Jdg2ihwWhfW0WufkEgYQy01iVSCK8Q9cfdVmss5mD7PwOXZ0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:df85:0:b0:6d0:6e1:85bc with SMTP id
 w127-20020a25df85000000b006d006e185bcmr36982852ybg.519.1668019882993; Wed, 09
 Nov 2022 10:51:22 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:14 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-15-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 14/14] perf build: Use tools/lib headers from install path
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
        Ian Rogers <irogers@google.com>
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
libraries that are depended upon. List header files provided by
libraries so that dependencies are built in the correct order.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |  2 --
 tools/perf/Makefile.perf   | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

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
index 6c1a2a3ccc38..d71e728e7a5c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -305,6 +305,7 @@ LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
 LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
 export LIBTRACEEVENT
 LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
+CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
 
 #
 # The static build has no dynsym table, so this does not work for
@@ -322,6 +323,13 @@ LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
 LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
 LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
 export LIBAPI
+CFLAGS += -I$(LIBAPI_OUTPUT)/include
+$(LIBAPI_OUTPUT)/include/api/fs/fs.h \
+$(LIBAPI_OUTPUT)/include/api/fs/tracing_path.h \
+$(LIBAPI_OUTPUT)/include/api/io.h \
+$(LIBAPI_OUTPUT)/include/api/debug.h \
+$(LIBAPI_OUTPUT)/include/api/cpu.h \
+$(LIBAPI_OUTPUT)/include/api/fd/array.h: $(LIBAPI)
 
 ifneq ($(OUTPUT),)
   LIBBPF_OUTPUT = $(abspath $(OUTPUT))/libbpf
@@ -331,6 +339,20 @@ endif
 LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+CFLAGS += -I$(LIBBPF_OUTPUT)/include
+$(LIBBPF_OUTPUT)/include/bpf/bpf_helpers.h \
+$(LIBBPF_OUTPUT)/include/bpf/libbpf_legacy.h \
+$(LIBBPF_OUTPUT)/include/bpf/bpf_tracing.h \
+$(LIBBPF_OUTPUT)/include/bpf/usdt.bpf.h \
+$(LIBBPF_OUTPUT)/include/bpf/bpf_helper_defs.h \
+$(LIBBPF_OUTPUT)/include/bpf/libbpf_common.h \
+$(LIBBPF_OUTPUT)/include/bpf/bpf_core_read.h \
+$(LIBBPF_OUTPUT)/include/bpf/bpf.h \
+$(LIBBPF_OUTPUT)/include/bpf/libbpf.h \
+$(LIBBPF_OUTPUT)/include/bpf/skel_internal.h \
+$(LIBBPF_OUTPUT)/include/bpf/bpf_endian.h \
+$(LIBBPF_OUTPUT)/include/bpf/btf.h \
+$(LIBBPF_OUTPUT)/include/bpf/libbpf_version.h: $(LIBBPF)
 
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -340,6 +362,12 @@ endif
 LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
 LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
 LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
+CFLAGS += -I$(LIBSUBCMD_OUTPUT)/include
+$(LIBSUBCMD_OUTPUT)/include/subcmd/run-command.h \
+$(LIBSUBCMD_OUTPUT)/include/subcmd/exec-cmd.h \
+$(LIBSUBCMD_OUTPUT)/include/subcmd/help.h \
+$(LIBSUBCMD_OUTPUT)/include/subcmd/pager.h \
+$(LIBSUBCMD_OUTPUT)/include/subcmd/parse-options.h : $(LIBSUBCMD)
 
 ifneq ($(OUTPUT),)
   LIBSYMBOL_OUTPUT = $(abspath $(OUTPUT))/libsymbol
@@ -349,6 +377,8 @@ endif
 LIBSYMBOL_DESTDIR = $(LIBSYMBOL_OUTPUT)
 LIBSYMBOL_INCLUDE = $(LIBSYMBOL_DESTDIR)/include
 LIBSYMBOL = $(LIBSYMBOL_OUTPUT)/libsymbol.a
+CFLAGS += -I$(LIBSYMBOL_OUTPUT)/include
+$(LIBSYMBOL_OUTPUT)/symbol/kallsyms.h: $(LIBSYMBOL)
 
 ifneq ($(OUTPUT),)
   LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
@@ -359,6 +389,22 @@ LIBPERF_DESTDIR = $(LIBPERF_OUTPUT)
 LIBPERF_INCLUDE = $(LIBPERF_DESTDIR)/include
 LIBPERF = $(LIBPERF_OUTPUT)/libperf.a
 export LIBPERF
+CFLAGS += -I$(LIBPERF_OUTPUT)/include
+$(LIBPERF_OUTPUT)/include/perf/core.h \
+$(LIBPERF_OUTPUT)/include/perf/mmap.h \
+$(LIBPERF_OUTPUT)/include/perf/evsel.h \
+$(LIBPERF_OUTPUT)/include/perf/evlist.h \
+$(LIBPERF_OUTPUT)/include/perf/bpf_perf.h \
+$(LIBPERF_OUTPUT)/include/perf/event.h \
+$(LIBPERF_OUTPUT)/include/perf/cpumap.h \
+$(LIBPERF_OUTPUT)/include/perf/threadmap.h \
+$(LIBPERF_OUTPUT)/include/internal/mmap.h \
+$(LIBPERF_OUTPUT)/include/internal/evsel.h \
+$(LIBPERF_OUTPUT)/include/internal/lib.h \
+$(LIBPERF_OUTPUT)/include/internal/evlist.h \
+$(LIBPERF_OUTPUT)/include/internal/cpumap.h \
+$(LIBPERF_OUTPUT)/include/internal/xyarray.h \
+$(LIBPERF_OUTPUT)/include/internal/threadmap.h: $(LIBPERF)
 
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
-- 
2.38.1.431.g37b22c650d-goog

