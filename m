Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F96674104
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjASSbm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 13:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjASSbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 13:31:40 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0875A18
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 10:31:39 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o15-20020a170902d4cf00b00194d05746aeso1180780plg.13
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 10:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyXhvPvPbADpaSv/EYaQvarEBuQZacwnWp/5FIvc94s=;
        b=dUXnT88TH2X/cpMgLnC/jDim2bvVeneZtEmqqSsTVO+h3X/PsM+8YkeiPvU8ZQevzK
         Zn4T2ff7XcwlgxMq6h9V5y2e3yHL+hYcJZ/ojweALCJFZICxQl8Fsy3e+fZ2yAFMj2gl
         K1kmwYEsi1V7TNTsLu+fyq4tEgA6H1KjmzyksYGbA0TG5R2RDMOxtEN8jNIXvLmB6Fsp
         Lq/pLiQAnxNuvSPRsfzFvj9lcp1BCon/lS5gVIy/b/INatUUqVF9IcxCv/H6BxuPFLFI
         xbgAQEzjCQwJcOkE0tZR4SgoVqD0CH9QMwJzoTZChK1QvzubxA4nmkGwN3cFaoQOkSeO
         BzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyXhvPvPbADpaSv/EYaQvarEBuQZacwnWp/5FIvc94s=;
        b=gryXdOjnRzEbOu/TW0e/nTfo4hkq9ByPNHe38AjHG55bvngIDyYC0vbPtP9X61YtEc
         LgtqrIQlIbyVgGES+MX1YkORGRY160V5ogBYn+lvtEnZC5i7BYa511qqHDXqnlBVrq3v
         OdC8fYtxd6K6rG5LFJDj79xMoJBdsFxqdjVbqgH65twjA58Z/v9gLcJ8crTmj8RzkvCS
         NPro/hSR13FD27+LQcHN2b5M4F15yZdWdrmGBKDZtmzxXUGYZSz8pVVEJjLiLNckhQ60
         WLkAQIdJwLeRhaynDQY4bo77C+gu8CIspGpB4qjKg5YZoIWZCw71FkxX6nwHxeoQ4Qom
         ak6w==
X-Gm-Message-State: AFqh2kqg8sbGqVPUY1PxUOQPTGpnKElSmC1/Cn2Sgs6+iNm7kqTGLP+/
        R0bROPYOmoZFtjFFAfJtIf5D9I8VA9sQ
X-Google-Smtp-Source: AMrXdXvlXtBxk9hh9EaucGVFPSaRYxAfCvKM4hryIGhpEvBoWdDLNvcI5VBW2IwQu9pYeY+rKvQ5G2EtAKOX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:93c6:b65e:5f33:bc6b])
 (user=irogers job=sendgmr) by 2002:aa7:8f95:0:b0:58d:a316:b578 with SMTP id
 t21-20020aa78f95000000b0058da316b578mr1125043pfs.58.1674153098798; Thu, 19
 Jan 2023 10:31:38 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:31:17 -0800
In-Reply-To: <20230119183118.126387-1-irogers@google.com>
Message-Id: <20230119183118.126387-2-irogers@google.com>
Mime-Version: 1.0
References: <20230119183118.126387-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 1/2] tools/resolve_btfids: Install subcmd headers
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
index 19a3112e271a..76b737b2560d 100644
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
+$(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
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
2.39.0.246.g2a6d74b583-goog

