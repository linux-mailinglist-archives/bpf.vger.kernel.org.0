Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56E25499B
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgH0PiO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0PiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0AAC061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so8293062ejp.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sLQKuNzCkUI4XRB6gOMH6rmKmQmmnxxXCNwwONqGG4=;
        b=w3PrZvHZJJGn42U3gwGX+vCCRKig5stMiMIoCVpFUKh9Ih+la9IV7EAN4zL4cFMrsz
         Z6E2x7CzSv7UkaZerlh+vvnifeJG8s8XnEgwVwACHpqRead9fqi5f3e33bX+wWg5QSzV
         18QbWqDjpqBrIdzNneGcKU/eUk6mrTzOiTK51LDvxMrJBdtRpM4Z96ZsICiu8qciTK7x
         HkE+qZJ3K92QZHhBqhfAdutIlblESRVMNkgnjc68XgnBXyi6zMhLld+7YhMT3F+Nh86G
         JiUPWYZ3I6AdOlUPlo3T0R1cNW0WD+6sJ9eeuvO7in8YY+j+gTYAezJKyIYaN2t6JNcc
         gydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sLQKuNzCkUI4XRB6gOMH6rmKmQmmnxxXCNwwONqGG4=;
        b=ptuG43qvjLUZHrBw1ZaveA76J4taFOyRRQkJWzo37ZjQqQqfot1eHu2nQdRDr/NUxQ
         ZYVDXGXsRCUGTNM8ZeEqHYtA5lAnJ1vRGVSOan4Ai8U/lL8Xl8QSVmdOY5WYHehRYgQy
         HYLNvAwxzD7nJK1ZgWF6KrMfYV238hoaQs7iXOvDVtgGOsol9b/mbPS1KrH0qQy3CJWb
         xUkukgoj5jEY9lybpRVqR11d558U5RlNcSeFWV1v9/+S9C2gGgJzuKmdhGuOYQE6Qwyf
         WxeRJBSD+ceZoIT3E62Isuw1F+OYDi6XsS3T/aSG1crcPJm3RJ6yiuj5NDzkieoXbGEb
         J35g==
X-Gm-Message-State: AOAM533djQJknyDx646t2rnkiqGSVH0a+/GpA0Kvo3mc9LO/BxcXF4Zg
        ejglaxhwGBL8DEhyRvqTmTH9xg==
X-Google-Smtp-Source: ABdhPJzvDvEzdVC9qS+3+9qXDEw4FQ6RFu5UCm7wIi0ft77xCIk2HvmqgNX9p15P4zZZTQIvyWC4jg==
X-Received: by 2002:a17:906:f150:: with SMTP id gw16mr13667933ejb.532.1598542690726;
        Thu, 27 Aug 2020 08:38:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:10 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 5/6] tools/runqslower: Enable out-of-tree build
Date:   Thu, 27 Aug 2020 17:36:29 +0200
Message-Id: <20200827153629.3820891-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
wasn't already set by the user.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/runqslower/Makefile | 45 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index bcc4a7396713..861f4dcde960 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -1,15 +1,20 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 include ../../scripts/Makefile.include
 
-OUTPUT := .output
+ifeq ($(OUTPUT),)
+  OUTPUT = $(abspath .output)/
+endif
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
@@ -20,7 +25,6 @@ VMLINUX_BTF_PATHS := /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
 VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
 					  $(wildcard $(VMLINUX_BTF_PATHS))))
 
-abs_out := $(abspath $(OUTPUT))
 ifeq ($(V),1)
 Q =
 else
@@ -36,9 +40,13 @@ all: runqslower
 
 runqslower: $(OUTPUT)/runqslower
 
-clean:
+clean: $(DEFAULT_BPFTOOL)-clean $(BPFOBJ)-clean
 	$(call QUIET_CLEAN, runqslower)
-	$(Q)rm -rf $(OUTPUT) runqslower
+	$(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
+	$(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
+	$(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
+	$(Q)$(RM) $(OUTPUT)runqslower
+	$(Q)$(RM) -r .output
 
 $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
@@ -59,8 +67,8 @@ $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
 	$(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
 
-$(OUTPUT):
-	$(QUIET_MKDIR)mkdir -p $(OUTPUT)
+$(OUTPUT) $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT):
+	$(QUIET_MKDIR)mkdir -p $@
 
 $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
@@ -70,10 +78,17 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	fi
 	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
-$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) $@
+
+$(BPFOBJ)-clean: $(BPFOBJ_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) clean
 
-$(DEFAULT_BPFTOOL):
-	$(Q)$(MAKE) $(submake_extras) -C ../bpftool			      \
-		    prefix= OUTPUT=$(abs_out)/ DESTDIR=$(abs_out) install
+$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)
+
+$(DEFAULT_BPFTOOL)-clean: $(BPFTOOL_OUTPUT)
+ifeq ($(DEFAULT_BPFTOOL),$(BPFTOOL))
+	$(call QUIET_CLEAN,bpftool)
+	$(Q)$(MAKE) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT) clean
+endif
-- 
2.28.0

