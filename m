Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB66F63C5
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjEDDzL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEDDzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:55:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BD1FFE
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:54:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51f64817809so743576a12.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683172498; x=1685764498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Emd2dl1W0iOyWnHWAOzqJ17+WsdlXOxm8TtWVtyd1lI=;
        b=WguiP0zly07Ko7bkjlrdq6npOk1u1maU2nwH+60W1F8fL/Q+hEZOIyYhm8QcNFaiAe
         xNw1WcRgCediNO+YZV+I0q2T+YA+2oK/+8cO82IdjC1rl6OFpACTdXZFsESDe0Yzq/tz
         sV/dHVzC4BUjsSAdeN4I3/pzFsxlo04BbTl0DqiEX7ZAUv98DxX6ygdQgyOpA+fqdAk0
         EjQ5dBMo+IjuYjma+0M/MZp7OqUcjQfSfcNG3mK0kFLS5pYcXWli3qkXUVlXahz3UexO
         QC/ALVc3XH6mW7OlH71CTSaasGY695Aj7EAtNG5WGThwnKOoSn2iFtTWOFHnXLB8CG99
         Y2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683172498; x=1685764498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Emd2dl1W0iOyWnHWAOzqJ17+WsdlXOxm8TtWVtyd1lI=;
        b=YNkCdhvYl24hfKSqXHu8GBYRV9UgeD45qhRoinBJ9os+MQmp9t5PmYeFHH2if3crnS
         BMG1JqZf+VmA7C6FboYWeUik+ZFWtaVv+JhSLeBOGYoKXt+nV6tHEiCd5tkr9e8805w4
         5UmRhD61vk/GlYV85X9K8aKapy3jepp0r7bcid8M/VFvldVuHiqKkB4Y03UHnC/bK6d+
         PqPHH3a3ytPw1EiuZfFf8VVqCRO/MMeSxS/C7xt6WGCxyLAQauUApH0tkyfWkxph6Lm9
         tg1Ix0SRhetscoYT8KHjJwJj+IjdTNi8SZQ5waSP1+8aIIYD6qcdX39ra38KUm1ds8dT
         7RqQ==
X-Gm-Message-State: AC+VfDwQZY6KWqCcZD3MCnFGpx09xHqMkNRuilIJPcZ2POK9bwla5c3f
        6iP5XQcKbP9NB/awIOwVdV0=
X-Google-Smtp-Source: ACHHUZ5/zgITduTmoGJOT7dL562XXnd46C1F1/uW4WJgHCCrTEM8sB8CvipTklGIZ7slSmHnb2zMXw==
X-Received: by 2002:a05:6a00:2e0f:b0:63b:4978:a50a with SMTP id fc15-20020a056a002e0f00b0063b4978a50amr10459727pfb.1.1683172497763;
        Wed, 03 May 2023 20:54:57 -0700 (PDT)
Received: from localhost.localdomain ([202.12.244.21])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b0063d238b1e4bsm3785867pfn.160.2023.05.03.20.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:54:57 -0700 (PDT)
From:   Kenjiro Nakayama <nakayamakenjiro@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Subject: [PATCH v2 bpf-next] libbpf: Fix comment about arc and riscv arch in bpf_tracing.h
Date:   Thu,  4 May 2023 12:54:43 +0900
Message-Id: <20230504035443.427927-1-nakayamakenjiro@gmail.com>
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

Signed-off-by: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
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

