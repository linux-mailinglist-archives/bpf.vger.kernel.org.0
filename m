Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3342E620A43
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiKHHgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHHgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:03 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32973136A
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:36:01 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s16-20020a632c10000000b0047084b16f23so1526608pgs.7
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XV8F7Y9b6lLTaqsCc66jRKiIqG8YARD76LN05/Nr/k=;
        b=tIu+ae8RAaJV6DT6ho3AZcMSnxba+8gPBUz3vxCbEzMIUvJI6h7jZT1ljI6sdhfqHq
         dl04PKc9R1t8WtzG+mIc3Ra8vcsKiptz7/NH2D2SKLrPBZay+T1ygysr4GGbhu6re7Nf
         CF7ug8e1MQanPm6kirN9k/NUz9JQAzJH+eh4o2SmmGZMmuadREaqEE5+Xinl1P72wmfP
         EXD0mUA+j16ZMCDcpi0WO5JIh3W9CvOfjFHtr9rr5FmoSrdDweg+/zucQHuj3aFaSR6M
         YgtnDw16RUa9SFXt/ivoYv6vi+iYPgiA5NhL72Id3CodqjjnP28tLmlOA0itqjwR9fat
         9UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XV8F7Y9b6lLTaqsCc66jRKiIqG8YARD76LN05/Nr/k=;
        b=exlfCPl9tRFqGB4J14YYVkilzGWulswcuNjN3iNAEToxDk1mUFB/9zxorKY7xjfXNa
         LFpzPfPEfiqVflXKE4d+1AqsGnmoShR04q8MLmsy1ShRH8IWVxJX+vIRllY36RR2mXWz
         QGTgdc9hBvPsJCSJsKSwSia3jvG9D9Ifsgb588BDlGLK83JyU8gW8ftuwFbFO+A3jMmD
         frXcL/C85WLvfPIlc16FMBfDIK7CdV9hG4VSGvRE8iDy1rfFTp4Wga+q5DHFMO+BGWq+
         1LF9hoZA+g9elRJqI9ExVwiW2kz2PpyGgIj81KmDys5Fk8wmAwk+YQNdYHXVqrWV7a+C
         jLwg==
X-Gm-Message-State: ACrzQf3x2afn9uwsUi1ZOfD2QDcZ9Ru+5FE8DXYiryNnYO01lSihAf0M
        Nn4V1oYssAbNOm05k/yDXYU8jBUux1Ru
X-Google-Smtp-Source: AMsMyM58HW9LrRnmkPmzOlTtj3nWzJkX9jlkn+yPHCPLJhy8xb33X8MHzFv1btcrjkrFKO+1ddKfH/+lLMu1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a17:902:a5cc:b0:188:53c8:fddd with SMTP id
 t12-20020a170902a5cc00b0018853c8fdddmr758529plq.52.1667892961109; Mon, 07 Nov
 2022 23:36:01 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:08 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-5-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 04/14] perf build: Install libapi locally when building
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

The perf build currently has a '-Itools/lib' on the CC command
line. This causes issues as the libapi, libsubcmd, libtraceevent,
libbpf headers are all found via this path, making it impossible to
override include behavior. Change the libapi build mirroring the
libbpf and libsubcmd build, so that it is installed in a directory
along with its headers. A later change will modify the include
behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 626f5dd9a037..1932848343f3 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -38,6 +38,7 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 feature/
+libapi/
 libbpf/
 libsubcmd/
 fixdep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index af62c6b9ed7a..3874d88d72c9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -241,7 +241,7 @@ sub-make: fixdep
 
 else # force_fixdep
 
-LIB_DIR         = $(srctree)/tools/lib/api/
+LIBAPI_DIR      = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
 LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
@@ -295,15 +295,9 @@ ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   PLUGINS_PATH=$(OUTPUT)
   LIBPERF_PATH=$(OUTPUT)
-ifneq ($(subdir),)
-  API_PATH=$(OUTPUT)/../lib/api/
-else
-  API_PATH=$(OUTPUT)
-endif
 else
   TE_PATH=$(TRACE_EVENT_DIR)
   PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
-  API_PATH=$(LIB_DIR)
   LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
@@ -318,7 +312,14 @@ LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
 DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
 LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
 
-LIBAPI = $(API_PATH)libapi.a
+ifneq ($(OUTPUT),)
+  LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
+else
+  LIBAPI_OUTPUT = $(CURDIR)/libapi
+endif
+LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
+LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
+LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
 export LIBAPI
 
 ifneq ($(OUTPUT),)
@@ -831,12 +832,14 @@ $(LIBTRACEEVENT)-clean:
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) install_plugins
 
-$(LIBAPI): FORCE
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
+$(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
+		DESTDIR=$(LIBAPI_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
+	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
 
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
@@ -1052,7 +1055,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifdef BUILD_BPF_SKEL
-- 
2.38.1.431.g37b22c650d-goog

