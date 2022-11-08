Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E9620A45
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiKHHgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiKHHgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009AF1A80F
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:36:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so13374314ybp.3
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZA/f3MSpP9/H1Abii1NpKRbnV3jMWj2nBqG7xqYGg0=;
        b=LQcU5xO28wTELZbTpiimJoSAHs5p0tszI+5HwFrlnpiUaeEHjHrdaE9rKiRUhfHO6w
         9PL+5vLXFk5S7DbYJU3SAjEMQ6wq+HxR/Ozv+7E9mfJHhnhuiHq8PIbk2y4bYL9d7Sbh
         S/IL8XS16Pxf9QYT9ZwgeKeKq2w82oYnMY+Ds63OY0QI1Rp/p0vvbaPUdvCwL+gPK1Xf
         S81XjE7Latp9wHdFsOg8RQd934t7rCapKde1uvUXdcS80E91Z1h96r8wuAkO+MjNuDeK
         mt3mkij/VFJitiMNMSVqX0KNgQemV5rGzDG/gYnSfy07ut1RN5KfrMvJHGhwcMo+mg6B
         XinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZA/f3MSpP9/H1Abii1NpKRbnV3jMWj2nBqG7xqYGg0=;
        b=AIvmXbdstnzTe0VaDh4xNBmAOhvSBmWGzqIKy7pcxnCemPKSWCBcaIbPkF3vO9YUnd
         4Kw/cria9pNS/ozSPq22X/se4daZsMmhGGrwjRurrmtqBepOivF7bJ1sNz6cRL+UwjCR
         PFJGd8XvOIheciAoZYZ20w0XO+gy01pvHZLS3uLuAAZ0YUui5yFRX09QsIzOV0o2KP99
         3ilooWexiidn7jSsSbYRb3c4wA6WC8DzMmmycuLMqTkvRD2drBRWZyJswj+DlO1t/i8I
         ig64igMKnoQcQVngXf2UTZqiKwV8proApLOIttTTbHhaPM5gXCYSAUNDeNhch5G6O8ls
         Pfhw==
X-Gm-Message-State: ACrzQf2zjqn0PeuUMCezhHA4CkSHjrVhUucf27mV6VKD0y6t0ijslxVB
        /+hK6cd/u2H4ExQrZnovc6OkTgPG21cE
X-Google-Smtp-Source: AMsMyM7mRg4LyeSLq0JAjWQ3+SZfXSW9s4GsLG25fMuG+GbSZAQ4PemTd1X1LDjRl9DFMRCDLHKoUpY37TOE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a05:690c:683:b0:368:43f3:aa60 with SMTP id
 bp3-20020a05690c068300b0036843f3aa60mr898663ywb.50.1667892970237; Mon, 07 Nov
 2022 23:36:10 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:09 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-6-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 05/14] perf build: Install libperf locally when building
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
override include behavior. Change the libperf build mirroring the
libbpf, libsubcmd and libapi build, so that it is installed in a
directory along with its headers. A later change will modify the
include behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 1932848343f3..43f6621ef05e 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -40,6 +40,7 @@ pmu-events/jevents
 feature/
 libapi/
 libbpf/
+libperf/
 libsubcmd/
 fixdep
 libtraceevent-dynamic-list
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3874d88d72c9..5a2a3c4f045d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -294,11 +294,9 @@ strip-libs = $(filter-out -l%,$(1))
 ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   PLUGINS_PATH=$(OUTPUT)
-  LIBPERF_PATH=$(OUTPUT)
 else
   TE_PATH=$(TRACE_EVENT_DIR)
   PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
-  LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
 LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
@@ -340,7 +338,14 @@ LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
 LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
 LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
 
-LIBPERF = $(LIBPERF_PATH)libperf.a
+ifneq ($(OUTPUT),)
+  LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
+else
+  LIBPERF_OUTPUT = $(CURDIR)/libperf
+endif
+LIBPERF_DESTDIR = $(LIBPERF_OUTPUT)
+LIBPERF_INCLUDE = $(LIBPERF_DESTDIR)/include
+LIBPERF = $(LIBPERF_OUTPUT)/libperf.a
 export LIBPERF
 
 # python extension build directories
@@ -850,12 +855,14 @@ $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT)
 
-$(LIBPERF): FORCE
-	$(Q)$(MAKE) -C $(LIBPERF_DIR) EXTRA_CFLAGS="$(LIBPERF_CFLAGS)" O=$(OUTPUT) $(OUTPUT)libperf.a
+$(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
+		DESTDIR=$(LIBPERF_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBPERF)-clean:
 	$(call QUIET_CLEAN, libperf)
-	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) clean >/dev/null
+	$(Q)$(RM) -r -- $(LIBPERF_OUTPUT)
 
 $(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
@@ -1055,7 +1062,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifdef BUILD_BPF_SKEL
-- 
2.38.1.431.g37b22c650d-goog

