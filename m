Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB756F636B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjEDDeS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDDeL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:34:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2B1FFD
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:33:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a69e101070so11107105ad.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683171237; x=1685763237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SAlwbiChBFkNzrNQcILdqClddx4PszVSmGMpUG5X2o=;
        b=Grvm2BxuuXhyrbaLLNOz38PX6bXbRcnroRmOuz5P0uy9F2+da/41uJL4BNqic+fCZe
         UkQa6msqI1TN86g+0L/50m/NPJgViv88qSvlMb9mWCsHauH6omL51ZkHwtrq9qRTUYUh
         vPEFlgFFAVxP6n3OEH0SY1LBI2+6nEXT8EHH6w8+7XhDF8BAi/+jh21+Vh9v3xQg2veE
         4hXP0axNF8L76YsWcfQHKGtkPJCT36/W91FU/eKxyToLfZQEJTz1znGHMPBPKmLp5h+F
         jWr0czv9o232ghGESMiqZ6uhx250u4IgQGTGLbpMEksyEZlW/VEnRx1Zofl5ojhbGmin
         NjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683171237; x=1685763237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SAlwbiChBFkNzrNQcILdqClddx4PszVSmGMpUG5X2o=;
        b=fME4g5dwHFTPCifeNyeidbTEKtBdY58BT/zo5gTPF39+425gGv8Mb7x67+gp4CpL30
         iYnL8MD4XTYsub5PlTn+xgV+sj9XuR1It+ExqZ+5NHKUvAggHAhSEmhKdPw56NFZnYwa
         xtnzKq6jA6hH/q5EGpxUfDKBjSMrmTrZuTcJJevF3uEAj8CzKcaub+ZiBxOhb4JtJu7O
         dz0QdZEEFayB8uLCvSbtxjhVoYURD69OMuJ7676eg48d9pgOpAhK9wpGkbIRENPJ1I6u
         CLPj/V1a3qOIdKVtQjDqUUQGTeqUbxiiowMhewN1gRJ5VJ3h0zSfOTVUIp43iwsvVjBn
         CtNA==
X-Gm-Message-State: AC+VfDy0RCNRoywGSsQXAIUwKzcqWlQXJPcYK0wQSkM5EpuNsVnWflDg
        sCBxoRzzJbatwtPIw8Noq3M=
X-Google-Smtp-Source: ACHHUZ7VJReVd4xGVwZHDV6R49lVhPXtOkCQKKxXlh1O0HcqX+ip90BVKJeB+hsblUjmQ2FKVATjew==
X-Received: by 2002:a17:903:244b:b0:1a9:4b42:a5a2 with SMTP id l11-20020a170903244b00b001a94b42a5a2mr10300813pls.0.1683171236851;
        Wed, 03 May 2023 20:33:56 -0700 (PDT)
Received: from localhost.localdomain ([202.12.244.21])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709027b9100b001a980a23804sm16635883pll.4.2023.05.03.20.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:33:56 -0700 (PDT)
From:   Kenjiro Nakayama <nakayamakenjiro@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Subject: [PATCH bpf-next] libbpf: Fix comment about arc and riscv arch in bpf_tracing.h
Date:   Thu,  4 May 2023 12:33:42 +0900
Message-Id: <20230504033342.424208-1-nakayamakenjiro@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To make comments about arc and riscv arch in bpf_tracing.h accurate,
this patch fixes the comment about arc and adds the comment for riscv.
---
 tools/lib/bpf/bpf_tracing.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 6fb3d0f9af17..be076a4041ab 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -351,6 +351,7 @@ struct pt_regs___arm64 {
  * https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc#risc-v-calling-conventions
  */
 
+/* riscv provides struct user_regs_struct instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
 #define __PT_PARM1_REG a0
 #define __PT_PARM2_REG a1
@@ -383,7 +384,7 @@ struct pt_regs___arm64 {
  * https://raw.githubusercontent.com/wiki/foss-for-synopsys-dwc-arc-processors/toolchain/files/ARCv2_ABI.pdf
  */
 
-/* arc provides struct user_pt_regs instead of struct pt_regs to userspace */
+/* arc provides struct user_regs_struct instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
 #define __PT_PARM1_REG scratch.r0
 #define __PT_PARM2_REG scratch.r1
-- 
2.40.1

