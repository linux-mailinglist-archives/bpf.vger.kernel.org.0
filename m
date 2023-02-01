Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D03687083
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBAVjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 16:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAVjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 16:39:06 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50DB45887
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 13:39:05 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y5-20020aa78545000000b00593b071cb99so5775384pfn.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eWU8Wf7WbCcdizUxk2H/YR69JsIuzZin0dIPZlloMMk=;
        b=FU10G6B2+g9PzMzxfpNRiJeGnptAYcIp2QvBjqv54BJ8V0CMq8ioLqV+bcgZKZygN/
         LbE5TUOUL7I/hrmjkXpdFefjT3jlkt/JqliZ39r+oQZDBIK5J+uKJ8WJO3idqyeIBAWM
         ZtNCgOk5r8ehN/tZYHYhwVuSlG4uVNGUI97d6wIB+FSQSVcCa5ZiMqUwcjHjSj6eOCWi
         WEq80wbWukPJ6IZC/r+lhEWHitEOokI+oSmy0JmwB3LYYCiWsOviHL3UDUeLumcfycLB
         peokXOcAaAPbPOkEnlxL9lvw9+2jrHzBhSjIcm92iE+dg0izLDV1LQ7XfRRajfLzy30E
         xhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWU8Wf7WbCcdizUxk2H/YR69JsIuzZin0dIPZlloMMk=;
        b=wfV1ERiEk/0vk1OhqxdWka9HehVxCCjc4tuugJVGK3D6A51RNDdVHpLEXSYK2YOw2u
         45kTD9YcPWznqy2yxTShkPx6i9ujeabte5I7YEzLQKpp6iopP3xEp8YNCCYO4OFbYsU1
         R0mxAPmKvliy/jDsKRwZ9uCT382DEjmjJRr7+IwkCIvS+LuqNHzDvQXIm4Tkzn1+/i8S
         E8NBlAndklyZjXivQoBTF8bJOxzq8dGauovqBRxanuYbg1u/ro4Tl++76qpIbSaK5NVO
         6xvoXGs++JdSLATFAv4vn7DD9AA7htWf7y/fHLJBmKC7rrwEGjfrkPQXIFADhAxUrOvH
         rvKw==
X-Gm-Message-State: AO0yUKVBeHrU2mHrKD+GVd+oTg4BQ9C707ACEQL6hPYc4doXE2gY3/lh
        VtXA5mcPXTLpPuaJ0BP5oLwfJUGahzpH
X-Google-Smtp-Source: AK7set9BbgO121BEF+Z/LkN0vPEKX//rAAjGkQKPjEBy1YhfvQx3CJV4XbVdAyFrvItrLSGSnpVCfGE0oeOv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9560:c385:78a2:6c0e])
 (user=irogers job=sendgmr) by 2002:a05:6a00:190c:b0:593:a079:639a with SMTP
 id y12-20020a056a00190c00b00593a079639amr969510pfi.44.1675287545401; Wed, 01
 Feb 2023 13:39:05 -0800 (PST)
Date:   Wed,  1 Feb 2023 13:37:43 -0800
Message-Id: <20230201213743.44674-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v2] tools/resolve_btfids: Tidy host CFLAGS forcing
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
HOSTCFLAGS for submake builds. This fixes problems with cross
compilation.

Tidy to not unnecessarily modify/export CFLAGS, make the override for
prepare and build clearer.

Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 49 ++++++++++++++++---------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index daed388aa5d7..3ed4e3be4e06 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,12 +17,7 @@ else
   MAKEFLAGS=--no-print-directory
 endif
 
-# always use the host compiler
-HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
-
 RM      ?= rm
-CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -43,8 +38,31 @@ SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
 BINARY     := $(OUTPUT)/resolve_btfids
 BINARY_IN  := $(BINARY)-in.o
 
+LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
+RESOLVE_BTFIDS_CFLAGS = -g \
+          -I$(srctree)/tools/include \
+          -I$(srctree)/tools/include/uapi \
+          -I$(LIBBPF_INCLUDE) \
+          -I$(SUBCMD_INCLUDE) \
+          $(LIBELF_FLAGS)
+
+# Overrides for the prepare step libraries.
+HOST_OVERRIDES_PREPARE := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" \
+	  ARCH="$(HOSTARCH)" CROSS_COMPILE=""
+
+# Overrides for Makefile.build C targets.
+HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \
+	  CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS) $(RESOLVE_BTFIDS_CFLAGS)" \
+
+LIBS = $(LIBELF_LIBS) -lz
+
 all: $(BINARY)
 
+export srctree OUTPUT Q
+include $(srctree)/tools/build/Makefile.include
+
 prepare: $(BPFOBJ) $(SUBCMDOBJ)
 
 $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
@@ -53,31 +71,16 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
-		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
+		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES_PREPARE) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES_PREPARE) prefix= subdir= \
 		    $(abspath $@) install_headers
 
-LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
-LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
-
-CFLAGS += -g \
-          -I$(srctree)/tools/include \
-          -I$(srctree)/tools/include/uapi \
-          -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_INCLUDE) \
-          $(LIBELF_FLAGS)
-
-LIBS = $(LIBELF_LIBS) -lz
-
-export srctree OUTPUT CFLAGS Q
-include $(srctree)/tools/build/Makefile.include
-
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
+	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES_BUILD)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-- 
2.39.1.519.gcb327c4b5f-goog

