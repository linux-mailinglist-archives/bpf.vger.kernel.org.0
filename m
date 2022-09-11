Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919745B5119
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIKUPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIKUPK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:15:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175561AD82
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t14so12297300wrx.8
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pwBcXEdZ0bwNQEQkHCPZ0SYXvbbBEOobN7rGFCnE0t8=;
        b=Fb/pQovZwD5nekkQUFlWKh+RXfFhFiB/8X/SA2Tu1nO4LYvQGWO1AtYA7XHheQqByW
         PFz5sPK6ycU7MmxDksIi59hBcY7qi1kUbujtYyj5jcthl7mih2zCIN5zU3cRONydDJkp
         ZdiGgN2GSYxNmZUiZykLTt3lWSAtdTaxaD5tKq/chaMXf5gRbz9goZYlDES1cB427Mn0
         bf5+TIsx4OszF6g+aEsup9C1ZMcpJ5LG3AgSTA7IvFHpsp8+xyzaxHdkWt+Gysac9tu6
         VIiUyqhHvnF9/+Dvha1gC5Eij9K7t5UZ1OdZy8zqdBSPc1E/AFUdS4DQB9OEdiD8mdas
         C6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pwBcXEdZ0bwNQEQkHCPZ0SYXvbbBEOobN7rGFCnE0t8=;
        b=2j9OitbM82pl+b5FXCaqwwk0Qwkbcc6j0Rivhgq1Rsa4vcRfPXJm7s05O8yeRcbCWU
         RXsL7B9xjrAry6tJXGtg+6vnmHOq22xw/LEqvTPl91SqFKLrP+xOc1xQrRpu9KrF0vW+
         tz7kvBEeQ5KB9OKzGQgBdjqeTaSfMY1SpWvvMBW+a/6aQqnPu9vtwd2SnnZQ22b2oWMi
         2Xm2HaUlSEwi5cdHAXb+VA6oEDHixYy7Xo5CILcpM6pn33mYGbJnsoxARE+yPZeRWzrj
         de0nvtDwJ4YRDvb8/Ncey+fq8MbpjQTUExwjtUNfaDMeQxDNP3JUDzcydZQOSJ29DDzv
         CnMQ==
X-Gm-Message-State: ACgBeo31LB1xDH40Or35FFZSrPy9Whvke9+gN2hWjzOInYOsirK2c9FE
        z5pf1zN84NXn/LN1d9zGNRaD7g==
X-Google-Smtp-Source: AA6agR5SemsBV/iDMr5/ITBVVbGPLT04T7jwbFjp6QqxSPXEoHFAwIFrSU3Az29lycHLI9HHqAmueQ==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr13214403wrr.361.1662927308599;
        Sun, 11 Sep 2022 13:15:08 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:15:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/8] bpftool: Group libbfd defs in Makefile, only pass them if we use libbfd
Date:   Sun, 11 Sep 2022 21:14:47 +0100
Message-Id: <20220911201451.12368-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911201451.12368-1-quentin@isovalent.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

