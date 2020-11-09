Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4423B2AB630
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgKILKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:36 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA577C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:35 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t11so8250442edj.13
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY+9tVMDs1jDIM90XTwx0DC8i7pqZFo0WMi7ZA+k+QU=;
        b=woW3hhN2xSxu09zLvfYmgHu1MCdXvAID1YGZYDdqifF2u/tCyJFxlfxcBYXxg+/sGH
         WyOsadPGwuNqoAfiuZZlJQH17K0U9C6fSsb/8heYwVAgzT4BYVBpdORtSLCwsNH8GTuX
         EH62yWY7lWmgaSnbEOkev6czCGBD+BwOf9Gz9shAE1znPJSUfGoptl4rur1bcEmxqjry
         6fhEBx4C2VjmW/nEIYz8xtKYub7e9UAS+23undSU+KAWz0UAGqmIq59wEUGKSmVRJKBT
         VzclWgHsAujYRQGCxtHrkPCVNgaioFs3LDTvvJttPncrGLA+yIMveIucWu0vmRlPKl8H
         8umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY+9tVMDs1jDIM90XTwx0DC8i7pqZFo0WMi7ZA+k+QU=;
        b=L2vf4l0jYwlPVUib/m0WKTyJbKgeE0D5IXpG7ZHnMXaWcxwEZMOSCNWVgOQhG++Uy5
         be1GEV7UdV+I0UAS96z/eIkk69DIfUqIf39s0+spRFyZBDToeYk8kNQaJ9q45UxAriqx
         6xunhA3f01vzW3PYTLRS7Sy+xVGCh9AwxwkwqgrQqNTFw9+Xid2gIp+jPLpnHyZykN//
         LKnSPddQgkA6wpTgj8heQKuGUQC0wjzPVSfvQs1oSS16TVp6Njf4nRfWarZEEquNyGyz
         hgCwAn9GxEyw7w4veW5Hc2hTOdVg70UBtrbGLcCsr3pi1MS111slMtb2TpQTPMuNz8eQ
         E5Xg==
X-Gm-Message-State: AOAM531cPow1jfI02poR53rITGZHL7M5cvoILAGz2hAYuLWjeblKjjLk
        LvBblazMiUonSKrnVY5/MFyBjg==
X-Google-Smtp-Source: ABdhPJyrxNIyZXb24lMkwugIQpk2f6Emev4Yug4YjpeJsHKxQou94ldBdJupSUOU8fNHfV/yuQe37Q==
X-Received: by 2002:a05:6402:1813:: with SMTP id g19mr15004568edy.105.1604920234465;
        Mon, 09 Nov 2020 03:10:34 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:33 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 3/6] tools/bpftool: Fix cross-build
Date:   Mon,  9 Nov 2020 12:09:27 +0100
Message-Id: <20201109110929.1223538-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpftool build first creates an intermediate binary, executed on the
host, to generate skeletons required by the final build. When
cross-building bpftool for an architecture different from the host, the
intermediate binary should be built using the host compiler (gcc) and
the final bpftool using the cross compiler (e.g. aarch64-linux-gnu-gcc).

Generate the intermediate objects into the bootstrap/ directory using
the host toolchain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/bpftool/Makefile | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 1358c093b812..0705c48e0ce0 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -19,24 +19,36 @@ BPF_DIR = $(srctree)/tools/lib/bpf/
 ifneq ($(OUTPUT),)
   LIBBPF_OUTPUT = $(OUTPUT)/libbpf/
   LIBBPF_PATH = $(LIBBPF_OUTPUT)
+  BOOTSTRAP_OUTPUT = $(OUTPUT)/bootstrap/
 else
   LIBBPF_PATH = $(BPF_DIR)
+  BOOTSTRAP_OUTPUT = $(CURDIR)/bootstrap/
 endif
 
 LIBBPF = $(LIBBPF_PATH)libbpf.a
+LIBBPF_BOOTSTRAP_OUTPUT = $(BOOTSTRAP_OUTPUT)libbpf/
+LIBBPF_BOOTSTRAP = $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
 
 BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
 
-$(LIBBPF_OUTPUT):
+$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
 	$(QUIET_MKDIR)mkdir -p $@
 
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
 
+$(LIBBPF_BOOTSTRAP): FORCE | $(LIBBPF_BOOTSTRAP_OUTPUT)
+	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
+		ARCH= CC=$(HOSTCC) LD=$(HOSTLD) $@
+
 $(LIBBPF)-clean: $(LIBBPF_OUTPUT)
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) clean >/dev/null
 
+$(LIBBPF_BOOTSTRAP)-clean: $(LIBBPF_BOOTSTRAP_OUTPUT)
+	$(call QUIET_CLEAN, libbpf-bootstrap)
+	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) clean >/dev/null
+
 prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
@@ -94,6 +106,7 @@ CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
 endif
 
 LIBS = $(LIBBPF) -lelf -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
 ifeq ($(feature-libcap), 1)
 CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
@@ -120,9 +133,9 @@ CFLAGS += -DHAVE_LIBBFD_SUPPORT
 SRCS += $(BFD_SRCS)
 endif
 
-BPFTOOL_BOOTSTRAP := $(if $(OUTPUT),$(OUTPUT)bpftool-bootstrap,./bpftool-bootstrap)
+BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(OUTPUT),main.o common.o json_writer.o gen.o btf.o)
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
 
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
@@ -169,12 +182,16 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 
 $(OUTPUT)feature.o: | zdep
 
-$(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(BOOTSTRAP_OBJS) $(LIBS)
+$(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
+	$(QUIET_LINK)$(HOSTCC) $(CFLAGS) $(LDFLAGS) -o $@ $(BOOTSTRAP_OBJS) \
+		$(LIBS_BOOTSTRAP)
 
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
 
+$(BOOTSTRAP_OUTPUT)%.o: %.c | $(BOOTSTRAP_OUTPUT)
+	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
+
 $(OUTPUT)%.o: %.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
 
@@ -182,11 +199,12 @@ feature-detect-clean:
 	$(call QUIET_CLEAN, feature-detect)
 	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ clean >/dev/null
 
-clean: $(LIBBPF)-clean feature-detect-clean
+clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
 	$(call QUIET_CLEAN, bpftool)
 	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
-	$(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
+	$(Q)$(RM) -- $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
 	$(Q)$(RM) -r -- $(OUTPUT)libbpf/
+	$(Q)$(RM) -r -- $(BOOTSTRAP_OUTPUT)
 	$(call QUIET_CLEAN, core-gen)
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
 	$(Q)$(RM) -r -- $(OUTPUT)feature/
-- 
2.29.1

