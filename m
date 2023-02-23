Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB76A052F
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjBWJr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 04:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjBWJr0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 04:47:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1002367F
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:47:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so7637858wmc.5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9WECZ1N9v7q7yfoKM7X1rawsrS45FNO2ZeMp1Z5udY=;
        b=E/W5GXlBTniUz/ETKWWhLN9ZauiK1QBKTQCFfar/Ae4keau1n2eUtK4LwWkpXVcISb
         bL+NEupk9CzReHr0GoRRUT3zJ1WbXwzsJfbW+3IkQ3LP7yXEqksAIK7FbiGb/Fb/vMbq
         Fy4NRuI6+bLtILZHOQDa0QMy0CcP1mMTHvd8psnLCy85XJ9RP3eGwm+Mxj+yJY/p5PEI
         Gqzw1uFPVDEzLERNgXd7BHEp9bo0ULiibkaVzpgvGu7wl6XI33XMn4dv+TAH1he8sggR
         RH50DDqWh2gz23R4E2nYktUUYS8sL2PAL/BuZa/dQCHCNnQ0OjHBhOlFz/jlXTbyZzZV
         yCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9WECZ1N9v7q7yfoKM7X1rawsrS45FNO2ZeMp1Z5udY=;
        b=s9XiVLG/UDf+QDC87NxryrSeuhS6R1yn8wsv+RYZt90hoN/K6xkWXxqnIJg+Pw9/Fa
         eyD8cF7Kd9yvnyd7aVdnNeUFIE/OUTOgy4AR9vJMVwgGwmj5voDgro+ftooz4qOQ8FU8
         osPQ2q3Jhq9QB0LatpFOecqGCrRNEn7TZVCMCbV/4oRKGG5hg2k0Up+0vMyA5cSVFswF
         eHjElOBOxA9BS9Qu1UN940U4dZRK4jIEqKB9wjGjp+cLbmkOca+CE6fW2IU8iUpwYGWl
         Oy/3fNMxUPeCDkjBPIXoEcic0fJN6oP4v3x53tQSnS6gzk34pBxOQ0vqMV53ONfJa0Yp
         USAg==
X-Gm-Message-State: AO0yUKUiuDlDTkakpNsszNqRcDF0TtM7JaiE7CL5RMLJxgpRuWAEuBWU
        4kn4qtrFdrxSiOXlTjWECck=
X-Google-Smtp-Source: AK7set+VHi4Or9MgFmQI/tFsscTXD+dFD+2vHVC4KvMF+p6no1FV5rM4T+quGxq3fxYcTT07aZCPUQ==
X-Received: by 2002:a05:600c:328a:b0:3d9:e5f9:984c with SMTP id t10-20020a05600c328a00b003d9e5f9984cmr8461575wmp.2.1677145643073;
        Thu, 23 Feb 2023 01:47:23 -0800 (PST)
Received: from ip-172-31-34-25.eu-west-1.compute.internal (ec2-34-246-174-231.eu-west-1.compute.amazonaws.com. [34.246.174.231])
        by smtp.gmail.com with ESMTPSA id t6-20020a1c7706000000b003e1fee8baacsm9679745wmi.25.2023.02.23.01.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:47:22 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
Cc:     Puranjay Mohan <pjy@amazon.com>
Subject: [PATCH] libbpf: Fix arm syscall regs spec in bpf_tracing.h
Date:   Thu, 23 Feb 2023 09:47:17 +0000
Message-Id: <20230223094717.9746-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Puranjay Mohan <pjy@amazon.com>

The syscall register definitions for ARM in bpf_tracing.h doesn't define
the fifth parameter for the syscalls. Because of this some KPROBES based
selftests fail to compile for ARM architecture.

Define the fifth parameter that is passed in the R5 register (uregs[4]).

Fixes: 3a95c42d65d5 ("libbpf: Define arm syscall regs spec in bpf_tracing.h")
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
 tools/lib/bpf/bpf_tracing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 6db88f41fa0d..2cd888733b1c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -204,6 +204,7 @@ struct pt_regs___s390 {
 #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
 #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
 #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
+#define __PT_PARM5_SYSCALL_REG uregs[4]
 #define __PT_PARM6_SYSCALL_REG uregs[5]
 #define __PT_PARM7_SYSCALL_REG uregs[6]
 
-- 
2.39.1

