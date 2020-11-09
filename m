Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06D52AB631
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgKILKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILKh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:37 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A3C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:36 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b9so8281546edu.10
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKZ4+2eyEb4R1RRmvhM/k0lBeo2ErDz99RkSgDH/CpM=;
        b=iMABYuUSpVZ+cluHRWOkqdFpPOxnHTfPQg9RMHF5eS4Ug5ql2ZC1dkpfMHVi6dOwVr
         hZzpKAYN4m5trVI3+6u+zMRWnHijLoyD8K8aoD3Iuf9gq6fSFAO/Gkff1Aylare4jbOl
         wZ7OGG6hniGkTY8rrAbzzN3GFrj/jWLWSTu4uw+mIga1GfV9LcdNTllqV1I1neWuYqri
         MRIUal7+VXpPHFD83WrlWCecC4l+aheBA39bBIIUSSospxz8mdZCutcbDXTOztfe0W19
         UiHCixwvnIeSX6UVYq0BBdOf17fyoKPX4uC5h75UBKstS2WvYrZSWgw0+aj/F8HYLXjn
         /UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKZ4+2eyEb4R1RRmvhM/k0lBeo2ErDz99RkSgDH/CpM=;
        b=Kn1K7cuO+ql/mTSlx4SgbEDLLHwC0oI1s6FPtFHZ5uH9xU6sGA2j/8VOEEvxVYnwOe
         4sXX1Ai22xucEvptPEUabYSFbYrW3Xor44lGq8BqStl0/+QZLI4WIL7e9rbHE4TBkjGp
         v4fTqvNynkI6mfKZqWdecDLAKDGiQhZLPIHZr7r0Pd21rBca83dvZFhKYEjGMIrXoZsl
         ryW9RRju6N4PIm3Gw+HHM/BMmREyhMeCtM/MIRw9f6Z6TR3/3CzJJLUu9EC2pqDyZJHS
         3WQW8aW5DnsVsN5qvoVOZfIb7mg/dJhBGKYZG/COpOQBvwLpaYHwJBMOZxTgCyr4wPad
         ulvQ==
X-Gm-Message-State: AOAM5317kAHeiTvSFEiafUTb7RAWpoquriQYqyKzpMK3vyKs1PtIkvVo
        Q8IYUvPFtAu9g+idadVvo8BLGg==
X-Google-Smtp-Source: ABdhPJzDiWlEYQuv0x6tmSKQHUZimjRwPFAxr9Jeyra+hd4ub0aFvcjwwgUZJhvqPmetr0562q9nUw==
X-Received: by 2002:a50:d587:: with SMTP id v7mr14272180edi.38.1604920235625;
        Mon, 09 Nov 2020 03:10:35 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:35 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 4/6] tools/runqslower: Use Makefile.include
Date:   Mon,  9 Nov 2020 12:09:28 +0100
Message-Id: <20201109110929.1223538-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
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

