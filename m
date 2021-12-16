Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870FA4779A9
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhLPQux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 11:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhLPQuv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5128C06173E
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:50:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1712219wmb.1
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ57tzLvzYQgO/9a3Xp1difD235xOW6tp16fePO+Nvw=;
        b=FssgxFJeWNvA52S2sKL8qB9q1T0ylP/fCugzW2B7O25Ifxn5IiNuY3dG8Bzo6PA9Rk
         kwV+nNqZ9QZ/SRGM0ntcjAk3PpHDXtW8jGqDo9qv26D9ZXRjsiTPE1u3kX4VdjZi3mw9
         T4yiRmy2ZNZOorhXbNxf3mtNLHNMKUPY7Q0GDycbsLZmO0Z1q38k9xLg2fOyYl5ZUcXM
         jYeDM2xivey529HnCxoeEYc+ilywrnRXW+QAzGS7iLw6UFoAcZ38r/SOBJoR6ATWvl0M
         F6zNnMzjkhW847CpHIaTyz3JMrC1f64//fNhIl1GGt/tZ2WKShrkm1VhRmkJ9PQpZc08
         0Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ57tzLvzYQgO/9a3Xp1difD235xOW6tp16fePO+Nvw=;
        b=z9hu4SyuMdK2TNKrFDzJggJBT8EWVHSxj3GlPKLT7ht3O8z9f085btKH2gFdxCEkBZ
         wUxZIaO4xks2yWV5JBFulzGaG8vYracKJYzLhwoRHMhQ6GfdUT8ZU06LrUqN05vmq+Th
         /mt5awn6lbA0AVLzKHS+/0tsoao3Rpv2JaSXRZBH1C2QifG7KeBJ1KAtCtE82w7UDdYR
         a9Qn4utIKlJIJXoluD2Zwizkz1tvMD6E+o4xKI9qauJMeDDnsyVgP/+C8JP5gFWqan9R
         nMfcivbBP+5XXFpzcxKdTI7A/5nxfG+nTSOdq73IaIWAQE82YT/LIjWdBjfuFG+KHNDo
         6bcg==
X-Gm-Message-State: AOAM531qtgFAGztDDbZRLbfWOrnCyqRSVQR/musdvRDAPifgafd0PJty
        sa667ao9jfPIwuozXt7ZqOT3DQ==
X-Google-Smtp-Source: ABdhPJzkUQ91OzbhQT8Zh1Yv5cFer+EkjDQhAjtPzPWe+NBWXRNdGWaP8Jrjn9dbEUm9AuAgAFar0A==
X-Received: by 2002:a1c:1f88:: with SMTP id f130mr5863988wmf.91.1639673449319;
        Thu, 16 Dec 2021 08:50:49 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y15sm7438906wry.72.2021.12.16.08.50.48
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
Subject: [PATCH bpf-next v2 3/6] tools/libbpf: Enable cross-building with clang
Date:   Thu, 16 Dec 2021 16:38:40 +0000
Message-Id: <20211216163842.829836-4-jean-philippe@linaro.org>
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
CROSS_COMPILE into CLANG_CROSS_FLAGS. Add them to the CFLAGS.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 5f7086fae31c..f947b61b2107 100644
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
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
 		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
 		-Wl,--version-script=$(VERSION_SCRIPT) $< -lelf -lz -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
-- 
2.34.1

