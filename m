Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3391B2AB632
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgKILKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:38 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D573C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:38 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id oq3so11640426ejb.7
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9a6wyduhqH0XylkIaF2dRKTCJ4v/xB9x3/Syw+y2zY=;
        b=kIIUsyzY0dYDBumswG4u4Y0P0PhUW91rtXwfHZ30H+/YwJdndoDBGS7K4H9qDdb/pC
         /1pZgpv7xAQXgGJJ/nXZM5OXda5m9E7hW7ZFujzUEIOFun0LHoFvc7PtUiYrtS9Bd21e
         TB72s4u5tzNyeo+yBZ7sxVLuu5N0b3fbEhifNON7D80bopMNuGQql7lreW9CIy0zaO/1
         x35OPbjfoYSO0b9JGjtnOJzED1A3sSk5tzCSnIRNnKTR8MMlDQh//x9w1zGJ8R/eJHwj
         oQsJE/GXIoqhwafZkDlPcUv6gSkR1u+fBmw0aithne34Imue6ozrkvDq1qtLMPUe0CLJ
         Ltyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9a6wyduhqH0XylkIaF2dRKTCJ4v/xB9x3/Syw+y2zY=;
        b=DMyZcKF/a0G/iwh3Q9Ql1/AREpMAvnn0jEZ068BNELnkqffQS7TJeHGFqtq6EvRyhp
         T+tnmqlyqpEQetfYUlC9dVzuwG9/TONcT6AkDnJf1T/h0ekbZe0pWc6Viv8LPqqygcwM
         NXBs9YO20SD8/01/to0CeFHbPuNXR5Cg+7eb+qugbOIBKLJvY5N2uiALgJvkDn0X5FD7
         sT1ZuNbZrZG1cCGuTZpcxZ3TB62EtQ+I9gawe/d/zVLu2lDH1+Q9RrWskQic9omsrkjw
         ZL36QFzoqW5zGCgI5tmWZCopY6r15hT44Cs0VRlo8CvDIa10akHqfQFkvnONOICbl+hh
         bhSg==
X-Gm-Message-State: AOAM532zM0gl/VoqtHRlz32CYcxTAgLu8M8jmUqpF8D7irUTOyQkrU/A
        mM1TNqF9AYS1hvMZBb2z3DIUQg==
X-Google-Smtp-Source: ABdhPJxUX2LsSmZp62ikiWZbl6BVF2zSQhrL1CZ7bGsLxVyex8UxvqdAyEZEQI7w2AWr3NlhDWnePA==
X-Received: by 2002:a17:906:b043:: with SMTP id bj3mr14230926ejb.543.1604920236924;
        Mon, 09 Nov 2020 03:10:36 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:36 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 5/6] tools/runqslower: Enable out-of-tree build
Date:   Mon,  9 Nov 2020 12:09:29 +0100
Message-Id: <20201109110929.1223538-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.29.1

