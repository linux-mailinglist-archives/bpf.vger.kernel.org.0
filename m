Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FE660212
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 15:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjAFO0F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 09:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjAFO0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 09:26:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6218B7681A
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 06:25:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n190-20020a25dac7000000b007447d7a25e4so1961025ybf.9
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=jQ7TMfZ6mTKGiYxELU7dPBP6UAmUuxQp12nnyfHvFquXR1IyQZKdRmpS0Mhza56NGT
         gQ08Oxc+jxPERM20WK5uePhumjytu8aVvUWqGlG8xyTv+AnKtbcwzRo7ATc7veAstRKp
         xUrc0+WMAqnkom2fm8sUbpFm7WuL507emRZnu0m8hxc0UPEyoy9zOtexa4OSlwheSULE
         vbMc+5aOZIHbgp+1muwMCZlRZ8gM8s8nGj7OOpcMveq5PvDGsLv3W+usV70sASV4hunN
         rPM3O2XE2CuozWbLAzgiNvdJb7Ksxapkyt2zhPjW1cHo8PGqXBuFvCsP9NnMwMp1qQsE
         pgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=TRKe5IvC3uz+Ewz4Xw0vaP2VGOAHuN324749ag7OI5F244QnWZ08HkDqJcBbG0d49R
         Kjzt/cGkjQbYseiTvkdC/rJjRpugYLul2Bv4RetVIJJKkn6P67PShgBZbFes3/xzxJF0
         ptGCYw2nWPvtKAJby/3UhmttpwMmFXz84Mkvp5txBwBpMIMPk1GdqK58Cm9Dw8eBEJnm
         hghBch7r5bj3kuHOEX32qvfbj5eXgQdHfibX8+RutXsmyggv21kgOekBPP73eVt07ntU
         vw4B2poHb6Mq7EgVrHwRVuH5FEprgImyXxgVwQqAj1AYUZOhzTQJD0raSAad3xatLd1r
         OoJg==
X-Gm-Message-State: AFqh2kq9zb8oAxd0/jff83+E0jSMNf5IWYN1NB+1ygFv+/b+XegbQLok
        uvRS7qIUZHQ5XBCsmv46fjOsstVOgLZE
X-Google-Smtp-Source: AMrXdXsNGei0vSpM99XUx325C+Rc5uU5k9EeMbxPqJ35LB5KOmm89s3rVH+Ilz/sPOwbuVFTzg0a15Ex65ea
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b317:a30:653a:18e5])
 (user=irogers job=sendgmr) by 2002:a81:748a:0:b0:38f:abc4:fd47 with SMTP id
 p132-20020a81748a000000b0038fabc4fd47mr5945038ywc.170.1673015157713; Fri, 06
 Jan 2023 06:25:57 -0800 (PST)
Date:   Fri,  6 Jan 2023 06:25:37 -0800
In-Reply-To: <20230106142537.607399-1-irogers@google.com>
Message-Id: <20230106142537.607399-2-irogers@google.com>
Mime-Version: 1.0
References: <20230106142537.607399-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 2/2] perf build: Fix build error when NO_LIBBPF=1
From:   Ian Rogers <irogers@google.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
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

The $(LIBBPF) target should only be a dependency of prepare if the
static version of libbpf is needed. Add a new LIBBPF_STATIC variable
that is set by Makefile.config. Use LIBBPF_STATIC to determine whether
the CFLAGS, etc. need updating and for adding $(LIBBPF) as a prepare
dependency.

As Makefile.config isn't loaded for "clean" as a target, always set
LIBBPF_OUTPUT regardless of whether it is needed for $(LIBBPF). This
is done to minimize conditional logic for $(LIBBPF)-clean.

This issue and an original fix was reported by Mike Leach in:
https://lore.kernel.org/lkml/20230105172243.7238-1-mike.leach@linaro.org/

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |  2 ++
 tools/perf/Makefile.perf   | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c2504c39bdcb..7c00ce0a7464 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -602,6 +602,8 @@ ifndef NO_LIBELF
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
       else
+        # Libbpf will be built as a static library from tools/lib/bpf.
+	LIBBPF_STATIC := 1
 	CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
         CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
         CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..4e370462e7e1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -303,10 +303,12 @@ ifneq ($(OUTPUT),)
 else
   LIBBPF_OUTPUT = $(CURDIR)/libbpf
 endif
-LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
-LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
-LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
-CFLAGS += -I$(LIBBPF_OUTPUT)/include
+ifdef LIBBPF_STATIC
+  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
+  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
+  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+  CFLAGS += -I$(LIBBPF_OUTPUT)/include
+endif
 
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -393,10 +395,8 @@ endif
 export PERL_PATH
 
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
-ifndef NO_LIBBPF
-  ifndef LIBBPF_DYNAMIC
-    PERFLIBS += $(LIBBPF)
-  endif
+ifdef LIBBPF_STATIC
+  PERFLIBS += $(LIBBPF)
 endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
@@ -756,12 +756,15 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(arch_errno_name_array) \
 	$(sync_file_range_arrays) \
 	$(LIBAPI) \
-	$(LIBBPF) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL) \
 	bpf-skel
 
+ifdef LIBBPF_STATIC
+prepare: $(LIBBPF)
+endif
+
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
-- 
2.39.0.314.g84b9a713c41-goog

