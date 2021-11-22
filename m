Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3D45958C
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbhKVT1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 14:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbhKVT1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 14:27:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20FC06175C
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 11:23:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o29so16502912wms.2
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 11:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20odS1sGlZOVOTVJ+h0ATXc3IjCp4ghIzYe7OtypAl4=;
        b=Tn1lU0bD88IO+9yCRA6my8Iwn8DdSi2yjmwKm6kCVat9P4MZbf8fk8q1VWneE0TQMr
         xnQSOZ+OGzgQUnaQRhJrBVw8vuNdWTbTKFLwx/nlO5xCaGq/zFUzcaPK9h51bWJxQ3ik
         Per+P/IB5wRUmmxGrykwQfiRNOBPXSvqCf2mp0Pg+peiE5PtpEZCvU3IzL9SXBgoDSJT
         9MjphdkIt/a4BQLYOUr3f4akQA/F2Zlwj5jXh+48xjNpBUj3LphtLWGQY7+K7piMHFmt
         nk95BeGVt1G9J6C34OPzChTKQfutYPiyse4sOcDVW+7TmgMR8d6h5nhk55JdaisCqkwi
         pgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20odS1sGlZOVOTVJ+h0ATXc3IjCp4ghIzYe7OtypAl4=;
        b=QLKbhdlXZPNc771Wa8u8gOfYG+hEZppBhZiinfIrv2wgiurmf7zwJy6oP+I4QnN9Y4
         rbC2b+3yNYr8tJEBmoxL6Ve2y5QXtwA61kFPeJvEADfR6mDuFFyXBjVfTGc0mI9s4sOZ
         1DZx2t+OsKJf0tvpgf6gCosxjPA+huvr8rNp18cfuHmg+hhLnGuGjNIkfxtpQdZ1MQWD
         6KObKFzsrrEWgrNBS5e3926y9iTo8wV/IMGRaLHfbZtNb51dInyjJCfdQRseO7cXiWsF
         GwdTNFCXo2zqu8x5CFOAywbC9Kxcf9/H9SnAknJ5DzGlQ48/TX6ymsbVcJ3FFrWsIiWR
         p+PQ==
X-Gm-Message-State: AOAM533KGn9/J94a34Rbz7Yd2cADuIMD8cjqJZXVATVDdH5NGbCnEuy9
        +nfWmwFKIA15dedr1eJoYKVKXw==
X-Google-Smtp-Source: ABdhPJwO+fR7TuysSgJw95qlWY88C/MS5DSdhnBIyjOi33oxzKHfxJ2yjFeNCmhCvb1o8azdpWmQhw==
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr33464993wmb.131.1637609030871;
        Mon, 22 Nov 2021 11:23:50 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:50 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 5/6] tools/runqslower: Enable cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:19 +0000
Message-Id: <20211122192019.1277299-6-jean-philippe@linaro.org>
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
CROSS_COMPILE into CLANG_CROSS_FLAGS. Add them to CFLAGS, and erase
CROSS_COMPILE for the bpftool build, since it needs to be executed on
the host.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/runqslower/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8791d0e2762b..da6de16a3dfb 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -12,7 +12,7 @@ BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
 BPF_DESTDIR := $(BPFOBJ_OUTPUT)
 BPF_INCLUDE := $(BPF_DESTDIR)/include
 INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
-CFLAGS := -g -Wall
+CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
@@ -88,4 +88,4 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OU
 
 $(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)   \
-		    CC=$(HOSTCC) LD=$(HOSTLD)
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)
-- 
2.33.1

