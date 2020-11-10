Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C197C2ADC52
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgKJQns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 11:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbgKJQnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:47 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BFC0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:47 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so10014285wrx.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKZ4+2eyEb4R1RRmvhM/k0lBeo2ErDz99RkSgDH/CpM=;
        b=D1c6u/Q7Uivtn1YqumM/Mx5XpBbog/Tpl2dysPAcY7xtJNaZELtI+Fg8rDqBQeqLAZ
         Zmx/rT9ingEjcqrtwdsPU+gkpgQRhEj3cb+Anqw0uD/22n1IheDiQw0wxxLLNJWKcWI9
         A0+OKDJ7LTVFqm2MYJwK0he6BLNY9Y8RleEbIxA/62zX/glci4sfSaXOXRCL1OA/MDMI
         xXsFpt30V9kg6VUN3P2EWkINQ+S/hCQUCd1mkB3/OWIEgUKaN2nZzrUFdEiqLIJU4FCz
         TFv/ZcXUJfPAaN8rJM89d638wzCxFPginIKs1fxgC9GvKe8cyF76vLeta/09WEBROeWk
         aNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKZ4+2eyEb4R1RRmvhM/k0lBeo2ErDz99RkSgDH/CpM=;
        b=H79VngsnBlhCcqZn2zDIN4LRs+8NbIYXDIzC34KJi/RVb85CONR76HFP/Qn7VyfNLp
         xo9Zt54yu1n9v8611I9v22Pip40HCycgbUgazBoLrB7XabgRe0stS4AaGEphlxFp25c9
         odKb3NWO0hltB7/8oMX1f/RPZy2abGjR5+TRBtvfy6BAB+AxfY9dttj1XK2XhAT/YmkT
         ws3ssrln1DH8EVy3Q+i0/WFIsB1GJK5zpXyPHqrHduDu3lvLeeWRb8mXBrT8hhERTvn+
         ISnhJfA1N3zBqnK1rIkn6+LFUyV2R6pvS9GXnqNCvBIbaib/GzaKiiyTxVnUO8p85aev
         kQbg==
X-Gm-Message-State: AOAM531nFlTPNkNjhO2O+jFyh0CoiLbRSEFxFgurxkxMFRy1oj3vvFAH
        EmvohMafHEmOQbvBhDQK/s8q1A==
X-Google-Smtp-Source: ABdhPJwIo2ZPFRCBHa/r8BrH6Q0b5zggNR7iQI+uIpmQqCkhmMYKmHzCeSNGlZpJD8Y0DIgPjRIlng==
X-Received: by 2002:a5d:4a07:: with SMTP id m7mr23698904wrq.316.1605026626076;
        Tue, 10 Nov 2020 08:43:46 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:45 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 4/7] tools/runqslower: Use Makefile.include
Date:   Tue, 10 Nov 2020 17:43:08 +0100
Message-Id: <20201110164310.2600671-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.29.1

