Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAEB63FFA8
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 05:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiLBE64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 23:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiLBE6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D82D7552
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 20:58:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j6-20020a05690212c600b006fc7f6e6955so3195684ybu.12
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fILq8A5qrz+unrhULUsXFNDjXn/1W1i4JLQUQRTfzvo=;
        b=acO/rNicqUru8CkyXkWALo/Fo2ksQ8hWFQGgauAkCDH9CYAjhXMx2G6uXmAEFKIYU1
         FEDkyb6VhGSOK4t1tK46XWBuCchhlS1aJSGEKIH79Q+G/OhDs4MXMewZmk34Rn8E1vM/
         mSRisawQckSeTp2MkhOMqYTigFB1Z9FMDVqpWaX9U4M39HG23S3FBx4aLE4ndNeqEnCI
         2BRkONxouTflHYDQgx1iDO6qwz3B2MTCqeeRsAc8W36Zm+6Dhabs1ZY+Fmqatd0/KZZx
         M1DWpDDg0SjO4hCaqS04mv5+k9MacTqZ3R0iYJO3mfBnIj0cw0trCdA7okWKg6xa1xsf
         YqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fILq8A5qrz+unrhULUsXFNDjXn/1W1i4JLQUQRTfzvo=;
        b=lhF5cOhyESbZJ0bGfcQoZupvPVhpyntnMU7Kc1mhdXkGUHE7Bmwq4hpnY4TqpgxsbN
         38ZQk2m2ffYrl97JqBo1Eu72zMyXfYHbRmP8s+ATQ6QvrRRhVt7LIM8gzVfL1GYXOgDJ
         Y0YJanBei0SjqeKrT4F5Xh0rZMBiXsA5UYjR7OlA+Rnr5ePDsFm3KkZ52trluX0x4vnG
         4UiKIQ83sh8An1AmA+gTKeHGDLungThgwpVjlR7qbK41O7BRDDQrQ5fb5mAdxlfCd8Qo
         WfN/xQOmjhUM61SMV/om04sHX1Jmn1sEqenB0WjyD+F0Xd/FlKVk7cRWsSM0bjP2YwtE
         ho1g==
X-Gm-Message-State: ANoB5pkWEK5GkirPB5nqlhAKTDAs8Mj9M0xloXN+SUl1TuRmadooRp2v
        I0o39j4tgh51ebPIGjPejnoF76LftVtg
X-Google-Smtp-Source: AA0mqf6J88v0jQ/vpUt8gWXuYLzszh3xJz4A/psqOw9CH17kaOd1Hvy7pJ8mWpeUGZogqM+Y2HcWcehDaIV6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a05:690c:8:b0:391:c415:f872 with SMTP id
 bc8-20020a05690c000800b00391c415f872mr47275258ywb.318.1669957108981; Thu, 01
 Dec 2022 20:58:28 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:42 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-5-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 4/5] tools lib symbol: Add dependency test to install_headers
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
 tools/lib/symbol/Makefile | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index ea8707b3442a..13d43c6f92b4 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -89,10 +89,10 @@ define do_install_mkdir
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
@@ -100,9 +100,16 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libsymbol_headers) \
-		$(call do_install,kallsyms.h,$(prefix)/include/symbol,644);
+HDRS := kallsyms.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/symbol
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS)
+	$(call QUIET_INSTALL, libsymbol_headers)
 
 install: install_lib install_headers
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

