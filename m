Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3766667F8
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjALAlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjALAkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:40:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70939A1AC
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:40:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u186-20020a2560c3000000b007c8e2cf3668so130773ybb.14
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5P/G8QEaO3HyqhOGu82/HAf0R+66PdkPKsQpUDiMlc=;
        b=eGF1F/lrqMAN39cq8nEU49coorNRUqIbHnBryr2InQnzMzIJqVkcu5LPJEwm9N98WX
         XfQXM1GX3/oQQD7WLmDXjPWDDCmAGtUKDrKG+13dIczddfM9NyrDPOxdTaJ2OiHTy7Ua
         VS9swDDP9KM29DD1GKHiBd7AONB27uTqkb5q82XGMSidBRLysjYg3uXSbYpvy2juUbUN
         sW7A3W4icerCbpWSVO1oWTlwIMOejaGAdCDE9GHEg5DWjLyQY0nxgB3zaJCByzx0uRzR
         jg9mAkaclTKJ4T4oUsjzayw971NIw0wGEB9BJkz+K2Ru3FAJQvWRAygLhr+2LU0pZjef
         1gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5P/G8QEaO3HyqhOGu82/HAf0R+66PdkPKsQpUDiMlc=;
        b=gTzz02wVulMtVXx3Mj8x1BMRb1NGNuH/53gbHvDSyiZWMPvLnpGF2c3JHTOLVpFRsN
         e8ehS2WyeBmX4gOS1WJNGwz0n0h6mSEyINZHgEHT1EB9K5G+iFcz3pZzIh3uoLVIRWqz
         gJJXKzdbPWrC1AjPIdg5K8XEJ4Q8yZUVikyzG0+qMhF9bioGL+jrDlRTWRYQ5GRbn47H
         SpH+YgcQVXAgD581aCTVGgIDaP11Lbe5C+sZ/qaUFHcSCZCO/yNi9JafRS/6Xio9ghyZ
         l56GceuHqu1zWDKYga8+wIuzqap7tuSmSlBv6S4Ue9cWoFvu8rd1VLLHtQvbVmhBTbkW
         65ew==
X-Gm-Message-State: AFqh2kqHmcDtR7zCIT/SAA7h685k0Jb+j4Rn3Dfn8h8XnVjBW9Fju2x+
        FqYzoHdBjTauJcakY56tnA4gMYGz8cTT
X-Google-Smtp-Source: AMrXdXundbCb7228SbcR6pwey2fibfqlj3mfadwLRyLe+3nDs49ZYHwTOvs+jqWJ9NNUcMgbYkf+ezMwkHJt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:16b7:1d88:e27f:db49])
 (user=irogers job=sendgmr) by 2002:a81:6f42:0:b0:36f:f251:213b with SMTP id
 k63-20020a816f42000000b0036ff251213bmr1500569ywc.228.1673484043746; Wed, 11
 Jan 2023 16:40:43 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:40:24 -0800
Message-Id: <20230112004024.1934601-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] tools/resolve_btfids: Install subcmd headers
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

Previously tools/lib/subcmd was added to the include path, switch to
installing the headers and then including from that directory. This
avoids dependencies on headers internal to tools/lib/subcmd. Add the
missing subcmd directory to the affected #include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
 tools/bpf/resolve_btfids/main.c   |  2 +-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 19a3112e271a..de7d29cf43d6 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
 BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
 LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
 SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
+SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
 
 LIBBPF_DESTDIR := $(LIBBPF_OUT)
 LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
 
+SUBCMD_DESTDIR := $(SUBCMD_OUT)
+SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
+
 BINARY     := $(OUTPUT)/resolve_btfids
 BINARY_IN  := $(BINARY)-in.o
 
 all: $(BINARY)
 
+prepare: $(SUBCMDOBJ)
+
 $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $(@)
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
-	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
+		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
@@ -60,14 +68,14 @@ CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC)
+          -I$(SUBCMD_INCLUDE)
 
 LIBS = -lelf -lz
 
 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
-$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
+$(BINARY_IN): $(BPFOBJ) fixdep FORCE prepare | $(OUTPUT)
 	$(Q)$(MAKE) $(build)=resolve_btfids
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
@@ -79,7 +87,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.d             \
                             $(LIBBPF_OUT)                \
                             $(LIBBPF_DESTDIR)            \
-                            $(OUTPUT)/libsubcmd          \
+                            $(SUBCMD_OUT)                \
+                            $(SUBCMD_DESTDIR)            \
                             $(OUTPUT)/resolve_btfids)
 
 ifneq ($(clean_objects),)
@@ -96,4 +105,4 @@ tags:
 
 FORCE:
 
-.PHONY: all FORCE clean tags
+.PHONY: all FORCE clean tags prepare
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 80cd7843c677..77058174082d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -75,7 +75,7 @@
 #include <linux/err.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
-#include <parse-options.h>
+#include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
 #define BTF_ID		"__BTF_ID__"
-- 
2.39.0.314.g84b9a713c41-goog

