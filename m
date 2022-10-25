Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147560CFE1
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiJYPDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiJYPDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133D1B2BBD
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk15so21556462wrb.13
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwBcXEdZ0bwNQEQkHCPZ0SYXvbbBEOobN7rGFCnE0t8=;
        b=JPMZYnmmHaa8KqJLQJhzJhdNtIxq9NnnISGOV36btcqqtJJb4OcKbxP2byfbhljX8n
         T/ApZHjurfCcw6zKHFtJUly1KJIpSWRfOpGufkXUEJv6/C9rFBafphGPOHy3OxfOjBSF
         bMdfFq9paVvMO5sL93MjQFwjLuEi01Rl3eLT5F8p0FqXbRP2eoVeaeYuj15ObsZWxxU8
         OxA8ofwvSs6xgeHKxNhTYbZkIwaNwWbTB7GWNqLwCQci2FlI5eAeJS1v9DJ5WEBM58he
         Rz9aH6QIqTwSvlnjqBrhdbjlLEIW/noG9NAaI8eQlt3V+QsjxS++4H/AQxRRUGczZ/1l
         vpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwBcXEdZ0bwNQEQkHCPZ0SYXvbbBEOobN7rGFCnE0t8=;
        b=zv65EYodyJVnGGAB7FBypEqjsa2Kj6WNjl3ajjZQxNE0U+LD8RFAssmqrR1XTRMZqr
         IIJI3PuTxZL906YWQXIOjhxUPV1z6y93NrGugOBMWNIVnSYVvXOl6fQymKlqQPimByPx
         ueCdAZdwiU/E3zxkwEunC5BUZ+5CGDiPW3WDNObzqm1efyrkNkWnNuYkPWRCtBEYFhl6
         7ajdkkd6F1mwdMdXDUYft0zF6DLi07HyXqR6j+8908PlGJBFl4LaxX6VCoR8a9tjfmvC
         W6OWCdbD/LC+v4Lkfw5VoZJBxkcqiPY6y30FIJx3tJpvfVyy/8jL+r7h1jqV9gWRfD63
         8AkQ==
X-Gm-Message-State: ACrzQf1T/HCMHbnYfvZ/BPE0GR2XagTTCcDgwnl4QUjJ7vFjW4SR24XY
        13XQ74+f2lNF3u6pelx15ndDSA==
X-Google-Smtp-Source: AMsMyM7pdt3lyJb2qxt+ZfuICRvOoxmvUe7cmmXS60HUGOSZcs0Iqm7jbvZAIuNpL2gCNkIQQtHVQw==
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr25954025wrf.480.1666710222756;
        Tue, 25 Oct 2022 08:03:42 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/8] bpftool: Group libbfd defs in Makefile, only pass them if we use libbfd
Date:   Tue, 25 Oct 2022 16:03:25 +0100
Message-Id: <20221025150329.97371-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
References: <20221025150329.97371-1-quentin@isovalent.com>
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

