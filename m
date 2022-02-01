Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260364A59E5
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiBAKVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 05:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiBAKVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 05:21:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC5C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 02:21:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id h7so52700104ejf.1
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0qn/AbWYdlLKsTLrdNzjvpKb0731eh3D9ihByfG+Cg=;
        b=GclaufmiyIC2kKKQl4aH3RGgPrbBuv3HO3aoA323ZCByUaHOYBu14a+1X4OPD10WK3
         fm09gXtsRKcRrXHZzbGhdDWhrBhzp7aZRXgIHcl5GSEivA00a4ZpoPShGxrimismSBbt
         5hRcYS3bs53+jLtmUacafSZhb65dAhhzN6Q0cXaKlA9pMyNrm3qXPqQ8ZPQkwT4+kxCL
         k8gWdAn7OfjVIOKW38f7SPxR9tRi6j2OiiPzKJf2uR1GJjx7NLalUItt2Ps4tKxvxxFy
         TeMbypA4daJ/EklIghqrkNpywc3ae4t5HOTQg5sZADVHQTuDLqg3TFdR6HRfe7zZDMf8
         AffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0qn/AbWYdlLKsTLrdNzjvpKb0731eh3D9ihByfG+Cg=;
        b=hPrNFZ0QOZqyOV2LoaF2PTKKZ4EgBj3FKXANUhz4ooE2xE+jGigfoD0zTwR/LjS6w2
         49cJEE5NkLkf7oG7HSZuqYI3L+QzhynA3c2RqMlfAq4RsEtgqEtVTu9deX1aiBOaxvZz
         tvi+tavgaSnw4nfLot5DgB+XtG1NZyl6vBod51DVms0yi3sFuUxCFwutaaAk2zdVWOgj
         Z1SnoG/UNM6M3RkK0EG3Mq/ZWjVf/Aqqzq9K7cwHoXuNLxyplbsdcX95Zyo0GuW8Vu4P
         5tK/IBnDhS8UctROL1CXI1eRvJrNlCwCB3XdzBqeYxsdvdrUBV1T4SLApln0xvLnQzEa
         jt1A==
X-Gm-Message-State: AOAM533eUcqaEjftwkuRnXZTbax24/ZPVQSnSmuTIGpuIJUUgYHALdVV
        LTLvHxuw3++zaMWVdGa7qXHJdQ==
X-Google-Smtp-Source: ABdhPJzP6DNVGKDR/xSND+TRoZ71TnPMxBl+WvaIrcN/UAaCkj9VHFG9apRFHeZD0UVOyZv+T/zx4w==
X-Received: by 2002:a17:906:bc4a:: with SMTP id s10mr20318695ejv.371.1643710908455;
        Tue, 01 Feb 2022 02:21:48 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id lm6sm14283211ejb.46.2022.02.01.02.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:21:48 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     nathan@kernel.org
Cc:     ndesaulniers@google.com, llvm@lists.linux.dev, bpf@vger.kernel.org,
        andrii@kernel.org, quentin@isovalent.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] tools: Ignore errors from `which' when searching a GCC toolchain
Date:   Tue,  1 Feb 2022 09:31:20 +0000
Message-Id: <20220201093119.1713207-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When cross-building tools with clang, we run `which $(CROSS_COMPILE)gcc`
to detect whether a GCC toolchain provides the standard libraries. It is
only a helper because some distros put libraries where LLVM does not
automatically find them. On other systems, LLVM detects the libc
automatically and does not need this. There, it is completely fine not
to have a GCC at all, but some versions of `which' display an error when
the command is not found:

	which: no aarch64-linux-gnu-gcc in ($PATH)

Since the error can safely be ignored, throw it to /dev/null.

Fixes: cebdb7374577 ("tools: Help cross-building with clang")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/scripts/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index b0be5f40a3f1..79d102304470 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -90,7 +90,7 @@ EXTRA_WARNINGS += -Wstrict-aliasing=3
 
 else ifneq ($(CROSS_COMPILE),)
 CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/null))
 ifneq ($(GCC_TOOLCHAIN_DIR),)
 CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
 CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
-- 
2.34.1

