Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5C685CDA
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 02:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBABuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 20:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBABue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 20:50:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195952CC55
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 17:50:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so18085142ybc.1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 17:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdDlsYqmeKUXi1m/okS37mLJa+8YvjWUBaTgXlbztPE=;
        b=NjDYjH9h61xsRUkP1cMK6GH/YJOE/Ugf+FYRQmlIy6/pU9YfGeWWMtVYSz3bSqYFXf
         OnxmZLq6YmvL4A6u3cXYcmfs981RefJnJFfw4TjFSdZYVBSv0D6JkmIRk+slznlJs2N7
         wzUp3xH9l7ir6KMUkp4+oELZU4hUm5VqOMcEyu8J2VVWc7P8fTCsmnM6wDnKa6uJ5yjG
         UOFFlmWkrExXx/yz4nox+NsZ0AZFKmbz20kvR9juq0khDxynOHBQ6jZze+WDohgtCRjJ
         63IdzIR0bEklXdmrsRRUcs8jmr9QaTLq9aeolM21CGZW6xH9ZemOMdjCws8iji17SGHE
         weQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdDlsYqmeKUXi1m/okS37mLJa+8YvjWUBaTgXlbztPE=;
        b=HnMWrOIF/XO+l6/0J9bqD1UMqUtQYUYMyMNbjpxF56VlM6vLSX6Ki52bQsuQnR9vLw
         1xwl7prFNPUTjABuCfX7nZqUM81RpLU1sp7F8gSz9OHJaNzJh7cvqanR4uKbTEiiQyMM
         KfLU/sFTr+neb3ygzvubrjFzyVDTbT0D/nLQkpib3ePpJsjy/mFee2oLELfc0mXAdX5A
         cqNFZNqmTo+VxjXRbwdwQThUkbNuai8x5teyLtjDJIm+4Emq+LJr6t0jEYgJQJ5bkVGo
         oIYnp89j5apk/lJq5xehd8u6tNcIUKFGzIkhzCOcvfT/HFZHjaHwlmQbrVJy08sFik2d
         SnuA==
X-Gm-Message-State: AO0yUKWU3RR5zo05kSuYV2nKiGKlSDEwPo9Yfy7ng7OT6oOvxLtlDG4o
        Ieb22psxB1S9hDD5kx5TR7UzeKuPX+m6
X-Google-Smtp-Source: AK7set+6G7w93iKvh3pK8d4Pn09fp4vjG7pahxdlFvN/m3ZzAOPWx2J7sdTsm/hJEeolIHRv+ZBD+dSqPMMX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc49:772b:8c4f:d691])
 (user=irogers job=sendgmr) by 2002:a81:8d09:0:b0:4df:ab25:431 with SMTP id
 d9-20020a818d09000000b004dfab250431mr52684ywg.312.1675216232233; Tue, 31 Jan
 2023 17:50:32 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:50:15 -0800
Message-Id: <20230201015015.359535-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
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
index daed388aa5d7..c9b6cf1fb844 100644
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
 
@@ -43,6 +38,29 @@ SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
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
+export srctree OUTPUT Q
+include $(srctree)/tools/build/Makefile.include
+
 all: $(BINARY)
 
 prepare: $(BPFOBJ) $(SUBCMDOBJ)
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
2.39.1.456.gfc5497dd1b-goog

