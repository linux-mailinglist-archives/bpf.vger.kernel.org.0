Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD1653E3F
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 11:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiLVK1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 05:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVK1S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 05:27:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4F18365
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:27:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so3791537ejc.12
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljmchwGOSv1mKwTABEDrD+Xj5luqUOTbeklyb9AdXpo=;
        b=B8cEVoIWuyuB5h1fGwRytdS2nDjFi5cTCKUGdCkeTo09TsvL/5gFP6jVdeqCb//z2U
         7gKUxjyN9Q41pIWG0Yym79zgeqQ4ETPwNNgyVitkFJArnsHj2ypcx2sYIi7bdhC75+Aw
         t9un2V/Y7mdyviE09GooDx5qj7Rfnnfw7WAMZ+4Q5HDfrsXuc3N1n/0NOYb8NUNwuCIj
         FvzHqw5OMm0TEPeanPOkJ13O0MRpYz0HkuKL0MW7l5Bxa7oCnhVygE5bHQ7FW6fm7S3g
         22xzZoQ8Ldn1e3mWAu3L/ub0t08qoVsjgwfGbZugtnvCwabPgUdW+KcGEat/1vKwC+xA
         5opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljmchwGOSv1mKwTABEDrD+Xj5luqUOTbeklyb9AdXpo=;
        b=vpRFYrJFm7sTizek3u0kcvYfpo56bT3KX3M+WJ+lBFdgHO1pp7wN4AI/Mzpt6aZj03
         RKDN6kxWYOIxAvrRUPLAFWF4Ops8fNwumSdJuOkXlFAJ8Nw3EPyYY6viRiFq4V2BR6Be
         IrgXmeGRbWjgEa6dUkMlsvJJfPOHlEMOka61k/CDE1GYWG++jmjaVQIbvXzEM546PDPJ
         S9IIoMBV7Q875ZY+xiu4GFYnKvI0ElgGyd8qmWppeMEjwohXVTmYxjIjUG/RsIVXM3pX
         VqDU/KTcmASQzuWnzqtcDJo3i5hvEJFGbE43LnUpqSbEU9asVPFzbPthAorGElTgt9Xq
         YA1A==
X-Gm-Message-State: AFqh2krJO5DOUWSf0Il8jfL1uwp+OzRKbkm8n4c3hiYscaw9JkqlqTr4
        HyfYioumfYbA+7/Q/pRVuaKnR4zCJj43Hko//WM=
X-Google-Smtp-Source: AMrXdXv18rYZ8WtxA0sQToLQ4vamGjDxkX6o4eyp/cRqRexgqodIxzpJRT3gw761+KawVyFDaq0yQA==
X-Received: by 2002:a17:906:3513:b0:7ff:7205:414e with SMTP id r19-20020a170906351300b007ff7205414emr3896056eja.69.1671704835103;
        Thu, 22 Dec 2022 02:27:15 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906680700b007c0aefd9339sm81418ejr.175.2022.12.22.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 02:27:14 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2] bpftool: fix linkage with statically built libllvm
Date:   Thu, 22 Dec 2022 10:26:27 +0000
Message-Id: <20221222102627.1643709-1-aspsk@isovalent.com>
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
libllvm library.  This works fine when a shared libllvm library is available,
but fails if we want to link bpftool with a statically built LLVM:

    /usr/bin/ld: /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function `llvm::CrashRecoveryContextCleanup::~CrashRecoveryContextCleanup()':
    CrashRecoveryContext.cpp:(.text._ZN4llvm27CrashRecoveryContextCleanupD0Ev+0x17): undefined reference to `operator delete(void*, unsigned long)'
    /usr/bin/ld: /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function `llvm::CrashRecoveryContext::~CrashRecoveryContext()':
    CrashRecoveryContext.cpp:(.text._ZN4llvm20CrashRecoveryContextD2Ev+0xc8): undefined reference to `operator delete(void*, unsigned long)'
    ...

So in the case of static libllvm we need to explicitly link bpftool with
required libraries, namely, libstdc++ and those provided by the `llvm-config
--system-libs` command.  We can distinguish between the shared and static cases
by using the `llvm-config --shared-mode` command.

eb9d1acf634b commit ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
v2:
  Use llvm-config to distinguish between shared and static modes (Stanislav)

 tools/bpf/bpftool/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 313fd1b09189..ab20ecc5acce 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -145,6 +145,10 @@ ifeq ($(feature-llvm),1)
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
+    LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
+    LIBS += -lstdc++
+  endif
   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 else
   # Fall back on libbfd
-- 
2.34.1

