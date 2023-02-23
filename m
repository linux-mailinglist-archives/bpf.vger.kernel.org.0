Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585A6A0553
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 10:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjBWJyT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 04:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjBWJx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 04:53:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6271515CB
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:53:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j2so9997726wrh.9
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1jz6MKe+/waJNr4k08l2hwqjpwcrvEo/OB/jFRietg=;
        b=P0+cTiSHKB6dP5ULbtkgaq7oTps4rtZrq5eU3zEYZpj54XeCukuFJwmu6IplHJW//A
         OPYqvqNVj/4jxyIC7xJXV0GCaLZmHAOD5OVB9AY+diFgd2vYXo3bb304g/4UGGtPE498
         dz2leErIGROXyK6I0mSp8YmJ1x/r8EqB4oVrgm+qm/FjwnimNJAJo0Wao2GXNGuLgcA1
         ps/Y69agh3F4DSlnhlInYcmuZUp6GrJ4aaJYBWA1gzpKnuLINXQqvv2Kl1erhIE7wabP
         xpb1l5nL3KXFSLPQHN6Chm3gtmQbyPZD3Eww9/IzLDok74hA3TKYopPIK8s/omEMvFWS
         Xr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1jz6MKe+/waJNr4k08l2hwqjpwcrvEo/OB/jFRietg=;
        b=e9Kpxy4cHnNqOwd12CdoRcWyXM0FWIhQV4Agv6Z6EGRiDIHBe5ZGQyVb+UR91mw1af
         cQNv+47R7G3zuMmeEAQ/LYQlMS9RPG+k8Vloc/vWHjQTkI22fz2ixcigiL8NzJ5SnCPc
         jR5xJn5HBAUL6bBB0/a73wsRgAFYh7n2p63fifdCKjCa803ke+x5SuK2sOT5xWgnoEO9
         nV9mZp74xEWzbYVxroaO1zLPo/tufequ1ieL1Ike8BzKXo1v/946t6jaofcS1hB5PbjC
         cJ8AR6spgdjN6E1KjlupHHv0WFJROOOx3aRzznOCmIKk3cNHhS5pIJG3d6S8LxJVSbzB
         xzoQ==
X-Gm-Message-State: AO0yUKXfQVefdofAhFGBc9E+QCpzlyY3s4kovlWnWslkCeD1hlJCLGBy
        G6w4G6HRoVI0JxCbei7/D8s=
X-Google-Smtp-Source: AK7set9DV1jyarYEmmYglWipUeL8g9TPJT+4I5pQcIIoJwTiqawn5zJna4xtirfrpttznLU8RhYX2g==
X-Received: by 2002:a5d:6605:0:b0:2c7:156c:affd with SMTP id n5-20020a5d6605000000b002c7156caffdmr591992wru.9.1677146028140;
        Thu, 23 Feb 2023 01:53:48 -0800 (PST)
Received: from ip-172-31-34-25.eu-west-1.compute.internal (ec2-34-246-174-231.eu-west-1.compute.amazonaws.com. [34.246.174.231])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b002c54241b4fesm371507wrr.80.2023.02.23.01.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:53:47 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2] libbpf: Fix arm syscall regs spec in bpf_tracing.h
Date:   Thu, 23 Feb 2023 09:53:46 +0000
Message-Id: <20230223095346.10129-1-puranjay12@gmail.com>
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

The syscall register definitions for ARM in bpf_tracing.h doesn't define
the fifth parameter for the syscalls. Because of this some KPROBES based
selftests fail to compile for ARM architecture.

Define the fifth parameter that is passed in the R5 register (uregs[4]).

Fixes: 3a95c42d65d5 ("libbpf: Define arm syscall regs spec in bpf_tracing.h")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
Changes in V1[1]->V2:
- Fix signed-off-by and send-from emails.

[1] https://lore.kernel.org/bpf/20230223094717.9746-1-puranjay12@gmail.com/T/#u
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

