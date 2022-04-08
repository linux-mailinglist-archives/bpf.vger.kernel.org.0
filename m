Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D64F99A6
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 17:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiDHPlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbiDHPkj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 11:40:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3129EF0BA
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 08:38:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p15so15728809lfk.8
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFdD+A2EohTP65KQkKV3Pqn5e8TfPQKEbucjauIlrko=;
        b=AFWbu8oi0d8yjs8OiP3NZbNFgzEP9XI5whzn32iJA/DL0lBrC+ONZNHicz2Sbf+vq+
         YZ4Kx4xsh11bZJU9vEVrXRoj0nkXTfyEXwfFOqic5WK1XRLHdZXV7gchXVDwg1dpX5i0
         FnCJsWyGZx0fErj5A4+hv2+QgyP+eIkC2b/AOtXCiJm/bqpncBf2RWbu4nvj407A+G0F
         SPvGSIJAktsgtC7Tf7NvzkI53Topq54iD6x4g8nmMWuYVKv/lnapwlxGGjJzJAKmj+FQ
         ysPk2bO0EpA34sxigPMCPxqdjqetVnPesm+L8iOCwaM2nQiuzfehAMz5VBh6XigCS6Aj
         mVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFdD+A2EohTP65KQkKV3Pqn5e8TfPQKEbucjauIlrko=;
        b=eMFyiACBdJRmy5/l+pSssDVzjpyQNmdSeD4mb+l9rqHrzg2ELdD3JSTR44IQAMju+0
         T0VFIIl2OrPrNSS7qDzo10RgN7LxWB5ygHXSZadCc+65A2YANv2PuCnFUB3eo98sHMQN
         d8KMoDoZKL5J2Tls4lbAm2qKwkURM/wK4OAnzg5vVDfS22mWrcQctHpLjcv7oI9m/DnZ
         KchBBqKwkZEKqfN4PKtuWW0F/llRsLwLU9gvuJ4iQtYsZP7GdI/9eYbnmuLwYlcPmrhs
         ad3ZC3i3RaoPw/LfE3O6MpLm2ezy1W3fRVrWH1iLZzDvF2AOLNY87TMXZrIxmqMGJhas
         Me1g==
X-Gm-Message-State: AOAM533J+cVGdGf/UhbacaCqRWaTzBCq7pDCo6Q4WNtPZnz5POTIdX2l
        7DwpoDY/oEm4oTp1f1j6pqVXVNUWThdQZg==
X-Google-Smtp-Source: ABdhPJyNoKC0n05Nryhm2tdj/2erMeJ7dQrWClZ5JI4dSJdbTPyw62ihPnetdbwyrFABIb5Vczk62g==
X-Received: by 2002:a05:6512:2353:b0:44a:26d4:607c with SMTP id p19-20020a056512235300b0044a26d4607cmr12847638lfu.638.1649432312368;
        Fri, 08 Apr 2022 08:38:32 -0700 (PDT)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id o19-20020ac24c53000000b0044a0574bbc5sm2489830lfk.0.2022.04.08.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:38:31 -0700 (PDT)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] libbpf: add ARC support to bpf_tracing.h
Date:   Fri,  8 Apr 2022 18:38:29 +0300
Message-Id: <20220408153829.582386-1-geomatsi@gmail.com>
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
---
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

