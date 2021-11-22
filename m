Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E039459582
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhKVT1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 14:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbhKVT0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 14:26:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C940C061746
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 11:23:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so680839wmb.5
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDICyqBCyU2udumcBVTu0p9pr75weFjqtozx/DNW2VQ=;
        b=d+i6bSB5J837uvpw9A53cC9RuzjeZR9tJhOOhDEqV7sFkpNKnHnx/G1nXFZZpeWN7D
         9XSJ+aXLqHPo1uCxNWcKrsU0LMmMt9WdMnj0+JDRD0BuIuANjEUZWyAHWpPpMLmY5lPG
         lnXb8y86ANZVrM/w5c9Ylr8Hv8/RjwdZGVk9aawzzA9DtLq03S/qWpeeN5aqt0tlFoBc
         sf2m87y4jl+L+BY1udLO7FzLCWwPXeOuRS8WTxrfIABuJhkNqbw5pAgjRgXe9RTYk1vy
         Kd9q75+WvgebWhzHCVFQIbSgbop1ednOMU5+eAzr7cbTnSGF4MBtToH5Wez5Mx+Dxi7u
         b1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDICyqBCyU2udumcBVTu0p9pr75weFjqtozx/DNW2VQ=;
        b=RuomnKgybDgJg8sNPiiaRhYN/cJFYdXnai0kw6XoqvLUEEelfrgfjUsTY0fliE+JXh
         JFkVtN/ai0EwP54iCV4neeMCSKuE3tAVAvbz5xk6LEibO3cmRYhL/iL1c5TPWC1hMdQB
         v5y5BqlhB31sUgkiWHaZqNL85QKg6RMZ+A/HCj/5okref0CoMXzFfN/SLyk65CNhYMAG
         IHNMOQx59IF0SvCw/ukjCjHlWiLb2bnBNh73PZZFvoDTt0pKgGnfaTeAqM1rj2tXBO+j
         FBNDvf7/4LTNOqyXDJUfhs/ZLMjsQMT6tOZJ2fiSM+u6pFFjIgsA6j49YSKsWopeBLSd
         Us6w==
X-Gm-Message-State: AOAM533h4Pzsx3mS6lvcuupBJp9o8hn0Ubt/BavjMaKgM0fDvJ3xEaqR
        AP5G1rhH/4SvO7hpoPRGBzHc5Q==
X-Google-Smtp-Source: ABdhPJyuQ3q0UHvKGua2+rO2YKZoAB/o+s0tV/BFVxOAryYMi3xaTsIOv5qNfnWUKjHc6GerxF3Y3Q==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr32984997wmq.138.1637609026989;
        Mon, 22 Nov 2021 11:23:46 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:46 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 1/6] tools: Help cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:15 +0000
Message-Id: <20211122192019.1277299-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cross-compilation with clang uses the -target parameter rather than a
toolchain prefix. Just like the kernel Makefile, add that parameter to
CFLAGS when CROSS_COMPILE is set.

Unlike the kernel Makefile, we use the --sysroot and --gcc-toolchain
options because unlike the kernel, tools require standard libraries.
Commit c91d4e47e10e ("Makefile: Remove '--gcc-toolchain' flag") provides
some background about --gcc-toolchain. Normally clang finds on its own
the additional utilities and libraries that it needs (for example GNU ld
or glibc). On some systems however, this autodetection doesn't work.
There, our only recourse is asking GCC directly, and pass the result to
--sysroot and --gcc-toolchain. Of course that only works when a cross
GCC is available.

Autodetection worked fine on Debian, but to use the aarch64-linux-gnu
toolchain from Archlinux I needed both --sysroot (for crt1.o) and
--gcc-toolchain (for crtbegin.o, -lgcc). The --prefix parameter wasn't
needed there, but it might be useful on other distributions.

Use the CLANG_CROSS_FLAGS variable instead of CLANG_FLAGS because it
allows tools such as bpftool, that need to build both host and target
binaries, to easily filter out the cross-build flags from CFLAGS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Most tools I looked at needed additional changes to support cross-build
with clang. I've only done the work for bpf tools.
---
 tools/scripts/Makefile.include | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 071312f5eb92..b0be5f40a3f1 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -87,7 +87,18 @@ LLVM_STRIP	?= llvm-strip
 
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
-endif
+
+else ifneq ($(CROSS_COMPILE),)
+CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))
+ifneq ($(GCC_TOOLCHAIN_DIR),)
+CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
+CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
+CLANG_CROSS_FLAGS += --gcc-toolchain=$(realpath $(GCC_TOOLCHAIN_DIR)/..)
+endif # GCC_TOOLCHAIN_DIR
+CFLAGS += $(CLANG_CROSS_FLAGS)
+AFLAGS += $(CLANG_CROSS_FLAGS)
+endif # CROSS_COMPILE
 
 # Hack to avoid type-punned warnings on old systems such as RHEL5:
 # We should be changing CFLAGS and checking gcc version, but this
-- 
2.33.1

