Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFA425C80
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbhJGTq5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbhJGTqt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 15:46:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F823C06176D
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 12:44:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r18so22496054wrg.6
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEX+HUR72ahF32WavI8A1JXem/G4/Ffc2RuIMJIPcLY=;
        b=eJVgM3miacm0KO3DZRObjCZ5t30rJvgbWKWzzcataAWcPpeN4VMR79G+CGoAKNjm5c
         EUYeB7CAKkX6vGw/iHd293GiKmbopwx756/sSMrCkNgpoLwrC+OBlrn5LvYh2TuMJZqq
         wI46gFPjJXsY155He9gf3jSH1y9BNgBYlkeNNQAh79qMmpSpOPXWnpF9+FpOKse2LUKK
         d8uOuYtxp9ZS7hkFcRdu9wvPspcCv9lWZiVGW12qmOhwndSxRjN4i300AhbHsRCaQKcW
         xZY+x9G0+mMWBNL9MRDie08ZrM2ZMl2yg4T4Dmr20kT7WldKN2aXzxP95iRko6IIzBUv
         sbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEX+HUR72ahF32WavI8A1JXem/G4/Ffc2RuIMJIPcLY=;
        b=JvSLAHYKeeo7KtBLP54svoLdsjsvSBmTX+4saDBALRt6qKa/PJniuaog4YP4EGsYnz
         97O44/S82WL0lxwy/TtEgw3l+piVeu7tNjXTqSM7Xuchfv9iJpA/ticOnt+wxijeE9Mx
         fFups2c6iyizt2Qy2vWmoJO3XURNgg9TH38elpx1ogLqmCDWMeLBfQ1i39i2tJe+cqdh
         whakg2A0z6VTYfkp3PKV+05MuaZ/fefBxYB8SgYu+uBkbbzN6CeLl6qdYbET1qQsy2ZP
         guIMA1FO1dfGeTHZo9il72Zy2BHMj0jOwRbqG3xllLYeFrdaPXc/0oFEDvKou397e9YP
         mzGQ==
X-Gm-Message-State: AOAM5302ybtzLgTTOKvD2sn/EEKszsNMJJvN8KkGBLqkhypfjPZJqTMp
        wsnCIjZSRjs/bkiv5aYg4Q0a3Q==
X-Google-Smtp-Source: ABdhPJxfZpNIdHkASocbv0CsPop4GPexwIdstYwId+Tp6/kQgzWoDallHdbxajnB7RJYvHvpplfxKQ==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr7833742wrs.121.1633635892239;
        Thu, 07 Oct 2021 12:44:52 -0700 (PDT)
Received: from localhost.localdomain ([149.86.87.165])
        by smtp.gmail.com with ESMTPSA id u2sm259747wrr.35.2021.10.07.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:44:51 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4 07/12] bpf: iterators: install libbpf headers when building
Date:   Thu,  7 Oct 2021 20:44:33 +0100
Message-Id: <20211007194438.34443-8-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007194438.34443-1-quentin@isovalent.com>
References: <20211007194438.34443-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

API headers from libbpf should not be accessed directly from the
library's source directory. Instead, they should be exported with "make
install_headers". Let's make sure that bpf/preload/iterators/Makefile
installs the headers properly when building.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 kernel/bpf/preload/iterators/Makefile | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/preload/iterators/Makefile b/kernel/bpf/preload/iterators/Makefile
index 28fa8c1440f4..ec39ccc71b8e 100644
--- a/kernel/bpf/preload/iterators/Makefile
+++ b/kernel/bpf/preload/iterators/Makefile
@@ -1,18 +1,26 @@
 # SPDX-License-Identifier: GPL-2.0
 OUTPUT := .output
+abs_out := $(abspath $(OUTPUT))
+
 CLANG ?= clang
 LLC ?= llc
 LLVM_STRIP ?= llvm-strip
+
+TOOLS_PATH := $(abspath ../../../../tools)
+BPFTOOL_SRC := $(TOOLS_PATH)/bpf/bpftool
+BPFTOOL_OUTPUT := $(abs_out)/bpftool
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
-LIBBPF_SRC := $(abspath ../../../../tools/lib/bpf)
-BPFOBJ := $(OUTPUT)/libbpf.a
-BPF_INCLUDE := $(OUTPUT)
-INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../../../tools/lib)        \
-       -I$(abspath ../../../../tools/include/uapi)
+
+LIBBPF_SRC := $(TOOLS_PATH)/lib/bpf
+LIBBPF_OUTPUT := $(abs_out)/libbpf
+LIBBPF_DESTDIR := $(LIBBPF_OUTPUT)
+LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)/include
+BPFOBJ := $(LIBBPF_OUTPUT)/libbpf.a
+
+INCLUDES := -I$(OUTPUT) -I$(LIBBPF_INCLUDE) -I$(TOOLS_PATH)/include/uapi
 CFLAGS := -g -Wall
 
-abs_out := $(abspath $(OUTPUT))
 ifeq ($(V),1)
 Q =
 msg =
@@ -44,14 +52,19 @@ $(OUTPUT)/iterators.bpf.o: iterators.bpf.c $(BPFOBJ) | $(OUTPUT)
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
-$(OUTPUT):
+$(OUTPUT) $(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
 	$(call msg,MKDIR,$@)
-	$(Q)mkdir -p $(OUTPUT)
+	$(Q)mkdir -p $@
 
-$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile)	       \
+	   | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+		    OUTPUT=$(abspath $(dir $@))/ prefix=		       \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(abspath $@) install_headers
 
-$(DEFAULT_BPFTOOL):
-	$(Q)$(MAKE) $(submake_extras) -C ../../../../tools/bpf/bpftool			      \
-		    prefix= OUTPUT=$(abs_out)/ DESTDIR=$(abs_out) install
+$(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
+		    OUTPUT=$(BPFTOOL_OUTPUT)/				       \
+		    LIBBPF_OUTPUT=$(LIBBPF_OUTPUT)/			       \
+		    LIBBPF_DESTDIR=$(LIBBPF_DESTDIR)/			       \
+		    prefix= DESTDIR=$(abs_out)/ install
-- 
2.30.2

