Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A5620A50
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiKHHhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiKHHgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783718E39
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:36:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37010fefe48so129837307b3.19
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWHBnleM/U+ALy+KZuJ6Xy7hOJ7pkM7npKBk7OqW5V4=;
        b=D8qndW/cQLD55TMxBie/sblq1Jb5A2qhrqh1hSKQ5uTr300QOnou6RNSlnNfDdVkaK
         om6LuWKDEgv0Wp9dRiI3Q5+QLcKIUfFjJeODPcWvs+tKJcci/xJewQrY0vUSKG40fLHg
         8R/19PebzLeYbknSDk4WeFEJt/0Blrl0LUcIvrOJgvLyQr7sFFhUsOfF3zNVGTtl5wId
         L6d61KnxC0StQ+18muwJ7H9aPnTHXUNR0kLRwo1wK1LmsY2HUsb9VdcAD/kxEb/7Id64
         zLes4pTIRE05zL4cfzMIRAGo5iHQpEihSq7hYYiHi8P95gRyidxkNfXuqQhuRge91c+T
         MSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWHBnleM/U+ALy+KZuJ6Xy7hOJ7pkM7npKBk7OqW5V4=;
        b=fdjv55f8kdBdqeQn8IjY5qeI07p6jO1OxnYQwERBX/+M4fywN/01a7frSU4dqkXdlF
         PBO2QG6eJX0gogZYXaEh/KcCHluim3WSwT1GPV/AZRasTtJn0m/Gs8PCrOxfUqXaMWvB
         zlZhWxfwlb7vnyW4qM5n6OO15JMlbHS4SsGNWgu+DCbCbXgFB6Pmat96xFCK0C4DBs7c
         JMhNZ2RUUQZRQVcAKTDLNC3VumJrzz8EZ8HA7eaQORkSgNbc1i2Fy4i5HuODWZnG1p0W
         9eQ2P1c83XJH6XWhK/DTXTmTz3iMimmGd0N2osM2fTba7tlPwqRGZjISvBjCp4m5KKGV
         ZDQQ==
X-Gm-Message-State: ACrzQf2W4t+/OaMXl3mxLTgniucpHFUmLfPJA8vxq2XoOuyAdgtl4TxY
        qVE7Vu+jul2dFfHC9GP4LxQgpN+r2f9J
X-Google-Smtp-Source: AMsMyM7382PvVJzIVODHvjv7rbwxkqCcP0Qk7qOaP8pLrcAp+pLOXutt138aJypueQIQjjK+su/+kPSRMeMW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a5b:110:0:b0:6be:3546:b761 with SMTP id
 16-20020a5b0110000000b006be3546b761mr53163291ybx.203.1667893011731; Mon, 07
 Nov 2022 23:36:51 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:14 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-11-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 10/14] perf build: Install libsymbol locally when building
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf build currently has a '-Itools/lib' on the CC command
line. This causes issues as the libapi, libsubcmd, libtraceevent,
libbpf and libsymbol headers are all found via this path, making it
impossible to override include behavior. Change the libsymbol build
mirroring the libbpf, libsubcmd, libapi, libperf and libtraceevent
build, so that it is installed in a directory along with its
headers. A later change will modify the include behavior. Don't build
kallsyms.o as part of util as this will lead to duplicate definitions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 25 ++++++++++++++++++++++---
 tools/perf/util/Build    |  5 -----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 65b995159cf1..675c03ec1f1c 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -42,6 +42,7 @@ libapi/
 libbpf/
 libperf/
 libsubcmd/
+libsymbol/
 libtraceevent/
 libtraceevent_plugins/
 fixdep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 537ac7055a35..1d90d78303b4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -246,6 +246,7 @@ LIBTRACEEVENT_DIR = $(srctree)/tools/lib/traceevent/
 LIBTRACEEVENT_PLUGINS_DIR = $(LIBTRACEEVENT_DIR)/plugins
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
 LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
+LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
@@ -340,6 +341,15 @@ LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
 LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
 LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
 
+ifneq ($(OUTPUT),)
+  LIBSYMBOL_OUTPUT = $(abspath $(OUTPUT))/libsymbol
+else
+  LIBSYMBOL_OUTPUT = $(CURDIR)/libsymbol
+endif
+LIBSYMBOL_DESTDIR = $(LIBSYMBOL_OUTPUT)
+LIBSYMBOL_INCLUDE = $(LIBSYMBOL_DESTDIR)/include
+LIBSYMBOL = $(LIBSYMBOL_OUTPUT)/libsymbol.a
+
 ifneq ($(OUTPUT),)
   LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
 else
@@ -398,7 +408,7 @@ endif
 
 export PERL_PATH
 
-PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
+PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifndef NO_LIBBPF
   ifndef LIBBPF_DYNAMIC
     PERFLIBS += $(LIBBPF)
@@ -887,6 +897,15 @@ $(LIBSUBCMD)-clean:
 	$(call QUIET_CLEAN, libsubcmd)
 	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
 
+$(LIBSYMBOL): FORCE | $(LIBSYMBOL_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBSYMBOL_DIR) O=$(LIBSYMBOL_OUTPUT) \
+		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= \
+		$@ install_headers
+
+$(LIBSYMBOL)-clean:
+	$(call QUIET_CLEAN, libsymbol)
+	$(Q)$(RM) -r -- $(LIBSYMBOL_OUTPUT)
+
 help:
 	@echo 'Perf make targets:'
 	@echo '  doc		- make *all* documentation (see below)'
@@ -1076,7 +1095,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifndef LIBTRACEEVENT_DYNAMIC
@@ -1126,7 +1145,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e315ecaec323..45f3d2723725 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -19,7 +19,6 @@ perf-y += perf_event_attr_fprintf.o
 perf-y += evswitch.o
 perf-y += find_bit.o
 perf-y += get_current_dir_name.o
-perf-y += kallsyms.o
 perf-y += levenshtein.o
 perf-y += llvm-utils.o
 perf-y += mmap.o
@@ -294,10 +293,6 @@ CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
 CFLAGS_arm-spe.o       += -I$(srctree)/tools/arch/arm64/include/
 
-$(OUTPUT)util/kallsyms.o: ../lib/symbol/kallsyms.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
 $(OUTPUT)util/argv_split.o: ../lib/argv_split.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-- 
2.38.1.431.g37b22c650d-goog

