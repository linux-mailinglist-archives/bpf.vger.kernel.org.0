Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC025499A
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgH0PiN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgH0PiL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E59C06121B
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so8292963ejp.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDBvGOMRRlbLo3aQl2trxQoUQwz2l1e/yUsctAVaVes=;
        b=bzHg/tXkxBdjhdZx7W6NqI7j+/21YP30qGR+SwKgxSirul+Z2ZzwUSRkz+bAQ3hj0T
         +/fgqcrvxhTi0NJ2BAM5B9uyJO18DZ+/pXsjgMotWwNDxiW9MYsoXehxSv1Pw11ajiFW
         qqDb6+5CcaWKiLEOMffrgmINAIR1nsMFGdQ/7EgS/cQGegJ72BRxgC9OBIXITxOlGYG2
         G0J9IWd/t9ajTsLy816l6i5HsxQdTzwMWJTSb8tQ2TirdcDajI1rDPhKfF0oHaH1zO88
         HTHteErCR/7kgtXRRPXJBsD6ODp68/vhmRejjIbjCtsuOETFTvVHMDpkHo2kCCjXmwWa
         oUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDBvGOMRRlbLo3aQl2trxQoUQwz2l1e/yUsctAVaVes=;
        b=Ad/2RZomoR/5SqwFoZy5HfBLVzgnTT5i7avmcO68QbxXe4lPu2oksjNi+W05jZLyK+
         q7K7aQd7nhJ1FSp8beiOGC39WR3ibllnezpxaAfPi1w1U4V/YGwoTxdIp670KETAs5TA
         3ST0A37aQLfBpobTTwOpQSGGOxX6NY7CHGlLPxUwnln9vdXurIwGZ+WwYbQyY1Eng6FN
         bmfVKmXDoQKowf85XK2yE0QEtsx/uv4JtYXWrvGa4Lwf2LpPTs/f+H+zTOHI3zCQ0f+p
         ZFPQICwCBAOs1CipBPzMLgrMnO3ebK0wTNd6Ae4aEc8aBDAQcCllmxN3vgWhBuknpvp+
         qyNQ==
X-Gm-Message-State: AOAM531Ws+eXVHbUgVCsihSl41nE44HZKnxgkmuzpjuZ4Bqyzyze6HIF
        9ZQJF5ERawUeuzJJ/0Tr2FxBMw==
X-Google-Smtp-Source: ABdhPJyCTC6b0hoK1FOZ5swOPK4Ko2BVsjC08YPh67oAzJ517DAxxXlbif7ss2h4Q0DNU7q8DB5oRA==
X-Received: by 2002:a17:907:72d2:: with SMTP id du18mr8161461ejc.359.1598542689573;
        Thu, 27 Aug 2020 08:38:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:09 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 4/6] tools/runqslower: Use Makefile.include
Date:   Thu, 27 Aug 2020 17:36:28 +0200
Message-Id: <20200827153629.3820891-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Makefile.include defines variables such as OUTPUT and CC for out-of-tree
build and cross-build. Include it into the runqslower Makefile and use
its $(QUIET*) helpers.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/runqslower/Makefile | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index fb1337d69868..bcc4a7396713 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+include ../../scripts/Makefile.include
+
 OUTPUT := .output
 CLANG ?= clang
 LLC ?= llc
@@ -21,10 +23,8 @@ VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
 abs_out := $(abspath $(OUTPUT))
 ifeq ($(V),1)
 Q =
-msg =
 else
 Q = @
-msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
 endif
@@ -37,12 +37,11 @@ all: runqslower
 runqslower: $(OUTPUT)/runqslower
 
 clean:
-	$(call msg,CLEAN)
+	$(call QUIET_CLEAN, runqslower)
 	$(Q)rm -rf $(OUTPUT) runqslower
 
 $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
-	$(call msg,BINARY,$@)
-	$(Q)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
+	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
 
 $(OUTPUT)/runqslower.o: runqslower.h $(OUTPUT)/runqslower.skel.h	      \
 			$(OUTPUT)/runqslower.bpf.o
@@ -50,31 +49,26 @@ $(OUTPUT)/runqslower.o: runqslower.h $(OUTPUT)/runqslower.skel.h	      \
 $(OUTPUT)/runqslower.bpf.o: $(OUTPUT)/vmlinux.h runqslower.h
 
 $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
-	$(call msg,GEN-SKEL,$@)
-	$(Q)$(BPFTOOL) gen skeleton $< > $@
+	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
+	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
-	$(call msg,CC,$@)
-	$(Q)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
+	$(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
 
 $(OUTPUT):
-	$(call msg,MKDIR,$@)
-	$(Q)mkdir -p $(OUTPUT)
+	$(QUIET_MKDIR)mkdir -p $(OUTPUT)
 
 $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
-	$(call msg,GEN,$@)
 	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
 		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
 			"specify its location." >&2;			       \
 		exit 1;\
 	fi
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-- 
2.28.0

