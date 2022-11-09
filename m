Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980896232EE
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiKISuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiKIStx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D615A04
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:49:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j132-20020a25238a000000b006da635e2073so3900310ybj.2
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5rlVN6/O6ud7i+l5M9N1PAvZ4u3YCtftz8CMo8WwgUg=;
        b=Pst/p+SP8ArcizzeOdYdK9oukzMegssjv7eyFFIkdPoKsMYGFPyXLfm8/N3yKz+Vg0
         dofEvx2C47DeVsYgMsn+nVEIbAtw1JV1f6PvghnjZTJyc4RCQPuYzthPbULPeV5BkNlW
         7tdsXn8yMObCUNvAHoF4zUDu8S5kfbCtASnfyjRSysdKlZgKxPMn1ImFwAqHGLmPP8Ab
         c/+JAdlA1YWOjP0+BNI+36fDq3Ix0jkJn2/OcN1mIH/lwnEL/j671IHrkuJzq208f55s
         iBvcaTd0fcxFSuKfVJGMTDFu5eoZbHdGHDaF3H66ecowF1Ra7zWCiw43fisERT0s4bJD
         HIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rlVN6/O6ud7i+l5M9N1PAvZ4u3YCtftz8CMo8WwgUg=;
        b=G/6aMwLiR5ULSZlwFeB9A4N4iZ1gSTho6ia7NI5aBCL2XgrMMa/3aVKwQIac+Ghiz+
         pKBpWFukGeQ2QpkR7z7RhWTWtwcuYhbceDG6nuLKhVQ8TJsT+HlDE13kZG9/wgJL/dv6
         eahFz2Xb0aAVUShUR11PAvSR7pmqv1bjee3pz6fEEcp5s2Kv9DVn/faV3MKGyyYW8NDP
         XfuuSIGzuS+09Uj+Qu1fktRmwlLQBnEaVo6hUKiCx+m7Uz/FTNRXfEpv+BqRFnV8kT+R
         ZvrytxaJLxF+JuaKuEiepfJ6Q+6RVgTKrpsNcJ8ypnm6Yqjt514MMCiZY/BjQ7eSmgMb
         dsWg==
X-Gm-Message-State: ACrzQf2VK2bYSlPrbAwpuPWWdCFHtC9J2Kw+E0UuU/qaxk0LDqvCrVpm
        hND5UX/EL0yxix7Zh5NimohDD+Splbm9
X-Google-Smtp-Source: AMsMyM5FcLGFT2SQkb9U591ISwR4jLJ/1QbGCHi79LiEXj+dda25rXAZSNpQdxvhrJjSlu0xPw7nHT3Wk+Gt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a81:f04:0:b0:36a:d4bf:c187 with SMTP id
 4-20020a810f04000000b0036ad4bfc187mr56341249ywp.208.1668019788911; Wed, 09
 Nov 2022 10:49:48 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:03 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-4-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 03/14] perf build: Install libsubcmd locally when building
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
override include behavior. Change the libsubcmd build mirroring the
libbpf build, so that it is installed in a directory along with its
headers. A later change will modify the include behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/Makefile.perf | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index a653311d9693..626f5dd9a037 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,7 @@ pmu-events/pmu-events.c
 pmu-events/jevents
 feature/
 libbpf/
+libsubcmd/
 fixdep
 libtraceevent-dynamic-list
 Documentation/doc.dep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 67819f905611..4ec6b95a1c49 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -244,7 +244,7 @@ else # force_fixdep
 LIB_DIR         = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
-SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
+LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
@@ -294,7 +294,6 @@ strip-libs = $(filter-out -l%,$(1))
 ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   PLUGINS_PATH=$(OUTPUT)
-  SUBCMD_PATH=$(OUTPUT)
   LIBPERF_PATH=$(OUTPUT)
 ifneq ($(subdir),)
   API_PATH=$(OUTPUT)/../lib/api/
@@ -305,7 +304,6 @@ else
   TE_PATH=$(TRACE_EVENT_DIR)
   PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
   API_PATH=$(LIB_DIR)
-  SUBCMD_PATH=$(SUBCMD_DIR)
   LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
@@ -332,7 +330,14 @@ LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
 
-LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
+ifneq ($(OUTPUT),)
+  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
+else
+  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
+endif
+LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
+LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
+LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
 
 LIBPERF = $(LIBPERF_PATH)libperf.a
 export LIBPERF
@@ -849,11 +854,14 @@ $(LIBPERF)-clean:
 	$(call QUIET_CLEAN, libperf)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) clean >/dev/null
 
-$(LIBSUBCMD): FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
+$(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
+		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBSUBCMD)-clean:
-	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) clean
+	$(call QUIET_CLEAN, libsubcmd)
+	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
 
 help:
 	@echo 'Perf make targets:'
@@ -1039,7 +1047,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBBPF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifdef BUILD_BPF_SKEL
-- 
2.38.1.431.g37b22c650d-goog

