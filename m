Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767E85AEA74
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiIFNot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiIFNnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:43:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E797E83D
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:37:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso8915295wma.2
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6H8KdwUCDA9IoCWknsDTaVHGW/ZpCyIDX2q/KTx4PM8=;
        b=dfbrmGyWjgv64/Jj81UEmI7B+xKkx45326Q+ydfsIwRQ7Ps34tW3RZbw3auwy2rkGZ
         mp2a+NOLSjmpNzjmSMKw2F9Zvhi1ES8TyPZ/qubtMEvdTyig2+DdWWPWZYOvV+k1tPkR
         TNIwNtBEcFI03zmqezoiWJzuyn14YWgNpmS9vvgOhAvgbL6Ij+FrB5cjfMipdyBZl0pU
         QqDRjr9pedxO7fyMPwEIEfDxoQ+s71i8GhLYlmPXxI/3Pz6f874jX3xCYT/aRIGh/5bR
         YHddQU1Kp8aKlC/VsBO6ynoLxMbJEWqsDeW3Uikyn8CIWb7JgP/F/f0YReKt66ZgQMO7
         IVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6H8KdwUCDA9IoCWknsDTaVHGW/ZpCyIDX2q/KTx4PM8=;
        b=ma9pPmsVqT61LaR548syLbuRbdE19CjVPRJJTV4OpIysVnrarGnWEQxQ29fl74gA5G
         V251nqyS9TGEqhc/tOk4L/5TiPF9fy4Wdl21TJdC4tJJCNqetFbI+GxIwAnTKCHptr6s
         KpdFPqFfC8qUuHrGnjldpwn01Qs925BZzuO3VEh3lzYStwFuBZXr4GoZAfkBQHfoO6ll
         wxbQq6pRYHGp/vEAu3jt3D9ECriCkTd6J1h9xb5e4vHnyfoQMZK5y0HYIB0RgrNdSsh4
         hs/GW1WwqaVVDkL5smXYI3V2TZMTQBvpxazrYDTHLRCumdtj/jJbLEDgwJCO7Ip/RfQQ
         IR4A==
X-Gm-Message-State: ACgBeo1byhN7I37gKLF0bnf792QkwM7nXSqAm0AiwpDwG/F6i1JFUimz
        LFQIQ/maz19jEv11gMd4FVgCNw==
X-Google-Smtp-Source: AA6agR6cA52XGbaA9LirYLUWCKC8xLDTGQT/v6urlvjVlkvn3+jqKkGvbOkDeGRfkQ5oPhXDUsdXig==
X-Received: by 2002:a05:600c:1554:b0:3a6:23d7:1669 with SMTP id f20-20020a05600c155400b003a623d71669mr14033021wmg.70.1662471395332;
        Tue, 06 Sep 2022 06:36:35 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:34 -0700 (PDT)
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
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 4/7] bpftool: Group libbfd defs in Makefile, only pass them if we use libbfd
Date:   Tue,  6 Sep 2022 14:36:10 +0100
Message-Id: <20220906133613.54928-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906133613.54928-1-quentin@isovalent.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
MIME-Version: 1.0
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
---
 tools/bpf/bpftool/Makefile | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 8b5bfd8256c5..8060c7013d4f 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -120,13 +120,6 @@ include $(FEATURES_DUMP)
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
@@ -138,9 +131,7 @@ include $(wildcard $(OUTPUT)*.d)
 
 all: $(OUTPUT)bpftool
 
-BFD_SRCS = jit_disasm.c
-
-SRCS = $(filter-out $(BFD_SRCS),$(wildcard *.c))
+SRCS := $(wildcard *.c)
 
 ifeq ($(feature-libbfd),1)
   LIBS += -lbfd -ldl -lopcodes
@@ -150,9 +141,21 @@ else ifeq ($(feature-libbfd-liberty-z),1)
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

