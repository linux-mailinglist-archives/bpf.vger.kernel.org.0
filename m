Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC94254999
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH0PiM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgH0PiK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66FC061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so8292885ejp.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgezLxNLD39j7OqPZk7tsI5umtS3vpaKa0Ky+SbavLg=;
        b=udLJOSUbiqa0OlKm1uFZhw/KRHP+llMVqKJIOEwvuF1DdwEbzQbMqG2Huh+Q99d95Y
         qOyRw/L9YEzZxqp1pU5AMKjxEHc86jWCD1O8Sl8cd7ALiX8135VeXG8AZDTgHM2NKFLT
         oMU6fJNUaMF3k/tbKBqiv/M/Y39izTvo0Wc1mpAQiFy+mn1gXOh+ekYmnOiKQ+7GvCV2
         Xr79U8fJV1rGf5eacQu4Q1LINWRv+xzM+2Xwv9ORV/UWxzK0TgcIl+ojGOyLEDPN/eHs
         uTB5wSmbTxgiGjFLImcuomPc9CPi+TpDZl9UINptIJrxQp7UARn6dC5RYoFkBCCbzRK/
         kzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgezLxNLD39j7OqPZk7tsI5umtS3vpaKa0Ky+SbavLg=;
        b=OfYYCBZqU5/g4h3ttOhlo8LKSS0WromnSMf6Oov55Occu/34iko53F2t8DnO4G0MaF
         dLG8hI82PvZLlBj2v90pYlPZDF/rmnULGudVfCcoWRnS21p7KtjLJryQ07nraK4pQ3Bq
         LMHdtwdY2+fnbKkCe6MRqWsyPX0zXDUvxDsFRl3lgaGpybPRLOqLsaWocPQ1LVocE7OA
         t4GeU6mfwpBmHtLVBdoZ74/bsh+9hABDVw49+C23Ovno0OOu9JAU51SS1hxgSB2OHNfc
         9cV/whnk2qsZpHDtsmMULIb4UkQRQaWQrZXuuKhd7FhhdyZPugBb1xgO6VFc7NK9b9oM
         KUXg==
X-Gm-Message-State: AOAM530fhoSxz0MpuDAUYCaTIRp/Iz7zT5UtIE5RRdTqqrqKAvaAiLyH
        BpOBp3VOA2cJK/9VF619/iqvOw==
X-Google-Smtp-Source: ABdhPJwPnAu6GxEtbvkmBsYYlq37s7S/b+SLfP/dnWOFbAPo+CfGLMLoumhTbTjwqhD7uD2j9lvR6w==
X-Received: by 2002:a17:906:f8ce:: with SMTP id lh14mr13610883ejb.89.1598542688455;
        Thu, 27 Aug 2020 08:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:07 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 3/6] tools/bpftool: Fix cross-build
Date:   Thu, 27 Aug 2020 17:36:27 +0200
Message-Id: <20200827153629.3820891-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
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
index 26a0006f329d..383489b5173a 100644
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
 
 BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
 
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
@@ -169,20 +182,25 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 
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
 
-clean: $(LIBBPF)-clean
+clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean
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
2.28.0

