Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E24F9FB7
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiDHWqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiDHWqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:46:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4694B1CC
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:44:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu29so17454241lfb.0
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V15P+mvv2hqb/+ryMVHF0KaLi38LXFmSSgMx4imnzTw=;
        b=mWuiYUnqVJcKvn2mc8vlJUUXrdzXcOGyv/0lHYdO4XpBsaiM5GW+sLSPrGi8xUeQJK
         qkx4WgzqAm8ZlR97dHyK0g42B9pbrZE2sRzDAlXSfTPewEtGsl7cH99gXMUWRkzINRHB
         bFNbVKnbHLrRT9igDPG0frF6D0J+6dHXj4DFq/34HJlpP6c3JPR+tHgIGvgJUtd4hj+/
         +Kyk9lKFI3RkgPTFX4BBXn/aYHXn14crTwr3Ko2C4684qU05MbfNIfPuTaDCEwvIHEaA
         J13OpBP91sXgQub9p8XV+nv/LJ5wmiLVlvyUBGKZxJG0/CDYfUV/0ruRvFjdtKjl1+jz
         vhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V15P+mvv2hqb/+ryMVHF0KaLi38LXFmSSgMx4imnzTw=;
        b=TKU7oH2dr6QyomL1sUHvIlR8IWPn8xjwNlKpwVjh28at8F3HQSp/aM9iDpg5nmO7Cw
         RcAG0PW7+zmOaUGsMgcIKX+G1R28FTJg5iZ6c9clOgIofCM7zM4B8d1kSi0oYsJfZVTJ
         sU/MkYNYclKSdnZRwQ8Ym4YIqJA9ulHou5RLdLafR6Q8uR5oO9dlY4u26/DrB19b5oM4
         5oFoD7fWeVlgOpDfLGT9kJQsJj0VAT4u4KJehEqks3HvOUnfjB4novkgUABUOqIa4uqa
         EsWWxu/Svi7mse5eKl04tsBKDs8TOZe6Vocpg4/9b9fWBUWL3fNqRfgJpxgBTko0H45l
         XEQg==
X-Gm-Message-State: AOAM531baiToVaeCmu4quNmXCFoGkLc1eSxhx1RBI0DMU4so9jMRtLl9
        BVIYc/jl3uVf+bOErIvWhvqnZxWbYLQBmw==
X-Google-Smtp-Source: ABdhPJzYjqfx+qUlUDtxwtWbvmKnJPtUXZIAYJUEnUSO8WVryCvM+87Z4fpMDSVu1rtDNG08hisOvQ==
X-Received: by 2002:a05:6512:260a:b0:43d:909a:50cf with SMTP id bt10-20020a056512260a00b0043d909a50cfmr13769718lfb.195.1649457885211;
        Fri, 08 Apr 2022 15:44:45 -0700 (PDT)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id v21-20020a2e2f15000000b002456e6cdab2sm2338140ljv.93.2022.04.08.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 15:44:44 -0700 (PDT)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2] libbpf: add ARC support to bpf_tracing.h
Date:   Sat,  9 Apr 2022 01:44:42 +0300
Message-Id: <20220408224442.599566-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Vladimir Isaev <isaev@synopsys.com>

Add PT_REGS macros suitable for ARCompact and ARCv2.

Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

---

v1 -> v2
- according to request from Song Liu, added my SoB

 tools/include/uapi/asm/bpf_perf_event.h |  2 ++
 tools/lib/bpf/bpf_tracing.h             | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/include/uapi/asm/bpf_perf_event.h b/tools/include/uapi/asm/bpf_perf_event.h
index 39acc149d843..d7dfeab0d71a 100644
--- a/tools/include/uapi/asm/bpf_perf_event.h
+++ b/tools/include/uapi/asm/bpf_perf_event.h
@@ -1,5 +1,7 @@
 #if defined(__aarch64__)
 #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
+#elif defined(__arc__)
+#include "../../arch/arc/include/uapi/asm/bpf_perf_event.h"
 #elif defined(__s390__)
 #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
 #elif defined(__riscv)
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index e3a8c947e89f..01ce121c302d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -27,6 +27,9 @@
 #elif defined(__TARGET_ARCH_riscv)
 	#define bpf_target_riscv
 	#define bpf_target_defined
+#elif defined(__TARGET_ARCH_arc)
+	#define bpf_target_arc
+	#define bpf_target_defined
 #else
 
 /* Fall back to what the compiler says */
@@ -54,6 +57,9 @@
 #elif defined(__riscv) && __riscv_xlen == 64
 	#define bpf_target_riscv
 	#define bpf_target_defined
+#elif defined(__arc__)
+	#define bpf_target_arc
+	#define bpf_target_defined
 #endif /* no compiler target */
 
 #endif
@@ -233,6 +239,23 @@ struct pt_regs___arm64 {
 /* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
 #define PT_REGS_SYSCALL_REGS(ctx) ctx
 
+#elif defined(bpf_target_arc)
+
+/* arc provides struct user_pt_regs instead of struct pt_regs to userspace */
+#define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
+#define __PT_PARM1_REG scratch.r0
+#define __PT_PARM2_REG scratch.r1
+#define __PT_PARM3_REG scratch.r2
+#define __PT_PARM4_REG scratch.r3
+#define __PT_PARM5_REG scratch.r4
+#define __PT_RET_REG scratch.blink
+#define __PT_FP_REG __unsupported__
+#define __PT_RC_REG scratch.r0
+#define __PT_SP_REG scratch.sp
+#define __PT_IP_REG scratch.ret
+/* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
+#define PT_REGS_SYSCALL_REGS(ctx) ctx
+
 #endif
 
 #if defined(bpf_target_defined)
-- 
2.35.1

