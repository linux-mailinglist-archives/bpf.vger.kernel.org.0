Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703EC652F86
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiLUKch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 05:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiLUKbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 05:31:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E77676
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 02:31:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so35779180ejc.4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/31VPUJXKlvItSMhi/3ovqws6KUEvH0jXSR/PDtght0=;
        b=5pQsp4EMCly/N12psM+kSeEvUKrBFWBWdZdcz3N5953GfqWLk6KYCtWtWfvUTxasYk
         8SliwD0fr+2VgdEdpMjfGl37dynRsCYQVRi7yFT8NoPy2PBj2ECWo/oUbmQ2hBSYrzwC
         1iclAS/kTZEAopNviLV+O4/eTzSwEgwla+aqvW64L3BI6S0gWU3sGQnkTyx178hzEsYf
         c2gIi0i8ufE5FKMMtpbEbf1y9Sd48FT6x3TP5YJ18EzFc/INl48NiU7O3u+enQoztfjf
         q6IUQ6MzGG1bmfT6PM0T2F2qB2yOb8W1WpyW3FtaZqFCwxVj35xhFqXJzcSPzB7RiZpZ
         R/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/31VPUJXKlvItSMhi/3ovqws6KUEvH0jXSR/PDtght0=;
        b=3iK3AiWkhFUiguwjJv4rnpB4kqbyjhduoKyb7u2B/wUovK4FT9TdHB6ywquHVXTxw3
         xxZB2YpK6p9f2kKDdcHr483DLopHZeYNtf+14K47MkWAyyOxmFvJUQisWqpMx6L/YFeE
         1m20u33rP95kctWtW95l9ufn5gB4HD8HESgCHzzvVauibqmvVQFfeqmjNqiZunhJu9yz
         BC63OOse/TySWPCeEjFvBN/HdS6FlRzem1q5YejipaIqMvEbyQWvzwHPU/fHU1wCga7C
         CewxHJOE0c8cHStUtWWA2oi8uYnJfIzSkmdeKfsDlRxiAWUl1DhyIh64VH3xfTGgLCuB
         /bnw==
X-Gm-Message-State: AFqh2kphZGRNYBihmjoiiOQ9L7vThhSmDyYzqixZlxe69Zepw0hs+yT/
        ysokCMrGXUF5rFnTA8IGetk8Hc+K9dlBetaPCz0=
X-Google-Smtp-Source: AMrXdXs48C/AqC/SNRWH5dn1vS8hr17HDPkG/tNr4mMoWm8lRecUs4Y5QrXjbIoin2B2YRv+orjqQQ==
X-Received: by 2002:a17:907:b026:b0:7c0:e7a8:bc41 with SMTP id fu38-20020a170907b02600b007c0e7a8bc41mr3870636ejc.74.1671618665976;
        Wed, 21 Dec 2022 02:31:05 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b007c0b4387d2asm6888133ejo.8.2022.12.21.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:31:05 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] bpftool: fix linkage with statically built libllvm
Date:   Wed, 21 Dec 2022 10:30:07 +0000
Message-Id: <20221221103007.1311799-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the eb9d1acf634b commit ("bpftool: Add LLVM as default library for
disassembling JIT-ed programs") we might link the bpftool program with the
libllvm library.  This works fine when a dynamically built libllvm available,
but fails if we want to link bpftool with a statically built llvm:

    /usr/bin/ld: /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function `llvm::CrashRecoveryContextCleanup::~CrashRecoveryContextCleanup()':
    CrashRecoveryContext.cpp:(.text._ZN4llvm27CrashRecoveryContextCleanupD0Ev+0x17): undefined reference to `operator delete(void*, unsigned long)'
    /usr/bin/ld: /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function `llvm::CrashRecoveryContext::~CrashRecoveryContext()':
    CrashRecoveryContext.cpp:(.text._ZN4llvm20CrashRecoveryContextD2Ev+0xc8): undefined reference to `operator delete(void*, unsigned long)'
    ...

To fix this we need to explicitly link bpftool with required libraries, namely,
libstdc++ and those provided by `llvm-config --system-libs`.  This patch
doesn't change the build with a dynamically built libllvm, as the `llvm-config
--system-libs` list is empty in this case, and the bpftool is linked with the
libstdc++ in any case as this is a dynamic dependency of libLLVM.so.

eb9d1acf634b commit ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 787b857d3fb5..e4c15095eac7 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -144,7 +144,7 @@ ifeq ($(feature-llvm),1)
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
-  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  LIBS    += $(shell $(LLVM_CONFIG) --libs --system-libs $(LLVM_CONFIG_LIB_COMPONENTS)) -lstdc++
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
   # Fall back on libbfd
-- 
2.34.1

