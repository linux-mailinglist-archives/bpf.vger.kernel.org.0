Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5659D65FB56
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAFGRc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 01:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAFGQt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 01:16:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6FF6CFD3
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 22:16:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4700580ca98so8768887b3.9
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=FD+9b2BC7G6wp1RX4Zlmmp4Hb9G65TpW7cDfR3jRy7lIv397XuI2wMBzLeKhNfG3ie
         gaLrkjp+GuVOyruOeqib5Bk7mY6Lhau5XAg/K55bSJx177ozgbSwJPOPoBAlh6iGM1Kc
         0YuuJ7jeGD3vuqwkLJ97g5cfsbkrg2VoyYi4AxI/sFez/XUp+5lmOTIjDOLeNFxTMNBB
         40w2dm1yuZ8CEPgEtqNtT1Tjw6uPXmh/XkkYT/VMEHUGEyqZ1/YSr+V2qfljgx74gUXn
         RtOY7j2U/cYd9F+nAy3ouNrOkRNNC4Q/EZ6/j+/k5HQRy2zM7bx84B7qMwbyxUl8QZps
         N6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=Yi8YgigdwLw+pV22qHWwlw1fUiB/2vBbWIIoeMzANnQ8OE7PVewIqkXc3kaZZWNN5c
         rHWbLG4PA9ZL5xt6JBYo6UxvorEWTHAdeUV1qApWnGYWrgNF0AAxVFrr1y4EVyqUUwPN
         b9v2XczIFZQjSEXpW3l8ZOmf1pcB4oR6ne3Kez4QnAI04AQYCVAZMekH3+gSMjr1UOBi
         j5BPsNX8YL4U5JdJ/P7FHGrUxcRK4WHmY879zrHzqtdKuPUT4XdZhw6WksXo3xmoIe4Y
         N/e4KPzDPqjdcz4b2vKCifBkDPOp0guEHbeaqKMF12vtMtw04LYhlcqwcjgW4bB3uNM3
         LyUA==
X-Gm-Message-State: AFqh2kosZtiaEKWH7gxRC9ZlGRqEpQiND1neTQKCsETb+XiDy9gGXzt4
        DzdY0RKKVAZ8oKHD6VvLwVEw8sqdyYKv
X-Google-Smtp-Source: AMrXdXuEa+hE8IGo8QRTwe0GaP5vmgi2S5IZ46ckdBfVNuEnI5WR/9UKlq3NfjLxAuttGhumPk5/Ks0kVfSA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a05:690c:841:b0:480:274c:bfac with SMTP id
 bz1-20020a05690c084100b00480274cbfacmr4305130ywb.104.1672985803154; Thu, 05
 Jan 2023 22:16:43 -0800 (PST)
Date:   Thu,  5 Jan 2023 22:16:31 -0800
Message-Id: <20230106061631.571659-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf build: Fix build error when NO_LIBBPF=1
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

