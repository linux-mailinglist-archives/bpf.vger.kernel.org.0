Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B519865A371
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLaKIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 05:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLaKIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 05:08:19 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B7D10D
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 02:08:18 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e10so1623719pgc.9
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caYBi8+Qt+SIFvPenZGmyOkcUedrR0YCFyP77etiBps=;
        b=ggXAqQShudCniXqA622DYIC+fqJZ4fxh/7M8gwkk3zudEz6sXU6BMG/qpTlCz9iVf9
         LyAC8xKhe+ZWeNdN6sKaBNdl64bhn6iP6jfT+jd8c5nEKtzxtml5lXnILxrFU27rSWtA
         dtoJhLTK8jhSDYptWvbmswBXEzV91Szrg/qR7Xjc0BFKtnzYQEqgcVzdGvA/ALkcU7Ib
         OEggVL5HcXSkHl9fzlnLWjIQNWSTLdRQgxvys8utAdBdK6mywC7tYVwMU1G1rKgJaXSW
         bk7NtuSNCXdkO85vpYuhDYg+5HNgOgao5I5djdQavdtShkfyqLRbh4JonfoSCoOLQySf
         n29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caYBi8+Qt+SIFvPenZGmyOkcUedrR0YCFyP77etiBps=;
        b=SN8qzi5O1tKf2MgI/L4EsFAojjO9rRXRowIag3ncT7EYFIqC9D71PcqyVEMcanwjDp
         8q3AFr7Ii3QvbiRkjSdlPm5fmx7xwsGzAVQc6j8DEJCyJeBRMQpLk28XJ541raDv4Whj
         TU//cfG6PgGX/FsaQAqOMV5Aw9/B5zV08GBHRCgkUxMLSYQwpymo8+nWI/PbDVjUxGA4
         RAxiHRZi2o5uGuuTNtwvbeIVUzviJeQ40IijZ0iYodWdnvQSDqfFO13sYe4Ut8A2P8rx
         EZNFz8XLQa0GvJVTldAUCGoC24IteqXSynP4OCP5dhdbGAlDnNnQf7cPJJNxGaimt650
         0TSw==
X-Gm-Message-State: AFqh2krBoCyVI5kVrnozb/IbWNJwmLT+n4uWrGVNfMrNG+i9pDm/deNn
        faPYYRhN0N9GtP2gRn6rPtj8rorE9Oo=
X-Google-Smtp-Source: AMrXdXvRFOm6/G6GqKv7ySNbOZE5KZoIFVQErFCPYzbVce40UFz38eA7bs8vxhDiPSTZLTKkh7HVTw==
X-Received: by 2002:a05:6a00:d1:b0:580:eb71:40f0 with SMTP id e17-20020a056a0000d100b00580eb7140f0mr27202693pfj.23.1672481297326;
        Sat, 31 Dec 2022 02:08:17 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id g23-20020aa796b7000000b005811082f134sm10543679pfk.158.2022.12.31.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:08:17 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev, andrii@kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
Date:   Sat, 31 Dec 2022 18:07:57 +0800
Message-Id: <20221231100757.3177034-1-hengqi.chen@gmail.com>
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

Add PT_REGS macros for LoongArch ([0]).

  [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/bpf_tracing.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 9c1b1689068d..bdb0f6b5be84 100644
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
+#elif defined(__loongarch__)
+	#define bpf_target_loongarch
+	#define bpf_target_defined
 #endif /* no compiler target */

 #endif
@@ -258,6 +264,23 @@ struct pt_regs___arm64 {
 /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
 #define PT_REGS_SYSCALL_REGS(ctx) ctx

+#elif defined(bpf_target_loongarch)
+
+/* https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html */
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
