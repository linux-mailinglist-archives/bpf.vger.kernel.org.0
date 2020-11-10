Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE52ADC51
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgKJQnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 11:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgKJQnq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF65C0613D3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so10014216wrx.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hv+MtdKXTpTLctYjLMkmsc3F3M6Gdqr5InIXmGWvKwk=;
        b=OOnHb4J5diup+46RtfT6miy4Jbx6ll+JMWIGjFKk41MgyC/GbTW0Fjx0z6RQ6WMKbN
         YJCgkDHTgVDJ2XFw81dXMT2a2mxSNWwqFsJCRLoFbFVclFzY6Q/7Fivt83XJJmLHM/ZC
         iT6pQBaPTD+yf5JToRvuoqkX0CDcvyAQg59kKii9pwLEdUlPxhFNyeTkkmoIfi9gbFJJ
         YfA3+ybWejW1miUEFnXqFEPjkqa06FD7VVyqvpNl0KmhNmtymer/+PqeGD+yhcazCuc0
         GMLmkUYcwfcOP7ErZDGlzBn8k4YeCeebwndlr4E+cnXTvuUQiZPa8HQ4TknDDiGrugZy
         RcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hv+MtdKXTpTLctYjLMkmsc3F3M6Gdqr5InIXmGWvKwk=;
        b=cvwEn6q2RSi1/WDOFxULyusSaRUDs3U0jXgtuyM3d01RL+9i4utAPq2CrLOXlZHSWr
         XFVjjtbrPSyGxvuFDqWdEMuJLT/i9wmgYjQ1io+wKor815kQePWQ424okhiA9QuNS/Bo
         xiQN9Ep/NESv4jr+hOeTUGGAikI2zTFy6QLhRLS6WYvnmdnXqVeHksAOluwkUmICPQak
         isSHKndFosTBqBy0nIeN63zTBJC7h2f5nLc/L2lAqiWoTrUNeeK0CgErh1MysT0JHPPV
         a+BeTjn8TisDRwstrZCSgKkvjLuU61yvdfbWweyFI4YnWunkBaIXNyP07KIfpQp//dNk
         Vwpw==
X-Gm-Message-State: AOAM531VOZNVdviIAZsyzQRS9N1/Hk0y4RFl36Y3KVVq+dTPRhABJsiH
        WTKlntz4UnoqA9q8++DmDi1uow==
X-Google-Smtp-Source: ABdhPJyvD4jOKjkmZb8/EoHle8cQTFf91s0eSmjc0zOnksZaAuDEADX+u6PVrlznyuo/VNx52UF/6Q==
X-Received: by 2002:a5d:6cc5:: with SMTP id c5mr24883181wrc.301.1605026624947;
        Tue, 10 Nov 2020 08:43:44 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:44 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 3/7] tools/bpftool: Fix cross-build
Date:   Tue, 10 Nov 2020 17:43:07 +0100
Message-Id: <20201110164310.2600671-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
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
v3: Always set LIBBPF_OUTPUT. Tidy the clean recipe.
---
 tools/bpf/bpftool/Makefile | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 1358c093b812..d566bced135e 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -19,24 +19,37 @@ BPF_DIR = $(srctree)/tools/lib/bpf/
 ifneq ($(OUTPUT),)
   LIBBPF_OUTPUT = $(OUTPUT)/libbpf/
   LIBBPF_PATH = $(LIBBPF_OUTPUT)
+  BOOTSTRAP_OUTPUT = $(OUTPUT)/bootstrap/
 else
+  LIBBPF_OUTPUT =
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
 
@@ -94,6 +107,7 @@ CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
 endif
 
 LIBS = $(LIBBPF) -lelf -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
 ifeq ($(feature-libcap), 1)
 CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
@@ -120,9 +134,9 @@ CFLAGS += -DHAVE_LIBBFD_SUPPORT
 SRCS += $(BFD_SRCS)
 endif
 
-BPFTOOL_BOOTSTRAP := $(if $(OUTPUT),$(OUTPUT)bpftool-bootstrap,./bpftool-bootstrap)
+BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(OUTPUT),main.o common.o json_writer.o gen.o btf.o)
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
 
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
@@ -169,12 +183,16 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 
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
 
@@ -182,11 +200,11 @@ feature-detect-clean:
 	$(call QUIET_CLEAN, feature-detect)
 	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ clean >/dev/null
 
-clean: $(LIBBPF)-clean feature-detect-clean
+clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
 	$(call QUIET_CLEAN, bpftool)
 	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
-	$(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
-	$(Q)$(RM) -r -- $(OUTPUT)libbpf/
+	$(Q)$(RM) -- $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
+	$(Q)$(RM) -r -- $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT)
 	$(call QUIET_CLEAN, core-gen)
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
 	$(Q)$(RM) -r -- $(OUTPUT)feature/
-- 
2.29.1

