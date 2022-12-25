Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9E655D21
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 13:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLYMEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 07:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiLYMEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 07:04:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10F95BB
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 04:01:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so8665720pjh.5
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWvEKeZXI1rB1wz3yUyFiGe+8/2+5HAKxZsLyUNZlno=;
        b=F+zdfPQR6vsSBibTfE6kkHg6FYweaExEu2uNbpjezGOjxWMBkSJAgy8PfxURbqGiCk
         6VCl+bT4VcJp38kSlkLXXNAPYEy/Wkz8223FQFxyb71G0QcDduYont1cjRsmJ+DPCRRZ
         2JqGvAHqMfIGyFeTqT3Od2YgOcWpDYE0F0wxmWrfLpSqLVx4TQhr4GzcStR2oAslC6t/
         ZbNk5nmQ624f4+SOe01aox+onp9uz4zuLJpLD2Pv0cIDxM1iFmVKS8IMGdhhlFWSfGgs
         4I5XLmIIQXA8fygPJsTlGaTGVQZ6pdGOxy8CNLmSNIiEhFlX3eO/JRSU7PbSNzzn4Pxz
         IAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWvEKeZXI1rB1wz3yUyFiGe+8/2+5HAKxZsLyUNZlno=;
        b=g2EInzYpM1wVfzEmCGsvxNzWevspoJrl10PUXYsI/lYxOxs33ULvQIMZJiL5gvp06Y
         DZ0gGDNs96I6qpzIjTYmXL61tevTwthYB8NSkL/JhTmpTJ8nBzuKgjK65df/YMr+eC6m
         IWq/mcVcxToexvzylDlMaMitwRP7JDK0w0o71Y9mIHJhXScjpGykd4eTdRYzqByAeCYw
         claM7F6TCWIFA4C+0PyDksHk8WlZCVfF7DCAuMXMvv4xObXCrxfdIeT6S9myR5UFwYOW
         Qo+JpsRs8x2tFUiXH3Bquoe4r0RsvwmALuwRoNWqy/mjt/XqR9e89BRDL0bfzXyL+8QS
         Eoag==
X-Gm-Message-State: AFqh2kqO4UFi0f0oYMeKdg3zRpnG7SfN40p79vUAlIJi4nQbmjhAKWk0
        WbFLdvkZNnDCb2LDD3NJqLIucR0s/oY=
X-Google-Smtp-Source: AMrXdXvcrjqsvadp7m8/4f3hc5XK8N4cUHd/W3kWoBZ/wVAxPDo+U2icvmb0g0lmQgiFStSQECgTzw==
X-Received: by 2002:a17:90a:4ca2:b0:21d:5e73:d562 with SMTP id k31-20020a17090a4ca200b0021d5e73d562mr16983369pjh.27.1671969718275;
        Sun, 25 Dec 2022 04:01:58 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id dw6-20020a17090b094600b00223f495dc28sm4797766pjb.14.2022.12.25.04.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 04:01:57 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev, andrii@kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
Date:   Sun, 25 Dec 2022 20:01:38 +0800
Message-Id: <20221225120138.1236072-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add PT_REGS macros for LoongArch64 ([0]).

  [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 2972dc25ff72..5a8a0830d133 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -32,6 +32,9 @@
 #elif defined(__TARGET_ARCH_arc)
 	#define bpf_target_arc
 	#define bpf_target_defined
+#elif defined(__TARGET_ARCH_loongarch)
+	#define bpf_target_loongarch
+	#define bpf_target_defined
 #else

 /* Fall back to what the compiler says */
@@ -62,6 +65,9 @@
 #elif defined(__arc__)
 	#define bpf_target_arc
 	#define bpf_target_defined
+#elif defined(__loongarch__) && __loongarch_grlen == 64
+	#define bpf_target_loongarch
+	#define bpf_target_defined
 #endif /* no compiler target */

 #endif
@@ -258,6 +264,21 @@ struct pt_regs___arm64 {
 /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
 #define PT_REGS_SYSCALL_REGS(ctx) ctx

+#elif defined(bpf_target_loongarch)
+
+#define __PT_PARM1_REG regs[4]
+#define __PT_PARM2_REG regs[5]
+#define __PT_PARM3_REG regs[6]
+#define __PT_PARM4_REG regs[7]
+#define __PT_PARM5_REG regs[8]
+#define __PT_RET_REG regs[1]
+#define __PT_FP_REG regs[22]
+#define __PT_RC_REG regs[4]
+#define __PT_SP_REG regs[3]
+#define __PT_IP_REG csr_era
+/* loongarch does not select ARCH_HAS_SYSCALL_WRAPPER. */
+#define PT_REGS_SYSCALL_REGS(ctx) ctx
+
 #endif

 #if defined(bpf_target_defined)
--
2.31.1
