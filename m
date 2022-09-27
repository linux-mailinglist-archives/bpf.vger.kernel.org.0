Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568A5ECC8B
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiI0TAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiI0TAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C3815EFA3
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u69so10235998pgd.2
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MoO/Vd3tHUhNgy1Ah7hXRl6Wax5Zfvh8DPFtmIVmBMA=;
        b=LiRocCVn3n0C08rhsuROJNzmonmZHrZv4RdEaW3nuzRS5VhxUzRmmyLi3ET8BMswBF
         kKQ0IOhXeG0+BaicYp8HLMdswPISS+kbiCYsmPvrHJ5LBgOP4fYVS/Uz7/JyY5wC8fOx
         nN0l5D4oT4xaVUDEO9egp8Z0PHbyCGQxolVhdy06RQ105P8+a7oYlnMXz1UFXY2S5o4Z
         UlnDUjg1CbC4HfosyaZSBDa6ikHdHn7vzKoMzIh0t0KXqMxyyJwfm2rRBYIiA4z5/FLg
         2sQy/NIyWxEKBPuZh28YCdkHL095jdoPH1Qlf/0D8YjZN0I2MDCVdPLEBTV6uzl5asT1
         krwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MoO/Vd3tHUhNgy1Ah7hXRl6Wax5Zfvh8DPFtmIVmBMA=;
        b=pPr/6e88dSeoTT4/RhZ8Ey6CGa9mIh5hDwvsi4ORaQz4+SvQFtW7ZyeU3uIFV4eoy5
         eHcwhrxmliK61H2gCOJMImBn6sgmwZMDo1QyyAStJLcNc4ut71I05ooBZUjkzI/hlTYf
         G8agZ0TAvY0V2D75aVPsX8dBRXXpZ3bm0e59Jzz2q9Hkg9xp0/o59OgF1hNpS3OzsIXt
         VreiVMGAtMMYY89XmVVOcmbeAfVTMm76A74guV3Nc1L4DqbbixtVQPVUhXsUpXFBorCA
         vA4C+J6aSxm+7RKYsmRpiLkfP76c4SFiM50hps4qlZj8vg3rK1ln8aHpm2JOINF51Js0
         bMMw==
X-Gm-Message-State: ACrzQf2fjJusVgFpD1JD10RvrQ0iR+zTPCYNZaP/g63XmX/UogEoMnW0
        dWx6td4jGx9UE3kY4KUo2obviI9RD6g=
X-Google-Smtp-Source: AMsMyM5kO6we4jM57grRVtXWNHQ5THdkBY1wGmU3SmeaEl4HkYEUhElhz5c4LsHQGd0QMvOqOt6McQ==
X-Received: by 2002:a63:d1b:0:b0:42b:828b:f14a with SMTP id c27-20020a630d1b000000b0042b828bf14amr25935931pgl.235.1664305221720;
        Tue, 27 Sep 2022 12:00:21 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:21 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 06/15] ebpf-docs: Use standard type convention in standard doc
Date:   Tue, 27 Sep 2022 18:59:49 +0000
Message-Id: <20220927185958.14995-6-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
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

From: Dave Thaler <dthaler@microsoft.com>

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 14 ++++++++++----
 Documentation/bpf/linux-notes.rst     |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 4997d2088..a24bc5d53 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -7,6 +7,10 @@ eBPF Instruction Set Specification, v1.0
 
 This document specifies version 1.0 of the eBPF instruction set.
 
+Documentation conventions
+=========================
+
+This specification uses the standard C types (uint32_t, etc.) in documentation.
 
 Registers and calling convention
 ================================
@@ -114,7 +118,9 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
-  dst_reg = (u32) dst_reg + (u32) src_reg;
+  dst_reg = (uint32_t) dst_reg + (uint32_t) src_reg;
+
+where '(uint32_t)' indicates truncation to 32 bits.
 
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
@@ -122,7 +128,7 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  src_reg = (u32) src_reg ^ (u32) imm32
+  src_reg = (uint32_t) src_reg ^ (uint32_t) imm32
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
@@ -276,11 +282,11 @@ BPF_XOR   0xa0   atomic xor
 
 ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
-  *(u32 *)(dst_reg + off16) += src_reg
+  *(uint32_t *)(dst_reg + off16) += src_reg
 
 ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
-  *(u64 *)(dst_reg + off16) += src_reg
+  *(uint32_t *)(dst_reg + off16) += src_reg
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 1c31379b4..522ebe27d 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -7,6 +7,12 @@ Linux implementation notes
 
 This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
 
+Arithmetic instructions
+=======================
+
+While the eBPF instruction set document uses the standard C terminology as the cross-platform specification,
+in the Linux kernel, uint32_t is expressed as u32, uint64_t is expressed as u64, etc.
+
 Byte swap instructions
 ======================
 
-- 
2.33.4

