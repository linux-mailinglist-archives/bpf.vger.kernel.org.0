Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0684263FFA2
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 05:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiLBE6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 23:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiLBE6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE6A4313
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 20:58:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e185-20020a2569c2000000b006f28dd5da75so4022467ybc.19
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 20:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGokNFaqiWO8B2J/T6MZZ4ADWJYF/iSbGD5+uCgO7sc=;
        b=gL8o14UrQviMjz6ojWwVm9joeKIp5dL9zqvEgl2iI/RpvbLfvzb/sOzg1Xl/ZpCenS
         lcAhj5PIsQgKEfWWxPPNjoSNJRH4u2Dovx3VEp6Jr5HtV0Tcm58LsJeJcggxHlp/cPbZ
         6YeaiNKyJNPW3kujOi+DMFUiwbGcs2V4J0/qKcXQ+2/TrB69zNZT5hHSPYqgyV4v1JZu
         9vCvjBMVHDD5YEaHwXI3ll3jUOcSFG3OozsCxyyAOg9AgImeDl1zuXJdhZ0Sk7aGS7Rr
         TIv1777uLKu6IwikLYMY9ozGV7d+CbAc1fPwyqSNXBhB7q/s0jobbK7pM1pfJYjqx8vl
         IgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGokNFaqiWO8B2J/T6MZZ4ADWJYF/iSbGD5+uCgO7sc=;
        b=rBOF1mFNEeG3idnGBOEZKMFKYGPXnasiEeFodQQBwBE+eaE7gDn1LftoAdlqovjuug
         GH4TCVRRFE/n0QeR9VSDkUlZW6igq6fT2yAfjlBJ68WrZ8/q5/j4wfY02v1ZED/4CxY3
         B2avFDVQn8icpj2jM/PbVTOthEhiq/HMMqA8rtbuQGNy9paHyCxsVw8RBzwIa4oBoVie
         xxUMP3YOWbYWpdVKSbwFsgjjAZ4HT5z76ToYkrLVabLM1UfOrdY2uL4KrBwIhc3DgZDT
         LmigyStl5nFzP1qRd2TT+PQitpVtTDCYsA9K3pjlbnmbl6Gmomskb5a16B7HpRl/p2QK
         733Q==
X-Gm-Message-State: ANoB5pnuORxSUPKTzKQpxfLRYBJf3IqJJxUIYPZ96KhiYm3nmWApmdYk
        v2biNjQ3K1F7N1xC52pk8bEEGhJ1iU9U
X-Google-Smtp-Source: AA0mqf6z9fKITJHvlB/H9vw43T/f3pHyeTs+f7lE9UyAISJ4rgD5H4TeWp1z3V1R1NpqhZblvkMdNlmwjEvO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a25:ca58:0:b0:6f4:3ced:f7f8 with SMTP id
 a85-20020a25ca58000000b006f43cedf7f8mr28634915ybg.489.1669957086560; Thu, 01
 Dec 2022 20:58:06 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:39 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-2-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 1/5] tools lib api: Add dependency test to install_headers
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
 tools/lib/api/Makefile | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 3649c7f7ea65..044860ac1ed1 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -88,10 +88,10 @@ define do_install_mkdir
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
 
 install_lib: $(LIBFILE)
@@ -99,14 +99,28 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libapi_headers) \
-		$(call do_install,cpu.h,$(prefix)/include/api,644); \
-		$(call do_install,debug.h,$(prefix)/include/api,644); \
-		$(call do_install,io.h,$(prefix)/include/api,644); \
-		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
-		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644); \
-		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
+HDRS := cpu.h debug.h io.h
+FD_HDRS := fd/array.h
+FS_HDRS := fs/fs.h fs/tracing_path.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+INSTALL_FD_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(FD_HDRS))
+INSTALL_FS_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(FS_HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+$(INSTALL_FD_HDRS): $(INSTALL_HDRS_PFX)/fd/%.h: fd/%.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/fd/,644)
+
+$(INSTALL_FS_HDRS): $(INSTALL_HDRS_PFX)/fs/%.h: fs/%.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/fs/,644)
+
+install_headers: $(INSTALL_HDRS) $(INSTALL_FD_HDRS) $(INSTALL_FS_HDRS)
+	$(call QUIET_INSTALL, libapi_headers)
 
 install: install_lib install_headers
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

