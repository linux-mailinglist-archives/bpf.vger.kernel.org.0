Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802760605C
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJTMh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJTMhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12265495C4
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so2219707wmr.2
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwBcXEdZ0bwNQEQkHCPZ0SYXvbbBEOobN7rGFCnE0t8=;
        b=rPYOO+ZPvSnE+WW2aBWc5QyV5/Ez2emewree60lbS76mGBNwSTQoLt+Nxo9PkMlg5B
         wSF+88tlniJrbtLFZ4b4kqRnFwc8cZHJvXuLFCDsn+olHFWtzqquQ2g+OYAeGpWWdTgm
         1PigaWIqIGc6RKWiW+R8KqQvRrlnYi7v7rZQthvGOMuAKMBvPbTRGJvDQfrTvMOjv3cl
         XwXZHgbaTOL+T5ZQIPk8vbCOa/4fhZgtw0OhW/q3jwraXp+MSQOYrBpZ8Y89MFru8mgw
         4S9SYuUIO+1ctH0NWbkY+Rhx6NQuVJxB50R+cLvMKGGZzTy4A9ACZWuGHpi+HEaP3nU4
         saSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwBcXEdZ0bwNQEQkHCPZ0SYXvbbBEOobN7rGFCnE0t8=;
        b=vRTj4PUgLSudzqm/AHIuRh1JWB8PkD8QVf3PsouAFGGHcZfJZjqsCpVvJPp3mn8O7F
         Sld8RBsnSiLuooUeI+XdCyQ/FKoIgotsSalkGDrdzoaVuH6e88tjjhAZODBLx+3DPQlj
         PJudfw420m7aFN7KkpwNomL32WWgukLZDVaizX0XbJ8QI2RFDMxwn/Km/tA2BJF5I2Z5
         lhJsCP9ph2NpcnfM4rj+avAOoS/JGZBoA6I/4C7Mkg3uZ1VDMTtk6iKoFpuI0z5K7fQU
         6WsT44hjdAfG0lnPcgZoPqZynpLpbfBSWT4bqj90pJWJe4g9JZwXfs5PUVrsPuwrTtW7
         mcVA==
X-Gm-Message-State: ACrzQf0aR3El2aTcGP57qIP8XUU9TAAU95Q4J11BTJXoX5XhxjN9hhfZ
        vLz7PjO0KzfYWBz5wQJxXEP/ww==
X-Google-Smtp-Source: AMsMyM7QOTuCOC90uy7lWYb1z5U9woT5zewUp5PRRFJ1jY8w7kFCMa9RDpFdztd53UtTuKakDnDlqA==
X-Received: by 2002:a1c:f20e:0:b0:3c2:5062:4017 with SMTP id s14-20020a1cf20e000000b003c250624017mr29276700wmc.175.1666269442396;
        Thu, 20 Oct 2022 05:37:22 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:22 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v3 4/8] bpftool: Group libbfd defs in Makefile, only pass them if we use libbfd
Date:   Thu, 20 Oct 2022 13:37:00 +0100
Message-Id: <20221020123704.91203-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020123704.91203-1-quentin@isovalent.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool uses libbfd for disassembling JIT-ed programs. But the feature
is optional, and the tool can be compiled without libbfd support. The
Makefile sets the relevant variables accordingly. It also sets variables
related to libbfd's interface, given that it has changed over time.

Group all those libbfd-related definitions so that it's easier to
understand what we are testing for, and only use variables related to
libbfd's interface if we need libbfd in the first place.

In addition to make the Makefile clearer, grouping the definitions
related to disassembling JIT-ed programs will help support alternatives
to libbfd.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/Makefile | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0218d6a1cae7..1c81f4d514bb 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -124,13 +124,6 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-ifeq ($(feature-disassembler-four-args), 1)
-CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-endif
-ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
-endif
-
 LIBS = $(LIBBPF) -lelf -lz
 LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
 ifeq ($(feature-libcap), 1)
@@ -142,9 +135,7 @@ include $(wildcard $(OUTPUT)*.d)
 
 all: $(OUTPUT)bpftool
 
-BFD_SRCS = jit_disasm.c
-
-SRCS = $(filter-out $(BFD_SRCS),$(wildcard *.c))
+SRCS := $(wildcard *.c)
 
 ifeq ($(feature-libbfd),1)
   LIBS += -lbfd -ldl -lopcodes
@@ -154,9 +145,21 @@ else ifeq ($(feature-libbfd-liberty-z),1)
   LIBS += -lbfd -ldl -lopcodes -liberty -lz
 endif
 
+# If one of the above feature combinations is set, we support libbfd
 ifneq ($(filter -lbfd,$(LIBS)),)
-CFLAGS += -DHAVE_LIBBFD_SUPPORT
-SRCS += $(BFD_SRCS)
+  CFLAGS += -DHAVE_LIBBFD_SUPPORT
+
+  # Libbfd interface changed over time, figure out what we need
+  ifeq ($(feature-disassembler-four-args), 1)
+    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
+  endif
+  ifeq ($(feature-disassembler-init-styled), 1)
+    CFLAGS += -DDISASM_INIT_STYLED
+  endif
+endif
+ifeq ($(filter -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
+  # No support for JIT disassembly
+  SRCS := $(filter-out jit_disasm.c,$(SRCS))
 endif
 
 HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
-- 
2.34.1

