Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD904779AC
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 17:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbhLPQux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 11:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhLPQuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF4C061401
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:50:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i22so15514699wrb.13
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpxpkXYQscEfsWsFoTOiPTSmY6NepL3QKAAqEPptpwY=;
        b=uEb42ddIqlf5GTi3ZfvCLziEA2Eilam4mdrPDskEFILbqlZDTt866z35BAaU3OXZHX
         KeNHt5fs1ZtAzz7alex5nB2Q/jUC47m90SdVHPHB9cCqRsXQJRdDKQupAPYPNwOjBAZd
         +7JQ9b/5pv7PgWy8PUTjaj1lzzfOh6qR3Ky59lP6hPZ72rQe5JZjiZfN65ktvwmCiQii
         GAajOxxX0z3DRjzwwkO21PJE4xsaG1gTKIEBw/eaDF1EmrFziAbdPKi8lN2E4rsPmjQk
         14/g2kUw1Gm7e8QICYTBHM3xBRi1fd2rPZckm8k/lXuq3QAp+a5sY5gLWLpGTL7vR1+p
         Wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpxpkXYQscEfsWsFoTOiPTSmY6NepL3QKAAqEPptpwY=;
        b=RILhHcnPKKOou7MDykJjzxG4u2X2XK+UcUQC2N6UcSx056IpNi1u0peBbl2RTeTTZh
         QYgQqFoErFQ+9gbG15dD3MReqAsoSfcwUtEayBZjH03GEbEqXgfk2RJD/XyHchegt/7U
         7ld/jNY6Gb7zMtvyTtKjWk/kZ3wgMkCFZn0Xo/YJbPT7NZjoztuc1h6HJeAEDpGvin62
         dreblLW+e8zmVvbILCSnLZPSOaJ1/57/H9ZPY3oJfe/5iunkCjR9sWoGNn33RbzmrlYf
         YfQtiSNIRa+55RAE4HRYiM/RYDXuSx2Oyj/oZDrAZKxEMaGH4pnsdxElBTlr2D6SWDmd
         Lpow==
X-Gm-Message-State: AOAM5331DB/c0l9XOiwIJyWTvPqiMe6aBtXMvwyvdcwPfunnd7jbl4Sc
        O37tpspxwsn2XjE8lVdQRVYjxQ==
X-Google-Smtp-Source: ABdhPJyh5IEh8DFsqYWeu4iMwCkRIQ4DYRdYJrE9x2CeUc8WZt+jk1IHdBFqcFelUpBlrrnjehm+nQ==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr9601163wri.461.1639673450279;
        Thu, 16 Dec 2021 08:50:50 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y15sm7438906wry.72.2021.12.16.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:50:49 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 4/6] bpftool: Enable cross-building with clang
Date:   Thu, 16 Dec 2021 16:38:41 +0000
Message-Id: <20211216163842.829836-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163842.829836-1-jean-philippe@linaro.org>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cross-building using clang requires passing the "-target" flag rather
than using the CROSS_COMPILE prefix. Makefile.include transforms
CROSS_COMPILE into CLANG_CROSS_FLAGS, and adds that to CFLAGS. Remove
the cross flags for the bootstrap bpftool, and erase the CROSS_COMPILE
flag for the bootstrap libbpf.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/bpftool/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 42eb8eee3d89..83369f55df61 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -57,7 +57,7 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
 $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
 		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR) prefix= \
-		ARCH= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
+		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
 
 $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
 	$(call QUIET_INSTALL, $@)
@@ -152,6 +152,9 @@ CFLAGS += -DHAVE_LIBBFD_SUPPORT
 SRCS += $(BFD_SRCS)
 endif
 
+HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
+		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
+
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
 BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
@@ -202,7 +205,7 @@ endif
 CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
 
 $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
-	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD $< -o $@
+	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
@@ -213,15 +216,13 @@ ifneq ($(feature-zlib), 1)
 endif
 
 $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
-	$(QUIET_LINK)$(HOSTCC) $(CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
 
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
 
 $(BOOTSTRAP_OUTPUT)%.o: %.c $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS) | $(BOOTSTRAP_OUTPUT)
-	$(QUIET_CC)$(HOSTCC) \
-		$(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),$(CFLAGS)) \
-		-c -MMD $< -o $@
+	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)%.o: %.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
-- 
2.34.1

