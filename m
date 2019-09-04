Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98596A9501
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfIDVXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 17:23:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45650 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfIDVXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so152976lji.12
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jcr7utRE+skJcsLIDmCcqhAtcA7yd+FAfx8VSIjlEN0=;
        b=ABJbZSLCV3FsQTMEMvdQFXH1D6yKF8jjS3/RsTHVZzVIkAvo/W1a9b9X01mzy8erDf
         IvqzyVfDgOZy32aa2l5oCtncvHQ6pMbPDxg7JN2j46uWoAF42oXFeCw9S7iXZ3TCsDU7
         bXlTQlfFkgg8VgBDXwIJy5jEQ0IpJoX1rT+fT8L3uKAjbYVAbZx8BJhUff53hbdBvUil
         4ImdVopvHM5krnUPckUJAQOEh8YvcljPij/nQuBCc39DZ9KGfce2McYBf7MWkJe1ieJm
         DCHDm8Q5yTXSRrFzvxF7e4WBVf0/ob1Bhcsx52IZEldzSy51EfyGwBs/8oSuQ/oTYIPU
         9AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jcr7utRE+skJcsLIDmCcqhAtcA7yd+FAfx8VSIjlEN0=;
        b=D34xYiGYi6lDKCa9k8VIrfm5hQltI2M/w4pAa/81U7XZHZTaqYEd2UgrnWewYhESEj
         84EPEm2ML3EDTPZU5IfEbXuEw3mHtSzzuWJPsUPU/AbaZd3JrQDXwKJQklHUzBIsFq1R
         8IonuuB5DjX0g2gWXiQFjFKma9f04pBgqr0yEZGUH70aVwposb1YSWsYzXofSUI0z7F1
         K9Z/A9gmyCXCBtEpcgTERbfo3OoAKCgsjEKEQWffFlj/+0ttGy8/KJr+E7nOZb5eQcRs
         XSfFORqL4JQ1s+Lc9OaPzyBu7COm79tNV2oex2UIADRWUL0mZ4Q+zV73Jsw5vn/gXdPW
         586g==
X-Gm-Message-State: APjAAAWN/JKXhvj6FeS1RZLgYzUWydlibFjYWqLnJ9A3Bdr62XtgOQ8u
        vS8H9TsfJI//eJSzFEIE2fzOVw==
X-Google-Smtp-Source: APXvYqzWzjPF5Ux6tXpfnaSESyw9BAsVGLBMfoM57dZneHbSnLSQxMQ/ucdfrDeUAhN152yzYDB67A==
X-Received: by 2002:a2e:8103:: with SMTP id d3mr3392965ljg.105.1567632185972;
        Wed, 04 Sep 2019 14:23:05 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:05 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 4/8] samples: bpf: use own EXTRA_CFLAGS for clang commands
Date:   Thu,  5 Sep 2019 00:22:08 +0300
Message-Id: <20190904212212.13052-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It can overlap with CFLAGS used for libraries built with gcc if
not now then in next patches. Correct it here for simplicity.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a2953357927e..cdd742c05200 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -219,10 +219,10 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-	EXTRA_CFLAGS += -g
+	CLANG_EXTRA_CFLAGS += -g
 else
 ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
-	EXTRA_CFLAGS += -g
+	CLANG_EXTRA_CFLAGS += -g
 	LLC_FLAGS += -mattr=dwarfris
 	DWARF2BTF = y
 endif
@@ -281,8 +281,8 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # useless for BPF samples.
 $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
-	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
-		-I$(srctree)/tools/testing/selftests/bpf/ \
+	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(CLANG_EXTRA_CFLAGS) \
+		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.17.1

