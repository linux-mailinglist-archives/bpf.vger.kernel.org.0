Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5E66D12A
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 22:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjAPV6U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 16:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjAPV6T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 16:58:19 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238F1252A8
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:58:18 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n1-20020a170902e54100b00192cc6850ffso20694638plf.18
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im4HZCj7jcJlp9Gtkw1K/6eYSSab6dr0jizMwUKesmY=;
        b=mFNK+1ILDrtb/vjVJyN/aZBKd7qUO6uZIXxu8LzzcKGw5Ri7j+QgXk9p/PCz4MorJl
         EVMHWFmDbMz3lnAIez05n6KoU+vt1PA1OFfclqx2r5xJiiiy3D6noqryXHDQK4v1HAt4
         VQciOtUsTwLOG3/WtnkGd+t4i4A2JNaA4xf9yK6RHDdCSMpQp0lxB4zgyP0BWz8QuPVl
         pPvriRmmAX+7PMhRdm7KgJibuKxi4ncRPl+T9e4VrToftfJfa2FTHjSWf00FtXH23slH
         1HRnZBQUTZmWlQMGRADtdnzUH31FFhVQDHed3cdHNzAA4vRE/m/50h2bRr8hQ1wrPaU1
         YRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im4HZCj7jcJlp9Gtkw1K/6eYSSab6dr0jizMwUKesmY=;
        b=Rhh2Tek5cjPSs6dC1bQm4frVc/sjAYmZEBNe3yE9STTLS2boStAEH3SH/W0QC5JpVj
         /D5DkV7ny4zXvdkveKdeepq275L3pQHaAbbi3XZex3Zwcw7N5E4xzn3Cp8uw00LALSfY
         NZBz+iVQJ1HEQWdxTvZCohlFGgi19ympoW3GK8SXVexCXFZ0QdpHL1QvbvSO3vBH7DPH
         Vw8oEni/aKTcXRPqiJVD+QbvU2D+8iHCLlgxvB3a1+perfqu9a/7W394pzlDIZqIqhl1
         zg/AEumaD0RGBgN0Xqqs6tSgadvK5tw7jtZz5k9IU3foKJPp3hprXCFYbl6KVf1B553u
         fzYA==
X-Gm-Message-State: AFqh2kqOKpJ+uHrOKwVWQUVFXHU42lATRHhEXCaoVllpto01FuKYKAuX
        oeBwnASbN6OcWC+V+C1MAQsj4XzOogRu
X-Google-Smtp-Source: AMrXdXv2ow9rG1ZyEcZ7nZsUDooZYfdUMW5ER9m8esbadYNS7siPZ9cymMsCH6dO7VTabRkj27j2EX/o9u00
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5088:3695:f3a5:d639])
 (user=irogers job=sendgmr) by 2002:a17:90a:408e:b0:229:2296:4be3 with SMTP id
 l14-20020a17090a408e00b0022922964be3mr81847pjg.5.1673906297579; Mon, 16 Jan
 2023 13:58:17 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:57:51 -0800
In-Reply-To: <20230116215751.633675-1-irogers@google.com>
Message-Id: <20230116215751.633675-2-irogers@google.com>
Mime-Version: 1.0
References: <20230116215751.633675-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
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

HOSTCC is always wanted when building. Setting CC to HOSTCC happens
after tools/scripts/Makefile.include is included, meaning flags are
set assuming say CC is gcc, but then it can be later set to HOSTCC
which may be clang. tools/scripts/Makefile.include is needed for host
set up and common macros in objtool's Makefile. Rather than override
CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
builds and the linkage step. This means the Makefiles don't see things
like CC changing and tool flag determination, and similar, work
properly.

Also, clear the passed subdir as otherwise an outer build may break by
inadvertently passing an inappropriate value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 76b737b2560d..515d87b32fb8 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -18,14 +18,11 @@ else
 endif
 
 # always use the host compiler
-AR       = $(HOSTAR)
-CC       = $(HOSTCC)
-LD       = $(HOSTLD)
-ARCH     = $(HOSTARCH)
+HOST_OVERRIDES := AR=$(HOSTAR) CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
+		  ARCH=$(HOSTARCH) EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+
 RM      ?= rm
 CROSS_COMPILE =
-CFLAGS  := $(KBUILD_HOSTCFLAGS)
-LDFLAGS := $(KBUILD_HOSTLDFLAGS)
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
-		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 CFLAGS += -g \
@@ -76,11 +73,11 @@ export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids
+	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-	$(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
+	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
 
 clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.cmd           \
-- 
2.39.0.314.g84b9a713c41-goog

