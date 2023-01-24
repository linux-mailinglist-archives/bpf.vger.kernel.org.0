Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A1679131
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 07:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAXGni (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 01:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAXGnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 01:43:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D71327D55
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 22:43:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4fa63c84621so143618377b3.20
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 22:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrTgrRLylW19wsfnugIU2K6YrtxXGRZd048ZOU/pB04=;
        b=pGDB8zVceKFlAS71Zz2UIMzSTQ4gkNUHMXGEOOgIEFvWN0QfHGKR1EV33cVWAkWQjG
         woDMqzbLFCY1E6XDLMmnBI8JsnCKPKPe7xTszD9MYDJHzAQlYwSOrNHCHirqLCQ3XU8+
         eCogsW/0aUEBQdO048bEyFvtiyWf589/HKoMeunnD/cqQOWpFkohB0DCWwvJcJn99SmB
         FKFQl98vRJxPkJ4BG/3UqE9ggBKNZXP44erXVR/8H6dmdGQYQn/61LsfLWhgnkyq5Dxn
         R3HWjl+s6baDiEDgWU0SJ6bqr41FZZ2rV8v+w1CV0kL1mSgTnWXbKHpwuAIu2xjbugpu
         wNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrTgrRLylW19wsfnugIU2K6YrtxXGRZd048ZOU/pB04=;
        b=USWG2FJ2S89Zg0ZZ8iv7qLwmTqgSwdeo0FzSLJXynLwN6oICmcwbGCPMhH6L7G5Csq
         yvSFiTLwlO15qXbjr4gIQk1KVmtBsRm3REUsNnaKqMoJpr65j4OQqbh1xysLtlb8so4I
         R67idZs7grRpE3dug+up43Qxs29GgK/aIVrKgEItGqE7XDKCAjPhxCppm4QZ1PGdl8XQ
         2d32uQ5K1/l6i+OpPC5SviIWfuQY+E8GbRfcQ3g5KiKMe2u222InoqGr6XTF3qic8omc
         k52jzgFnz6fDBXUAbiBrQiHN6PGZExvrmyjaieAXF5vr7z/6oA1MN546BTIpChTnas7T
         1vpw==
X-Gm-Message-State: AFqh2ko2Rq1il4/Lcz4s1UqamaZ0LIYWbNy4QLQVL5Ln1ZgIJWTHmziA
        EikSrf6/il/f+LLe59OoeJM09Di7Un7z
X-Google-Smtp-Source: AMrXdXu7sfn5ygCbiyFGXP1ACqzBFw2leq+yHhsBrzUhl/zVPTuZ0/Vo0X3uKu3r8+1yk07nvO3wXfbK21H4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a81:7307:0:b0:464:4ea1:3baa with SMTP id
 o7-20020a817307000000b004644ea13baamr2791679ywc.302.1674542615810; Mon, 23
 Jan 2023 22:43:35 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:43:23 -0800
Message-Id: <20230124064324.672022-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v4 1/2] tools/resolve_btfids: Install subcmd headers
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
index f7375a119f54..1fe0082b2ecc 100644
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
 
+prepare: $(BPFOBJ) $(SUBCMDOBJ)
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
@@ -63,7 +71,7 @@ CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_SRC) \
+          -I$(SUBCMD_INCLUDE) \
           $(LIBELF_FLAGS)
 
 LIBS = $(LIBELF_LIBS) -lz
@@ -71,7 +79,7 @@ LIBS = $(LIBELF_LIBS) -lz
 export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
-$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
+$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
 	$(Q)$(MAKE) $(build)=resolve_btfids
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
@@ -83,7 +91,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.d             \
                             $(LIBBPF_OUT)                \
                             $(LIBBPF_DESTDIR)            \
-                            $(OUTPUT)/libsubcmd          \
+                            $(SUBCMD_OUT)                \
+                            $(SUBCMD_DESTDIR)            \
                             $(OUTPUT)/resolve_btfids)
 
 ifneq ($(clean_objects),)
@@ -100,4 +109,4 @@ tags:
 
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
2.39.0.246.g2a6d74b583-goog

