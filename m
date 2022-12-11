Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BD64930E
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 08:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLKHQf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 02:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLKHQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 02:16:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC811C29
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 23:16:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so9086345pjj.4
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 23:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFkT/vy9EXUh6ZowdJHLVfWb/YgLO0Exw6V7Kpmrpxw=;
        b=nJkHGe9xu0jkBnU0HU7N08JpjEAKriRvDBsbQwLMlA12V3do+eg955juka/p2xiomv
         Oic8Tnt/zY0VuOduvP1KsUx9cQ4xyQ9uJDzDnFk4cGrK6DRhE3p4dcIPjpcL+20IDLsC
         HOCU8LjdNmJnVc+vKEvW6MQQ7ZKfNWFUtlOtuR4kwHGq7vTbLJzmK0jBwJmFLkPjk+KM
         tRA3WJLKIgSCPEcwHR79KOyNIH1zkzdZPqQZmZ4EPzYwtx2EK9M2QPfjlFaJr41dWmOB
         K3LO9H5BDEJgP7AzMQEaB8vk6NET882ZncCKGrVFKW7WxWqSbzoZvrU3L7tfNaU04d0y
         K4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFkT/vy9EXUh6ZowdJHLVfWb/YgLO0Exw6V7Kpmrpxw=;
        b=nuv6Ug2OAJnuJh3bhxTzWDc9YzwPZYNrN7M63/apdCvGM5NiuPn2MwrYAnfsIoQkw4
         PCjOzEQbZ2zDwLKr0JpW+AZXFIBlOd5jH/YY/+BF5Y+Irxb0a9Uiecmav7kx4oZIbrf5
         nuEf+jAfT6pH0PzQgtYTvHYkobUDMx8M+mzOpPPIHRym1EwVy0lj6iKuMoKs1zUuQY5l
         wRAb/nhdXlLcvM271w94S6fTmkIUbf286IlcmNcId7S8gDiWO9fT5XeuzqyXFqfeJUM9
         wcyJhhMOanz7SmG0Gb+0jNUm6WhhMkCcZ1ptcDNTYn5Nn+I5qcInNuQrbNrguopBQpp2
         oDBA==
X-Gm-Message-State: ANoB5plGFE7afITKQCyu4yF9GKmVbeeW0+PLqm1l80rQaad+CyJxVpr2
        7yoYpEDjlvKILlb1JjnYNDIpjDneRTE=
X-Google-Smtp-Source: AA0mqf5HieeMj0Fft9OsTOf+JBVKocEz9UhFcQT3Vam9bv56EOu9axgRJogVy0dBmXvqPa3QcG1XMA==
X-Received: by 2002:a05:6a20:d903:b0:a3:c448:b03a with SMTP id jd3-20020a056a20d90300b000a3c448b03amr16572068pzb.20.1670742992281;
        Sat, 10 Dec 2022 23:16:32 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id s10-20020a63d04a000000b0047911890728sm3183755pgi.79.2022.12.10.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 23:16:31 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     hengqi.chen@gmail.com, yangtiezhu@loongson.cn
Subject: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
Date:   Sun, 11 Dec 2022 15:16:23 +0800
Message-Id: <20221211071623.637473-1-hengqi.chen@gmail.com>
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

Add PT_REGS macros for LoongArch64.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 src/bpf_tracing.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/bpf_tracing.h b/src/bpf_tracing.h
index 2972dc2..2d7da1c 100644
--- a/src/bpf_tracing.h
+++ b/src/bpf_tracing.h
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
+#define __PT_PARM1_REG regs[5]
+#define __PT_PARM2_REG regs[6]
+#define __PT_PARM3_REG regs[7]
+#define __PT_PARM4_REG regs[8]
+#define __PT_PARM5_REG regs[9]
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
