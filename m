Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679236602D1
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 16:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjAFPNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 10:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjAFPNn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 10:13:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80E281119
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 07:13:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-434eb7c6fa5so20795967b3.14
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=b1woKxlTxDe2aMky9Gxycj7tdnYGqz4wHF+OS3uMz1LMlDeH1+FDNBZHw6QGRgHJbE
         8KrRqouh3zKL51ld/RXy0PvPwQ/BNTrQ3mOLgjhTT/8rXpw2ZFVBzsfIzg8d/8Po1Usf
         zcdtFlfNIb+0vGlczu0pDF7irJQLaScldPBTyI7U4131OMwmPcYr88HTkl+JM8Xq+yMH
         KcLDUd1Cw0RU8ccBM+008GgZ6idhgM1U+quqBNoEc1SU3z+gAaPQJZgfpbvtJQfM902M
         9k1c+/R5CXLIvrS945izzUudap5Gvqigac4ZN/JCC6w5tg/19v8XvJDRQJnZEjbd/u2F
         tA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=oFCxvw63bs8+oq8eO3K5uYT+f80Oer4HPTs/c4b4FybZskeBEHcQk+u84pvXCKvb2C
         6zNOgvoDG/dDdr7Pu10re5Ip6w4ztPQ9+06uyNUvJDPT8gHae3RfSP0K6PoXdvjiBFdr
         TWQ67e8XnuWAcBXtx7QS7YpgDsZjvYnc5Dusacdm2O8Sl7gtRaMJlWMB/6/XGddPO1qX
         Ecj4b9zayxO57mBgUfBSe/z5Jp9NNGtWZa74J/BxIQQRmwV/AfKcp1GQdEZRjXl4KtqX
         oWS4ol734wsJrxpQAuOr0SD3pWp4Dn6WzYgYozHhHbzR2NXib0BAWtzvBgspfviar5tq
         Q+SA==
X-Gm-Message-State: AFqh2krTqDign0qjABfMBJUx7puW6LyWUSeNUmELTkbKVaObJ5JsP1vS
        oOnJXuYlXKgdKBbRCl5zRfwrxfLry3SF
X-Google-Smtp-Source: AMrXdXvOmlZdfXY1yS0XS9Kwv3Fztvy4P5OCtKpH7XLsXyDAs64NyLwnS9FfEtbqBZEWbJ1J9cMhjXaXt1kn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b317:a30:653a:18e5])
 (user=irogers job=sendgmr) by 2002:a25:5144:0:b0:753:4db:6fcc with SMTP id
 f65-20020a255144000000b0075304db6fccmr5824670ybb.1.1673018022074; Fri, 06 Jan
 2023 07:13:42 -0800 (PST)
Date:   Fri,  6 Jan 2023 07:13:20 -0800
In-Reply-To: <20230106151320.619514-1-irogers@google.com>
Message-Id: <20230106151320.619514-2-irogers@google.com>
Mime-Version: 1.0
References: <20230106151320.619514-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v3 2/2] perf build: Fix build error when NO_LIBBPF=1
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

