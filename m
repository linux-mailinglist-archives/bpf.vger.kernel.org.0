Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63BB63FFA4
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 05:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiLBE62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 23:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiLBE6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F9A1C3A
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 20:58:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e202-20020a2550d3000000b006f9d739c724so3986100ybb.6
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 20:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iWxq/u3wHgDjVSNkc7auJpnDIRbf8fSfDG5v5JG7J0=;
        b=p5G2cwctgiaHhOcKEGfHNn3gkiZX+7RGSihGS9CjLhPobraLLQn/xF4fLzjZFXt/66
         0W7AeLNNPkWL3AjPRBR7m5+YjiguiI3aRQLD7By6QccvylAS8F+Ppio/3BN+HMetCk7s
         d9tU9f7dFgGC03PLjmZ4wUm6/NrAe29aVLu9qabVlcNXZBWSE3GDYGYqdOuldZt2oe5e
         cPABFaPehhIn3cYz98skSYGWVGrLW5jk3HR9jFJwR3icauA41Qa+LwrJBHdARW1atu38
         KB3kw9ZyAPwPxE+oHsfjXMJfWj16JeX+7UepBi42JfVxnvOLeFgTTpzqg+V07F20tfZg
         LYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iWxq/u3wHgDjVSNkc7auJpnDIRbf8fSfDG5v5JG7J0=;
        b=XSr2kyla/XAev28litSmJe3iNHdfohdYzUvVJFe1cmFEB9EysajhggVlBlW8c1n11X
         LGdMi9LAnyezwUZ1IukDEbt6vZ0CwVhSSjP61SMDGA/s57fxec8A30L/0zpEFBB51ORk
         EA5nItSGEQFCCWG3q/TcA1QNdnAJlhkGxKMYfI/J8yQHU53Y3m/zIF2D80URKMfv3YaV
         lgfHcu+95k3xi4YaoKxjxC8h7xdfL2X1y1/DMhmQniy3Kgn5fHxh47fJpewh2LIQCq1V
         YzTnJqda3pOuETUuo1IUNO79QHhAxaF/fDwecjHDfvIh6UJA14aiywWsnY8ecmXA3aZy
         TTTg==
X-Gm-Message-State: ANoB5pn+dkqhQeMcWda4hj3LTUsSwMBbDUtkJ01llmZVz3cbcDBEwkGR
        IFIeRGADD9eBt4PhzWt3MDmiHTewk9Go
X-Google-Smtp-Source: AA0mqf6Txc45owdcurSb9SkQpULmrEIO3kNLEV9vM2kVhF6t85yIOOogSM+LeckRANUQOiP9fRxokITuZ0eS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a25:7042:0:b0:6f1:8895:e769 with SMTP id
 l63-20020a257042000000b006f18895e769mr37756823ybc.390.1669957094634; Thu, 01
 Dec 2022 20:58:14 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:40 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-3-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 2/5] tools lib perf: Add dependency test to install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

Compute the headers to be installed from their source headers and make
each have its own build target to install it. Using dependencies
avoids headers being reinstalled and getting a new timestamp which
then causes files that depend on the header to be rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Makefile | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index a90fb8c6bed4..30b7f91e7147 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -176,10 +176,10 @@ define do_install_mkdir
 endef
 
 define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
-	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	if [ ! -d '$2' ]; then             \
+		$(INSTALL) -d -m 755 '$2'; \
+	fi;                                \
+	$(INSTALL) $1 $(if $3,-m $3,) '$2'
 endef
 
 install_lib: libs
@@ -187,23 +187,24 @@ install_lib: libs
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libperf_headers) \
-		$(call do_install,include/perf/bpf_perf.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/internal/cpumap.h,$(prefix)/include/internal,644); \
-		$(call do_install,include/internal/evlist.h,$(prefix)/include/internal,644); \
-		$(call do_install,include/internal/evsel.h,$(prefix)/include/internal,644); \
-		$(call do_install,include/internal/lib.h,$(prefix)/include/internal,644); \
-		$(call do_install,include/internal/mmap.h,$(prefix)/include/internal,644); \
-		$(call do_install,include/internal/threadmap.h,$(prefix)/include/internal,644); \
-		$(call do_install,include/internal/xyarray.h,$(prefix)/include/internal,644);
+HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
+INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h threadmap.h xyarray.h
+
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+INSTALL_INTERNAL_HDRS_PFX := $(DESTDIR)$(prefix)/include/internal
+INSTALL_INTERNAL_HDRS := $(addprefix $(INSTALL_INTERNAL_HDRS_PFX)/, $(INTERNAL_HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: include/perf/%.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+$(INSTALL_INTERNAL_HDRS): $(INSTALL_INTERNAL_HDRS_PFX)/%.h: include/internal/%.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_INTERNAL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS) $(INSTALL_INTERNAL_HDRS)
+	$(call QUIET_INSTALL, libperf_headers)
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

