Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BE2ADC53
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgKJQnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbgKJQns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65799C0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so6137360wrp.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRNgSMyFWD2YhO4YUj+TYEJ27Ubp4KzAnhl3fl6mE3k=;
        b=Z7oG4I5FBgpq+8VxqzkPRhgzTLrviLLrRca2/2msMeqGLRKVc+ZHDnn40JnH+yzS3M
         gANBvZgOapbZDOlxtVgjhrGJHCejvJvXFKFQeT0bemOqkyC4tSGOQyKWFw2E0SAmWHz4
         WDwvJS2pwueJwMCrvbVMpzOEHZwTCsMtHODHdU99tWLmez5eWcsSjdEQo3EU/XX2JTBy
         DBpg0VcaPMgCZPq1tJTDDad5KQcxOA9Wxva6VaFuVoDlMAATipQhaCruPgnFWWy2caoa
         PNSXlRMsqOyOmPcnkhcTMGjOMXh4GJzFm3BAntqK6WK7db97RajcqSUYcP085dIpke1E
         8eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRNgSMyFWD2YhO4YUj+TYEJ27Ubp4KzAnhl3fl6mE3k=;
        b=E2mBMcplHjc+k1grXShvJC26jfEX20n4eSqNm6S2zJSceYaaMh0wVdbzDcu82n6hW8
         maFelbof7YSwYboJaRIZcsluE774cz9kmXDXtfoQmFdH2+I4/ghr1nLgi5/ElbZW22M/
         iQgsoSWkoa9XWmIRLVtx1BPdSYrUJzbfxAWVUf9+M8vhSC0/3812gY25NH+Z9FIANGTt
         s8uzfZEOdxFuv9eI4vt0XrV/B7ilmnAuiik53Q7GRsdxediQyz18C4ZJ5RFwBWWXj/xR
         NzfNcaWrjMBU6G+8NqXRPyMY651D0A7QYSXks1N2czFbP5HUBmu66JEKDKQ4qM9vJryq
         t8Vw==
X-Gm-Message-State: AOAM531aKLEdTBDgGfQ07eVYpais77fN02bd1B/vP07VI2n8bPcXg92j
        BUd5lxSN90Oo61eoIh5RU6Dd6w==
X-Google-Smtp-Source: ABdhPJw9Qh8/A4cA949YurwKCETh38SZeJUwKdkYu6HYxhzjecjaZs7C9gXC8FZf+OesAnnnT7fWCg==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr23723553wrn.427.1605026627115;
        Tue, 10 Nov 2020 08:43:47 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:46 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 5/7] tools/runqslower: Enable out-of-tree build
Date:   Tue, 10 Nov 2020 17:43:09 +0100
Message-Id: <20201110164310.2600671-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
wasn't already set by the user.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v3:
* Drop clean recipe for bpftool and libbpf, since the whole output
  directories are removed by the clean recipe.
* Use ?= for $(OUTPUT)
---
 tools/bpf/runqslower/Makefile | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index bcc4a7396713..0fc4d4046193 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -1,15 +1,18 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 include ../../scripts/Makefile.include
 
-OUTPUT := .output
+OUTPUT ?= $(abspath .output)/
+
 CLANG ?= clang
 LLC ?= llc
 LLVM_STRIP ?= llvm-strip
-DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
+BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
+DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
-BPFOBJ := $(OUTPUT)/libbpf.a
-BPF_INCLUDE := $(OUTPUT)
+BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
+BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
+BPF_INCLUDE := $(BPFOBJ_OUTPUT)
 INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../lib)        \
        -I$(abspath ../../include/uapi)
 CFLAGS := -g -Wall
@@ -20,7 +23,6 @@ VMLINUX_BTF_PATHS := /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
 VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
 					  $(wildcard $(VMLINUX_BTF_PATHS))))
 
-abs_out := $(abspath $(OUTPUT))
 ifeq ($(V),1)
 Q =
 else
@@ -38,7 +40,11 @@ runqslower: $(OUTPUT)/runqslower
 
 clean:
 	$(call QUIET_CLEAN, runqslower)
-	$(Q)rm -rf $(OUTPUT) runqslower
+	$(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
+	$(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
+	$(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
+	$(Q)$(RM) $(OUTPUT)runqslower
+	$(Q)$(RM) -r .output
 
 $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
@@ -59,8 +65,8 @@ $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
 	$(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
 
-$(OUTPUT):
-	$(QUIET_MKDIR)mkdir -p $(OUTPUT)
+$(OUTPUT) $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT):
+	$(QUIET_MKDIR)mkdir -p $@
 
 $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
@@ -70,10 +76,8 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	fi
 	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
-$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) $@
 
-$(DEFAULT_BPFTOOL):
-	$(Q)$(MAKE) $(submake_extras) -C ../bpftool			      \
-		    prefix= OUTPUT=$(abs_out)/ DESTDIR=$(abs_out) install
+$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)
-- 
2.29.1

