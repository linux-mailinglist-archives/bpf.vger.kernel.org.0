Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FE45958D
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhKVT1G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 14:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhKVT1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 14:27:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F5C061758
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 11:23:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so679098wme.4
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 11:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3LTkpgb4YE18mw3OKBtH3udDe7QlkxzG+PzZ1tUbsA=;
        b=dgftq9xHELzP4x8nZQnYg2fvVYgxq+O8uUGW9nXLbnBHDHJBPWypWfKOjXWLq4S9iF
         eg0v3LD9aaT7ORh8gV+EtUWTpfagf2hc9sXGyLdaFcgzkXQHHe14f6KoVxgUtxbP0DN4
         2CbY7CrMHWfO1OkaCcHf25L/1eAI0zw6UJwSQS5HuBAXEkUzKB6b6mdy//mpWCnVhO6d
         OLeprSGhW9MRJ3I7521ctm/H97FkG7iAyHF7HfywbJkOaYgI/KkgQapINuAE7rox6M8Q
         Re4xGtoJxVCWZfz8zpWdj76EylB+J2eKiZIUqQX2EGRtf2D9uUss43mMul2XGxG68jec
         X1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3LTkpgb4YE18mw3OKBtH3udDe7QlkxzG+PzZ1tUbsA=;
        b=VxXQ+yNazMM6Cdwyf3wwDqcoK/bwrZhi3xIeLNXhvIxVCAJVC9ORH9t647QCfgU5Bh
         s7bDZC5CnudUIZEqrRSZjz+xs7ogLTjfX13JPekwymle1iCByn4AVU8mD04inYXgh3jM
         tAX679nwpZVospNzNZ/IqzukO1YJpA64wmlz/NXOpIz3jyefLx8gpe6BOsg1CnoemrSu
         iwXCjOzpxV9/8bE1xVjJ+zewo0qLVh/vDAbQ9BrI11ilJ8ZANKeg6dBuwLTgwtlgl1h8
         YoU0EK+R7WdOeZSFenvhgKWr1OjTB/435U+4L0bygCpMUv8guF/NQgEd/krHStAJhsgb
         IbgQ==
X-Gm-Message-State: AOAM531bXEVPCPZ0XblS6WRkLXYbdCOS7jh3Dn9vhR0WhKDCrDzp2jOG
        npdZaDvh4yrR8k9vh3vHFcGutQ==
X-Google-Smtp-Source: ABdhPJzbS8DyPHc1CvkMU//eUj0YedlEnTZRKz7L0NzB22USJIXqjQbsaV2Sx+5qVvccDCi8q7lOvw==
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr33315488wmq.161.1637609028936;
        Mon, 22 Nov 2021 11:23:48 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:48 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 3/6] tools/libbpf: Enable cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:17 +0000
Message-Id: <20211122192019.1277299-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cross-building using clang requires passing the "-target" flag rather
than using the CROSS_COMPILE prefix. Makefile.include transforms
CROSS_COMPILE into CLANG_CROSS_FLAGS. Add them to the CFLAGS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 5f7086fae31c..fe9201862aed 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -90,6 +90,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += $(CLANG_CROSS_FLAGS)
 
 # flags specific for shared library
 SHLIB_FLAGS := -DSHARED -fPIC
@@ -162,7 +163,7 @@ $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED) $(VERSION_SCRIPT)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+	$(QUIET_LINK)$(CC) $(CLANG_CROSS_FLAGS) $(LDFLAGS) \
 		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
 		-Wl,--version-script=$(VERSION_SCRIPT) $< -lelf -lz -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
-- 
2.33.1

