Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3E6232FE
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKISvd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKISvP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301F17049
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:50:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so169094657b3.7
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDNhPIt4/z9SJ7uwDwdB3T2uKfBtceScPS7ow3Eeh9c=;
        b=HALTwabRTeqIzYg2xWUsMszov/CdFvQk0hIIEeL/AcK32EAM9q84QhHnbVz008nHY3
         JOKVZebfnNR9iKzyrjIyOcWDlfNPtNhl4ck93W/pIAmNlDnr3NeauapCFXAPYEDzIvtp
         0H4H9yacURDsTcSMOOjd+IVyiCH5FIFi6GxSA1GunFz1/EWW/oD+emnblFMWIfcDKNif
         eyQGXIZIQAinyR0d7O5NP4BLFO7Ygx1i6GPQ1h84SY/oGum8pe/ejkzsYR0anmjaOHVn
         HjEUyMZ9xHCau0S2yk7K549RVwSJPH5AFBKngVcSeCpRR6GBzMUjqcvascMCSwUyt+Z6
         PUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDNhPIt4/z9SJ7uwDwdB3T2uKfBtceScPS7ow3Eeh9c=;
        b=W5aaWYjgAmVLEgSJg23Y+IQIJhhUg/DbbtnnF6QnjD2di4uO2iyKxOQZ8GKnwFWgfK
         Qw2KhUn3WWJfZntKi6mQj8oT6ZSLyYa5TdYiDF6Xny0au6OCXkYqbSeBisBA2CZ8SUMq
         wpy8zX4vTfrYR9rkqkP18XelLdUfJ6ypXiLskaxRMmCcGEQTbV7OwSLFW1sjxVI9mMx5
         DRldvCe3QuSQcA9/W+EIyMelu0qIOdPoTosmIoW+UvHMSpMDX5XYjEswpeH4VyTJTqQk
         LyAHPdVyrepNMVFdQAW9IzRSMEzJ/lFgPFLVjmSDQVNvjUaCXOOYO9Rmie0YuhA3kbuz
         qrjw==
X-Gm-Message-State: ACrzQf0diA96qt4PWJC1HKOF6lkEPAZPqB2JunFnnISHBRZremrPJDm5
        0LvWRsrUdQAEDgGyi2ekdkcehAxQ2GG2
X-Google-Smtp-Source: AMsMyM6FTO2X32armDtX3+De/2vmhDy0NZShGOke/PKQ3s72ZThETClUjM776A1o25YdFTpJdeAhrUzm+uBC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a05:690c:a0c:b0:36e:8228:a127 with SMTP id
 cg12-20020a05690c0a0c00b0036e8228a127mr1137236ywb.299.1668019850065; Wed, 09
 Nov 2022 10:50:50 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:10 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-11-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 10/14] perf build: Install libsymbol locally when building
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
libbpf and libsymbol headers are all found via this path, making it
impossible to override include behavior. Change the libsymbol build
mirroring the libbpf, libsubcmd, libapi, libperf and libtraceevent
build, so that it is installed in a directory along with its
headers. A later change will modify the include behavior. Don't build
kallsyms.o as part of util as this will lead to duplicate
definitions. Add kallsym's directory to the MANIFEST rather than
individual files, so that the Build and Makefile are added to a source
tar ball.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  1 +
 tools/perf/MANIFEST      |  3 +--
 tools/perf/Makefile.perf | 25 ++++++++++++++++++++++---
 tools/perf/util/Build    |  5 -----
 4 files changed, 24 insertions(+), 10 deletions(-)

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
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index f5d72f936a6b..c8e8e05b4ff1 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -13,8 +13,7 @@ tools/lib/ctype.c
 tools/lib/hweight.c
 tools/lib/rbtree.c
 tools/lib/string.c
-tools/lib/symbol/kallsyms.c
-tools/lib/symbol/kallsyms.h
+tools/lib/symbol
 tools/lib/find_bit.c
 tools/lib/bitmap.c
 tools/lib/list_sort.c
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6e5e3f7730b5..6c1a2a3ccc38 100644
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
@@ -1071,7 +1090,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
-$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT):
+$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifndef LIBTRACEEVENT_DYNAMIC
@@ -1121,7 +1140,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 47a7db3ad0a1..ab37f588ee8b 100644
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

